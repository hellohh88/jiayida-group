<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/static/commons/admin.js"></script>
<script type="text/javascript" src="/static/hightcharts/js/highcharts.js"></script>
<!-- <script type="text/javascript" src="/static/hightcharts/js/modules/exporting.js"></script> -->
<script type="text/javascript" src="/static/commons/highcharts-options.js"></script>
<script type="text/javascript">

$(function() {
	// 不能在这里初始化datebox，否则会报js错误
	renderAuditLog('init');
});

/**
 * 查询
 */
function renderAuditLog(flag) {
	//debugger;
	var form = getQueryJson(flag);
	//console.log(form);
	
	$.ajax({
		type : "post",
		url : 'chart/audit_performance.json',
		data : form,
		success : function(data) {
			if(data && data.code == 0){
				//console.log(data.series[0].data);
			    if(flag == 'init'){
				    $('#audit_startTime_from').datebox('setValue', getMonthFirstDate());
				    $('#audit_startTime_to').datebox("setValue", getDate());
			    }

				var subtitle = getDate($('#audit_startTime_from').datebox("getValue")) + ' ~ ' + getDate($('#audit_startTime_to').datebox("getValue"));
				
			    $('#apiStat_chart').highcharts({
			        chart: {
			            type: 'column'
			        },
			        title: {
			            text: $('#apiStatCat option:selected').text() + '性能�?��'
			        },
			        subtitle: {
			            text: subtitle
			        },
			        xAxis: {
			            type: 'category',
			            labels: {
			                rotation: -45,
			                style: {
			                    fontSize: '13px',
			                    fontFamily: 'Verdana, sans-serif'
			                }
			            }
			        },
			        yAxis: {
			            min: 0,
			            title: {
			                text: '耗时 (毫秒)'
			            }
			        },
			        legend: {
			            enabled: false
			        },
			        tooltip: {
			            pointFormat: '调用耗时: <b>{point.y} 毫秒</b>'
			        },
			        series: [{
			        	// data: data.series ? data.series.data : '',
			        	data: data.series && data.series.length > 0 ? data.series[0].data : [],
			            dataLabels: {
			                enabled: true,
			                rotation: -90,
			                color: '#FFFFFF',
			                align: 'right',
			                x: 4,
			                y: 10,
			                style: {
			                    fontSize: '13px',
			                    fontFamily: 'Verdana, sans-serif',
			                    textShadow: '0 0 3px black'
			                }
			            }
			        }]
			    });		
			}
		},
		error: function(data){
			handleError(data.code);
		}
	});
}

/**
 * 查询条件
 */
function getQueryJson(flag){
	var json;
	//var contextRoot = '/jiayida-admin';
	
	if(flag == 'init'){
		json = {
			from: getMonthFirstDate(),
			contextRoot: $('#apiStatCat').val()
		};
	}else{
		json = {
			from: $('#audit_startTime_from').datebox("getValue"),
			to: $('#audit_startTime_to').datebox("getValue"),
			contextRoot: $('#apiStatCat').val()
		};
	}
	
	return json;
}
</script>

<div id="apiStat_toolbar" style="padding:5px;height:auto">
	日期范围：从<input id="audit_startTime_from" class="easyui-datebox" style="width:100px">
			<input id="audit_startTime_to" class="easyui-datebox" style="width:100px">
	<select id="apiStatCat">
		<option value="/jiayida-admin">管理后台</option>
		<option value="/jiayida-mobile" selected="selected">手机后台</option>
	</select>			
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="renderAuditLog()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#apiStat_toolbar')">清除</a>
</div>

<div id="apiStat_chart" style="width:100%;height:90%"></div>

