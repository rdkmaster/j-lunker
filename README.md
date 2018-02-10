# J-lunker

## What j-lunker can do

J-lunker evaluates your codes online, and your codes will be re-evaluated as soon as they are modified. It is convenient to share the codes and their result/behavior to someone else.

J-lunker is very similar to embed.plnkr.co, including the UI and the usage, even the names are very similar too :)

## Why j-lunker

As you may alreay know, embed.plnkr.co is doing the exactly samething, and it is amazing, so why we need j-lunker? Here are the reasons:

- **GFW troubles free**: This is the main reason why I create j-lunker. The GFW has been making a lot of troubles, including sharing and evaluating codes online with plunker. The readers of Jigsaw's demo code complain a lot about this.
- **Faster network access**: I deployed an instance of j-lunker in the mainland of China, which is most of Jigsaw's document readers are located at, they will be happy if the demo code shows and evaluates faster.
- **Evaluate codes to authorized readers, but not for everyone**: J-lunker is very very lightweight, and quite easy to [deploy](https://github.com/rdkmaster/j-lunker#how-to-deploy), it can even deployed with a PC! And therefor, you can use j-lunker within a contained and secure environment. Because of this, you do not need to worry the codes are stolen by someone unexpected or by plunker itself when sending them to plunker.

J-lunker is a better choice for you if you are having one of these reasons.

## Where are the codes stored

J-lunker does not store the codes permanently, its users store them. J-lunker just only tries to evaluate the codes. This is nice if you have a lot of codes to be evaluated like the demos of [Jigsaw](https://github.com/rdkmaster/jigsaw) or [angular.io](https://angular.io) or [angular.cn](https://angular.cn). Storing the codes by yourself makes it very easy to generate or update the codes automatically by some tool like CI or scripts.

## How to use

The usage is very similar to embed.plnkr.co, copy and save the following code to a html file, let say `embed.html`, open it with your favourite browser, and you should see the codes are evaluated in j-lunker.

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

This `embed.html` is totally dependency free, and can be saved anywhere within your web server, therefor you can share it to anyone with a simple link or referred in your api documents/articles. It is easy to generate the file automatically by CI or any other scripts.

Notice that the core of this file is a form, with a few hidden inputs, the `name` property of the inputs defines a property for j-lunker, and the `value` of the inputs defines the value of the specified property. J-lunker supports the following property now:

- `option[show]`: the key word `option` is the type of the property, and `show` is the option key, the value `index.html,preview` tells j-lunker to open `index.html` file and the evaluating box when the page is loaded.
- `entries[asset/styles.css][content]`: `entries` is a type, and `asset/styles.css` defines a file, located at `asset` dir and the name is `styles.css`. The value of this property is the content of the file, uri encoding is needed.
- `title`: this property defines the title of the evaluated page.

Go and check the live demos of Jigsaw: <http://rdk.zte.com.cn/j-lunker>

## How to deploy

You do not need to deploy j-lunker if you just simply want to evaluate your codes, check [this section](https://github.com/rdkmaster/j-lunker#how-to-use) before you start to deploy your own j-lunker server.

This section tells you how to deploy a j-lunker server in your own server, by doing this, you can evaluate the codes within your own server, the codes will not be sent to public and they are safe.

Follow these steps:

1. Clone or [download](https://codeload.github.com/rdkmaster/j-lunker/zip/master) this repo and unzip to any dir.
2. J-lunker's server need jre 1.8 or later, please install jre 1.8 or add a JAVA_HOME environment variable. You can also copy the jre to `proc/bin/jre` in case of you can not install jre 1.8 - maybe you need another version of jre.
3. Just simply run `start.bat`, j-lunker's server and web server should start running if you are going to deploy j-lunker in Windows or just for a test. You can try your j-lunker by following [this section](https://github.com/rdkmaster/j-lunker#how-to-use). Remember to replace the target server from `http://rdk.zte.com.cn` to `http://localhost:8080`.

There are some more steps to do if you are going to deploy j-lunker in Linux or any other OS.
1. Config your web server, I will show you how to do this by using nginx as the web server. You need to add a reverse proxy config by adding the following lines to nginx.conf under the server section:

```
location /rdk/service {
    proxy_pass http://localhost:5812;
}
```

This config tell nginx to proxy every `/rdk/service` request to j-lunker's server. Don't forget to restart or reload nginx.

Check [this file](https://github.com/rdkmaster/j-lunker/blob/master/nginx-1.11.9/conf/nginx.conf) if you need to shoot some trouble with your web server.

2. Make the `www` dir as the root of your web server, or add the following lines to your nginx.conf in case of your web server has other root:
```
location /j-lunker {
    root   /dir/to/j-lunker/www/;
    index  index.html index.htm;
}
```

Check [this file](https://github.com/rdkmaster/j-lunker/blob/master/nginx-1.11.9/conf/nginx.conf) if you need to shoot some trouble with your web server.

3. Change the listening port of the web server to any one you like, the default value is `8080`.
4. Goto `proc/bin` dir, and run `sh run.sh` command, j-lunker's server should start running now. Notice once more, the server needs jre 1.8+.
5. Everything is done, you can try your own j-lunker by following [this section](https://github.com/rdkmaster/j-lunker#how-to-use). Remember to replace the target server from `http://rdk.zte.com.cn` to `http://localhost:8080`.
6. Feel free to leave me an issue if you have any problem while deploying j-lunker.

## Contributing

Any PR is welcomed, please feel free to push me PRs.
