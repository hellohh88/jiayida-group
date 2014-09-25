<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
/*
extarea {
	display: block;
}
*/
</style>
<script type="text/javascript" src="resources/js/admin.js"></script>
<script>
function doBroadcast(jcntId){
	var form = new Object();
	form.title = $('#broadcast2_title').val();
	form.text = $('#broadcast2_content').val();
	//form.senderId = UC.userId;	
	form.senderId = ${userId};
	//console.log(bcEditor.getContent());
	//console.log(form);
	//checkAndPush(form, 'push/broadcast.json');
}
</script>
<input id="broadcast2_title" type="text" placeholder="标题" size="92"/><br/>
<!-- <div id="broadcast2_content"></div> -->
<!-- <input type="button" value="清空" onclick="clearInput('#broadcast2_content')"> -->

<!-- 
 -->
<script id="broadcast2_content" name="content" type="text/plain">
</script>
<input type="button" value="发�?" onclick="doBroadcast('#broadcast2_content')">
<script type="text/javascript">
	var bcEditor = UE.getEditor('broadcast2_content', {
		UEDITOR_HOME_URL: 'resources/ueditor/', 
		serverUrl: 'ueditor.do',
		initialFrameWidth: 800,
		initialFrameHeight: 500,
		autoHeightEnabled: false,
		autoFloatEnabled: false
	});
</script>