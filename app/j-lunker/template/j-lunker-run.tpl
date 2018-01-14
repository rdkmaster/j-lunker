<!DOCTYPE html>
<html>
<head>
	<title>hello j-lunker</title>
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="../../assets/favicon.ico">
    <script defer src="../../assets/lib/fontawesome-free-5.0.4/js/fontawesome-all.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../../assets/lib/codemirror.css">
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
		li {
			list-style: none;
			white-space:nowrap;
		}
		.icon-activated {
			color: #008fc7;
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
		.header .icon {
			cursor: pointer;
			font-size: 18px;
			float: right;
			margin: 6px 18px 0 0;
		}
		.header .activated {
		    background-color: white;
			font-size: 15px;
		    width: 36px;
		    padding: 4px 0 8px 0;
		    box-shadow: 1px -2px 1px #aaa;
		}
		.content {
			flex-grow: 1;
		}
		.content .splitor {
			float: left;
			cursor: e-resize;
			width: 4px;
			height: calc(100vh - 60px);
			background-color: #bbb;
		}
		.content .toolbar {
			float: left;
			width: 30px;
			box-shadow: inset 0 1px 3px rgba(0,0,0,.12), inset 0 1px 2px rgba(0,0,0,.24);
			background-color: #fafafa;
			margin-bottom: 2px;
			height: calc(100vh - 60px);
		}
		.content .toolbar .icon {
			cursor: pointer;
			font-size: 18px;
			margin: 12px 0 0 6px;
		}
		.content .code-tree {
			float: left;
			margin-top: 0px;
			overflow: hidden;
			width: 300px;
		}
		.content .code-box {
			float: left;
			margin-top: 0px;
			overflow: hidden;
			width: calc(50% - 169px);
		}
		.content .code-box .CodeMirror {
			margin: 2px 0 2px 0;
			height: calc(100vh - 62px);
			overflow: hidden;
			font-size: 14px;
			font-family: Consolas;
		}
		.content .eval-box {
			float: left;
			margin-top: 1px;
			width: calc(50% - 169px);
		}
		.content .eval-box iframe {
			border: 0;
			width: 100%;
			margin-top: 2px;
			height: calc(100vh - 63px);
		}
		.footer {
			background-color: #ececec;
			box-sizing: border-box;
			text-align: right;
			box-shadow: 0 -1px 3px #aaa;
			flex-grow: 0;
		}
		.footer .icon {
			font-size: 16px;
			line-height: 27px;
			text-align: middle;
			margin-right: 12px;
			cursor: pointer;
		}
		.loading-mask {
			position: fixed;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0,0,0,0.1);
			z-index: 1000;
			font-size: 20px;
			text-align: center;
			line-height: 100vh;
			display: none;
		}
		.file-entry-active {
			background-color: rgba(128, 185, 234, 0.76);
		}
	</style>
</head>
<body>

<a style="position: fixed; left: 1000px; z-index: 2000" href="/app/j-lunker/web/index.html">refresh</a>

<div class="wrapper">
<div class="header">
	<img src="../../assets/favicon.ico">
	<span>
		tree/basic - Jigsaw Live Demo - Visit http://rdk.zte.com.cn for more detail.
	</span>
	<span class="activated icon fas fa-play"></span>
	<span class="icon far fa-file-code"></span>
</div>
<div class="content">
	<div class="toolbar">
		<span class="icon-activated icon far fa-copy" onclick="toggleCodeTree()"></span>
		<span class="icon fas fa-cog"></span>
	</div>
	<div class="code-tree">
<ul><!-- to-be-replaced-with-code-tree --></ul>
	</div>
	<div class="splitor"></div>
	<div class="code-box">
		<textarea id="code">
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');
			var a = 'ab';
			a.split('');

		</textarea>
	</div>
	<div class="splitor"></div>
	<div class="eval-box">
		<iframe id="evaluator" src="http://localhost:8080/app/j-lunker/web/test.html"></iframe>
	</div>
</div>
<div class="footer">
	<span class="icon" style="margin-top:-2px"><img src="../../assets/favicon.ico"></span>
	<span class="icon fab fa-github-alt"></span>
