<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	$(jtabId).tabs({
		onSelect: function(title, index){
			$(this).children().find('[id$="_querybar"]').each(function(){
				// the invoke interval is an workaround due to can't get center panel width immediately
				var _this = $(this);
				setTimeout(function(){
					_this.panel('resize');
				}, 0);
			});
			$(this).children().find('[id$="_grid"]').each(function(){
				$(this).datagrid('resize'); 
			});
		}
	});
});
</script>
<div id="tab" class="easyui-tabs" data-options="fit:true">
   	<div title="欢迎" style="padding:10px" data-options="iconCls:'icon-home'">
<!--        <div id="welcome"></div>
       <div style="font-size: 14px;position: absolute;bottom: 1px;left: 40%"><font color="#C0C0C0">Copyright 2014 by Joinway  众晖科技</font></div> -->
   	</div>
</div>
