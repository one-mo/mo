#coding:utf-8
export LANG=UTF-8
export LANGUAGE=UTF-8
yum groupinstall -y "Development tools"
yum install -y sqlite-devel ncurses-devel ncurses-libs zlib-devel mysql-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel openssl-devel
wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz && tar zxvf Python-3.6.8.tar.xz && cd Python-3.6.8
./configure
make&& make install
cd ..
rm -rf Python-3.6.8 Python-3.6.8.tar.xz