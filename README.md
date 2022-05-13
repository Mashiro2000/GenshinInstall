# <p align="center">GenshinInstall</p>
> <p align="center">某动漫游戏一键部署脚本</p>
> 
> 某动漫游戏仓库地址:[点我](https://github.com/Grasscutters/Grasscutte)


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

### 创建账号

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/createAccount.png)


## 客户端部署

### 下载Fiddle代理转发工具
- [Download](https://www.telerik.com/download/fiddler)

#### 配置工具
##### 点击option
> 位置如图

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/1.png)

##### 点击https
>配置如下

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/2.png)

##### 点击connections
> 端口号应配置除8888外的任一端口，端口范围0-65535

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/3.png)

##### 配置代理转发脚本
> 点击Rulers -> Customize Rulers，配置转发脚本

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/4.png)

> 脚本如下，其中 yourIP，应换成您的服务器外网IP

```
/* Original script by NicknameGG, modified for Grasscutter by contributors. */
import System;
import System.Windows.Forms;
import Fiddler;
import System.Text.RegularExpressions;

class Handlers
{
    static function OnBeforeRequest(oS: Session) {
        if(oS.host.EndsWith(".yuanshen.com") || oS.host.EndsWith(".hoyoverse.com") || oS.host.EndsWith(".mihoyo.com")) {
            oS.host = "yourIP"; // This can also be replaced with another IP address.
        }
    }
};
```

#### 下载国际服或换区工具
> 国际服地址，自行谷歌
> 换区工具[Snap Genshin](https://www.snapgenshin.com/)，按照教程自行切换

####  游戏启动器
> [GrassClipper启动器](https://github.com/Grasscutters/GrassClipper/releases/tag/v0.9.9)
> 选择启动官方服务器

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/5.png)

> 如遇到HTTP认证问题，如下图，选择`yes`

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/6.png)

#### 启动顺序
> MongoDB > Grasscutter > Fiddler > 启动器

#### 游戏截图

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/7.png)

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/8.png)

![](https://cdn.jsdelivr.net/gh/Mashiro2000/GenshinInstall@main/image/9.png)
