<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#adminRole_form {
margin: 0;
padding: 10px 30px;
}

.adminRole_item {
margin-bottom: 5px;
}

.adminRole_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="resources/js/common.js"></script>
<script type="text/javascript">
var adminRoleTable = 'ADMIN_ROLE';
var adminRoleQuery;

$(function() {
	// need order, uncomment here
	//var orderBy = getIdDescOrder();
	//initDataGrid('#adminRole_grid', appName + 'search/' + adminRoleTable + '.json?orderBy=' + orderBy');
	
	// no need order
	initDataGrid('#adminRole_grid', 'search/' + adminRoleTable + '.json');
	adminRoleQuery = '';
});

/**
 * 查询
 */
function searchAdminRole() {
	adminRoleQuery = getQueryJson();
	searchDataGrid('#adminRole_grid', adminRoleQuery);
}

/**
 * 查询条件
 */
function getQueryJson(){
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#adminRole_fieldName_from').datebox("getValue");
	registerDateQuery.to = $('#adminRole_fieldName_to').datebox("getValue");
	*/
	var json = {
		roleName : $('#adminRole_name').val()
	};
	
	return json;
}

/**
 * 刷新
 */
function refreshAdminRole() {
	refreshDataGrid('#adminRole_grid');
}

/** 
 * 添加
 */
function addAdminRoleItem(){
	showAddDialog('#adminRole_form', '#adminRole_dlg');
 	
 	$('#adminRole_menu_select').combotree({
 		url: 'role/menu.json',
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
 	//$('#adminRole_menu_select').combotree('reload', 'role/menu.json');
 	
	$('#adminRole_save').unbind('click');
	$('#adminRole_save').click(function(){
		var actionContext;
		
		// 对于非自增主键，需要用户手工输入，解开以下注释来验证主键在数据库中是否已经存在
	 	/*
	 	actionContext = new Object();
	 	actionContext.table = adminRoleTable;
	 	actionContext.action = 'add';
	 	actionContext.idName = 'id';
	 	actionContext.idValue = $('#adminRole_id_input').val();
	 	*/
	 	saveItem('#adminRole_grid', '#adminRole_form', '#adminRole_dlg', adminRoleTable, actionContext);
 	});
}

/**
 * 编辑
 */
function editAdminRoleItem(){
	var flag = showEditDialog('#adminRole_grid', '#adminRole_form', '#adminRole_dlg');
 
	if(flag){
		//console.log('role id is ' + $('#adminRole_id_input').val());
		
	 	$('#adminRole_menu_select').combotree({
	 		url: 'role/menu.json?roleIds=' + $('#adminRole_id_input').val(),
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

		$('#adminRole_save').unbind('click');
		$('#adminRole_save').click(function(){
			saveItem('#adminRole_grid', '#adminRole_form', '#adminRole_dlg', adminRoleTable);
		});
	}
}

/**
 * 导出查询结果
function exportAdminRoleQuery(){
	showConfirmMessage('是否导出查询结果？', function(r){
		if(r){
			var form = new Object();
			// 每列以分号分隔
			form.columns = 'id,id;roleName,roleName;description,description';	
			form.table = adminRoleTable;
			
			var query = adminRoleQuery ? adminRoleQuery : getQueryJson();
			form.query = JSON.stringify(query);
			
			// 表格显示的名称
			form.tableDisplayName = 'AdminRole';
			form.fileName = 'adminRole';
			
			form.type = 'csv';
			
			downloadFile(form);
		}
	});
}
 */
 
</script>
<table id="adminRole_grid" style="width:700px;height:250px" data-options="toolbar:'#adminRole_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
		<th data-options="field:'id'">权限ID</th>
		<th data-options="field:'roleName'">权限名称</th>
		<th data-options="field:'description'">描述</th>
    </thead>
</table>

<div style="display:none">
<form id="adminRole_file_form" enctype="multipart/form-data">
	<!-- 解开以下注释 可接受excel文件 -->
	<!-- <input id="adminRole_file" type="file" name="file" accept="application/vnd.ms-excel" onchange="uploadFile('adminRole_file');"/> -->
	<!-- 当前只支持csv格式 -->
	<input id="adminRole_file" type="file" name="file" accept=".csv" onchange="uploadFile('adminRole_file', adminRoleTable, refreshAdminRole);"/>
	<input type="submit"/>
</form>
</div>

<div id="adminRole_toolbar" style="padding:5px;height:auto">
  <!-- 添加查询条件  -->      
        权限名称<input id="adminRole_name" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchAdminRole()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#adminRole_toolbar')">清除</a>
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addAdminRoleItem()">添加</a> 
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit "onclick="editAdminRoleItem()">编辑</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteItem('#adminRole_grid', adminRoleTable, 'id')">删除</a>
<!--         <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="exportAdminRoleQuery()">导出</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="selectFile('#adminRole_file')">导入</a> -->
</div>

<div id="adminRole_dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#adminRole_dlg_buttons">
     <form id="adminRole_form" method="post" novalidate>
		<input id="adminRole_id_input" name="id" type="hidden">		
		<div class="adminRole_item">
			<label>权限名称</label>
			<input id="adminRole_roleName_input" name="roleName">
		</div>
		<div class="adminRole_item">
			<label>描述</label>
			<input id="adminRole_description_input" name="description">
		</div>
		<div class="adminRole_item">
			<label>权限菜单</label>
			<select id="adminRole_menu_select" name="menuIds" multiple style="width:200px;"></select>
		</div>
     </form>
 </div>
 <div id="adminRole_dlg_buttons">
     <a id="adminRole_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDialog('#adminRole_dlg')">取消</a>
 </div>




