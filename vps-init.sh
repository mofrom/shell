#!/bin/bash


# 自定义端口号
read -p "是否需要修改SSH端口号（y/n）：" chpo
until [[ $chpo =~ ^([y]|[n])$ ]]; do
  read -p "请重新键入是否需要修改SSH端口号（y/n）：" chpo;
done
if [[ $chpo == y ]]; then
  read -p "请指定自定义SSH端口号（可用范围为0-65535 推荐使用大端口号）：" Port;Port=${Port:-22233}
  until  [[ $Port =~ ^([0-9]{1,4}|[1-5][0-9]{4}|6[0-5]{2}[0-3][0-5])$ ]];do
    read -p "请重新键入SSH自定义端口号：" Port;Port=${Port:-22233};

  done
fi



if [[ $chpo == y ]]; then
  echo 更改SSH端口号为$Port
  sed -i "s/Port .*/Port $Port/" /etc/ssh/sshd_config
fi
if [[ $chpo == y ]]; then
  echo 重启SSH服务
  service sshd restart
fi
