<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#treeMenu_dlg{
	padding:10px 20px;
}
#treeMenu_form table{
	width:100%;
	border-collapse:collapse;
	border-right:1px solid #A9A9A9;
}
#treeMenu_form th{
	border-left:1px solid #A9A9A9;
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	border-right:1px solid #D3D3D3;
	padding-left:10px;
	padding-right:10px;
	text-align:right;
}
#treeMenu_form td{
	border-top:1px solid #A9A9A9;
	border-bottom:1px solid #A9A9A9;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:5px;
	text-align:left;
}
</style>

<script type="text/javascript">
var treeMenuTable = 'TREE_MENU';
var treeMenuQuery;
var wysiwye = false;	// what you see is what you export

$(function() {
	initDataGrid('#treeMenu_grid', 'search/' + treeMenuTable + '.json');
	treeMenuQuery = '';

	initUploadFileForm($('#treeMenu_file_form'), $('#treeMenu_columnMap'), $('#treeMenu_grid'), wysiwye);
});


/**
 * 查询
 */
function searchTreeMenu() {
	treeMenuQuery = getQueryJson();
	searchDataGrid('#treeMenu_grid', treeMenuQuery);
}

/**
 * 查询条件
 */
function getQueryJson(){
	var json = {
		text : $('#treeMenu_text').val(),
		status : $('#treeMenu_status').val(),
	};
	
	return json;
}

/**
 * 刷新
 */
function refreshTreeMenu() {
	refreshDataGrid('#treeMenu_grid');
}

/** 
 * 添加
 */
function addTreeMenuItem(){
	showAddDialog('#treeMenu_form', '#treeMenu_dlg');
 
	// 设置每一个radio最后一项选中
	$('#treeMenu_form').children().find(':radio').each(function(){
		$(this).prop('checked', true);
	});
	
	fillParentIdSelect('add');
	
	$('#treeMenu_save').unbind('click');
	$('#treeMenu_save').click(function(){
	 	var valid = true;
	 	valid = checkExistence(treeMenuTable, 'text', $('#treeMenu_text_input').val(), '菜单已存在');
	 	
	 	if(valid){
	 		saveItem('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg', treeMenuTable, reloadTreeMenu);
	 	}
 	});
}

/**
 * 编辑
 */
function editTreeMenuItem(){
	var flag = showEditDialog('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg');
 
	if(flag){
		fillParentIdSelect();
		
		$('#treeMenu_save').unbind('click');
		$('#treeMenu_save').click(function(){
			saveItem('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg', treeMenuTable, reloadTreeMenu);
		});
	}
}

/**
 * 复制
 */
function copyTreeMenuItem(){
	var flag = showCopyDialog('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg');
	
	if(flag){
		fillParentIdSelect();
		
		$('#treeMenu_form').children().find('input[name="id"]').each(function(){
			$(this).val('0');
		});
		
		$('#treeMenu_save').unbind('click');
		$('#treeMenu_save').click(function(){
			var valid = checkExistence(treeMenuTable, 'text', $('#treeMenu_text_input').val(), '菜单已存在');
			if(valid){
				saveItem('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg', treeMenuTable, reloadTreeMenu);
			}
		});
	}
}



/**
 * 导出查询结果
 */