</div>
</div>

<div class="loading-mask">
	Loading...
</div>

<script type="text/javascript" src="../../assets/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../../assets/lib/codemirror.js"></script>
<script type="text/javascript">

	var folder = /* to-be-replaced-with-folder */;
	var files = /* to-be-replaced-with-file-list */;
	var saveFileTimer = -1;
	var editingFile = '';
	var editor = CodeMirror.fromTextArea($('#code')[0], { lineNumbers: true });
	editor.on('change', function(instance, changeObj) {
		if (changeObj.origin == 'setValue') {
			// change triggered by setValue()
			return;
		}
		if (saveFileTimer != -1) {
			clearTimeout(saveFileTimer);
		}
		saveFileTimer = setTimeout(saveFile, 500);
	});

	$(document).bind('resize', onResize);
	$('.content .splitor').bind('mousedown', onMouseDown);

	function saveFile() {
		clearTimeout(saveFileTimer);
		saveFileTimer = -1;
		$.ajax({
			url: '/rdk/service/app/j-lunker/server/file',
			method: 'post', contentType: 'text/plain',
			data: JSON.stringify({ path: editingFile, content: editor.doc.getValue() }),
			success: function(data) {
				$('#evaluator').attr('src', '/' + folder + '/index.html');
			},
			error: function(err) {
				alert('send data to server error, detail: ' + err.responseText);
			}
		});
	}

	var needManualResize = false;

	function toggleCodeTree() {
		var $target = $('.content .code-tree');
		$target.toggle();
		// var hidden = $target.css('display') == 'none';
		// var offset = hidden ? '15px' : '165px';
		// $('.content .code-box').css('width', 'calc(50% - ' + offset + ')');
	}

	function toggleFolder(self, target) {
		var $target = $('#' + target);
		$target.toggle();
		// toggle icon
		var hidden = $target.css('display') == 'none';
		$('#' + self + ' svg')
			.removeClass(hidden ? 'fa-folder-open' : 'fa-folder')
			.addClass(hidden ? 'fa-folder' : 'fa-folder-open');
	}

	function loadFile(target, path) {
		if (saveFileTimer != -1) {
			saveFile();
		}

		var $loading = $('.loading-mask');
		if ($loading.css('display') != 'none') {
			// still loading...
			return;
		}
		$('.content .code-tree li').removeClass('file-entry-active');
		$('#' + target).addClass('file-entry-active');
		$loading.show();

		editingFile = folder + path;
		$.ajax({
			url: '/' + editingFile,
			success: function(data) {
					editor.doc.setValue(data);
					$loading.hide();
				},
			error: function(err) {
				alert('load data error, detail: ' + err.responseText);
			}
		});
	}

	var $dragging;
	function onMouseDown() {
		$dragging = $(this);
		var $prev = $dragging.prev();
		var $next = $dragging.next();
		$(document).bind('mousemove', onMouseMove);
		$(document).bind('mouseup', onMouseUp);
		// hide iframe to make sure it won't swallow the mousemove event
		$('#evaluator').hide();
	}

	function onMouseUp() {
		$dragging = undefined;
		$(document).unbind('mousemove', onMouseMove);
		$(document).unbind('mouseup', onMouseUp);
		// bring iframe back to view
		$('#evaluator').show();
	}

	function onMouseMove(event) {
		if (!$dragging) {
			return;
		}
		needManualResize = true;

		var maxWidth = document.body.clientWidth - 100;
		var newWidth = event.pageX - $dragging.prev().offset().left - 4;
		newWidth = newWidth > 100 ? newWidth : 100;
		newWidth = newWidth > maxWidth ? maxWidth : newWidth;
		var delta = $dragging.prev().width() - newWidth;
		$dragging.prev().width(newWidth + 'px');
		$dragging.next().width($dragging.next().width() + delta);

		$('#evaluator').width($('#evaluator').parent().width());
	}

	function onResize() {
		if (!needManualResize) {
			return;
		}
	}
</script>
</body>
</html>