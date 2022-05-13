#!/bin/bash
branch=development
proxy=https://ghproxy.com/
mongoDBHome=/usr/local/mongoDB
Genshin_HOME=""
deploy(){
	yum install -y git
	git clone -b ${branch} ${proxy}https://github.com/Grasscutters/Grasscutter.git Grasscutter
	git clone ${proxy}https://github.com/Koko-boya/Grasscutter_Resources.git resource
	mv ${appPATH}/resource/Resources ${appPATH}/Grasscutter/resources
	rm -rf ${appPATH}/resource
	index=$(grep -En "^export Genshin_HOME.*" /etc/profile | awk -F: '{print $1}')
	if [ ${index} ];then
		sed -iE "$index s%.*Genshin_HOME.*%export Genshin_HOME=${appPATH}/Grasscutter%g" /etc/profile
	else
		sed -i "\$a export Genshin_HOME=${appPATH}/Grasscutter" /etc/profile
    fi
    Genshin_HOME=${appPATH}/Grasscutter
	source /etc/profile
}

build(){
	cd ${appPATH}/Grasscutter && chmod +x ./gradlew && ./gradlew jar
}

init(){
    echo -e "至此jar包已构建完成\n将在10秒后执行初始化\n待初始化完成后，请连续按两次 Ctrl+C\n如果您不懂如何配置config.json\n请运行setConfig.sh"
    sleep 10
    mongod --dbpath ${mongoDBHome}/db --logpath ${mongoDBHome}/log/mongod.log --fork
    cd ${Genshin_HOME} && java -jar grasscutter*.jar
}

echo -n -e "请输入部署服务的绝对路径（示例：/root)，回车默认为 当前目录:"
read -r installPath
if [ -z "$installPath" ]; then
    appPATH=`pwd`
elif [ -d "$installPath" ]; then
    appPATH=$installPath
else
    mkdir -p "$installPath"
    appPATH=$installPath
fi

deploy
build
init
