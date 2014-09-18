<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#auditLog_form {
margin: 0;
padding: 10px 30px;
}

.auditLog_item {
margin-bottom: 5px;
}

.auditLog_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="resources/js/common.js"></script>
<script type="text/javascript" src="resources/hightcharts/js/highcharts.js"></script>
<script type="text/javascript" src="resources/hightcharts/js/modules/exporting.js"></script>
<script type="text/javascript">
var auditLogTable = 'AUDIT_LOG_CHART';
/**
 * 查询
 */
function searchAuditLog() {
	var form = getQueryJson();
	$.ajax({
		type : "post",
		url : 'highcharts/audit/perform.json',
		data : form,
		success : function(data) {
			console.log(data);
			if(data && data.code == 0){
			    $('#auditLog_chart').highcharts({
			        chart: {
			            type: 'column'
			        },
			        title: {
			            text: '手机后台应用程序性能分析'
			        },
			        subtitle: {
			            text: getDate($('#audit_startTime_from').datebox("getValue")) + ' ~ ' + getDate($('#audit_startTime_to').datebox("getValue"))
			        },
			        xAxis: {
			        	categories: data.xAxis ? data.xAxis.categories : ''
			        },
			        yAxis: {
			            min: 0,
			            title: {
			                text: '耗时 (毫秒)'
			            }
			        },
			        plotOptions: {
			            column: {
			                pointPadding: 0.2,
			                borderWidth: 0
			            }
			        },
			        series: data.series
			    });			
			}
		},
		error: function(data){
			handleError(data.code);
		}
	});
}

function getDate(date){
	var d = date;
	//debugger;
	if(!date){
		var dd = new Date();
		var year = dd.getYear() + 1900;
		var month = dd.getMonth() + 1;
		var date =  dd.getDate();
		
		month = month < 10 ? '0' + month.toString() : month;
		date = date < 10 ? '0' + date : date;
		
		d = year + '-' + month + '-' + date;
	}	
	
	return d;
}

/**
 * 查询条件
 */
function getQueryJson(){
	var json = {
		from: $('#audit_startTime_from').datebox("getValue"),
		to: $('#audit_startTime_to').datebox("getValue"),
		contextRoot: '/jiayida-admin',
		seriesName: '耗时'
	};
	
	return json;
}
</script>

<div id="auditLog_toolbar" style="padding:5px;height:auto">
	日期范围：从<input id="audit_startTime_from" class="easyui-datebox" style="width:100px">
			�?input id="audit_startTime_to" class="easyui-datebox" style="width:100px">
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchAuditLog()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#auditLog_toolbar')">清除</a>
</div>

<div id="auditLog_chart"></div>



