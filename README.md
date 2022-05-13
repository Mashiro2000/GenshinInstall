# <p align="center">GenshinInstall</p>
> <p align="center">某动漫游戏一键部署脚本</p>
> 某动漫游戏仓库地址[点我](https://github.com/Grasscutters/Grasscutte)


## 免责声明
- 本仓库发布的`GenshinInstall`项目中涉及的任何脚本，仅用于测试和学习研究，禁止用于商业用途

- 如果本项目存在执行错误或者造成不可逆转的系统问题，概不负责!

- 本项目作为`shell`编程的初尝试，可能存在一系列问题，欢迎提出`issues`，但杜绝一切催更行为!

- 本项目基于`centos7.6`进行开发，其它系统无法执行，望周知!

- 本项目所有`shell`脚本参考自[Oreomeow](https://github.com/Oreomeow)

- 如果任何单位或个人认为该项目可能涉嫌侵犯其权利，则应及时通知并提供身份证明，所有权证明，我们将在收到认证文件后删除相关文件.

> 您使用或者复制了本仓库且本人制作的任何笔记，则视为`已接受`此声明，请仔细阅读



## 项目构成

| 文件         | 描述                             |
| ------------ | -------------------------------- |
| install.sh   | `java`和`MongoDB`环境安装        |
| structure.sh | 构建游戏`jar`包                  |
| setConfig.sh | 配置config.json文件              |
| run.sh       | 运行`mongoDB`数据库与游戏`jar`包 |
| LICENSE      | 许可证文件                       |
| README.md    | 自述文件                         |



## 使用教程
```bash
yum install -y git

git clone https://ghproxy.com/https://github.com/Mashiro2000/GenshinInstall.git scripts

mv ./scripts/* ./

chmod 777 *.sh

bash install.sh

bash structure.sh

bash setConfig.sh

bash run.sh
```
