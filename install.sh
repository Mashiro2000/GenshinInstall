#!/bin/bash
javaHome=/usr/local/java
mongoDBHome=/usr/local/mongoDB
initJava(){
    if [ -d ${javaHome} ];then
        rm -rf ${javaHome}
    fi
    mkdir ${javaHome}
    cd ${javaHome}
    wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz -O java.tar.gz
    tar -zxvf java.tar.gz -C ${javaHome} --strip-components 1
}

initMongoDB(){
    if [ -d ${mongoDBHome} ];then
        rm -rf ${mongoDBHome}
    fi
    mkdir ${mongoDBHome}
    cd ${mongoDBHome}
    wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-5.0.8.tgz -O mongodb.tgz
    tar -zxvf mongodb.tgz -C ${mongoDBHome} --strip-components 1
    sudo mkdir -p ${mongoDBHome}/db
    sudo mkdir -p ${mongoDBHome}/log
    sudo chown `whoami` ${mongoDBHome}/db     # 设置权限
    sudo chown `whoami` ${mongoDBHome}/log    # 设置权限
}

javaInstall(){
    echo "检测 java环境..."
    if [ -x "$(command -v java)" ]; then
        echo "检测到 java 已安装!"
    else
        if [ -r /etc/os-release ]; then
            lsb_dist=$(source /etc/os-release && echo ${ID})
        fi
        if [ "${lsb_dist}" == "centos" ]; then
                echo "安装 java-17 环境..."
                initJava
            echo "安装 java-17 环境...安装完成!"
        else
            echo "非centos环境请自行安装 java-17!"
            exit 1
        fi
    fi
}

mongoDBInstall(){
    echo "检测 mongo 环境..."
    if [ -x "$(command -v mongo)" ]; then
        echo "检测到 mongo 已安装!"
    else
        if [ -r /etc/os-release ]; then
            lsb_dist=$(source /etc/os-release && echo ${ID})
        fi
        if [ "${lsb_dist}" == "centos" ]; then
                echo "安装 mongo 环境..."
                initMongoDB
            echo "安装 mongo 环境...安装完成!"
        else
            echo "非centos环境请自行安装 mongo!"
            exit 1
        fi
    fi
}

setEnv(){
		echo "开始配置环境"
		# 配置JAVA_HOME环境变量
        jdkHomeEnvIndex=$(grep -En "^export JAVA_HOME.*" /etc/profile | awk -F: '{print $1}')
        if [ ${jdkHomeEnvIndex} ];then
                sed -iE "$jdkHomeEnvIndex s%JAVA_HOME.*%export JAVA_HOME=$javaHome%g" /etc/profile
        else
                sed -i "\$a export JAVA_HOME=$javaHome"  /etc/profile
        fi
        
        # 配置CLASSPATH环境变量
        jdkClsPathEnvIndex=$(grep -En "^export CLASSPATH.*" /etc/profile | awk -F: '{print $1}')
        if [ ${jdkClsPathEnvIndex} ];then
                sed -iE '$jdkClsPathEnvIndex s%.*CLASSPATH.*%export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.ja%g' /etc/profile
        else
                sed -i '$a export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' /etc/profile
        fi

		# 配置MongoDB_HOME环境变量
        mongoHomeEnvIndex=$(grep -En "^export MongoDB_HOME.*" /etc/profile | awk -F: '{print $1}')
        if [ ${mongoHomeEnvIndex} ];then
                sed -iE "$mongoHomeEnvIndex s%MongoDB_HOME.*%export MongoDB_HOME=$mongoDBHome%g" /etc/profile
        else
                sed -i "\$a export MongoDB_HOME=$mongoDBHome"  /etc/profile
        fi

		# 配置Java和mongoDB的PATH，由于均有PATH无法精准匹配替换，故选择末尾追加方式
        sed -i '$a export PATH=$JAVA_HOME/bin:$PATH' /etc/profile
        sed -i '$a export PATH=$MongoDB_HOME/bin:$PATH'  /etc/profile
        source /etc/profile
        echo "环境配置完毕!"
        echo $(java -version)
        echo $(mongo -version)
}

javaInstall
mongoDBInstall
setEnv
