<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
</style>
<script type="text/javascript" src="/static/commons/admin.js"></script>
<script>
var bcEditor;
$(function() {
	console.log('${contextRoot}');
/*	
    bcEditor = UE.getEditor('broadcast2_content', {
    	serverUrl: '${contextRoot}' + 'ueditor.do',
		initialFrameWidth: 1000,
		initialFrameHeight: 500,
		autoHeightEnabled: false,
		autoFloatEnabled: false,
		enableAutoSave: false
    });

    $('#bc_send').click(function(){
    	bcEditor.sync();
    	doBroadcast('#broadcast2_content');
        //$('#bc_form').submit();
    });
*/    

/*
	if(bcEditor){
		//try{
			bcEditor.destroy();
		//}catch(e){
		//	console.log(e.message);
		//}
		console.log('destroyed');
	}
*/	
	bcEditor = UE.getEditor('broadcast2_content', {
		serverUrl: '<%=request.getContextPath()%>' + '/ueditor.do',
		initialFrameWidth: 1000,
		initialFrameHeight: 500,
		autoHeightEnabled: false,
		autoFloatEnabled: false,
		enableAutoSave: false
	});

});

function doBroadcast(jcntId){
	//bcEditor.sync();
	
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
<!-- <form id="bc_form" method="post" target="_blank"> -->
	<div id="broadcast2_content"></div>
	<input id="bc_send" type="button" value="发送" onclick="doBroadcast('#broadcast2_content');">
	<input type="button" value="清空" onclick="bcEditor.execCommand('cleardoc')">
<!-- </form> -->

