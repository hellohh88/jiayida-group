<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#adminUser_dlg{
	padding:10px 20px;
}
#adminUser_form table{
	width:100%;
	border-collapse:collapse;
	border-right:1px solid #A9A9A9;
}
#adminUser_form th{
	border-left:1px solid #A9A9A9;
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	border-right:1px solid #D3D3D3;
	padding-left:10px;
	padding-right:10px;
	text-align:right;
}
#adminUser_form td{
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:5px;
	text-align:left;
}
</style>

<script type="text/javascript">
var adminUserTable = 'ADMIN_USER';
var adminUserQuery;
var wysiwye = false;	// what you see is what you export

$(function() {
	initDataGrid('#adminUser_grid', 'search/' + adminUserTable + '.json');
	adminUserQuery = '';

	initUploadFileForm($('#adminUser_file_form'), $('#adminUser_columnMap'), $('#adminUser_grid'), wysiwye);
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
	var json = {
		loginName : $('#adminUser_loginName').val(),
		status : $('#adminUser_status').val(),
		email : $('#adminUser_email').val(),
		lastLoginTime : JSON.stringify({type:'date',from:$('#adminUser_lastLoginTime_from').datebox('getValue'),to:$('#adminUser_lastLoginTime_to').datebox('getValue')}),
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
 
	// 设置每一个radio最后一项选中
	$('#adminUser_form').children().find(':radio').each(function(){
		$(this).prop('checked', true);
	});
	
 	var defPwd = '123456';
	
	$('#adminUser_password_input').val(defPwd);
 	$('#adminUser_password_input').attr('placeholder', defPwd);
	$('#adminUser_loginName_input').attr('readonly', false);
	
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
	 	var valid = true;
	 	valid = checkExistence('ADMIN_USER', 'loginName', $('#adminUser_loginName_input').val(), '用户已存在');
	 	
	 	if(valid){
 			resetAdminUserTimestampItem();
	 		saveItem('#adminUser_grid', '#adminUser_form', '#adminUser_dlg', adminUserTable);
	 	}
 	});
}

/**
 * 编辑
 */
function editAdminUserItem(){
	var flag = showEditDialog('#adminUser_grid', '#adminUser_form', '#adminUser_dlg');
 
	if(flag){
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

	 	resetAdminUserTimestampItem();
		$('#adminUser_save').unbind('click');
		$('#adminUser_save').click(function(){
			saveItem('#adminUser_grid', '#adminUser_form', '#adminUser_dlg', adminUserTable);
		});
	}
}

/**
 * 复制
 */
function copyAdminUserItem(){
	var flag = showCopyDialog('#adminUser_grid', '#adminUser_form', '#adminUser_dlg');
	
	if(flag){
		_.each(['id', 'loginCount'], function(element){
			$('#adminUser_form').children().find('input[name="' + element + '"]').each(function(){
				$(this).val('0');
			});
		});
		/*
		$('#adminUser_form').children().find('input[name="id"]').each(function(){
			$(this).val('0');
		});
		*/
		var defPwd = '123456';
		
		$('#adminUser_password_input').val(defPwd);
	 	$('#adminUser_password_input').attr('placeholder', defPwd);
		$('#adminUser_loginName_input').attr('readonly', false);

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

	 	resetAdminUserTimestampItem();
		$('#adminUser_save').unbind('click');
		$('#adminUser_save').click(function(){
			var valid = checkExistence('ADMIN_USER', 'loginName', $('#adminUser_loginName_input').val(), '用户已存在');
			if(valid){
				saveItem('#adminUser_grid', '#adminUser_form', '#adminUser_dlg', adminUserTable);
			}
		});
	}
}

/**
 * 设置更新时间戳
 */
function resetAdminUserTimestampItem(){
	var fields = ['lastLoginTime'];
	$('#adminUser_form').children().find('input').each(function(){
		if(_.contains(fields, $(this).attr('name'))){
			$(this).val('CURRENT_TIMESTAMP');
		}
	});
}


/**
 * 导出查询结果
 */
function exportAdminUserQuery(type){
	var suffix = type == 'Excel' ? 'xls' : 'csv';
	
	showConfirmMessage('是否以' + type + '格式导出查询结果?', function(r){
		if(r){
			var form = new Object();

			form.columns = getExportColumns($('#adminUser_grid'), wysiwye);
			form.table = adminUserTable;
			
			var query = adminUserQuery ? adminUserQuery : getQueryJson();
			form.query = JSON.stringify(query);
			
			// 表格显示的名称
			form.tableDisplayName = $(jtabId).tabs('getSelected').panel('options').title;
			// 下载文件的名称
			form.fileName = $(jtabId).tabs('getSelected').panel('options').title;
			// 下载文件格式
			form.type = suffix;
			
			downloadFile(form);
		}
	});
}

/**
 * 格式化status字段
 */
function AdminUserStatusFormatter(value, row, index){
	var text;
	switch(value){
		case 'N':
			text = '禁用';
			break;
		case 'Y':
			text = '启用';
			break;
		default:
			text = value;
	}
	return text;
}

function resizeAdminUser(){
	$('#adminUser_grid').datagrid('resize');
}
</script>

