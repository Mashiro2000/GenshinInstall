#!/bin/bash
IP=$(curl cip.cc 2>&1 | grep -i "^IP" | awk  '{print $3}')
echo "$您的IP是:${IP}"

sed -i "/accessAddress/ s/127.0.0.1/${IP}/g" ${Genshin_HOME}/config.json
sed -i "/language\|fallback/ s/en_US/zh_CN/g" ${Genshin_HOME}/config.json

echo "配置如下:"
grep -n 'accessAddress' ${Genshin_HOME}/config.json | awk 'NR>1{print}'
grep -nE 'fallback|language' ${Genshin_HOME}/config.json | awk 'NR>1{print}'
echo -e "至此，您可通过运行run.sh启动服务器"
