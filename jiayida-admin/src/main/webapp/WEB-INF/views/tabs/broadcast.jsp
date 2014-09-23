<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="resources/js/common.js"></script>
<script>
function doBroadcast(jcntId){
	var form = new Object();
	form.title = $('#broadcast_title').val();
	form.text = $('#broadcast_content').val();
	form.senderId = UC.userId;	
	
	checkAndPush(form, 'push/broadcast.json');
}
</script>
<input id="broadcast_title" type="text" placeholder="标题" size="92"/><br/>
<textarea id="broadcast_content" rows=10 cols=100></textarea>
<input type="button" value="发送" onclick="doBroadcast('#broadcast_content')">
<input type="button" value="清空" onclick="clearInput('#broadcast_content')">