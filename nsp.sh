#!/bin/bash

############################################################
#  一键安装Net-Speeder程序
#  
#  发布日期：2020-04-27 
#  程序版本：3.0
#  
#  脚本作者：WolfSkylake
#  脚本链接：https://www.mengclaw.com/2020/03/03/598/
#
#  项目作者：Snooda
#  项目地址：https://github.com/snooda/net-speeder
############################################################

# 判断系统版本
check_system_os(){
	if [[ -f /etc/redhat-release ]];then
		if [[ `cat /etc/redhat-release | awk -F " " '{print $4}' | awk -F "." '{print $1}'` == "8" ]];then
			release="CentOS8"
		else
			release="CentOS"
		fi
# -q 执行本条语句的时候不输出，-i 不区分大小写
	elif cat /etc/issue | grep -q -i "debian";then
		release="Debian"
	elif cat /etc/issue | grep -q -i "ubuntu";then
		release="Ubuntu"
	else
		release="Unknown"
		echo -e "\n 系统不受支持，安装失败 \n"
		exit 1
	fi
}


# 检查是否是root账户
check_root(){
	if [[ $EUID != 0 ]];then
		echo -e " 当前非ROOT账号，无法继续操作。\n 请更换ROOT账号登录服务器。 " 
		exit 1
	else
		echo " 管理员权限检查通过 "
	fi
}


# 安装系统依赖
dependent_install(){
	if [[ $release == "CentOS8" ]];then
		dnf -y makecache
		dnf -y install epel-release
		dnf config-manager --set-enabled PowerTools
		dnf -y install libnet libpcap libnet-devel libpcap-devel gcc unzip virt-what
	elif [[ $release == "CentOS" ]];then
		yum -y makecache
		yum -y install epel-release
		yum -y install libnet libpcap libnet-devel libpcap-devel gcc unzip virt-what
	elif [[ $release == "Debian" ]] || [[ $release == "Ubuntu" ]];then
		apt-get -y update
		apt-get -y install libnet1-dev libpcap0.8-dev gcc unzip virt-what
	else
		echo -e " 系统不受支持，安装失败 \n"
		exit 1
	fi
}


# 下载主程序
program_download(){
	rm -rf net-speeder* Net_Speeder*
	wget http://81.71.141.240:3333/netspeeder/Net_Speeder.zip
}


# 解压缩
program_unzip(){
	unzip Net_Speeder.zip
}


# 检查虚拟化
virt_check(){
if [[ -e '/tmp/net-speeder-install/virt.conf' ]];then
	virt-what > /tmp/net-speeder-install/virt.conf
else
	rm -rf /tmp/net-speeder-install
	mkdir /tmp/net-speeder-install
	touch /tmp/net-speeder-install/virt.conf
	virt-what > /tmp/net-speeder-install/virt.conf
fi
}


# 检查网卡名称
nic_name_check(){
if [[ -e '/tmp/net-speeder-install/nic.conf' ]];then
	if [[ `cat /tmp/net-speeder-install/virt.conf` == "openvz" ]];then
		echo "venet0" > /tmp/net-speeder-install/nic.conf
	else
		ip add|grep "state UP"|egrep "eth[0-9]|net[0-9]|ens[0-9]"|awk -F ": " '{print $2}' > /tmp/net-speeder-install/nic.conf
	fi
else
	touch /tmp/net-speeder-install/nic.conf
	if [[ `cat /tmp/net-speeder-install/virt.conf` == "openvz" ]];then
		echo "venet0" > /tmp/net-speeder-install/nic.conf 
	else
		ip add|grep "state UP"|egrep "eth[0-9]|net[0-9]|ens[0-9]"|awk -F ": " '{print $2}' > /tmp/net-speeder-install/nic.conf
	fi
fi
}


# 编译
program_compile(){
	if [[ `cat /tmp/net-speeder-install/virt.conf` == "openvz" ]];then
		sh net-speeder-master/build.sh -DCOOKED
		rm -rf /usr/local/bin/net_speeder
		cp net-speeder-master/net_speeder /usr/local/bin
	else
		sh net-speeder-master/build.sh
		rm -rf /usr/local/bin/net_speeder
		cp net-speeder-master/net_speeder /usr/local/bin
fi
}


