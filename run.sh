#!/bin/bash
echo -e "服务将于10秒后开始运行\n您可通过'yum install -y screen'安装交互式挂机程序"
echo -e "'screen -S <name>':建立一个窗口\n'screen -r <name>':恢复窗口\n'Ctrl + A + D':最小化窗口\n'exit':关闭窗口"
sleep 10
cd ${Genshin_HOME}
mongod --dbpath ${mongoDBHome}/db --logpath ${mongoDBHome}/log/mongod.log --fork
cd ${Genshin_HOME} && java -jar grasscutter*.jar
