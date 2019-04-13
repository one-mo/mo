#coding:utf-8
export LANG=UTF-8
export LANGUAGE=UTF-8
yum groupinstall -y "Development tools"
wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz && tar xvf Python-3.6.8.tar.xz && cd Python-3.6.8
./configure
make&& make install
cd ..
rm -rf Python-3.6.8 Python-3.6.8.tar.xz