# 运行
program_run(){
	nic_name=`cat /tmp/net-speeder-install/nic.conf|head -1`
	ethtool -K venet0 tso off >/dev/null 2>&1
	net_speeder $nic_name "ip" >/dev/null 2>&1 &
}

# 清理安装过程中产生的文件
after_installl(){
	rm -rf Net_Speeder.zip net-speeder-master
}

# 卸载
uninstall(){
	rm -rf /usr/local/bin/net_speeder
	rm -rf Net_Speeder.zip net-speeder-master
}

# 运行状态检查
program_run_status(){
	if [[ `ps -ef |grep -v grep|grep -v bash|grep net_speeder|grep -c 'net_speeder'` -ge 1 ]];then
		echo -e "\n 程序已运行，进程信息：\n"
		ps -ef |grep -v grep|grep -v bash|grep net_speeder
		echo -e "\n 考虑到稳定性问题，程序开机不会自启动。如果下次开机需要运行本程序，请重新运行本脚本。\n 运行方式：\n\nbash net_speeder.sh\n"
	else
		echo -e "\n 程序未运行 \n"
		sleep 1
		exit 1
	fi
}



# 检查PID
check_pid(){
	pid=`ps -ef |grep -v grep|grep net_speeder|awk '{print $2}'`
}

############################################################

# 安装

program_install(){
if [[ -s /usr/local/bin/net_speeder ]];then
	echo " 程序已安装 "
	exit 1
else
	check_root
	sleep 1

	check_system_os
	echo -e "\n 当前系统："$release
	sleep 1

	echo -e "\n 开始安装依赖环境\n "
	sleep 1
	dependent_install
	sleep 1

	echo -e "\n 依赖环境安装结束，开始下载Net-Speeder程序\n "
	sleep 1
	 program_download
	sleep 1

	echo -e "\n 下载完成，开始解压\n "
	sleep 1
	 program_unzip
	sleep 1

	echo -e "\n 解压完成，开始检查虚拟化 "
	sleep 1
	virt_check
	sleep 1

	echo -e "\n 检查虚拟化完成，开始检查网卡名称 "
	sleep 1
	nic_name_check
	sleep 1

	echo -e "\n 检查网卡名称完成，开始编译程序 "
	sleep 1
	program_compile
	sleep 1

	echo -e "\n 编译程序完成，开始启动程序 "
	sleep 1
	program_run

	echo -e "\n 启动程序完成，开始判断是否正常运行 "
	sleep 1
	program_run_status
	after_installl
fi
}


# 卸载
program_uninstall(){
if [[ -s /usr/local/bin/net_speeder ]];then
	check_pid
	uninstall
	echo " 卸载完成！"
	kill -9 $pid >/dev/null 2>&1 &
else
	echo " 程序未安装 "
	exit 1
fi
}


# 运行（多次运行效果叠加）
program_start(){
	virt_check
	nic_name_check
	program_run
	program_run_status
}


# 停止
program_stop(){
	check_pid
	kill -9 $pid
}

############################################################

echo -e " -------------------------"
echo -e " 一键安装Net-Speeder程序 "
echo -e " 版本：3.0 "
echo -e " 作者：WolfSkylake "
echo -e " 链接：https://www.mengclaw.com/2020/03/03/598/ "
echo -e " -------------------------"
echo -e "\n 部署操作："
echo -e " 1、安装Net-Speeder "
echo -e " 2、卸载Net-Speeder "
echo -e "\n 管理操作："
echo -e " 3、运行Net-Speeder "
echo -e " 4、停止Net-Speeder "
echo -e " 5、检查运行状态\n "
echo -e " -------------------------"

read -p " 请输入数字 [1-5]:" num
case "$num" in
1)
	program_install
	;;
2)
	program_uninstall
	;;
3)
	program_start
	;;
4)
	program_stop
	;;
5)
	program_run_status
	;;
esac

############################################################
