<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#pushlog_form {
margin: 0;
padding: 10px 30px;
}

.pushlog_item {
margin-bottom: 5px;
}

.pushlog_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="/static/commons/admin.js"></script>
<script type="text/javascript">
var pushlogTable = 'push_log_history_vt';

$(function() {
	var orderBy = getIdDescOrder();
	initDataGrid('#pushlog_grid', appName + 'search/' + pushlogTable + '.json?orderBy=' + orderBy);
	
	/**
	 * 改变群发中尚未全部查看的消息背景色
	 */
	/*
	$('#pushlog_grid').datagrid({
		rowStyler:function(index, row){
			//console.log('unAcceptCount count ' + row.unAcceptCount)
			if(row.target != 'B' && row.unAcceptCount > 0){
				//return 'background-color:#ffc0cb;';
				return 'background-color:#000000';
			}			
		}
	});
	*/
});

/**
 * 修改查询条件
 */
function doSearchPushlog() {
	
	var sendTimeQuery = new Object();
	sendTimeQuery.type = 'date';
	sendTimeQuery.from = $('#pushlog_text_sendTimeStart').datebox("getValue");
	sendTimeQuery.to = $('#pushlog_text_sendTimeEnd').datebox("getValue");

	var reviewStatus = $("#pushlog_text_unAcceptCount").val();
	
	var reviewQuery = new Object();
	reviewQuery.type = 'number';
	
	var unAcceptCountCriteria = '';
	
	if(reviewStatus == 'F'){
		// 已全部查看
		reviewQuery.from = 0;
		reviewQuery.to = 0;
		
		unAcceptCountCriteria = JSON.stringify(reviewQuery);
	}else if(reviewStatus == 'U'){
		// 未全部查看
		reviewQuery.from = 1;
		
		unAcceptCountCriteria = JSON.stringify(reviewQuery);
	}else{
		// 全部状态
		unAcceptCountCriteria = '';
	}
	
	searchDataGrid('#pushlog_grid', {
		title : $('#pushlog_text_title').val(),
		target : $('#pushlog_text_target').val(),
		text : $('#pushlog_text').val(),
		sendTime : JSON.stringify(sendTimeQuery),
		unAcceptCount : unAcceptCountCriteria
	});
}

/**
 * 修改刷新条件
 */
function doRefreshPushlog() {
	refreshDataGrid('#pushlog_grid', {
		title : '',
		target : '',
		text : '',
		sendTime : '',
		sendTime : ''
	});
	$('#pushlog_text_title').val("");
	$('#pushlog_text_target').val("");
	$('#pushlog_text').val("");
	$('#pushlog_text_sendTimeStart').val("");
	$('#pushlog_text_sendTimeEnd').val("");
}

function formatPushTarget(val, row){
	var value = val;
	if(val == 'B'){
		value = '广播';
	}else if(val == 'M'){
		value = '群发';
	}
	
	return value;
}

function formatUnAcceptCount(val, row){
	var value = val;
	
	if(row.target == 'B'){
		value = '';
	}
	
	return value;
}

function formatPushStatus(val, row){
	var value = val;
	
	if(row.pushStatus == 'S'){
		value = '发送成功';
	}else if(row.pushStatus == 'F'){
		value = '发送失败';
	}else if(row.pushStatus == 'P'){
		value = '部分成功';
	}
	
	return value;
}

function showPushDetail(){
	var rows = $('#pushlog_grid').datagrid('getSelections');

	if(!rows || rows.length == 0){
		showWarningMessage('请选择要查看的行');
	}else if(rows.length > 1){
		showWarningMessage('只能选择一行查看');
	}else if(rows[0].target == 'B'){
		showInformationMessage('不能查看广播明细');
	}else{
		var pageName = rows[0].pageName;
		console.log(pageName);
		
		UC.resendPage = pageName;
		
		var title = '通知' + rows[0].id + ' - ' + rows[0].title;
		
		var tab = $(jtabId);
		if(tab.tabs('exists', title)){
			tab.tabs("select", title); 
		}else{
			tab.tabs('add', {
				title: title,
				href: 'tabs/push_log/detail.jspx?noticeId=' + rows[0].id,
				closable: true
			});
		}
	} 

}

function showPreviewNotice(){
	
}
</script>
<table id="pushlog_grid" class="easyui-datagrid" style="width:700px;height:250px" data-options="toolbar:'#pushlog_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
            <th data-options="field:'id'">编号</th>
            <th data-options="field:'title'">标题</th>
            <th data-options="field:'text',width:800">内容</th>
            <th data-options="field:'target',formatter:formatPushTarget">类型</th>
            <th data-options="field:'pushStatus',formatter:formatPushStatus">发送状态</th>
            <th data-options="field:'sendTime'">发送时间</th>
            <th data-options="field:'sendBy'">发送者</th>
            <th data-options="field:'readCount',align:'center'">阅读次数</th>
            <!-- <th data-options="field:'unAcceptCount',formatter:formatUnAcceptCount,rowStyler:formatUnAcceptCountRowStyle,align:'center'">未查看人数</th> -->
            <th data-options="field:'unAcceptCount',formatter:formatUnAcceptCount,align:'center'">未查看人数</th>
            <th data-options="field:'pageName',hidden:'true'"></th>
        </tr>
    </thead>
</table>
<div id="pushlog_toolbar" style="padding:5px;height:auto">
  <!-- 添加查询条件  -->      
  <table style="width: 900px" border="0">
  	<tr>
  		<td style="width: 50px;">标题</td>
  		<td style="width: 50px;"><input id="pushlog_text_title" type="text"/></td>
  		<td style="width: 40px;text-align: right;">内容</td>
  		<td style="width: 50px;"><input id="pushlog_text" type="text"/></td>
  		<td style="width: 50px;">通知类型</td>
  		<td style="width: 50px;"><select id="pushlog_text_target" style="width: 155px;">
  			<option value="">全部</option>
  			<option value="B">广播</option>
  			<option value="M">群发</option>
  		</select>
  		</td>
  		<td style="width: 230px;">
  			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearchPushlog()">查询</a>
	        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#pushlog_toolbar')">清除</a>
	        <a href="#" class="easyui-linkbutton" iconCls="icon-large-picture" onclick="showPreviewNotice()">预览</a>
	        <a href="#" class="easyui-linkbutton" iconCls="icon-redo" onclick="showPushDetail()">查看</a>
  		</td>
  	 </tr>
  	 <tr>
  		<td style="width: 50px;">发送时间</td>
  		<td style="width: 50px;"><input id="pushlog_text_sendTimeStart" type="text" class="easyui-datebox"/></td>
  		<td style="width: 40px;text-align: center;">到</td>
  		<td style="width: 50px;"><input id="pushlog_text_sendTimeEnd" type="text" class="easyui-datebox"/></td>
  		<td style="width: 50px;">查看状态</td>
  		<td style="width: 50px;"><select id="pushlog_text_unAcceptCount" style="width: 155px;">
  			<option value="">全部</option>
  			<option value="F">已全部查看</option>
  			<option value="U">未全部查看</option>
  		</select>
  	</tr>
  </table>
</div>