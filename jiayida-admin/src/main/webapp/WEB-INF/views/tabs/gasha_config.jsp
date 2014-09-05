<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#gashaConfig_form {
margin: 0;
padding: 10px 30px;
}

.gashaConfig_item {
margin-bottom: 5px;
}

.gashaConfig_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="resources/js/common.js"></script>
<script type="text/javascript">
var gashaConfigTable = 'GASHA_CONFIG';
var gashaConfigQuery;

$(function() {
	// need order, uncomment here
	//var orderBy = getIdDescOrder();
	//initDataGrid('#gashaConfig_grid', appName + 'search/' + gashaConfigTable + '.json?orderBy=' + orderBy');
	
	// no need order
	initDataGrid('#gashaConfig_grid', 'search/' + gashaConfigTable + '.json');
	gashaConfigQuery = '';
});

/**
 * 查询
 */
function doSearchGashaConfig() {
	gashaConfigQuery = getQueryJson();
	searchDataGrid('#gashaConfig_grid', gashaConfigQuery);
}

/**
 * 查询条件
 */
function getQueryJson(){
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#drive_trainee_registerdate_from').datebox("getValue");
	registerDateQuery.to = $('#drive_trainee_registerdate_to').datebox("getValue");
	*/
	var json = {
		weaponId : $('#gashaConfig_weaponId').val()
	};
	
	return json;
}

/**
 * 刷新
 */
function doRefreshGashaConfig() {
	refreshDataGrid('#gashaConfig_grid');
}

/**
 * 导出查询结果
 */
function exportGashaConfigQuery(){
	showConfirmMessage('是否导出查询结果？', function(r){
		if(r){
			var form = new Object();
			// 每列以分号分隔
			form.columns = 'weaponId,weaponId;weight,weight';	
			form.table = gashaConfigTable;
			
			var query = gashaConfigQuery ? gashaConfigQuery : getQueryJson();
			form.query = JSON.stringify(query);
			
			// 表格显示的名称
			form.tableDisplayName = 'GashaConfig';
			form.fileName = 'gashaConfig';
			
			form.type = 'csv';
			
			downloadFile(form);
		}
	});
}

function fillGashaCofnigSelect(){
	$.get('search/distinct/weapon.json?field=weaponId&field=weaponName', function(data) {
		if(data && data.code == 0){
			resetSelect('#gasha_weapon_id', data, 'weaponId', 'weaponName', null, function(value, text){
				return value + ' - ' + text;
			});
		}
	}).fail(function(data) {
		// error occured
		handleError(data.code);
	});	
}

function addGashaCofnigItem(){
	showAddDialog('#gashaConfig_form', '#gashaConfig_dlg');

	fillGashaCofnigSelect();

	$('#gasha_weapon_id').show();
	$('#gasha_weapon_id2').hide();

	$('#gasha_weapon_id option:first').prop("selected", 'selected');

	$('#gashaConfig_save').unbind('click');
	$('#gashaConfig_save').click(function(){
		var actionContext = new Object();
		actionContext.table = 'GASHA_CONFIG';
		actionContext.action = 'add';
		actionContext.idName = 'weaponId';
		actionContext.idValue = $('#gasha_weapon_id').val();
		console.log(actionContext);
	
		$('#gasha_weapon_id2').val($('#gasha_weapon_id').val());
		
		saveItem('#gashaConfig_grid', '#gashaConfig_form', '#gashaConfig_dlg', gashaConfigTable, actionContext);
	});
}

function editGashaConfigItem(){
	var flag = showEditDialog('#gashaConfig_grid', '#gashaConfig_form', '#gashaConfig_dlg');
	
	if(flag){
		//fillGashaCofnigSelect();
	
		$('#gasha_weapon_id').hide();
		$('#gasha_weapon_id2').show();
		
		$('#gashaConfig_save').unbind('click');
		$('#gashaConfig_save').click(function(){
			saveItem('#gashaConfig_grid', '#gashaConfig_form', '#gashaConfig_dlg', gashaConfigTable);
		});
	}
}
</script>
<table id="gashaConfig_grid" style="width:700px;height:250px" data-options="toolbar:'#gashaConfig_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
        <th data-options="field:'weaponId'">武器ID</th>
        <th data-options="field:'weight'">权重</th>
        </tr>
    </thead>
</table>

<div style="display:none">
<form id="gashaConfig_file_form" enctype="multipart/form-data">
	<!-- 解开以下注释 可接受excel文件 -->
	<!-- <input id="gashaConfig_file" type="file" name="file" accept="application/vnd.ms-excel" onchange="uploadFile('gashaConfig_file');"/> -->
	<input id="gashaConfig_file" type="file" name="file" accept=".csv" onchange="uploadFile('gashaConfig_file', gashaConfigTable, doRefreshGashaConfig);"/>
	<input type="submit"/>
</form>
</div>

<div id="gashaConfig_toolbar" style="padding:5px;height:auto">
<!--     <div style="margin-bottom:5px">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddDialog('#gashaConfig_form', '#gashaConfig_dlg')">添加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="showEditDialog('#gashaConfig_grid', '#gashaConfig_form', '#gashaConfig_dlg')">编辑</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="doRefreshGashaConfig()">刷新</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteItem('#gashaConfig_grid', gashaConfigTable)">删除</a>
    </div> -->
  <!-- 添加查询条件  -->      
        武器ID<input id="gashaConfig_weaponId" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearchGashaConfig()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#gashaConfig_toolbar')">清除</a>
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addGashaCofnigItem()">添加</a> 
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit "onclick="editGashaConfigItem()">编辑</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteItem('#gashaConfig_grid', gashaConfigTable, 'weaponId')">删除</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="exportGashaConfigQuery()">导出</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="selectFile('#gashaConfig_file')">导入</a>
</div>

<div id="gashaConfig_dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#gashaConfig_dlg_buttons">
     <form id="gashaConfig_form" method="post" novalidate>
		<div class="gashaConfig_item">
			<label>武器ID</label>
			<input id="gasha_weapon_id2" name="weaponId" readonly>
			<select id="gasha_weapon_id" onchange="$('#gasha_weapon_id2').val(this.value);">
			</select>
		</div>
		<div class="gashaConfig_item">
			<label>权重</label>
			<input name="weight" class="easyui-numberbox" data-options="min:0,max:100,decimalSeparator:''">
		</div>
     </form>
 </div>
 <div id="gashaConfig_dlg_buttons">
     <a id="gashaConfig_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDialog('#gashaConfig_dlg')">取消</a>
 </div>



