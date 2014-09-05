<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#treeMenu_form {
margin: 0;
padding: 10px 30px;
}

.treeMenu_item {
margin-bottom: 5px;
}

.treeMenu_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="resources/js/common.js"></script>
<script type="text/javascript">
var treeMenuTable = 'TREE_MENU';
var treeMenuQuery;

$(function() {
	// need order, uncomment here
	//var orderBy = getIdDescOrder();
	//initDataGrid('#treeMenu_grid', appName + 'search/' + treeMenuTable + '.json?orderBy=' + orderBy');
	
	// no need order
	initDataGrid('#treeMenu_grid', 'search/' + treeMenuTable + '.json');
	treeMenuQuery = '';
});
//debugger;
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
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#treeMenu_fieldName_from').datebox("getValue");
	registerDateQuery.to = $('#treeMenu_fieldName_to').datebox("getValue");
	*/
	var json = {
		text : $('#treeMenu_text').val()
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
	
	fillParentIdSelect('add');
	
	$('#treeMenu_save').unbind('click');
	$('#treeMenu_save').click(function(){
		var actionContext;
		
		// 对于非自增主键，需要用户手工输入，解开以下注释来验证主键在数据库中是否已经存在
		/*
		actionContext = new Object();
		actionContext.table = treeMenuTable;
		actionContext.action = 'add';
		actionContext.idName = 'id';
		actionContext.idValue = $('#treeMenu_id_input').val();
		*/
		saveItem('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg', treeMenuTable, actionContext);
	});
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

/**
 * 编辑
 */
function editTreeMenuItem(){
	var flag = showEditDialog('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg');
 
	if(flag){
		fillParentIdSelect();
		/*
		console.log($('#treeMenu_parentId_input').val());
		
		var selectedValue = parseInt($('#treeMenu_parentId_input').val());
		console.log("set selected value to " + selectedValue);
		
		$('#treeMenu_parentId_select').val(4);
		*/
		$('#treeMenu_save').unbind('click');
		$('#treeMenu_save').click(function(){
			saveItem('#treeMenu_grid', '#treeMenu_form', '#treeMenu_dlg', treeMenuTable);
		});
	}
}
</script>
<table id="treeMenu_grid" style="width:700px;height:250px" data-options="toolbar:'#treeMenu_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
        <th data-options="field:'id'">菜单ID</th>
        <th data-options="field:'text'">名称</th>
        <th data-options="field:'url'">链接</th>
        <th data-options="field:'parentId'">上级菜单ID</th>
        <th data-options="field:'order'">序号</th>
        <th data-options="field:'status'">状态</th>
        </tr>
    </thead>
</table>

<div id="treeMenu_toolbar" style="padding:5px;height:auto">
  <!-- 添加查询条件  -->      
        名称<input id="treeMenu_text" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTreeMenu()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#treeMenu_toolbar')">清除</a>
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addTreeMenuItem()">添加</a> 
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit "onclick="editTreeMenuItem()">编辑</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteItem('#treeMenu_grid', treeMenuTable, 'id')">删除</a>
</div>

<div id="treeMenu_dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#treeMenu_dlg_buttons">
     <form id="treeMenu_form" method="post" novalidate>
		<input id="treeMenu_id_input" name="id" type="hidden">
		<div class="treeMenu_item">
			<label>名称</label>
			<input id="treeMenu_text_input" name="text" class="easyui-validatebox" data-options="required:true">
		</div>
		<div class="treeMenu_item">
			<label>链接</label>
			<input id="treeMenu_url_input" name="url">
		</div>
		<div class="treeMenu_item">
			<label>上级菜单ID</label>
			<input id="treeMenu_parentId_input" name="parentId" type="hidden">
			<select id="treeMenu_parentId_select" onchange="$('#treeMenu_parentId_input').val(this.value);">
			</select>
		</div>
		<div class="treeMenu_item">
			<label>序号</label>
			<input id="treeMenu_order_input" name="order" class="easyui-numberbox" data-options="min:0,decimalSeparator:''">
		</div>
		<div class="treeMenu_item">
			<label>状态</label>
            <input id="treeMenu_status_input" name="status" type="radio" value="Y" checked>可见
            <input name="status" type="radio" value="N">不可见
		</div>
     </form>
 </div>
 <div id="treeMenu_dlg_buttons">
     <a id="treeMenu_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDialog('#treeMenu_dlg')">取消</a>
 </div>

<script type="text/javascript">
//debugger;
</script>
