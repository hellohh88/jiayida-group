<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>佳艺达后台管理系统</title>
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui/1.4.1/themes/default/easyui.css">
    <!-- <link rel="stylesheet" type="text/css" href="/static/jquery-easyui/themes/metro-red/easyui.css"> -->
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui/1.4.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui/1.4.1/themes/color.css">
    <link rel="stylesheet" type="text/css" href="/static/css/admin.css">
    <link rel="stylesheet" type="text/css" href="resources/css/common.css">
    
    <script type="text/javascript" src="/static/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui/1.4.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui/1.4.1/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="/static/ueditor/1.4.3/ueditor.config.js"></script>
	<script type="text/javascript" src="/static/ueditor/1.4.3/ueditor.all.min.js"></script>
    <script type="text/javascript" src="/static/underscore/1.7/underscore-min.js"></script>
    <script type="text/javascript" src="/static/commons/jquery.validatebox.extend.js"></script>
    <script type="text/javascript" src="/static/jquery/plugins/jquery.blockUI-2.7.js"></script>
    <script type="text/javascript" src="/static/commons/admin.js"></script>
    <script type="text/javascript" src="resources/js/common.js"></script>
    
<script type="text/javascript">
function collapseWestRegion(){
	$('body').layout('panel','expandWest').addClass("panel-title").css("text-align", "center").html('导<br>航<br>菜<br>单');
	//$('body').children().find('[id$="_querybar"]').each(function(){
	var curTab = $(jtabId).tabs('getSelected');
	if(curTab){
		curTab.children().find('[id$="_querybar"]').each(function(){
			$(this).panel('resize');
		});
	}
}
function resizeWestRegion(){
	$('body').children().find('[id$="_querybar"]').each(function(){
		// the invoke interval is an workaround due to can't get center panel width immediately
		var _this = $(this);
		setTimeout(function(){
			_this.panel('resize');
		}, 500);
	});
}
</script>
</head>
<body id="adminBody" class="easyui-layout">
	<div id="header" data-options="region:'north',href:'header.jspx'" style="height:60px"></div>
	<div data-options="region:'west',split:true,href:'west.jspx',onCollapse:collapseWestRegion,onResize:resizeWestRegion" title="导航菜单" style="width:200px;"></div>
	<div data-options="region:'center',iconCls:'icon-ok',href:'center.jspx'"></div>
</body>
</html>
