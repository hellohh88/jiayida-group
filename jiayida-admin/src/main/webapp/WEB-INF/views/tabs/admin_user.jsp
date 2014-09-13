<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#adminUser_form {
margin: 0;
padding: 10px 30px;
}

.adminUser_item {
margin-bottom: 5px;
}

.adminUser_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="resources/js/common.js"></script>
<script type="text/javascript">
var adminUserTable = 'ADMIN_USER_VT';
var adminUserQuery;

$(function() {
	// need order, uncomment here
	//var orderBy = getIdDescOrder();
	//initDataGrid('#adminUser_grid', appName + 'search/' + adminUserTable + '.json?orderBy=' + orderBy');
	
	// no need order
	initDataGrid('#adminUser_grid', 'search/' + adminUserTable + '.json');
	adminUserQuery = '';
});

/**
 * 查询
 */
function searchAdminUser() {
	adminUserQuery = getQueryJson();
	searchDataGrid('#adminUser_grid', adminUserQuery);
}

/**
 * 查询条件
 */
function getQueryJson(){
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#adminUser_fieldName_from').datebox("getValue");
	registerDateQuery.to = $('#adminUser_fieldName_to').datebox("getValue");
	*/
	var json = {
		loginName : $('#adminUser_loginName').val()
	};
	
	return json;
}

/**
 * 刷新
 */
function refreshAdminUser() {
	refreshDataGrid('#adminUser_grid');
}

/** 
 * 添加
 */
function addAdminUserItem(){
	showAddDialog('#adminUser_form', '#adminUser_dlg');
 
 	var defPwd = '123456';
	
	$('#adminUser_password_input').val(defPwd);
 	$('#adminUser_password_input').attr('placeholder', defPwd);
	$('#adminUser_loginName_input').attr('readonly', false);
	
 	$('#adminUser_status_input').prop('checked', true);
 	
 	$('#adminUser_role_select').combotree({
 		url: 'role/list.json',
 		method: 'get',
 		loadFilter: function(data){
			if(data.code == 0){
				return data.menus;
			}else{
				handleError(data.code);
				return "";
			}
 		}
 	});

	$('#adminUser_save').unbind('click');
	$('#adminUser_save').click(function(){
		if($('#adminUser_password_input').val() == ''){
			$('#adminUser_password_input').val(defPwd);
		}
		
		var valid = checkExistence('ADMIN_USER', 'loginName', $('#adminUser_loginName_input').val(), '用户已存在');
		
		if(valid){
		 	saveItem('#adminUser_grid', '#adminUser_form', '#adminUser_dlg', adminUserTable);
	 	}
 	});
}

/**
 * 编辑
 */
function editAdminUserItem(){
	var flag = showEditDialog('#adminUser_grid', '#adminUser_form', '#adminUser_dlg');
	$('#adminUser_password_input').val('');
 	$('#adminUser_password_input').attr('placeholder', '留空保持现有密码不变');
 	$('#adminUser_loginName_input').attr('readonly', true);
 	
 	$('#adminUser_role_select').combotree({
 		url: 'role/list.json?userId=' + $('#adminUser_id_input').val(),
 		method: 'get',
 		loadFilter: function(data){
			if(data.code == 0){
				return data.menus;
			}else{
				handleError(data.code);
				return "";
			}
 		}
 	});

	if(flag){
		$('#adminUser_save').unbind('click');
		$('#adminUser_save').click(function(){
			saveItem('#adminUser_grid', '#adminUser_form', '#adminUser_dlg', adminUserTable);
		});
	}
}

/**
 * 导出查询结果
 */
function exportAdminUserQuery(){
	showConfirmMessage('是否导出查询结果？', function(r){
		if(r){
			var form = new Object();
			// 每列以分号分隔
			form.columns = 'id,id;loginCount,loginCount;loginName,loginName;lastLoginTime,lastLoginTime;password,password;createTime,createTime;status,status';	
			form.table = adminUserTable;
			
			var query = adminUserQuery ? adminUserQuery : getQueryJson();
			form.query = JSON.stringify(query);
			
			// 表格显示的名称
			form.tableDisplayName = 'AdminUser';
			form.fileName = 'adminUser';
			
			form.type = 'csv';
			
			downloadFile(form);
		}
	});
}
</script>
<table id="adminUser_grid" style="width:700px;height:250px" data-options="toolbar:'#adminUser_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
		<th data-options="field:'id'">用户编号</th>
		<th data-options="field:'loginName'">用户名</th>
		<th data-options="field:'email'">电子邮箱</th>
		<th data-options="field:'loginCount'">登录次数</th>
		<th data-options="field:'status'">状态</th>
		<th data-options="field:'lastLoginTime'">上次登录时间</th>
		<th data-options="field:'password',hidden:true">密码</th>
		<th data-options="field:'createTime'">创建时间</th>
		<!-- <th data-options="field:'roleIds',hidden:true">权限ID</th> -->
		<th data-options="field:'roleNames'">权限</th>
</table>

<div style="display:none">
<form id="adminUser_file_form" enctype="multipart/form-data">
	<!-- 解开以下注释 可接受excel文件 -->
	<!-- <input id="adminUser_file" type="file" name="file" accept="application/vnd.ms-excel" onchange="uploadFile('adminUser_file');"/> -->
	<!-- 当前只支持csv格式 -->
	<input id="adminUser_file" type="file" name="file" accept=".csv" onchange="uploadFile('adminUser_file', adminUserTable, refreshAdminUser);"/>
	<input type="submit"/>
</form>
</div>

<div id="adminUser_toolbar" style="padding:5px;height:auto">
  <!-- 添加查询条件  -->      
        登录名称<input id="adminUser_loginName" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchAdminUser()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#adminUser_toolbar')">清除</a>
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addAdminUserItem()">添加</a> 
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit "onclick="editAdminUserItem()">编辑</a>
        <!-- <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteItem('#adminUser_grid', adminUserTable, 'id')">删除</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="exportAdminUserQuery()">导出</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="selectFile('#adminUser_file')">导入</a> -->
</div>

<div id="adminUser_dlg" class="easyui-dialog" style="width:500px;height:280px;padding:10px 20px" closed="true" buttons="#adminUser_dlg_buttons">
     <form id="adminUser_form" method="post" novalidate>
		<input id="adminUser_id_input" name="id" type="hidden">
		<!-- <input id="adminUser_roleIds_input" name="roleIds" type="hidden"> -->
		<div class="adminUser_item">
			<label>用户名</label>
			<input id="adminUser_loginName_input" name="loginName" class="easyui-validatebox" data-options="required:true">
		</div>
		<div class="adminUser_item">
			<label>电子邮箱</label>
            <input id="adminUser_email_input" name="email">
		</div>
		<div class="adminUser_item">
			<label>状态</label>
            <input id="adminUser_status_input" name="status" type="radio" value="Y" checked>启用
            <input name="status" type="radio" value="N">禁用
		</div>
		<div class="adminUser_item">
<!-- 			<label id="adminUser_password_block">
				修改密码<input id="adminUser_password_update" type="checkbox" onclick="$('#adminUser_password_input').attr('readonly', !$('#adminUser_password_update').prop('checked'));">
			</label> -->
			<label>密码</label>
			<input id="adminUser_password_input" name="password">
		</div>
		<div class="adminUser_item">
			<label>权限分配</label>
			<select id="adminUser_role_select" name="roleIds" multiple style="width:150px;"></select>
		</div>
     </form>
 </div>
 <div id="adminUser_dlg_buttons">
     <a id="adminUser_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDialog('#adminUser_dlg')">取消</a>
 </div>




