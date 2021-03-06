#!/usr/bin/env bash
#Blog:https://github.com/one-mo/mo/

Green="\033[32m"
Font="\033[0m"
Red="\033[31m" 

#root权限
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}请使用ROOT身份运行……${Font}"
        exit 1
    fi
}

#检测ovz
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}额...OVZ？回家洗洗睡吧。${Font}"
        exit 1
    fi
}

add_swap(){
echo -e "${Green}输入需要添加的swap，建议为内存的2倍！${Font}"
echo -e "${Red}默认单位：MB，只需要输入纯数字即可，如：2048 ${Font}"
read -p "请输入swap数值:" swapsize

#检查是否存在swapfile
grep -q "swapfile" /etc/fstab

#如果不存在将为其创建swap
if [ $? -ne 0 ]; then
	echo -e "${Green}swapfile未发现，正在为其创建swapfile${Font}"
	fallocate -l ${swapsize}M /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo '/swapfile none swap defaults 0 0' >> /etc/fstab
         echo -e "${Green}swap创建成功，并查看信息：${Font}"
         cat /proc/swaps
         cat /proc/meminfo | grep Swap
else
	echo -e "${Red}swapfile已存在，swap设置失败，请先运行脚本删除swap后重新设置！${Font}"
fi
}

del_swap(){
#检查是否存在swapfile
grep -q "swapfile" /etc/fstab

#如果存在就将其移除
if [ $? -eq 0 ]; then
	echo -e "${Green}swapfile已发现，正在将其移除...${Font}"
	sed -i '/swapfile/d' /etc/fstab
	echo "3" > /proc/sys/vm/drop_caches
	swapoff -a
	rm -f /swapfile
    echo -e "${Green}swap已删除！${Font}"
else
	echo -e "${Red}swapfile未发现，swap删除失败！${Font}"
fi
}

#开始菜单
main(){
root_need
ovz_no
clear
echo -e "———————————————————————————————————————"
echo -e "${Green}Linux VPS一键添加/删除swap脚本${Font}"
echo -e "${Green}1、添加swap${Font}"
echo -e "${Green}2、删除swap${Font}"
echo -e "———————————————————————————————————————"
read -p "请输入数字 [1-2]:" num
case "$num" in
    1)
    add_swap
    ;;
    2)
    del_swap
    ;;
    *)
    clear
    echo -e "${Green}请输入正确数字 [1-2]${Font}"
    sleep 2s
    main
    ;;
    esac
}
main
