<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#term{
width:100%;
height:95%
}
</style>
<link rel="stylesheet" type="text/css" href="/static/css/jquery.terminal.css">
<script type="text/javascript" src="/static/commons/admin.js"></script>
<script type="text/javascript" src="/static/jquery/jquery.terminal.min.js"></script>
<script type="text/javascript" src="/static/jquery/jquery.mousewheel.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#term').terminal(function(command, term){
		
	},
	{
		greetings: '',
		name: '',
		//height: 400,
		prompt: ''
	});
});
</script>
<div style="padding:5px;height:auto">
	<select>
		<option value="cndalwas03vl.cn.fid-intl.com" selected>WebX</option>
	</select>
	<input id="termUserName" type="text" placeholder="用户�?"/>
	<input id="termPassword" type="text" placeholder="密码">
	<a href="#" class="easyui-linkbutton" iconCls="icon-back" onclick="connect()">连接</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="disconnect()">断开</a>
</div>
<div id="term"></div>
