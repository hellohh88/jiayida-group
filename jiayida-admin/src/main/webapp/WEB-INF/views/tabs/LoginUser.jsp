<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#loginUser_dlg{
	padding:10px 20px;
}
#loginUser_form table{
	width:100%;
	border-collapse:collapse;
	border-right:1px solid #A9A9A9;
}
#loginUser_form th{
	border-left:1px solid #A9A9A9;
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	border-right:1px solid #D3D3D3;
	padding-left:10px;
	padding-right:10px;
	text-align:right;
}
#loginUser_form td{
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:5px;
	text-align:left;
}
</style>

<script type="text/javascript">
var loginUserTable = 'LOGIN_USER';
var loginUserQuery;
var wysiwye = false;	// what you see is what you export
var loginUserDefPwd = '123456';

$(function() {
	initDataGrid('#loginUser_grid', 'search/' + loginUserTable + '.json');
	loginUserQuery = '';

	initUploadFileForm($('#loginUser_file_form'), $('#loginUser_columnMap'), $('#loginUser_grid'), wysiwye);
});


/**
 * 查询
 */
function searchLoginUser() {
	loginUserQuery = getLoginUserQueryJson();
	searchDataGrid('#loginUser_grid', loginUserQuery);
}

/**
 * 查询条件
 */
function getLoginUserQueryJson(){
	var json = {
		loginName : $('#loginUser_loginName').val(),
		cellPhone : $('#loginUser_cellPhone').val(),
		name : $('#loginUser_name').val(),
		gender : $('#loginUser_gender').val(),
		address : $('#loginUser_address').val(),
		email : $('#loginUser_email').val(),
		status : $('#loginUser_status').val(),
	};
	
	return json;
}

/**
 * 刷新
 */
function refreshLoginUser() {
	refreshDataGrid('#loginUser_grid');
}

/** 
 * 添加
 */
function addLoginUserItem(){
	showAddDialog('#loginUser_form', '#loginUser_dlg');
 
	// 设置每一个radio最后一项选中
	$('#loginUser_form').children().find(':radio').each(function(){
		$(this).prop('checked', true);
	});
	
	$('#loginUser_password_input').val(loginUserDefPwd);
 	$('#loginUser_password_input').attr('placeholder', loginUserDefPwd);
	$('#loginUser_loginName_input').attr('readonly', false);

	$('#loginUser_save').unbind('click');
	$('#loginUser_save').click(function(){
	 	var valid = true;
	 	valid = checkExistence(loginUserTable, 'loginName', $('#loginUser_loginName_input').val(), '用户已存在');
	 	
	 	if(valid){
	 		saveItem('#loginUser_grid', '#loginUser_form', '#loginUser_dlg', loginUserTable);
	 	}
 	});
}

/**
 * 编辑
 */
function editLoginUserItem(){
	var flag = showEditDialog('#loginUser_grid', '#loginUser_form', '#loginUser_dlg');
 
	if(flag){
		$('#loginUser_password_input').val('');
	 	$('#loginUser_password_input').attr('placeholder', '留空保持现有密码不变');
	 	$('#loginUser_loginName_input').attr('readonly', true);
	 	
	 	var valid = true;
/*
	 	valid = checkExistence(loginUserTable, 'loginName', $('#loginUser_loginName_input').val(), '用户已存在');
*/
	 	if(valid){
			$('#loginUser_save').unbind('click');
			$('#loginUser_save').click(function(){
				saveItem('#loginUser_grid', '#loginUser_form', '#loginUser_dlg', loginUserTable);
			});
	 	}
	}
}

/**
 * 复制
 */
function copyLoginUserItem(){
	var flag = showCopyDialog('#loginUser_grid', '#loginUser_form', '#loginUser_dlg');
	
	if(flag){
		_.each(['id', 'loginName', 'loginCount', 'salt', 'imId', 'cellPhone', 'cellPhoneType', 'name', 'address', 'email', 'qq', 'lastLoginTime', 'createTime'], function(element){
			$('#loginUser_form').children().find('input[name="' + element + '"]').each(function(){
				$(this).val('');
			});
		});

		$('#loginUser_password_input').val(loginUserDefPwd);
	 	$('#loginUser_password_input').attr('placeholder', loginUserDefPwd);
		$('#loginUser_loginName_input').attr('readonly', false);

		$('#loginUser_save').unbind('click');
		$('#loginUser_save').click(function(){
		 	var valid = true;
		 	valid = checkExistence(loginUserTable, 'loginName', $('#loginUser_loginName_input').val(), '用户已存在');
		 	
		 	if(valid){
				saveItem('#loginUser_grid', '#loginUser_form', '#loginUser_dlg', loginUserTable);
		 	}
		});
	}
}


