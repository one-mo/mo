#coding:utf-8
export LANG=UTF-8
export LANGUAGE=UTF-8
yum -y install unzip
wget https://github.com/iwannay/jiacrontab/archive/v1.4.5.zip
unzip jiacrontab-v1.4.5-linux-amd64.zip
cd jiacrontab/server
nohup ./jiaserver &> jiaserver.log &
cd .. && cd client
nohup ./jiaclient &> jiaclient.log &
firewall-cmd --zone=public --add-port=20000-20003/tcp --permanent
firewall-cmd --reload

echo --------------------------
echo 安装完毕
echo 访问：http://IP:20000
echo 用户名：admin  密码：123456
