<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#massPush_form {
margin: 0;
padding: 10px 30px;
}

.massPush_item {
margin-bottom: 5px;
}

.massPush_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="/static/commons/admin.js"></script>
<script type="text/javascript">
var massPushTable = 'LOGIN_USER';
var massPushQuery;
var massEditor;

$(function() {
	// need order, uncomment here
	//var orderBy = getIdDescOrder();
	//initDataGrid('#massPush_grid', appName + 'search/' + massPushTable + '.json?orderBy=' + orderBy');
	
	// no need order
	initDataGrid('#massPush_grid', 'search/' + massPushTable + '.json');
	massPushQuery = '';
	
	if(massEditor){
		UE.delEditor('mass_push_content');
	}
	
	massEditor = UE.getEditor('mass_push_content', {
		serverUrl: '${contextRoot}' + 'ueditor.do',
		initialFrameWidth: '100%',
		initialFrameHeight: 300,
		//enableAutoSave: false
		saveInterval: 1000 * 60 * 60 * 24,
		toolbars: ue_massbars
	});
});

/**
 * 查询
 */
function searchMassPush() {
	massPushQuery = getQueryJson();
	searchDataGrid('#massPush_grid', massPushQuery);
}

/**
 * 查询条件
 */
function getQueryJson(){
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#massPush_fieldName_from').datebox("getValue");
	registerDateQuery.to = $('#massPush_fieldName_to').datebox("getValue");
	*/
	var json = {
		userName : $('#massPush_userName').val()
	};
	
	return json;
}

function showPushUserMessageDialog(){
	var rows = $('#massPush_grid').datagrid('getSelections');

	if(!rows || rows.length == 0){
		showWarningMessage('请至少选择一行');
	}else{
		$('#mass_push_content').val('');
		$('#mass_push_title').val('');
		
		$('#mass_push_dlg').dialog({
			title: '发送消息',
			modal: true
		});
		
		$('#mass_push_dlg').dialog('open');
	} 	
}

function doPushUserMessage(jcntId){
	var form = new Object();
	form.title = $('#mass_push_title').val();
	form.text = massEditor.getContentTxt();
	form.senderId = UC.userId;
	form.html = massEditor.getContent();
	
	var rows = $('#massPush_grid').datagrid('getSelections');
   	var ids = '';
   	for(var i = 0; i < rows.length; i++){
   		ids += rows[i].id + ',';
   	}
   	ids = ids.substring(0, ids.length - 1);
   	
   	form.toUserIds = ids;
   	console.log(form);
   	
   	checkAndPush(form, 'push/mass.json');
}
</script>
<table id="massPush_grid" style="width:700px;height:250px" data-options="toolbar:'#massPush_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
		<th data-options="field:'id'">用户 编号</th>
		<th data-options="field:'loginName'">用户名</th>
		<th data-options="field:'name'">真实姓名</th>
		<th data-options="field:'gender'">性别</th>
		<th data-options="field:'cellPhone'">手机号</th>
		<th data-options="field:'email'">电子邮箱</th>
		<th data-options="field:'qq'">QQ</th>
		<th data-options="field:'lastLoginTime'">上次登录时间</th>
		<th data-options="field:'loginCount'">登录次数</th>
		<th data-options="field:'createTime'">注册时间</th>
    </thead>
</table>

<div id="massPush_toolbar" style="padding:5px;height:auto">
  <!-- 添加查询条件  -->      
        用户名<input id="massPush_userName" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchMassPush()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#massPush_toolbar')">清除</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-large-smartart" onclick="showPushUserMessageDialog()">发送</a></td>
</div>

<div id="mass_push_dlg" class="easyui-dialog" style="width:50%;height:540px;padding:10px 20px" data-options="shadow:false,resizable:true,closed:true">
	<input id="mass_push_title" type="text" placeholder="标题" size="92"/><br/>
	<div id="mass_push_content"></div>
	<input type="button" value="发送" onclick="doPushUserMessage()">
	<input type="button" value="清空" onclick="massEditor.execCommand('cleardoc')">
	<!-- <input type="button" value="关闭" onclick="massEditor.execCommand('cleardoc');$('#mass_push_dlg').dialog('close');"> -->
</div>
