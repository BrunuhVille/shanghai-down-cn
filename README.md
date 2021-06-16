#### 一键blog
wget https://raw.githubusercontent.com/BrunuhVille/shanghai-down-cn/master/vps.sh && chmod 777 vps.sh && bash vps.sh
****
wget http://193.122.110.130:13333/superbench.sh && chmod 777 superbench.sh && bash superbench.sh

https://github.com/filebrowser/filebrowser/releases/download/v2.15.0/linux-amd64-filebrowser.tar.gz

https://233blog.com/post/26

apt-get install grub-efi -y

wget https://raw.githubusercontent.com/bohanyang/debi/master/debi.sh && chmod 777 debi.sh && bash debi.sh --user root --password river3422

wget http://129.146.136.156:3333/debi.sh && chmod 777 debi.sh && bash debi.sh --user root --password river3422

bash <(wget --no-check-certificate -qO- 'https://moeclub.org/attachment/LinuxShell/InstallNET.sh') -d 9 -v 64 -a -firmware --mirror 'http://mirrors.ustc.edu.cn/debian/'

wget 'https://moeclub.org/attachment/LinuxShell/InstallNET.sh' && chmod 777 InstallNET.sh && bash InstallNET.sh -d 10 -v 64 -a -p river3422

wget 'https://moeclub.org/attachment/LinuxShell/InstallNET.sh' && chmod 777 InstallNET.sh && bash InstallNET.sh -d 9 -v 64 -a -p river3422

chmod 777 /etc/resolv.conf && echo -e "nameserver 8.8.8.8" > /etc/resolv.conf

apt update -y && apt install curl -y && apt install wget -y && apt install bc -y && apt install unzip -y

apt install unzip -y && apt install vim -y

curl -sL yabs.sh | bash -s -- -i

select-editor

crontab -e 
#### bbr
wget -N --no-check-certificate "https://github.000060000.xyz/tcp.sh" && chmod 777 tcp.sh && ./tcp.sh

wget http://193.122.110.130:13333/tcp.sh && chmod 777 tcp.sh && ./tcp.sh
#### 奈飞检测x2
wget --no-check-certificate -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.6/nf_2.6_linux_amd64 && chmod +x nf && clear && ./nf -method full

bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)

wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_amd64 && chmod +x dp && clear && ./dp

apt install jq -y && bash <(curl -sSL "https://github.com/CoiaPrant/MediaUnlock_Test/raw/main/check.sh")

yum install jq -y && bash <(curl -sSL "https://github.com/CoiaPrant/MediaUnlock_Test/raw/main/check.sh")
#### 关闭ipv6
vim /etc/sysctl.conf

添加下面的行：

net.ipv6.conf.all.disable_ipv6 = 1

net.ipv6.conf.default.disable_ipv6 = 1

保存并退出文件。

sysctl -p
#### * */1 * * * systemctl restart realm

#### 256
echo "tmpfs /run tmpfs nosuid,noexec,size=18M,nr_inodes=4096 0 0" >> /etc/fstab
#### realm安装完，再重启一下，内存占用会变少
wget -N --no-check-certificate https://git.io/realm.sh && chmod 777 realm.sh && ./realm.sh
#### trojan
#安装/更新

source <(curl -sL https://git.io/trojan-install)

#卸载

source <(curl -sL https://git.io/trojan-install) --remove
#### gost
apt install dnsutils -y

echo "tmpfs /run tmpfs nosuid,noexec,size=18M,nr_inodes=4096 0 0" >> /etc/fstab

wget --no-check-certificate https://raw.githubusercontent.com/KANIKIG/Multi-EasyGost/master/gost.sh && chmod 777 gost.sh && ./gost.sh
#### ddns/brook，注意，brook开启域名监控前，先crontab -e 选择编辑器2，vim
yum install -y iptables && yum install bind-utils -y

apt-get install iptables && apt-get install dnsutils

wget --no-check-certificate https://raw.githubusercontent.com/monret/brook/master/brook-pf-mod.sh

wget http://81.71.141.240:3333/brook/brook-pf-mod.sh && chmod 777 brook-pf-mod.sh && bash brook-pf-mod.sh

v20200801
#### caddy
wget -N --no-check-certificate https://raw.githubusercontent.com/sancdvs/caddy_install/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh

mkdir cadfile

echo ":13333 {

 root /root/cadfile
 
 timeouts none
 
 gzip
 
 browse
 
}" > /usr/local/caddy/Caddyfile

/etc/init.d/caddy start

chmod 777 cadfile

cd cadfile

dd if=/dev/zero of=aaa bs=1M count=300

mv aaa sra.asz

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

chmod 777 /etc/resolv.conf && echo -e "nameserver 8.8.8.8" > /etc/resolv.conf

chmod 777 /etc/resolv.conf && echo "nameserver 223.6.6.6" >> /etc/resolv.conf

systemctl stop firewalld.service

systemctl disable firewalld.service

chmod 777 /etc/hosts && echo "185.199.108.153 github.000060000.xyz" >> /etc/hosts

chmod 777 /etc/hosts && echo "185.199.108.133 raw.githubusercontent.com" >> /etc/hosts

chmod 777 /etc/hosts && echo "54.235.108.207 git.io" >> /etc/hosts

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

vim /etc/ssh/sshd_config 

passwd root

service sshd restart
## lkl
systemctl disable rinetd-bbr.service

killall -9 rinetd-bbr

rm -rf /usr/bin/rinetd-bbr /etc/rinetd-bbr.conf /etc/systemd/system/rinetd-bbr.service
## 回程路由
wget https://raw.githubusercontent.com/nanqinlang-script/testrace/master/testrace.sh && chmod 777 testrace.sh

wget https://raw.githubusercontent.com/flyzy2005/shell/master/autoBestTrace.sh && chmod 777 autoBestTrace.sh

