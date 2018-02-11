# J-lunker

[English Version](README.md)

## 用J-lunker来做啥

J-lunker可以在线运行任意前端代码，并且可以在代码被编辑之后，J-lunker会立即重新运行他们。它可以让你很方便的将代码及其结果和行为分享给他人。

J-lunker和embed.plnkr.co在功能、用法上都非常相似，就连名字也很相似不是吗？

## 为啥需要J-lunker

你可能已经知道了，embed.plnkr.co的功能和J-lunker几乎是一样的了，那为啥还需要J-lunker呢？这里是一些原因：

- **避免被GFW干扰**：这是我创造J-lunker的最主要原因，GFW在我们使用plunker来分享和运行代码的过程中，制造了太多的麻烦了，Jigsaw的demo代码的读者们常常抱怨这一点。
- **更快的速度**：我在国内部署了一个[J-lunker的服务器](http://rdk.zte.com.cn/j-lunker)，这样就可以让多数Jigsaw的demo代码读者享受到更快的代码打开和运行速度了，相信他们会很开心的。
- **只将代码及其运行效果共享给授信的人，而非所有人**：J-lunker极其轻量，因此它可以非常容易的[部署](https://github.com/rdkmaster/j-lunker/blob/master/README.zh.md#%E5%A6%82%E4%BD%95%E9%83%A8%E7%BD%B2)到任何范围可控且安全的环境中去，因此你就不需要担心你将代码发给plunker上去运行之后，被不信任的人（包括plunker在内）偷走了。

如果上述任何一个理由也适合你，那么J-lunker就是一个更好的选择。

## 代码持久化在哪

J-lunker本身不永久保存被运行的代码，代码由J-lunker的用户自行保存，J-lunker只是提供在线运行他们的功能。如果你和[Jigsaw](https://github.com/rdkmaster/jigsaw)、[angular.io](https://angular.io)、[angular.cn](https://angular.cn)那样，也有大量需要在线演示的代码的话，那J-lunker对你来说是很适合的工具。自行持久化代码的好处是你可以很容易通过CI或者其他脚本来更新或者生成这些代码。

## 如何使用

J-lunker的用法和embed.plnkr.co极其相似。拷贝下面的代码，保存到一个文件中去，假设命名为`embed.html`，使用任意的浏览器打开它，你应该可以立即看到J-lunker运行后的效果了。

```
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
  <form id="mainForm" method="post" target="_self"
  		action="http://rdk.zte.com.cn/rdk/service/app/j-lunker/server/eval">
    <input type="hidden" name="option[show]" value="index.html,preview" />
    <input type="hidden" name="entries[asset/styles.css][content]" value="
h1 {
  font-size: 30px;
  transition: .5s;
}

h1:hover {
  color: red;
}

a {
  cursor: pointer;
  transition: .3s;
}

a:hover {
  color: blue;
}
" />
    <input type="hidden" name="entries[script/script.js][content]" value="
function gotoProject() {
  window.open('https://github.com/rdkmaster/j-lunker');
}
    ">
    <input type="hidden" name="entries[index.html][content]" value="
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;title&gt;J-lunker basic template&lt;/title&gt;
  &lt;link rel=&quot;stylesheet&quot; type=&quot;text/css&quot; href=&quot;asset/styles.css&quot;&gt;
  &lt;script type=&quot;text/javascript&quot; src=&quot;script/script.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Hello J-lunker!&lt;/h1&gt;
&lt;p&gt;
  This is the basic template.
  &lt;a onclick=&quot;gotoProject()&quot;&gt;Click here to star us.&lt;/a&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
    ">
    <input type="hidden" name="title" value="J-lunker basic template." />
  </form>
  <script>document.getElementById("mainForm").submit();</script>
</body>
</html>
```

这个`embed.html`文件没有任何依赖，可以将它保存到你的web服务器下的任意目录，这样你就可以通过对应的链接来将他分享给任何人了，或者也可以将代码插入在你的文档、文章中去。使用CI或者脚本来创建这样的文件是很简单的事情。

注意到这个文件的核心部分是一个表单（form），以及一些隐藏了的inputs。这些inputs的`name`属性值定义了一个J-lunker可识别的属性，`value`定义了该属性的值。J-lunker目前可以支持的属性有：

- `option[show]`：关键字`option`表明这里定义的是一个选项，`show`是这个选项的名字，它的值是`index.html,preview`，这个选项告诉J-lunker在页面准备继续之后，就打开`index.html`这个文件，以及打开运行效果预览区。
- `entries[asset/styles.css][content]`：`entries`用于定义一个文件，`asset/styles.css`是文件名和路径。此属性的值就是文件的内容。注意需要对文件内容做uri编码。
- `title`：此属性用于定义运行结果的页面的标题。

这里给出Jigsaw的生产环境中的live demo的代码作为例子：<http://rdk.zte.com.cn/j-lunker>。

我们的[CI环境](https://travis-ci.org/rdkmaster/jigsaw/branches)每天自动检查两遍<http://rdk.zte.com.cn/j-lunker>这个站点以确保它是可用的。

## 如何部署

如果你只需要运行你的代码，你是无需部署J-lunker服务器的，请先阅读[这个小节](https://github.com/rdkmaster/j-lunker/blob/master/README.zh.md#%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8)，然后再决定是否继续按照这个小节的说明部署你自己的J-lunker服务器。

这个小节说明了如何部署一台独立的J-lunker服务器，由此，你就可以使用你自己部署的J-lunker服务器来运行你的代码了，被运行的代码不需要发送到公网上，因此被运行的代码的安全性就可以得到保障。

详细步骤如下：

1. 克隆或者[下载](https://codeload.github.com/rdkmaster/j-lunker/zip/master)这个仓库的代码，并且解压缩到一个任意目录，最好不要解压到有空格或者中文的目录中。
2. J-lunker的服务端需要jre1.8以上，如果你的运行环境上没有，则请安装或者设置JAVA_HOME指向jre1.8。如果你的环境无法安装或者不方便设置环境变量，你也可以将jre1.8拷贝到`proc/bin/jre`目录下。
3. 如果你想将J-lunker部署在Windows上，或者只想试一试，那么双击`start.bat`就可以启动J-lunker的服务端和web服务器了。接下来你可以按照[这个小节](https://github.com/rdkmaster/j-lunker#%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8)的方法来测试你自己的J-lunker服务器了。别忘了将例子中的`http://rdk.zte.com.cn`改为`http://localhost:8080`。

如果你想将J-lunker部署在其他操作系统上，则还要继续：

1. 配置你的web服务器，这里用nginx作为例子。首先你需要在nginx.conf中的server节点下添加一个反向代理配置：

```
location /rdk/service {
    proxy_pass http://localhost:5812;
}
```

这个配置项告诉nginx将所有包含`/rdk/service`关键字的URL转发给J-lunker的服务器，别忘了需要重启一下nginx。

你可以对比这个[文件](https://github.com/rdkmaster/j-lunker/blob/master/nginx-1.11.9/conf/nginx.conf)，它也许可以帮助你解决这方面的配置问题。

2. 将`www`目录设置为你的web服务器的根目录，如果你的web服务器已经有一个根了，则可以将下面这几行插入到nginx.conf中的server节点下

```
location /j-lunker {
    root   /dir/to/j-lunker/www/;
    index  index.html index.htm;
}
```

你可以对比这个[文件](https://github.com/rdkmaster/j-lunker/blob/master/nginx-1.11.9/conf/nginx.conf)，它也许可以帮助你解决这方面的配置问题。

3. 将web服务器的监听端口改为任何你喜欢的，默认是`8080`。
4. 到`proc/bin`目录下，执行`sh run.sh`命令，它将启动J-lunker的服务端，再次提醒，J-lunker的服务端需要jre1.8以上。
5. 至此大功告成，接下来你可以按照[这个小节](https://github.com/rdkmaster/j-lunker#%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8)的方法来测试你自己的J-lunker服务器了。别忘了将例子中的`http://rdk.zte.com.cn`改为`http://localhost:8080`。
6. 如果你碰到了任何困难，欢迎给我提issue。

## 共创共建

我非常欢迎你给我推送PR。

J-lunker的[默认首页](http://rdk.zte.com.cn/j-lunker)现在非常简陋，而且我不会有太多的时间花在它上面，我很希望有人能够帮我完善它，具体请参考[这个issue](https://github.com/rdkmaster/j-lunker/issues/1)。
