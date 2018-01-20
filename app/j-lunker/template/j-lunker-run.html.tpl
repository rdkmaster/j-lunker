<!DOCTYPE html>
<html>
<head>
	<title>hello j-lunker</title>
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="icon" type="image/x-icon" href="../../assets/favicon.ico">
	<script defer src="../../assets/lib/fontawesome-free-5.0.4/js/fontawesome-all.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../../assets/lib/codemirror/codemirror.css">
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
			margin-left: -18px;
			cursor: pointer;
			padding-left: 6px;
		}
		.icon-activated {
			color: #416b79;
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
			overflow: hidden;
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
		.content .file-tree {
			float: left;
			margin-top: 0px;
			width: 300px;
			overflow: hidden;
			user-select: none;
			height: calc(100vh - 62px);
		}
		.content .file-tree .file-entry-activated {
			background-color: #416b79;
			color: #fff;
		}
		.content .file-tree .file-entry {
			font-size: 16px;
			line-height: 24px;
			font-family: Consolas;
			margin: 4px 0 0 -22px;
		}
		.content .code-box {
			float: left;
			margin-top: 0px;
			user-select: none;
			width: calc(50% - 169px);
		}
		.content .code-box .CodeMirror {
			margin: 2px 0 2px 0;
			height: calc(100vh - 62px);
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
		.close-button {
			position: fixed;
			left: 0;
			top: 0;
			z-index: 7;
			cursor: pointer;
			z-index: 1000;
			display: none;
		}
	</style>
</head>
<body>

<div class="wrapper">
<div class="header">
	<img src="../../assets/favicon.ico">
	<span>
		tree/basic - Jigsaw Live Demo - Visit http://rdk.zte.com.cn for more detail.
	</span>
</div>
<div class="content">
	<div class="toolbar">
		<span class="icon-activated icon far fa-copy" onclick="onTogglePanel('.content .file-tree')"></span>
		<span class="icon-activated icon far fa-file-code" onclick="onTogglePanel('.content .code-box')"></span>
		<span class="icon-activated icon fas fa-play" onclick="onTogglePanel('.content .eval-box')"></span>

		<span style="margin-top:24px" class="icon fas fa-cog"></span>
	</div>
	<div class="file-tree">
		<ul class="file-entry"><!-- to-be-replaced-with-file-tree --></ul>
	</div>
	<div class="splitor"></div>
	<div class="code-box">
		<textarea id="code" style="display:none;"></textarea>
	</div>
	<div class="splitor"></div>
	<div class="eval-box">
		<iframe id="evaluator"></iframe>
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

<div class="close-button"><i class="fas fa-times"></i></div>

<script type="text/javascript" src="../../assets/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../../assets/lib/codemirror/codemirror.js"></script>
<script type="text/javascript" src="../../assets/lib/codemirror/mode/javascript.js"></script>
<script type="text/javascript" src="../../assets/lib/codemirror/mode/css.js"></script>
<script type="text/javascript">

	var folder = /* to-be-replaced-with-folder */;
	var files = /* to-be-replaced-with-file-list */;
	var saveFileTimer = -1;
	var needManualResize = false;
	var editingFile = '';
	var editor = CodeMirror.fromTextArea($('#code')[0], { lineNumbers: true });
	editor.on('change', onEditorChange);

	$(window).bind('resize', onResize);
	$('.content .splitor').bind('mousedown', onMouseDown);
	$('.content .close-button span').bind('click', onTogglePanel);
	$('.close-button').bind('click', onTogglePanel);
	$('.content .file-tree').bind('mouseover', onToggleCloseButton);
	$('.content .file-tree').bind('mouseout', onToggleCloseButton);
	$('.content .code-box').bind('mouseover', onToggleCloseButton);
	$('.content .code-box').bind('mouseout', onToggleCloseButton);
	$('.content .eval-box').bind('mouseover', onToggleCloseButton);
	$('.content .eval-box').bind('mouseout', onToggleCloseButton);

	initStatus();

	function initStatus() {
		var options = location.search.substring(1).split('&');
		var preview = false;
		var openFile = 0;
		for (var i = options.length - 1; i >= 0; i--) {
			var option = options[i];
			var parts = option.split('=');
			if (parts[0] !== 'show') {
				continue;
			}
			var values = parts[1].split(',');
			var idx = values.indexOf('preview');
			if (idx != -1) {
				values.splice(idx, 1);
				preview = true;
			}
			openFile = findFileElementByPath(values[0]);

			break;
		}

		if (preview) {
			$('#evaluator').attr('src', '/' + folder + '/index.html');
		} else {
			onTogglePanel('.content .eval-box');
		}
		if (openFile == 0) {
			onTogglePanel('.content .code-box');
		} else {
			loadFile(openFile);
		}
	}

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

	function onEditorChange(instance, changeObj) {
		if (changeObj.origin == 'setValue') {
			// change triggered by setValue()
			return;
		}
		if (saveFileTimer != -1) {
			clearTimeout(saveFileTimer);
		}
		saveFileTimer = setTimeout(saveFile, 500);
	}

	function onTogglePanel(target) {
		target = this === window ? target : $(this).attr('x-target');
		var $target = $(target);
		var $button = getCorrespondingButton($target);
		if (elementVisible($target)) {
			$target.hide();
			$button.removeClass('icon-activated');
		} else {
			$target.show();
			$button.addClass('icon-activated');
		}
		var $splitors = $('.content .splitor');
		var $leftSplitor = $($splitors.get(0));
		if (elementVisible($leftSplitor.prev())) {
			$leftSplitor.show();
		} else {
			$leftSplitor.hide();
		}
		var $rightSplitor = $($splitors.get(1));
		if (elementVisible($rightSplitor.prev()) && elementVisible($rightSplitor.next())) {
			$rightSplitor.show();
		} else {
			$rightSplitor.hide();
		}
		resizePanels();
	}

	function getCorrespondingButton($target) {
		if ($target[0] === $('.content .file-tree')[0]) {
			return $('.content .toolbar .fa-copy');
		}
		if ($target[0] === $('.content .code-box')[0]) {
			return $('.content .toolbar .fa-file-code');
		}
		if ($target[0] === $('.content .eval-box')[0]) {
			return $('.content .toolbar .fa-play');
		}
	}

	var resizeIFrameTimer = -1;
	function resizePanels() {
		$('.close-button').hide();
		needManualResize = true;

		var maxWidth = window.innerWidth - 30;
		var $fileTree = $('.content .file-tree');
		if (elementVisible($fileTree)) {
			maxWidth -= $fileTree.width();
		}

		var $splitors = $('.content .splitor');
		$splitors.each(function(idx, splitor) {
			if (elementVisible(splitor)) {
				maxWidth -= 4;
			}
		});

		var $codeBox = $('.content .code-box');
		var $evalBox = $('.content .eval-box');
		var width = 0;

		if (elementVisible($codeBox)) {
			width += $codeBox.width();
		}
		if (elementVisible($evalBox)) {
			width += $evalBox.width();
		}
		$codeBox.width(maxWidth/width * $codeBox.width());
		$evalBox.width(maxWidth/width * $evalBox.width());

		// have to toggle iframe to apply the change of width, don't know why.
		var $frame = $('#evaluator');
		$frame.width($evalBox.width());
		$frame.hide();
		clearTimeout(resizeIFrameTimer);
		resizeIFrameTimer = setTimeout(function() { $frame.show() }, 100);
	}

	function toggleFolder(self, target) {
		var $target = $('#' + target);
		$target.toggle();
		// toggle icon
		var hidden = !elementVisible($target);
		$('#' + self + ' svg')
			.removeClass(hidden ? 'fa-folder-open' : 'fa-folder')
			.addClass(hidden ? 'fa-folder' : 'fa-folder-open');
	}

	function findFileElementByPath(path) {
		var target = 0;
		if (!path) {
			return target;
		}
		path = (path[0] == '/' ? '' : '/') + path;
		$('.content .file-tree .file-entry li').each(function(idx, li) {
			if ($(li).attr('x-file') == path) {
				target = $(li).attr('id');
			}
		});
		return target;
	}

	function loadFile(target) {
		if (saveFileTimer != -1) {
			saveFile();
		}
		if (!elementVisible($('.content .code-box'))) {
			onTogglePanel('.content .code-box');
		}

		var $loading = $('.loading-mask');
		if (elementVisible($loading)) {
			// still loading...
			return;
		}
		$('.content .file-tree li').removeClass('file-entry-activated');
		var $target = $('#' + target);
		$target.addClass('file-entry-activated');
		$loading.show();

		editingFile = folder + $target.attr('x-file');
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
		$('.close-button').hide();
	}

	function onMouseUp() {
		resizePanels();
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
		$('.close-button').hide();
		needManualResize = true;

		var maxWidth = window.innerWidth - 100;
		var newWidth = event.pageX - $dragging.prev().offset().left - 4;
		newWidth = newWidth > 100 ? newWidth : 100;
		newWidth = newWidth > maxWidth ? maxWidth : newWidth;
		var delta = $dragging.prev().width() - newWidth;
		$dragging.prev().width(newWidth + 'px');
		$dragging.next().width($dragging.next().width() + delta);

		$('#evaluator').width($('#evaluator').parent().width());
	}

	function onResize() {
		$('.close-button').hide();
		if (!needManualResize) {
			return;
		}
		resizePanels();
	}

	function onToggleCloseButton(event) {
		var $closeButton = $('.close-button');
		var offset = $(this).next().offset();
		var left = offset ? offset.left : window.innerWidth;
		$closeButton.css('left', left - 15);
		$closeButton.css('top', 32);

		if (event.type == 'mouseover') {
			$closeButton.attr('x-target', '.content .' + $(this).attr('class'));
			$closeButton.show();
		}
	}

	function elementVisible(element) {
		return $(element).css('display') != 'none';
	}
</script>
</body>
</html>