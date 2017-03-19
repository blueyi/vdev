Vagrantfile
===========

提前下载好镜像，并命令为`ubuntu16.04.box`，放在上层目录，然后执行`vagrant up`即可。本文采用的镜像为官方`ubuntu/xenial64`，由于自动下载太慢，所以采用手动下载的形式，如果想自动下载，注释掉`Vagrantfile`中的`config.vm.box_url = "file://../ubuntu16.04.box"`即可。
使用：
```shell
git clone vagrant_dev vdev
cd vdev
vagrant up
```

文件说明：

* `Vagrantfile`：Vagrant 的配置文件
* `bootstrap.sh`：镜像初始化后自动运行的脚本
* `sources.list.cn`：Ubuntu16.04的国内镜像源

**box下载站**
* <https://github.com/chef/bento>
* <http://www.vagrantbox.es/>
* ubuntu官网：<https://cloud-images.ubuntu.com/>

**vagrant box常用命令**
这些命令可以在任意位置执行
* `vagrant box add <box_name> <box_file>` 添加名为box_name的box，默认应该有一个名为`base`的box，`vagrant init`将默认采用名为base的box初始化；以box_file为源box，box_file即可以是本地文件，也可以是远程URL，或者是官方`ubuntu/xenial64`
* `vagrant box list` 显示当前已经添加的box列表
* `vagrant box remove <name>` 移除box

**vagrant常用命令**
这些命令需要在指定的vagrant环境目录下执行，也就是在含有`Vagrantfile`的文件中执行
* `vagrant init` 将当前目录初始化vagrant目录，虚拟机启动后该目录将默认与虚拟机系统中的`/vagrant`目录同步
* `vagrant up` 启动当前目录对应的虚拟机，如果没有指定box，则默认导入当前已经存在box
* `vagrant ssh` 通过ssh连接到虚拟机，windows下需要使用第三方SSH工具，或者直接使用gitbash自带的
* `vagrant halt` 关闭当前虚拟机
* `vagrant suspend` 挂起当前虚拟机，相当于休眠
* `vagrant resume` 恢复一个挂起的虚拟机
* `vagrant reload` 重新载入配置文件`Vagrantfile`
* `vagrant reload --[no-]provision`  启用或不启用开机的布署，例如本配置文件中的shell脚本将只会在第一次启动时执行一次。如果修改了shell脚本和配置文件之后，希望重新载入配置文件后再次运行shell脚本，则需要该参数
* `vagrant status` 查看当前虚拟机的状态
* `vagrant global-status` 查看当前用户的所有虚拟机状态
* `vagrant destroy` 强制停止当前正在运行的虚拟机，并删除其占用的资源，但并不会删除该虚拟机实际的box文件，依然可以通过up来启动，要删除对应的box，需要使用`vagrant box remove <name>`
* `vagrant package` 将当前虚拟机打包为一个box文件，并放在当前目录下，名为`package.box`

上面这些命令几乎都可以在其后面接一个id来成为全局命令，每一个虚拟机都有一个唯一的全局id，可以通过`vagrant global-status`来查看

另外`vagrant`还有一些其他命令，可以通过`-h`查看

`Vagrantfile`中可以有多份配置，来一次启动多台虚拟机

**一些默认配置**
* 虚拟机IP为`192.168.33.10`
* 虚拟机的用户名和密码为`vagrant`
* 默认创建的虚拟机box命名为`ubuntu/xenial64`，可以在`Vagrantfile`修改为其他名字
* 默认安装的环境请参见`bootstrap.sh`文件

环境版本：`Vagrant 1.9.2`, `VirtualBox 5.1.16`

**注意事项**
1.使用 Apache/Nginx 时会出现诸如图片修改后但页面刷新仍然是旧文件的情况，是由于静态文件缓存造成的。需要对虚拟机里的 Apache/Nginx 配置文件进行修改：
```
# Apache 配置（httpd.conf 或者 apache.conf）添加：
EnableSendfile off

# Nginx 配置（nginx.conf）添加：
sendfile off;
```

2.要删除虚拟机及整个环境目录，首先进行`destroy`，然后删除创建的目录，最后删除相应的box。注意备份代码。

3.手动获取vagrant官方box的方法：
<http://stackoverflow.com/questions/10155708/where-does-vagrant-download-its-box-files-to>
其实官方的Ubuntu最新的ubuntu版本是从ubuntu官方获取的，Ubuntu官方提供的镜像有专门支持vagrant的版本，例如Ubuntu16.04的镜像：<https://cloud-images.ubuntu.com/xenial/current/>
下载后是一个以box或者tar为后缀的文件，都可以直接通过`vagrant box add`来添加。后缀为box的文件实际上就是个压缩文件


4.虚拟机升级之后出现如下错误的解决方法：
```
default: The guest additions on this VM do not match the installed version of
default: VirtualBox! In most cases this is fine, but in rare cases it can
default: prevent things such as shared folders from working properly. If you see
default: shared folder errors, please make sure the guest additions within the
default: virtual machine match the version of VirtualBox you have installed on
default: your host and reload your VM.
```
通过安装vagrant的vagrant-vbguest插件的自动升级guest addition
```
vagrant plugin install vagrant-vbguest
```
然后关闭虚拟机后再重新启动即可，有可能需要多次重新启动
