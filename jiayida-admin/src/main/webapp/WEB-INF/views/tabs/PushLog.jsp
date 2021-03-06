<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#pushLog_dlg{
	padding:10px 20px;
}
#pushLog_form table{
	width:100%;
	border-collapse:collapse;
	border-right:1px solid #A9A9A9;
}
#pushLog_form th{
	border-left:1px solid #A9A9A9;
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	border-right:1px solid #D3D3D3;
	padding-left:10px;
	padding-right:10px;
	text-align:right;
}
#pushLog_form td{
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:5px;
	text-align:left;
}
</style>

<script type="text/javascript">
var pushLogTable = 'push_log_history_vt';
var pushLogQuery;

$(function() {
	var orderBy = getPushLogOrder();
	initDataGrid('#pushLog_grid', appName + 'search/' + pushLogTable + '.json?orderBy=' + orderBy);
	pushLogQuery = '';

});

/**
 * 获得排序配置json
 */
function getPushLogOrder(){
	var order;
	var orderBy = new Array();

	order = {};
	order.name = 'id';
	order.order = 'desc';
	orderBy.push(order);
	
	return JSON.stringify(orderBy);
}

/**
 * 查询
 */
function searchPushLog() {
	pushLogQuery = getPushLogQueryJson();
	searchDataGrid('#pushLog_grid', pushLogQuery);
}

/**
 * 查询条件
 */
function getPushLogQueryJson(){
	var json = {
		title : $('#pushLog_title').val(),
		text : $('#pushLog_text').val(),
		target : $('#pushLog_target').val(),
		sendTime : JSON.stringify({type:'date',from:$('#pushLog_sendTime_from').datebox('getValue'),to:$('#pushLog_sendTime_to').datebox('getValue')}),
		sendBy : $('#pushLog_sendBy').val(),
		readCount : JSON.stringify({type:'number',from:$('#pushLog_readCount_from').numberbox('getValue'),to:$('#pushLog_readCount_to').numberbox('getValue')}),
	};
	
	return json;
}

/**
 * 刷新
 */
function refreshPushLog() {
	refreshDataGrid('#pushLog_grid');
}







/**
 * 格式化target字段
 */
function PushLogTargetFormatter(value, row, index){
	var text;
	switch(value){
		case 'B':
			text = '广播';
			break;
		case 'M':
			text = '群发';
			break;
		default:
			text = value;
	}
	return text;
}
/**
 * 格式化pushStatus字段
 */
function PushLogPushStatusFormatter(value, row, index){
	var text;
	switch(value){
		case 'S':
			text = '成功';
			break;
		case 'F':
			text = '失败';
			break;
		case 'P':
			text = '部分成功';
			break;
		default:
			text = value;
	}
	return text;
}

function PushLogUnAcceptCountFormatter(val, row){
	var value = val;
	
	if(row.target == 'B'){
		value = '';
	}
	
	return value;
}

function resizePushLog(){
	$('#pushLog_grid').datagrid('resize');
}

function showPreviewNotice(){
	//debugger;
	var rows = $('#pushLog_grid').datagrid('getSelections');
	if(!rows || rows.length == 0){
		showWarningMessage('请选择要预览的条目');
	}else if(rows.length > 1){
		showWarningMessage('只能选择1条预览');
	}else{
		window.open(rows[0].url);
	}
}

function showPushDetail(){
	var rows = $('#pushLog_grid').datagrid('getSelections');

	if(!rows || rows.length == 0){
		showWarningMessage('请选择要查看的行');
	}else if(rows.length > 1){
		showWarningMessage('只能选择一行查看');
	}else if(rows[0].target == 'B'){
		showInformationMessage('不能查看广播明细');
	}else{
		var pageId = rows[0].pageId;
		//console.log(pageId);
		UC.resendPage = pageId;
		
		var title = '通知' + rows[0].id + ' - ' + rows[0].title;
		
		var tab = $(jtabId);
		if(tab.tabs('exists', title)){
			tab.tabs("select", title); 
		}else{
			tab.tabs('add', {
				title: title,
				href: 'push_log/detail.jspx?noticeId=' + rows[0].id,
				closable: true
			});
		}
	} 

}
</script>

<table id="pushLog_grid" class="easyui-datagrid" data-options="toolbar:'#pushLog_toolbar'">
    <thead>
        <tr>
        	<th data-options="field:'ck'" checkbox="true"></th>
			<th data-options="field:'id',hidden:false">编号</th>
			<th data-options="field:'pageId',hidden:true">页面编号</th>
			<th data-options="field:'title',hidden:false">标题</th>
			<th data-options="field:'text',hidden:false">内容</th>
			<th data-options="field:'url',hidden:true">推送链接</th>
			<th data-options="field:'target',hidden:false,formatter:PushLogTargetFormatter">类型</th>
			<th data-options="field:'sendTime',hidden:false">发送时间</th>
			<th data-options="field:'sendBy',hidden:false">发送者</th>
			<th data-options="field:'readCount',hidden:false">阅读次数</th>
			<!-- <th data-options="field:'pushStatus',hidden:false,formatter:PushLogPushStatusFormatter">状态</th> -->
			 <th data-options="field:'unAcceptCount',formatter:PushLogUnAcceptCountFormatter,align:'center'">未查看人数</th>
		</tr>
    </thead>
</table>

<div id="pushLog_toolbar">
	<div id="pushLog_querybar" title="查询条件" class="easyui-panel" data-options="collapsible:true,border:false,onCollapse:resizePushLog,onExpand:resizePushLog">

		<table>

			<tr>
				<td style="text-align:right;"><strong>标题</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="pushLog_title" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>内容</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="pushLog_text" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>发送者</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="pushLog_sendBy" style="width:100%" type="text"/>
				</td>
				<td style="padding-left:10px;">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchPushLog()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearCriteria('#pushLog_querybar')">清空</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-large-picture" onclick="showPreviewNotice()">预览</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-redo" onclick="showPushDetail()">查看</a>
				</td>
			</tr>

			<tr>
				<td style="text-align:right;"><strong>类型</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="pushLog_target" style="width:100%">
						<option value="" selected>全部</option>
						<option value="B">广播</option>
						<option value="M">群发</option>
					</select>
				</td>
				<td style="text-align:right;"><strong>发送时间</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					从<input id="pushLog_sendTime_from" class="easyui-datebox" style="width:100px">&nbsp;到&nbsp;<input id="pushLog_sendTime_to" class="easyui-datebox" style="width:100px">
				</td>
				<td style="text-align:right;"><strong>阅读次数</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					从<input id="pushLog_readCount_from" class="easyui-numberspinner" data-options="min:0" style="width:70px">&nbsp;到&nbsp;<input id="pushLog_readCount_to" class="easyui-numberspinner" data-options="min:0" style="width:70px">
				</td>
			</tr>
		</table>
	</div>
</div>




