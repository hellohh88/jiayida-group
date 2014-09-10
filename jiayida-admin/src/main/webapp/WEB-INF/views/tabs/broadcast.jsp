<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
form {
	margin: 0;
}
textarea {
	display: block;
}
</style>
<!-- <link rel="stylesheet" href="resources/kindeditor/themes/default/default.css" />
<script charset="utf-8" src="resources/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="resources/kindeditor/lang/zh_CN.js"></script> -->
<script type="text/javascript" src="resources/js/common.js"></script>
<script>
/*
var editor;
$(function() {
	editor = KindEditor.create('textarea[name="content"]', {
		resizeType : 2,
		//allowPreviewEmoticons : false,
		//allowImageUpload : false,
		items : [
			'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
			'insertunorderedlist']
	});
});
*/
function doBroadcast(jcntId){
	var form = new Object();
	form.title = $('#broadcast_title').val();
	form.text = $('#broadcast_content').val();
	form.userId = UC.userId;	
	
	checkAndPush(form, 'push/broadcast.json');
}
/*
function doClearKindEditor(){
	editor.html('');
}
*/
</script>
<!-- <form>
	<textarea name="content" style="width:1050px;height:600px;visibility:hidden;" placeholder="最多5000字"></textarea><br/>
	<input type="button" value="发送" onclick="doPush()">
	<input type="button" value="清空" onclick="doClearKindEditor()">
</form> -->
<input id="broadcast_title" type="text" placeholder="标题" size="92"/><br/>
<textarea id="broadcast_content" rows=10 cols=100></textarea>
<input type="button" value="发送" onclick="doBroadcast('#broadcast_content')">
<input type="button" value="清空" onclick="clearInput('#broadcast_content')">