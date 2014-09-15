<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#${noticeId}_form {
margin: 0;
padding: 10px 30px;
}

.${noticeId}_item {
margin-bottom: 5px;
}

.${noticeId}_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="resources/js/common.js"></script>
<script type="text/javascript">
var usernoticeTable = 'push_log_detail_vt';

$(function() {
	initDataGrid('#${noticeId}_grid', appName + 'search/' + usernoticeTable + '.json?pageName=' + UC.resendPage);
});

/**
 * 修改查询条件
 */
function doSearchUserNotice() {
	searchDataGrid('#${noticeId}_grid', {
		cellPhone : $('#${noticeId}_text').val()
	});
}

/**
 * 修改刷新条件
 */
function doRefreshUsernotice() {
	refreshDataGrid('#${noticeId}_grid', {
		cellPhone : ''
	});
}

function formatReceiveType(val, row){
	var value = val;
	if(val == 'Y'){
		value = '已查看'
	}else{
		value = '未查看'
	}
	
	return value;
}

function doResend(){
	var rows = $('#${noticeId}_grid').datagrid('getSelections');

	if(!rows || rows.length == 0){
		showWarningMessage('请选择要重发的行');
	}else{
        var userIds = '';
        for(var i = 0; i < rows.length; i++){
        	userIds += rows[i].userId + ',';
        }
        
        userIds = userIds.substring(0, userIds.length - 1);
        console.log(userIds);
		
        var form = new Object();
        form.userId = UC.userId;
        form.targetUserIds = userIds;
        form.pageName = UC.resendPage;
        
        push(form, appName + 'push/resend.json');
	} 
}
</script>
<table id="${noticeId}_grid" class="easyui-datagrid" style="width:700px;height:250px" data-options="toolbar:'#${noticeId}_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
        	<th data-options="field:'id',hidden:'true'"></th>
        	<th data-options="field:'noticeId'">通知编号</th>
        	<th data-options="field:'userId'">用户编号</th>
            <th data-options="field:'name'">姓名</th>
            <th data-options="field:'cellPhone'">手机号码</th>
            <th data-options="field:'status',formatter:formatReceiveType">接收状态</th>
            <th data-options="field:'acceptTime'">接收时间</th>
        </tr>
    </thead>
</table>
<div id="${noticeId}_toolbar" style="padding:5px;height:auto">
  <!-- 添加查询条件  -->      
        手机号码<input id="${noticeId}_text" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearchUserNotice()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#${noticeId}_toolbar')">清除</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-large-smartart" onclick="doResend()">重发</a>
</div>
