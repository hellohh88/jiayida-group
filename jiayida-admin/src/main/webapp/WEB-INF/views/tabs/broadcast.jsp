<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
</style>
<script type="text/javascript" src="/static/commons/admin.js"></script>
<script>
var bcEditor;
$(function() {
	if(bcEditor){
		//try{
			bcEditor.destroy();
		//}catch(e){
		//	console.log(e.message);
		//}
		console.log('destroyed');
	}
	
	bcEditor = UE.getEditor('broadcast2_content', {
		serverUrl: '${contextRoot}' + 'ueditor.do',
		initialFrameWidth: 1000,
		initialFrameHeight: 500,
		autoHeightEnabled: false,
		autoFloatEnabled: false,
		enableAutoSave: false
	});
});

function doBroadcast(jcntId){
	var form = new Object();
	form.title = $('#broadcast2_title').val();
	form.text = bcEditor.getContentTxt();
	form.senderId = UC.userId;	
	form.html = bcEditor.getContent();
	//form.senderId = ${userId};
	checkAndPush(form, 'push/broadcast.json');
}
</script>
<input id="broadcast2_title" type="text" placeholder="标题" size="92"/><br/>
<div id="broadcast2_content"></div>

<input type="button" value="发送" onclick="doBroadcast('#broadcast2_content')">
<input type="button" value="清空" onclick="bcEditor.execCommand('cleardoc')">