function exportTreeMenuQuery(type){
	var suffix = type == 'Excel' ? 'xls' : 'csv';
	
	showConfirmMessage('是否以' + type + '格式导出查询结果?', function(r){
		if(r){
			var form = new Object();

			form.columns = getExportColumns($('#treeMenu_grid'), wysiwye);
			form.table = treeMenuTable;
			
			var query = treeMenuQuery ? treeMenuQuery : getQueryJson();
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
function TreeMenuStatusFormatter(value, row, index){
	var text;
	switch(value){
		case 'N':
			text = '不可见';
			break;
		case 'Y':
			text = '可见';
			break;
		default:
			text = value;
	}
	return text;
}

function resizeTreeMenu(){
	$('#treeMenu_grid').datagrid('resize');
}

function reloadTreeMenu(){
	$('#nav_menu').tree('reload');
}

function fillParentIdSelect(action){
	$.get('search/distinct/' + treeMenuTable + '.json?field=id&field=text', function(data) {
		if(data && data.code == 0){
			resetSelect('#treeMenu_parentId_select', data, 'id', 'text', null, function(value, text){
				return value + ' - ' + text;
			});
			
			$('#treeMenu_parentId_select').append('<option value="0" select>无</option>');
			
			if(action == 'add'){
				$('#treeMenu_parentId_select').val('0');
				$('#treeMenu_parentId_input').val('0');
			}else{
				$('#treeMenu_parentId_select').val($('#treeMenu_parentId_input').val());
			}
		}
	}).fail(function(data) {
		// error occured
		handleError(data.code);
	});	
}
</script>

<table id="treeMenu_grid" class="easyui-datagrid" data-options="toolbar:'#treeMenu_toolbar'">
    <thead>
        <tr>
        	<th data-options="field:'ck'" checkbox="true"></th>
			<th data-options="field:'id',hidden:false">编号</th>
			<th data-options="field:'text',hidden:false">名称</th>
			<th data-options="field:'parentId',hidden:false">上级菜单</th>
			<th data-options="field:'status',hidden:false,formatter:TreeMenuStatusFormatter">状态</th>
			<th data-options="field:'url',hidden:false">链接</th>
			<th data-options="field:'order',hidden:false">顺序号</th>
			<th data-options="field:'icon',hidden:false">图标类型</th>
		</tr>
    </thead>
</table>

<div id="treeMenu_toolbar">
	<div id="treeMenu_querybar" title="查询条件" class="easyui-panel" data-options="collapsible:true,border:false,onCollapse:resizeTreeMenu,onExpand:resizeTreeMenu">
		<div style="display:none">
			<form id="treeMenu_file_form" enctype="multipart/form-data" method="post" action="import.json">
				<input id="treeMenu_file" type="file" name="file" accept="" onchange="startUpload($('#treeMenu_file_form'));"/>
				<input name="table" type="text" value="TREE_MENU">
				<input id="treeMenu_columnMap" name="columnMap" type="text">
				<input id="treeMenu_file_submit" type="submit"/>
			</form>
			<iframe id="treeMenu_file_target" name="treeMenu_file_target"></iframe>
		</div>

		<table>

			<tr>
				<td style="text-align:right;"><strong>名称</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<input id="treeMenu_text" style="width:100%" type="text"/>
				</td>
				<td style="text-align:right;"><strong>状态</strong></td>
				<td style="text-align:left;padding-left:0px;padding-right:10px;">
					<select id="treeMenu_status" style="width:100%">
						<option value="" selected>全部</option>
						<option value="N">不可见</option>
						<option value="Y">可见</option>
					</select>
				</td>
				<td style="padding-left:10px;">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTreeMenu()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearCriteria('#treeMenu_querybar')">清空</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="margin-bottom:5px">
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addTreeMenuItem()">添加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editTreeMenuItem()">编辑</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copyTreeMenuItem()">复制</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cross" plain="true" onclick="deleteItem('#treeMenu_grid', treeMenuTable, 'id', null, reloadTreeMenu)">删除</a>
        <a href="#" class="easyui-menubutton" iconCls="icon-export" data-options="menu:'#treeMenu_export'">导出</a>
        <div id="treeMenu_export">
			<div data-options="iconCls:'icon-excel'"  onclick="exportTreeMenuQuery('Excel')">Excel</div>
			<div data-options="iconCls:'icon-csv'"  onclick="exportTreeMenuQuery('CSV')">CSV</div>
		</div>
        <a href="#" class="easyui-menubutton" iconCls="icon-import" data-options="menu:'#treeMenu_import'">导入</a>
        <div id="treeMenu_import">
			<div data-options="iconCls:'icon-excel'"  onclick="selectFile('#treeMenu_file', 'Excel')">Excel</div>
			<div data-options="iconCls:'icon-csv'"  onclick="selectFile('#treeMenu_file', 'CSV')">CSV</div>
		</div>
	</div>

</div>

<div id="treeMenu_dlg" class="easyui-dialog" style="width:28%" data-options="shadow:false,resizable:true,closed:true" buttons="#treeMenu_dlg_buttons">
     <form id="treeMenu_form" method="post">
     	<table>
														
			<tr style="display:none">
				<th style="">
					编号
				</th>
				<td><input id="treeMenu_id_input" style="width:95%" name="id" class="easyui-numberspinner" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
						
			<tr style="">
				<th style="">
					名称
				</th>
				<td><input id="treeMenu_text_input" style="width:95%" name="text" class="easyui-validatebox" data-options="required:true">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
															
			<tr style="">
				<th style="">
					上级菜单
				</th>
				<td>
					<input id="treeMenu_parentId_input" name="parentId" type="hidden">
					<select id="treeMenu_parentId_select" style="width:95%" onchange="$('#treeMenu_parentId_input').val(this.value);"></select>
				</td>
			</tr>
						
			<tr style="">
				<th style="">
					状态
				</th>
					<td>
			<label><input id="treeMenu_status_input1" name="status" type="radio" value="N">不可见</label>
			<label><input id="treeMenu_status_input2" name="status" type="radio" value="Y">可见</label>
			</td>
			</tr>
						
			<tr style="">
				<th style="">
					链接
				</th>
				<td><input id="treeMenu_url_input" name="url" style="width:95%" class="easyui-validatebox" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
															
			<tr style="">
				<th style="">
					顺序号
				</th>
				<td><input id="treeMenu_order_input" name="order" style="width:95%" class="easyui-numberspinner" data-options="required:false,min:0"></td>
			</tr>
						
			<tr style="">
				<th style="">
					图标类型
				</th>
				<td><input id="treeMenu_icon_input" name="icon" style="width:95%" class="easyui-validatebox" data-options="required:false">&nbsp;&nbsp;<span class="hint"></span></td>
			</tr>
		</table>
     </form>
 </div>
 <div id="treeMenu_dlg_buttons">
     <a id="treeMenu_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-no" onclick="closeDialog('#treeMenu_dlg')">取消</a>
 </div>




