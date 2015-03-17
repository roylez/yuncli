
## yuncli

`yuncli`是一个模仿[lftp][1]的百度云命令行客户端。用ruby编写，没有任何强制性的gem
依赖。

已经实现以下命令功能：

    help          显示本帮助
    auto_server   自动选择最快的服务器
    cd            更改服务器目录
    cp OLD NEW    在服务器复制文件
    debug on      打开debug显示
    da URL        添加离线下载
    dl            查看离线下载列表
    find FILE     递归在当前目录查找文件
    get FILE      下载单个文件
    url FILE      打印单个文件的下载链接
    history       历史命令
    lcd           切换本地目录
    ls [DIR]      列出文件列表
    mget PATTERN  批量下载(单线程)
    mkdir PATH    建立一个目录
    mput PATTERN  批量上传(单线程)
    mrm PATTERN   批量删除
    mv FILE FILE  重命名一个文件或目录
    pwd           当前目录
    put FILE      上传单个文件
    quota         容量使用信息
    rm FILE...    删除文件
    server        显示当前使用的服务器
    servers       显示可以使用的服务器列表
    quit          退出

百度登陆方面，因为懒惰直接采用了[bypy][2]的服务器进行登陆验证。第一次运行会自动
提示登陆，以后不再需要。

功能特点：

* 模仿lftp操作
* 采用readline库，支持历史命令记录，命令和目录补全
* 可以使用ruby自带`Net::HTTP`发送http请求，也可以使用[typhoeus][3]
* `class BaiduYun`可以单独使用，包含有大部分交互环境下支持的命令
* 暂时没有多线程支持
* **由于API限制，登陆后用户会被限制在`/apps/bypy`目录**

**如果有其他功能需要请给我留言**

[1]: http://lftp.yar.ru/
[2]: https://github.com/houtianze/bypy
[3]: https://github.com/typhoeus/typhoeus