<table id="adminUser_grid" class="easyui-datagrid" data-options="toolbar:'#adminUser_toolbar'">
    <thead>
        <tr>
        	<th data-options="field:'ck'" checkbox="true"></th>
			<th data-options="field:'id',hidden:false">编号</th>
			<th data-options="field:'loginName',hidden:false">用户名</th>
			<th data-options="field:'password',hidden:true">密码</th>
			<th data-options="field:'loginCount',hidden:false">登录次数</th>
			<th data-options="field:'status',hidden:false,formatter:AdminUserStatusFormatter">状态</th>
			<th data-options="field:'email',hidden:false">电子邮箱</th>
			<th data-options="field:'roleNames'">权限</th>
			<th data-options="field:'createTime',hidden:false">创建时间</th>
			<th data-options="field:'lastLoginTime',hidden:false">上次登录时间</th>
		</tr>
    </thead>
</table>

<div id="adminUser_toolbar">
	<div id="adminUser_querybar" title="查询条件" class="easyui-panel" data-options="collapsible:true,border:false,onCollapse:resizeAdminUser,onExpand:resizeAdminUser">
		<div style="display:none">
			<form id="adminUser_file_form" enctype="multipart/form-data" method="post" action="import.json">
				<input id="adminUser_file" type="file" name="file" accept="" onchange="startUpload($('#adminUser_file_form'));"/>
				<input name="table" type="text" value="ADMIN_USER">
				<input id="adminUser_columnMap" name="columnMap" type="text">
				<input id="adminUser_file_submit" type="submit"/>
			</form>
			<iframe id="adminUser_file_target" name="adminUser_file_target"></iframe>
		</div>

		<table>

			<tr>
				<td style="text-align:right;"><strong>用户名</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="adminUser_loginName" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>状态</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="adminUser_status" style="width:100%">
						<option value="" selected>全部</option>
						<option value="N">禁用</option>
						<option value="Y">启用</option>
					</select>
				</td>
				<td style="text-align:right;"><strong>电子邮箱</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="adminUser_email" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>上次登录时间</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					从<input id="adminUser_lastLoginTime_from" class="easyui-datebox" style="width:100px">&nbsp;到&nbsp;<input id="adminUser_lastLoginTime_to" class="easyui-datebox" style="width:100px">
				</td>
				<td style="padding-left:10px;">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchAdminUser()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearCriteria('#adminUser_querybar')">清空</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin-bottom:5px">
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addAdminUserItem()">添加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editAdminUserItem()">编辑</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copyAdminUserItem()">复制</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cross" plain="true" onclick="deleteItem('#adminUser_grid', 'ADMIN_USER', 'id')">删除</a>
        <a href="#" class="easyui-menubutton" iconCls="icon-export" data-options="menu:'#adminUser_export'">导出</a>
        <div id="adminUser_export">
			<div data-options="iconCls:'icon-excel'"  onclick="exportAdminUserQuery('Excel')">Excel</div>
			<div data-options="iconCls:'icon-csv'"  onclick="exportAdminUserQuery('CSV')">CSV</div>
		</div>
        <a href="#" class="easyui-menubutton" iconCls="icon-import" data-options="menu:'#adminUser_import'">导入</a>
        <div id="adminUser_import">
			<div data-options="iconCls:'icon-excel'"  onclick="selectFile('#adminUser_file', 'Excel')">Excel</div>
			<div data-options="iconCls:'icon-csv'"  onclick="selectFile('#adminUser_file', 'CSV')">CSV</div>
		</div>
	</div>

</div>

<div id="adminUser_dlg" class="easyui-dialog" style="width:28%" data-options="shadow:false,resizable:true,closed:true" buttons="#adminUser_dlg_buttons">
     <form id="adminUser_form" method="post">
     	<table>
														
			<tr style="display:none">
				<th style="">
					编号
				</th>
				<td><input id="adminUser_id_input" name="id" class="easyui-numberspinner" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
						
			<tr style="">
				<th style="">
					用户名
				</th>
				<td><input id="adminUser_loginName_input" style="width:95%" name="loginName" class="easyui-validatebox" data-options="required:true">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
						
			<tr style="">
				<th style="">
					密码
				</th>
				<td><input id="adminUser_password_input" style="width:95%" name="password" class="easyui-validatebox" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
														
			<tr style="display:none">
				<th style="">
					登录次数
				</th>
				<td><input id="adminUser_loginCount_input" style="width:95%" name="loginCount" class="easyui-numberspinner" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
						
			<tr style="">
				<th style="">
					状态
				</th>
					<td>
			<label><input id="adminUser_status_input1" name="status" type="radio" value="N">禁用</label>
			<label><input id="adminUser_status_input2" name="status" type="radio" value="Y">启用</label>
			</td>
			</tr>
							
			<tr style="">
				<th style="">
					电子邮箱
				</th>
				<td><input id="adminUser_email_input" style="width:95%" name="email" class="easyui-validatebox" data-options="required:false,validType:'email'">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
			
			<tr>
				<th>权限</th>
				<td><select id="adminUser_role_select" style="width:95%" name="roleIds" multiple style="width:150px;"></select></td>
			</tr>
			
			<tr style="display:none">
				<th style="">
					创建时间
				</th>
				<td><input id="adminUser_createTime_input" style="width:95%" name="createTime" class="easyui-datetimebox" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
							
			<tr style="display:none">
				<th style="">
					上次登录时间
				</th>
				<td><input id="adminUser_lastLoginTime_input" style="width:95%" name="lastLoginTime" class="easyui-datetimebox" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
		</table>
     </form>
 </div>
 <div id="adminUser_dlg_buttons">
     <a id="adminUser_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-no" onclick="closeDialog('#adminUser_dlg')">取消</a>
 </div>




