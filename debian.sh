#!/bin/bash

rand(){
	min=$1
	max=$(($2-$min+1))
	num=$(cat /dev/urandom | head -n 10 | cksum | awk -F ' ' '{print $1}')
	echo $(($num%$max+$min))  
}

randpwd(){
	mpasswd=$(cat /dev/urandom | head -1 | md5sum | head -c 4)
	echo ${mpasswd}  
}

add_backports(){
	apt install -y apt-transport-https sudo
	sudo echo deb https://deb.debian.org/debian/ buster-backports main contrib non-free >> /etc/apt/sources.list
	sudo echo deb-src https://deb.debian.org/debian/ buster-backports main contrib non-free >> /etc/apt/sources.list
	apt update
}

wireguard_install(){
	apt install -y sudo wireguard curl resolvconf
	sudo echo net.ipv4.ip_forward = 1 >> /etc/sysctl.conf
	sysctl -p
	echo "1"> /proc/sys/net/ipv4/ip_forward
	cd /etc/wireguard
	wg genkey | tee sprivatekey | wg pubkey > spublickey
	wg genkey | tee cprivatekey | wg pubkey > cpublickey
	s1=$(cat sprivatekey)
	s2=$(cat spublickey)
	c1=$(cat cprivatekey)
	c2=$(cat cpublickey)
	serverip=$(curl ipv4.icanhazip.com)
	port=$(rand 10000 60000)

sudo cat > /etc/wireguard/wg0.conf <<-EOF
[Interface]
PrivateKey = $s1
Address = 172.16.0.1/24 
PostUp   = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
ListenPort = $port
DNS = 8.8.8.8
MTU = 1420

[Peer]
PublicKey = $c2
AllowedIPs = 172.16.0.2/32
EOF

	systemctl enable wg-quick@wg0
	systemctl start wg-quick@wg0
	udp_install
}

udp_install(){
	#下载udpspeeder和udp2raw （amd64版）
	mkdir /usr/local/udp
	mkdir /etc/wireguard/client
	cd /usr/local/udp
	wget https://github.com/yushum/wireguard_game/raw/master/speederv2
	wget https://github.com/yushum/wireguard_game/raw/master/udp2raw
	wget https://github.com/yushum/wireguard_game/raw/master/run.sh
	chmod +x speederv2 udp2raw run.sh

	#启动udpspeeder和udp2raw
	udpport=$(rand 10000 60000)
	password=$(randpwd)
	nohup ./speederv2 -s -l127.0.0.1:4096 -r127.0.0.1:$port -f2:4 --mode 0 --timeout 0 >speeder.log 2>&1 &
	nohup ./run.sh ./udp2raw -s -l0.0.0.0:$udpport -r 127.0.0.1:4096  --raw-mode faketcp  -a -k $password >udp2raw.log 2>&1 &
	echo -e "\033[37;41m输入你客户端电脑的默认网关，打开cmd，使用ipconfig命令查看\033[0m"
	read -p "比如192.168.1.1 ：" ugateway

cat > /etc/wireguard/client/client.conf <<-EOF
[Interface]
PrivateKey = $c1
PostUp = mshta vbscript:CreateObject("WScript.Shell").Run("cmd /c route add $serverip mask 255.255.255.255 $ugateway METRIC 20 & start /b c:/udp/speederv2.exe -c -l127.0.0.1:2090 -r127.0.0.1:2091 -f2:4 --mode 0 --timeout 0 & start /b c:/udp/udp2raw.exe -c -r$serverip:$udpport -l127.0.0.1:2091 --raw-mode faketcp -k $password",0)(window.close)
PostDown = route delete $serverip && taskkill /im udp2raw.exe /f && taskkill /im speederv2.exe /f
Address = 172.16.0.2/24 
DNS = 8.8.8.8
MTU = 1420

[Peer]
PublicKey = $s2
Endpoint = 127.0.0.1:2090
AllowedIPs = 0.0.0.0/0, ::0/0
PersistentKeepalive = 25
EOF

cat > /etc/wireguard/client/client_noudp.conf <<-EOF
[Interface]
PrivateKey = $c1
Address = 172.16.0.2/24 
DNS = 8.8.8.8
MTU = 1420
[Peer]
PublicKey = $s2
Endpoint = $serverip:$port
AllowedIPs = 0.0.0.0/0, ::0/0
PersistentKeepalive = 25
EOF


#增加自启动脚本
cat > /etc/init.d/autoudp<<-EOF
#! /bin/sh
### BEGIN INIT INFO
# Provides:		autoudp
# Required-Start:    $remote_fs $syslog
# Required-Stop:    $remote_fs $syslog
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	autoudp
### END INIT INFO

cd /usr/local/udp
nohup ./speederv2 -s -l127.0.0.1:4096 -r127.0.0.1:$port -f2:4 --mode 0 --timeout 0 >speeder.log 2>&1 &
nohup ./run.sh ./udp2raw -s -l0.0.0.0:$udpport -r127.0.0.1:4096  --raw-mode faketcp  -a -k $password >udp2raw.log 2>&1 &
EOF



#设置脚本权限
	sudo chmod 755 /etc/init.d/autoudp
	cd /etc/init.d
	sudo update-rc.d autoudp defaults
}

