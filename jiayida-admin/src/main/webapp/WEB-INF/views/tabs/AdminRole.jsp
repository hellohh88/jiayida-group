<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#adminRole_dlg{
	padding:10px 20px;
}
#adminRole_form table{
	width:100%;
	border-collapse:collapse;
	border-right:1px solid #A9A9A9;
}
#adminRole_form th{
	border-left:1px solid #A9A9A9;
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	border-right:1px solid #D3D3D3;
	padding-left:10px;
	text-align:left;
}
#adminRole_form td{
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:5px;
}
</style>

<script type="text/javascript">
var adminRoleTable = 'ADMIN_ROLE';
var adminRoleVtTable = 'ADMIN_ROLE_VT';
var adminRoleQuery;

$(function() {
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
	var json = {
		roleName : $('#adminRole_roleName').val(),
		status : $('#adminRole_status').val(),
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
	$('#adminRole_roleName_input').prop('readonly', false);
	$('#adminRole_form').children().find('input[id^="adminRole_status_input"]').each(function(){
		$(this).prop('disabled', false);
	});
	$('#adminRole_menu_item').show();
	
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

 	// 设置每一个radio最后一项选中
	$('#adminRole_form').children().find(':radio').each(function(){
		$(this).prop('checked', true);
	});
	
	$('#adminRole_save').unbind('click');
	$('#adminRole_save').click(function(){
	 	var valid = checkExistence(adminRoleTable, 'roleName', $('#adminRole_roleName_input').val(), '权限已存在');
	 	
	 	if(valid){
	 		saveItem('#adminRole_grid', '#adminRole_form', '#adminRole_dlg', adminRoleVtTable);
	 	}
 	});
}

/**
 * 编辑
 */
function editAdminRoleItem(){
	$('#adminRole_roleName_input').prop('readonly', true);
	
	var flag = showEditDialog('#adminRole_grid', '#adminRole_form', '#adminRole_dlg', null, function(row){
		// the user can't disable own role, and can't disable super role
		if(row && (${roleIds} && _.contains([${roleIds}], row.id) || row.roleName == 'SUPER')){
			$('#adminRole_status_input_item').hide();
		}else{
			$('#adminRole_status_input_item').show();
		}
	});
 
	if(flag){
		
		if($('#adminRole_roleName_input').val() == 'SUPER'){
			$('#adminRole_menu_item').hide();
		}else{
			$('#adminRole_menu_item').show();
		 	$('#adminRole_menu_select').combotree({
		 		url: 'role/menu.json?roleId=' + $('#adminRole_id_input').val(),
		 		method: 'get',
		 		loadFilter: function(data){
					if(data.code == 0){
						//console.log(data.menus[2].children[2]);
						//console.log(data.menus);
						//debugger;
						return data.menus;
					}else{
						handleError(data.code);
						return "";
					}
		 		}
		 	});
		}
		
	 	$('#adminRole_save').unbind('click');
		$('#adminRole_save').click(function(){
			saveItem('#adminRole_grid', '#adminRole_form', '#adminRole_dlg', adminRoleVtTable);
		});
	}
}

/**
 * 复制
 */
function copyAdminRoleItem(){
	var flag = showCopyDialog('#adminRole_grid', '#adminRole_form', '#adminRole_dlg');
	
	if(flag){
		$('#adminRole_roleName_input').prop('readonly', false);
		$('#adminRole_form').children().find('input[id^="adminRole_status_input"]').each(function(){
			$(this).prop('disabled', false);
		});
		$('#adminRole_status_input_item').show();
		$('#adminRole_menu_item').show();
		
	 	$('#adminRole_menu_select').combotree({
	 		url: 'role/menu.json?roleId=' + $('#adminRole_id_input').val(),
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

	 	$('#adminRole_form').children().find('input[name="id"]').each(function(){
			$(this).val('0');
		});
		
		$('#adminRole_save').unbind('click');
		$('#adminRole_save').click(function(){
			var valid = checkExistence(adminRoleTable, 'roleName', $('#adminRole_roleName_input').val(), '权限已存在');
			if(valid){
				saveItem('#adminRole_grid', '#adminRole_form', '#adminRole_dlg', adminRoleVtTable);
			}
		});
	}
}

function beforeDeleteAdminRoleItem(row){
	var valid = true;
	if(row.roleName == 'SUPER'){
		showInformationMessage('不能删除SUPER权限');
		valid = false;
	}
	return valid;
}
/**
 * 格式化status字段
 */
function AdminRoleStatusFormatter(value, row, index){
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

function resizeAdminRole(){
	$('#adminRole_grid').datagrid('resize');
}
</script>

<table id="adminRole_grid" class="easyui-datagrid" data-options="toolbar:'#adminRole_toolbar'">
    <thead>
        <tr>
        	<th data-options="field:'ck'" checkbox="true"></th>
			<th data-options="field:'id',hidden:false">编号</th>
			<th data-options="field:'roleName',hidden:false">名称</th>
			<th data-options="field:'status',hidden:false,formatter:AdminRoleStatusFormatter">状态</th>
			<th data-options="field:'description',hidden:false">描述</th>
		</tr>
    </thead>
</table>

<div id="adminRole_toolbar">
	<div id="adminRole_querybar" title="查询条件" class="easyui-panel" data-options="collapsible:true,border:false,onCollapse:resizeAdminRole,onExpand:resizeAdminRole">

		<table>

			<tr>
				<td style="text-align:right;"><strong>名称</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="adminRole_roleName" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>状态</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="adminRole_status" style="width:100%">
						<option value="" selected>全部</option>
						<option value="N">禁用</option>
						<option value="Y">启用</option>
					</select>
				</td>
				<td style="padding-left:10px;">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchAdminRole()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearCriteria('#adminRole_querybar')">清空</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin-bottom:5px">
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addAdminRoleItem()">添加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editAdminRoleItem()">编辑</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copyAdminRoleItem()">复制</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cross" plain="true" onclick="deleteItem('#adminRole_grid', adminRoleTable, 'id', beforeDeleteAdminRoleItem)">删除</a>
	</div>

</div>

<div id="adminRole_dlg" class="easyui-dialog" style="width:32%" data-options="shadow:false,resizable:true,closed:true" buttons="#adminRole_dlg_buttons">
     <form id="adminRole_form" method="post">
     	<table>
     		<colgroup>
     			<col width="30%">
     		</colgroup>
														
			<tr style="display:none">
				<th style="">
					编号
				</th>
				<td><input id="adminRole_id_input" style="width:95%" name="id" class="easyui-numberbox" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
						
			<tr style="">
				<th style="">
					名称
				</th>
				<td><input id="adminRole_roleName_input" style="width:95%" name="roleName" maxlength="45" class="easyui-validatebox" data-options="required:true">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
						
			<tr id="adminRole_status_input_item" style="">
				<th style="">
					状态
				</th>
					<td>
			<label><input id="adminRole_status_input1" name="status" type="radio" value="N">禁用</label>
			<label><input id="adminRole_status_input2" name="status" type="radio" value="Y">启用</label>
			</td>
			</tr>
			
			<tr id="adminRole_menu_item">
				<th>可见菜单</th>
				<td><select id="adminRole_menu_select" style="width:95%" name="menuIds" multiple></select></td>
			</tr>
						
			<tr style="">
				<th style="vertical-align:top">
					描述
				</th>
				<td><textarea id="adminRole_description_input" style="width:95%" name="description" rows="3" cols="19"></textarea></td>
			</tr>
		</table>
     </form>
 </div>
 <div id="adminRole_dlg_buttons">
     <a id="adminRole_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-no" onclick="closeDialog('#adminRole_dlg')">取消</a>
 </div>