/**
 * 导出查询结果
 */
function exportLoginUserQuery(type){
	var suffix = type == 'Excel' ? 'xls' : 'csv';
	
	showConfirmMessage('是否以' + type + '格式导出查询结果?', function(r){
		if(r){
			var form = new Object();

			form.columns = getExportColumns($('#loginUser_grid'), wysiwye);
			form.table = loginUserTable;
			
			var query = loginUserQuery ? loginUserQuery : getQueryJson();
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

function LoginUserCellPhoneTypeFormatter(value, row, index){
	var text;
	switch(value){
		case 'A':
			text = 'Android';
			break;
		case 'I':
			text = 'iPhone';
			break;
		default:
			text = value;
	}
	return text;
}

/**
 * 格式化gender字段
 */
function LoginUserGenderFormatter(value, row, index){
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

/**
 * 格式化status字段
 */
function LoginUserStatusFormatter(value, row, index){
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

function resizeLoginUser(){
	$('#loginUser_grid').datagrid('resize');
}
</script>

<table id="loginUser_grid" class="easyui-datagrid" data-options="toolbar:'#loginUser_toolbar'">
    <thead>
        <tr>
        	<th data-options="field:'ck'" checkbox="true"></th>
			<th data-options="field:'id',hidden:false">编号</th>
			<th data-options="field:'loginName',hidden:false">登录名</th>
			<th data-options="field:'password',hidden:true">PASSWORD</th>
			<th data-options="field:'salt',hidden:true">SALT</th>
			<th data-options="field:'imId',hidden:true">IM_ID</th>
			<th data-options="field:'cellPhone',hidden:false">手机号</th>
			<th data-options="field:'cellPhoneType',hidden:false,formatter:LoginUserCellPhoneTypeFormatter">手机类型</th>
			<th data-options="field:'name',hidden:false">真实姓名</th>
			<th data-options="field:'gender',hidden:false,formatter:LoginUserGenderFormatter">性别</th>
			<th data-options="field:'address',hidden:false">通信地址</th>
			<th data-options="field:'postalCode',hidden:false">邮政编码</th>
			<th data-options="field:'email',hidden:false">电子邮箱</th>
			<th data-options="field:'qq',hidden:false">QQ号码</th>
			<th data-options="field:'loginCount',hidden:false">登录次数</th>
			<th data-options="field:'status',hidden:false,formatter:LoginUserStatusFormatter">状态</th>
			<th data-options="field:'lastLoginTime',hidden:false">上次登录日期</th>
			<th data-options="field:'createTime',hidden:false">注册日期</th>
		</tr>
    </thead>
</table>

<div id="loginUser_toolbar">
	<div id="loginUser_querybar" title="查询条件" class="easyui-panel" data-options="collapsible:true,border:false,onCollapse:resizeLoginUser,onExpand:resizeLoginUser">
		<div style="display:none">
			<form id="loginUser_file_form" enctype="multipart/form-data" method="post" action="import.json">
				<input id="loginUser_file" type="file" name="file" accept="" onchange="startUpload($('#loginUser_file_form'));"/>
				<input name="table" type="text" value="LOGIN_USER">
				<input id="loginUser_columnMap" name="columnMap" type="text">
				<input id="loginUser_file_submit" type="submit"/>
			</form>
			<iframe id="loginUser_file_target" name="loginUser_file_target"></iframe>
		</div>

		<table>

			<tr>
				<td style="text-align:right;"><strong>登录名</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="loginUser_loginName" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>手机号</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="loginUser_cellPhone" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>真实姓名</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="loginUser_name" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>性别</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="loginUser_gender" style="width:100%">
						<option value="" selected>全部</option>
						<option value="F">女</option>
						<option value="M">男</option>
					</select>
				</td>
				<td style="padding-left:10px;">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchLoginUser()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearCriteria('#loginUser_querybar')">清空</a>
				</td>
			</tr>

			<tr>
				<td style="text-align:right;"><strong>通信地址</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="loginUser_address" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>电子邮箱</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="loginUser_email" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>状态</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="loginUser_status" style="width:100%">
						<option value="" selected>全部</option>
						<option value="N">禁用</option>
						<option value="Y">启用</option>
					</select>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin-bottom:5px">
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addLoginUserItem()">添加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editLoginUserItem()">编辑</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copyLoginUserItem()">复制</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cross" plain="true" onclick="deleteItem('#loginUser_grid', loginUserTable, 'id')">删除</a>
        <a href="#" class="easyui-menubutton" iconCls="icon-export" data-options="menu:'#loginUser_export'">导出</a>
        <div id="loginUser_export">
			<div data-options="iconCls:'icon-excel'"  onclick="exportLoginUserQuery('Excel')">Excel</div>
			<div data-options="iconCls:'icon-csv'"  onclick="exportLoginUserQuery('CSV')">CSV</div>
		</div>
        <a href="#" class="easyui-menubutton" iconCls="icon-import" data-options="menu:'#loginUser_import'">导入</a>
        <div id="loginUser_import">
			<div data-options="iconCls:'icon-excel'"  onclick="selectFile('#loginUser_file', 'Excel')">Excel</div>
			<div data-options="iconCls:'icon-csv'"  onclick="selectFile('#loginUser_file', 'CSV')">CSV</div>
		</div>
	</div>

</div>

<div id="loginUser_dlg" class="easyui-dialog" style="width:40%" data-options="shadow:false,resizable:true,closed:true" buttons="#loginUser_dlg_buttons">
     <form id="loginUser_form" method="post">
     	<table>
													
			<tr style="display:none">
				<th style="">
					编号
				</th>
				<td><input id="loginUser_id_input" style="width:95%" name="id" class="easyui-numberspinner" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
					
			<tr style="">
				<th style="">
					登录名
				</th>
				<td><input id="loginUser_loginName_input" style="width:95%" name="loginName" class="easyui-validatebox" data-options="required:true,validType:'length[6,20]'"></td>
				<td><span class="hint"></span></td>
		</tr>
					
			<tr style="">
				<th style="">
					PASSWORD
				</th>
				<td><input id="loginUser_password_input" style="width:95%" name="password" class="easyui-validatebox" data-options="required:false,validType:'length[6,20]'"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="display:none">
				<th style="">
					SALT
				</th>
				<td><input id="loginUser_salt_input" style="width:95%" name="salt" class="easyui-validatebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="display:none">
				<th style="">
					IM_ID
				</th>
				<td><input id="loginUser_imId_input" style="width:95%" name="imId" class="easyui-validatebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="">
				<th style="">
					手机号
				</th>
				<td><input id="loginUser_cellPhone_input" style="width:95%" name="cellPhone" class="easyui-validatebox" data-options="required:true,validType:'mobile'"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="display:none">
				<th style="">
					手机类型
				</th>
				<td><input id="loginUser_cellPhoneType_input" style="width:95%" name="cellPhoneType" class="easyui-validatebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
					
			<tr style="">
				<th style="">
					真实姓名
				</th>
				<td><input id="loginUser_name_input" style="width:95%" name="name" class="easyui-validatebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
					
			<tr style="">
				<th style="">
					性别
				</th>
					<td>
			<label><input id="loginUser_gender_input1" name="gender" type="radio" value="F">女</label>
			<label><input id="loginUser_gender_input2" name="gender" type="radio" value="M">男</label>
			</td>
				<td><span class="hint"></span></td>
		</tr>
					
			<tr style="">
				<th style="">
					通信地址
				</th>
				<td><input id="loginUser_address_input" style="width:95%" name="address" class="easyui-validatebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="">
				<th style="">
					邮政编码
				</th>
				<td><input id="loginUser_postalCode_input" style="width:95%" name="postalCode" class="easyui-validatebox" data-options="required:false,validType:'zip'"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="">
				<th style="">
					电子邮箱
				</th>
				<td><input id="loginUser_email_input" style="width:95%" name="email" class="easyui-validatebox" data-options="required:false,validType:'email'"></td>
				<td><span class="hint"></span></td>
		</tr>
														
			<tr style="">
				<th style="">
					QQ号码
				</th>
				<td><input id="loginUser_qq_input" style="width:95%" name="qq" class="easyui-numberspinner" data-options="required:false,min:1"></td>
				<td><span class="hint">最小值1</span></td>
		</tr>
													
			<tr style="display:none">
				<th style="">
					登录次数
				</th>
				<td><input id="loginUser_loginCount_input" style="width:95%" name="loginCount" class="easyui-numberspinner" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
					
			<tr style="">
				<th style="">
					状态
				</th>
					<td>
			<label><input id="loginUser_status_input1" name="status" type="radio" value="N">禁用</label>
			<label><input id="loginUser_status_input2" name="status" type="radio" value="Y">启用</label>
			</td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="display:none">
				<th style="">
					上次登录日期
				</th>
				<td><input id="loginUser_lastLoginTime_input" style="width:95%" name="lastLoginTime" class="easyui-datetimebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
						
			<tr style="display:none">
				<th style="">
					注册日期
				</th>
				<td><input id="loginUser_createTime_input" style="width:95%" name="createTime" class="easyui-datetimebox" data-options="required:false"></td>
				<td><span class="hint"></span></td>
		</tr>
		</table>
     </form>
 </div>
 <div id="loginUser_dlg_buttons">
     <a id="loginUser_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-no" onclick="closeDialog('#loginUser_dlg')">取消</a>
 </div>




