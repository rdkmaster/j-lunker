<!DOCTYPE html>
<html>
<head>
	<title>hello j-lunker</title>
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="../assets/favicon.ico">
    <script defer src="../assets/lib/fontawesome-free-5.0.4/js/fontawesome-all.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../assets/lib/codemirror.css">
	<style type="text/css">
		html {
			height: 100%;
		}
		body {
			margin: 0;
			padding: 0;
			font-size: 15px;
			font-family: Open Sans,Helvetica Neue,Helvetica,Arial,sans-serif;
			height: 100%;
		}
		.wrapper {
			display: flex;
			flex-direction: column;
			height: 100%;
		}
		.header {
			height: 30px;
			box-shadow: 0 1px 3px rgba(0,0,0,.12), 0 1px 2px rgba(0,0,0,.24);
			color: #333;
			background-color: #f5f5f5;
			line-height: 30px;
			text-align: middle;
			flex-grow: 0;
		}
		.content {
			flex-grow: 1;
		}
		.content .toolbar {
			float: left;
			width: 30px;
			box-shadow: inset 0 1px 3px rgba(0,0,0,.12), inset 0 1px 2px rgba(0,0,0,.24);
			background-color: #fafafa;
			margin-bottom: 2px;
			height: calc(100vh - 60px);
		}
		.content .toolbar button {
			background-color: #fafafa;
			border: 0;
			cursor: pointer;
			font-size: 18px;
			margin-top: 6px;
			width: 26px;
			height: 30px;
		}
		.content .code-box {
			float: left;
			margin-top: 2px;
			overflow: hidden;
			width: calc(50% - 15px);
		}
		.content .code-box .CodeMirror {
			margin: 2px 0 2px 0;
			height: calc(100vh - 94px);
			overflow: hidden;
		}
		.content .header {
			background-color: #416b79;
			width: 100%;
			height: 30px;
			color: #fff;
			line-height: 30px;
			text-align: middle;
			border: 0;
		}
		.content .eval-box {
			float: left;
			margin-top: 2px;
			width: calc(50% - 15px);
		}
		.content .eval-box iframe {
			border: 0;
			width: 100%;
			margin-top: 2px;
			height: calc(100vh - 94px);
		}
		.footer {
			background-color: #ececec;
			box-sizing: border-box;
			height: 27px;
			text-align: right;
			box-shadow: 0 -1px 3px #aaa;
			flex-grow: 0;
		}
		.footer button {
			border: 0;
			color: #333;
			background-color: #ececec;
			font-size: 16px;
			line-height: 27px;
			text-align: middle;
			margin-right: 12px;
			padding: 0;
		}
	</style>
</head>
<body>

<a style="position: fixed; left: 1000px" href="/app/j-lunker/web/index.html">refresh</a>

<div class="wrapper">
<div class="header">
	<img src="../assets/favicon.ico">
	tree/basic - Jigsaw Live Demo - Visit http://rdk.zte.com.cn for more detail.
</div>
<div class="content">
	<div class="toolbar">
		<button><i class="far fa-file-code"></i></button>
		<button><i class="fas fa-cog"></i></button>
	</div>
	<div class="code-box">
		<div class="header">
			<span style="margin-left: 12px;">app/app.component.html</span>
		</div>
		<textarea id="code">
			var a = 'ab';
			a.split('');

		</textarea>
	</div>
	<div class="eval-box">
		<div class="header">
			<span style="margin-left: 12px;">app/app.component.html</span>
		</div>
		<iframe src="http://rdk.zte.com.cn"></iframe>
	</div>
</div>
<div class="footer">
	<button><img src="../assets/favicon.ico"></button>
	<button><i class="fab fa-github-alt"></i></button>
</div>
</div>





<script type="text/javascript" src="../assets/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../assets/lib/codemirror.js"></script>
<script type="text/javascript">
	var editor = CodeMirror.fromTextArea($('#code')[0], {
		lineNumbers: true
	});

	var files = /* will-be-replaced-by-file-list */;
</script>
</body>
</html>