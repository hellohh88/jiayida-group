<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#massPush_dlg{
	padding:10px 20px;
}
#massPush_form table{
	width:100%;
	border-collapse:collapse;
	border-right:1px solid #A9A9A9;
}
#massPush_form th{
	border-left:1px solid #A9A9A9;
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	border-right:1px solid #D3D3D3;
	padding-left:10px;
	padding-right:10px;
	text-align:right;
}
#massPush_form td{
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:5px;
	text-align:left;
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
});

/**
 * 查询
 */
function searchMassPush() {
	massPushQuery = getMassPushQueryJson();
	searchDataGrid('#massPush_grid', massPushQuery);
}

/**
 * 查询条件
 */
function getMassPushQueryJson(){
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#massPush_fieldName_from').datebox("getValue");
	registerDateQuery.to = $('#massPush_fieldName_to').datebox("getValue");
	*/
	var json = {
		loginName : $('#massPush_loginName').val(),
		cellPhone : $('#massPush_cellPhone').val(),
		name : $('#massPush_name').val(),
		gender : $('#massPush_gender').val(),
		createTime : JSON.stringify({type:'date',from:$('#massPush_createTime_from').datebox('getValue'),to:$('#massPush_createTime_to').datebox('getValue')}),
	};
	
	return json;
}

function showPushUserMessageDialog(){
	var rows = $('#massPush_grid').datagrid('getSelections');

	if(!rows || rows.length == 0){
		showWarningMessage('请至少选择一行');
	}else{
		
		if(massEditor){
			UE.delEditor('mass_push_content');
		}
		
		$('#mass_push_content_parent').empty();
		$('#mass_push_content_parent').append('<div id="mass_push_content"></div>');

		massEditor = UE.getEditor('mass_push_content', {
			serverUrl: '${contextRoot}' + 'ueditor.do',
			initialFrameWidth: '100%',
			initialFrameHeight: 300,
			//enableAutoSave: false
			saveInterval: 1000 * 60 * 60 * 24,
			toolbars: ue_massbars
		});

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
	form.senderId = ${userId};
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

function MassPushGenderFormatter(value, row, index){
	var text;
	switch(value){
		case 'F':
			text = '女';
			break;
		case 'M':
			text = '男';
			break;
		default:
			text = value;
	}
	return text;
}

function resizeMassPush(){
	$('#massPush_grid').datagrid('resize');
}
</script>
<table id="massPush_grid" class="easyui-datagrid" data-options="toolbar:'#massPush_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
		<th data-options="field:'id'">编号</th>
		<th data-options="field:'loginName'">登录名</th>
		<th data-options="field:'name'">真实姓名</th>
		<th data-options="field:'gender',formatter:MassPushGenderFormatter">性别</th>
		<th data-options="field:'cellPhone'">手机号</th>
		<th data-options="field:'createTime'">注册时间</th>
    </thead>
</table>

<div id="massPush_toolbar">
	<div id="massPush_querybar" title="查询条件" class="easyui-panel" data-options="collapsible:true,border:false,onCollapse:resizeMassPush,onExpand:resizeMassPush">
		<table>
			<tr>
				<td style="text-align:right;"><strong>登录名</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="massPush_loginName" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>真实姓名</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="massPush_name" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>手机号</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="massPush_cellPhone" style="width:100%" type="text"/>
				</td>
				<td style="padding-left:10px;">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchMassPush()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearCriteria('#massPush_toolbar')">清空</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-large-smartart" onclick="showPushUserMessageDialog()">发送</a>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><strong>性别</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="massPush_gender" style="width:100%">
						<option value="" selected>全部</option>
						<option value="F">女</option>
						<option value="M">男</option>
					</select>
				</td>
				<td style="text-align:right;"><strong>注册日期</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					从<input id="massPush_createTime_from" class="easyui-datebox" style="width:100px">&nbsp;到&nbsp;<input id="massPush_createTime_to" class="easyui-datebox" style="width:100px">
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="mass_push_dlg" class="easyui-dialog" style="width:50%;height:540px;padding:10px 20px" data-options="shadow:false,resizable:true,closed:true">
	<input id="mass_push_title" type="text" placeholder="标题" size="92"/><br/>
	<div id="mass_push_content_parent"></div>
	<input type="button" value="发送" onclick="doPushUserMessage()">
	<input type="button" value="清空" onclick="massEditor.execCommand('cleardoc')">
	<!-- <input type="button" value="关闭" onclick="massEditor.execCommand('cleardoc');$('#mass_push_dlg').dialog('close');"> -->
</div>