wireguard_remove(){

	sudo systemctl stop wg-quick@wg0
	sudo systemctl disable wg-quick@wg0
	sudo apt remove -y wireguard
	sudo apt -y autoremove
	sudo rm -rf /etc/wireguard
	sudo rm -rf /usr/local/udp
	sudo rm -f /etc/init.d/autoudp
	echo -e "\033[37;41m卸载完成,请重启\033[0m"

}

add_user(){
	echo -e "\033[37;41m给新用户起个名字，不能和已有用户重复\033[0m"
	read -p "请输入用户名：" newname
	cd /etc/wireguard/client
	cp client.conf $newname.conf
	wg genkey | tee temprikey | wg pubkey > tempubkey
	ipnum=$(grep Allowed /etc/wireguard/wg0.conf | tail -1 | awk -F '[ ./]' '{print $6}')
	newnum=$((10#${ipnum}+1))
	sed -i 's%^PrivateKey.*$%'"PrivateKey = $(cat temprikey)"'%' $newname.conf
	sed -i 's%^Address.*$%'"Address = 172.16.0.$newnum\/24"'%' $newname.conf

cat >> /etc/wireguard/wg0.conf <<-EOF

[Peer]
PublicKey = $(cat tempubkey)
AllowedIPs = 172.16.0.$newnum/32
EOF
	wg set wg0 peer $(cat tempubkey) allowed-ips 172.16.0.$newnum/32
	echo -e "\033[37;41m添加完成，客户端文件：/etc/wireguard/client/$newname.conf\033[0m"
	rm -f temprikey tempubkey
	systemctl restart wg-quick@wg0
}

#开始菜单
start_menu(){
	clear
	echo -e "\033[43;42m ====================================\033[0m"
	echo -e "\033[43;42m 介绍：wireguard+udpspeeder+udp2raw  \033[0m"
	echo -e "\033[43;42m 系统：Debian                        \033[0m"
	echo -e "\033[43;42m 作者：Yushum                        \033[0m"
	echo -e "\033[43;42m 网站：yushum.com                    \033[0m"
	echo -e "\033[43;42m ====================================\033[0m"
	echo
	echo -e "\033[0;33m 1. 添加backports到sources.list\033[0m"
	echo -e "\033[0;33m 2. 安装wireguard+udpspeeder+udp2raw\033[0m"
	echo -e "\033[0;31m 3. 删除wireguard+udpspeeder+udp2raw\033[0m"
	echo -e "\033[37;41m 4. 增加用户\033[0m"
	echo -e " 0. 退出脚本"
	echo
	read -p "请输入数字:" num
	case "$num" in
	1)
	add_backports
	;;
	2)
	wireguard_install
	;;
	3)
	wireguard_remove
	;;
	4)
	add_user
	;;
	0)
	exit 1
	;;
	*)
	clear
	echo -e "请输入正确数字"
	sleep 2s
	start_menu
	;;
	esac
}

start_menu
