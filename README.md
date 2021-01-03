#### bbr
wget -N --no-check-certificate "https://github.000060000.xyz/tcp.sh" && chmod 777 tcp.sh && ./tcp.sh

wget --no-check-certificate https://raw.githubusercontent.com/BrunuhVille/shanghai-down-cn/master/tcp.sh && chmod 777 tcp.sh && ./tcp.sh
#### trojan
#安装/更新

source <(curl -sL https://git.io/trojan-install)

#卸载

source <(curl -sL https://git.io/trojan-install) --remove
#### gost
wget --no-check-certificate https://raw.githubusercontent.com/KANIKIG/Multi-EasyGost/master/gost.sh && chmod 777 gost.sh && ./gost.sh
#### ddns/brook，注意，brook开启域名监控前，先crontab -e 选择编辑器2，vim
yum install -y iptables && yum install bind-utils -y

apt-get install iptables && apt-get install dnsutils

wget --no-check-certificate https://raw.githubusercontent.com/monret/brook/master/brook-pf-mod.sh

wget http://81.71.141.240:3333/brook/brook-pf-mod.sh && chmod 777 brook-pf-mod.sh && bash brook-pf-mod.sh

v20200801
#### caddy
wget --no-check-certificate https://raw.githubusercontent.com/BrunuhVille/shanghai-down-cn/master/caddy.sh && chmod 777 caddy.sh && bash caddy.sh install http.filemanager

mkdir /usr/local/caddy/www && mkdir /usr/local/caddy/www/speeder

echo ":3333 {

 root /usr/local/caddy/www/speeder
 
 timeouts none
 
 gzip
 
 browse
 
}" > /usr/local/caddy/Caddyfile

/etc/init.d/caddy start

cd /usr/local/caddy/www/speeder

chmod 777 /usr/local/caddy/www/speeder

dd if=/dev/zero of=ru bs=1M count=300

mv ru ra.asz

#### net_speeder
wget --no-check-certificate https://raw.githubusercontent.com/BrunuhVille/shanghai-down-cn/master/nsp.sh && chmod 777 nsp.sh && bash nsp.sh
#### testrace
wget https://raw.githubusercontent.com/nanqinlang-script/testrace/master/testrace.sh && chmod 777 testrace.sh && bash testrace.sh
#### superbench
wget https://raw.githubusercontent.com/msoayu56/speedtest/master/superbench.sh && chmod 777 superbench.sh && bash superbench.sh
#### v2ray-wulabing
wget -N --no-check-certificate -q -O install.sh "https://raw.githubusercontent.com/wulabing/V2Ray_ws-tls_bash_onekey/master/install.sh" && chmod 777 install.sh && bash install.sh
#### wireguard
ubuntu

sudo -i

apt update -y && wget https://raw.githubusercontent.com/BrunuhVille/shanghai-down-cn/master/wu.sh && chmod 777 wu.sh

apt update -y

apt upgrade -y

apt dist-upgrade

reboot

apt install linux-headers-$(uname -r) -y

wget https://raw.githubusercontent.com/BrunuhVille/shanghai-down-cn/master/dr.sh && chmod 777 dr.sh && bash dr.sh
##### 开机配置
yum update -y

apt update -y && apt-get update -y

yum install unzip -y && yum install gcc -y

apt install unzip -y && apt install gcc -y

chmod 777 /etc/resolv.conf && echo -e "nameserver 223.5.5.5" > /etc/resolv.conf
chmod 777 /etc/resolv.conf && echo "nameserver 223.6.6.6" >> /etc/resolv.conf

systemctl stop firewalld.service

systemctl disable firewalld.service

chmod 777 /etc/hosts && echo "185.199.108.153 github.000060000.xyz" >> /etc/hosts

chmod 777 /etc/hosts && echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts

chmod 777 /etc/hosts && echo "13.229.188.59 github.com" >> /etc/hosts

CentOS 7.0默认使用的是firewall作为防火墙

查看防火墙状态

firewall-cmd --state

停止firewall

systemctl stop firewalld.service

禁止firewall开机启动

systemctl disable firewalld.service

开启防火墙

systemctl start firewalld.service

设置开机自启

systemctl enable firewalld.service

重启防火墙

systemctl restart firewalld.service
## ubuntu oracle
iptables -P INPUT ACCEPT

iptables -P FORWARD ACCEPT

iptables -P OUTPUT ACCEPT

iptables -F
## root
sudo -i

chmod 777 /etc/ssh/sshd_config 

vi /etc/ssh/sshd_config 

passwd root

service sshd restart
## lkl
systemctl disable rinetd-bbr.service

killall -9 rinetd-bbr

rm -rf /usr/bin/rinetd-bbr /etc/rinetd-bbr.conf /etc/systemd/system/rinetd-bbr.service
## 回程路由
wget https://raw.githubusercontent.com/nanqinlang-script/testrace/master/testrace.sh && chmod 777 testrace.sh

wget https://raw.githubusercontent.com/flyzy2005/shell/master/autoBestTrace.sh && chmod 777 autoBestTrace.sh

