<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="resources/js/admin.js"></script>
<script type="text/javascript" src="resources/hightcharts/js/highcharts.js"></script>
<!-- <script type="text/javascript" src="resources/hightcharts/js/modules/exporting.js"></script> -->
<script type="text/javascript" src="resources/js/highcharts-options.js"></script>
<script type="text/javascript">

$(function() {
	// 不能在这里初始化datebox，否则会报js错误
	renderLoginUser('init');
});

/**
 * 查询
 */
function renderLoginUser(flag) {
	var form = getQueryJson(flag);
	
	$.ajax({
		type : "post",
		url : 'chart/login_user.json',
		data : form,
		success : function(data) {
			if(data && data.code == 0){
				//console.log(data.series[0].data);
				//debugger;
			    if(flag == 'init'){
				    $('#loginUserStat_from').datebox('setValue', getMonthFirstDate());
				    $('#loginUserStat_to').datebox("setValue", getDate());
				}
				
				var subTitle = getDate($('#loginUserStat_from').datebox("getValue")) + ' ~ ' + getDate($('#loginUserStat_to').datebox("getValue"));
				
			    $('#loginUser_chart').highcharts({
			        chart: {
			            type: 'column'
			        },
			        title: {
			            text: '用户登录注册统计'
			        },
			        subtitle: {
			            text: subTitle
			        },
			        xAxis: {
			            categories: [
			                '数量统计'
			            ]
			        },
			        yAxis: {
			            min: 0,
			            title: {
			                text: '数量'
			            }
			        },
			        plotOptions: {
			            column: {
			                pointPadding: 0.2,
			                borderWidth: 0
			            }
			        },
			        /*
			        tooltip: {
			            pointFormat: '<b>{point.y} �?/b>'
			        },
			        */
			        series: [{
			            name: '登录人数',
			            data: [data.loginCount]
			
			        }, {
			            name: '注册人数',
			            data: [data.registerCount]
			
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
	var contextRoot = '/jiayida-admin';
	
	if(flag == 'init'){
		json = {
			from: getMonthFirstDate(),
			contextRoot: contextRoot
		};
	}else{
		json = {
			from: $('#loginUserStat_from').datebox("getValue"),
			to: $('#loginUserStat_to').datebox("getValue"),
			contextRoot: contextRoot
		};
	}
	
	return json;
}
</script>

<div id="loginUserStat_toolbar" style="padding:5px;height:auto">
	日期范围：从<input id="loginUserStat_from" class="easyui-datebox" style="width:100px">
			<input id="loginUserStat_to" class="easyui-datebox" style="width:100px">
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="renderLoginUser()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#loginUserStat_toolbar')">清除</a>
</div>

<div id="loginUser_chart" style="width:100%;height:90%"></div>

