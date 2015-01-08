<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	//alert('aaaa');
	$('#nav_menu').tree({
		url: 'navigator.json',
		animate : true,
		loadFilter: function(data){
			if(data.code == 0){
				return data.menus;
			}else{
				handleError(data.code);
				return "";
			}
		},
		onClick:function(node){
			if(node.children != null) return;
			
			var tab = $(jtabId);
			if(tab.tabs('exists', node.text)){
				tab.tabs("select", node.text); 
			}else{
				tab.tabs('add', {
					title: node.text,
					href: node.attribute.url,
					closable: true,
					iconCls: node.iconCls
				});
			}
		}
	});
});
</script>
<ul id="nav_menu"></ul>
<!-- <div class="easyui-accordion" style="height:100%">
	<div title="系统设置">
		<a href="#">菜单管理</a><br>
		<a href="#">系统权限</a>
	</div>
	<div title="代码工具">
		<a href="#">DDL2Bean</a>
	</div>
</div> -->