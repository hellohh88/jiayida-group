<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#loginUser_form {
margin: 0;
padding: 10px 30px;
}

.loginUser_item {
margin-bottom: 5px;
}

.loginUser_item label {
display: inline-block;
width: 80px;
}
</style>

<script type="text/javascript" src="/static/commons/admin.js"></script>
<script type="text/javascript">
var loginUserTable = 'LOGIN_USER';
var loginUserQuery;

$(function() {
	// need order, uncomment here
	//var orderBy = getIdDescOrder();
	//initDataGrid('#loginUser_grid', appName + 'search/' + loginUserTable + '.json?orderBy=' + orderBy');
	
	// no need order
	initDataGrid('#loginUser_grid', 'search/' + loginUserTable + '.json');
	loginUserQuery = '';
});

/**
 * 查询
 */
function searchLoginUser() {
	loginUserQuery = getQueryJson();
	searchDataGrid('#loginUser_grid', loginUserQuery);
}

/**
 * 查询条件
 */
function getQueryJson(){
	// search from/to date demo
	/*
	var registerDateQuery = new Object();
	registerDateQuery.type = 'date';
	registerDateQuery.from = $('#loginUser_fieldName_from').datebox("getValue");
	registerDateQuery.to = $('#loginUser_fieldName_to').datebox("getValue");
	*/
	var json = {
		userName : $('#loginUser_userName').val()
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
 
	$('#loginUser_save').unbind('click');
	$('#loginUser_save').click(function(){
	 	saveItem('#loginUser_grid', '#loginUser_form', '#loginUser_dlg', loginUserTable);
 	});
}

/**
 * 编辑
 */
function editLoginUserItem(){
	var flag = showEditDialog('#loginUser_grid', '#loginUser_form', '#loginUser_dlg');
 
	if(flag){
		$('#loginUser_save').unbind('click');
		$('#loginUser_save').click(function(){
			saveItem('#loginUser_grid', '#loginUser_form', '#loginUser_dlg', loginUserTable);
		});
	}
}

/**
 * 导出查询结果
 */
function exportLoginUserQuery(){
	showConfirmMessage('是否导出查询结果？', function(r){
		if(r){
			var form = new Object();
			// 每列以分号分隔
			form.columns = 'question,question;creditLine,creditLine;visitCount,visitCount;userName,userName;qq,qq;userRank,userRank;cellPhoneType,cellPhoneType;imId,imId;parentId,parentId;userId,userId;addressId,addressId;password,password;homePhone,homePhone;sex,sex;birthday,birthday;isValidated,isValidated;ecSalt,ecSalt;salt,salt;frozenMoney,frozenMoney;lastLogin,lastLogin;flag,flag;rankPoints,rankPoints;lastIp,lastIp;mobilePhone,mobilePhone;email,email;isSpecial,isSpecial;answer,answer;lastTime,lastTime;passwdQuestion,passwdQuestion;userMoney,userMoney;passwdAnswer,passwdAnswer;payPoints,payPoints;officePhone,officePhone;msn,msn;regTime,regTime;alias,alias';	
			form.table = loginUserTable;
			
			var query = loginUserQuery ? loginUserQuery : getQueryJson();
			form.query = JSON.stringify(query);
			
			// 表格显示的名称
			form.tableDisplayName = 'LoginUser';
			form.fileName = 'loginUser';
			
			form.type = 'csv';
			
			downloadFile(form);
		}
	});
}
</script>
<table id="loginUser_grid" style="width:700px;height:250px" data-options="toolbar:'#loginUser_toolbar'">
    <thead>
        <tr>
        <th data-options="field:'ck'" checkbox="true"></th>
		<th data-options="field:'id'">用户 编号</th>
		<th data-options="field:'loginName'">用户名</th>
		<th data-options="field:'gender'">性别</th>
		<th data-options="field:'cellPhone'">手机号</th>
		<th data-options="field:'email'">电子邮箱</th>
		<th data-options="field:'qq'">QQ</th>
		<th data-options="field:'msn'">MSN</th>
		<th data-options="field:'lastLoginTime'">上次登录时间</th>
		<th data-options="field:'loginCount'">登录次数</th>
		<th data-options="field:'createTime'">注册时间</th>
		<!-- <th data-options="field:'question'">question</th>
		<th data-options="field:'creditLine'">creditLine</th> -->
		<!-- <th data-options="field:'cellPhoneType'">cellPhoneType</th> -->
		<!-- <th data-options="field:'imId'">imId</th> -->
		<!-- <th data-options="field:'parentId'">parentId</th> -->
		<!-- <th data-options="field:'addressId'">addressId</th> -->
		<!-- <th data-options="field:'password'">password</th> -->
		<!-- <th data-options="field:'isValidated'">isValidated</th> -->
		<!-- <th data-options="field:'ecSalt'">ecSalt</th>
		<th data-options="field:'salt'">salt</th> -->
		<!-- <th data-options="field:'frozenMoney'">frozenMoney</th> -->
		<!-- <th data-options="field:'flag'">flag</th> -->
		<!-- <th data-options="field:'rankPoints'">rankPoints</th> -->
		<!-- <th data-options="field:'lastIp'">lastIp</th> -->
		<!-- <th data-options="field:'isSpecial'">isSpecial</th>
		<th data-options="field:'answer'">answer</th> -->
		<!-- <th data-options="field:'lastTime'">lastTime</th>
		<th data-options="field:'passwdQuestion'">passwdQuestion</th> -->
		<!-- <th data-options="field:'userMoney'">userMoney</th> -->
		<!-- <th data-options="field:'passwdAnswer'">passwdAnswer</th> -->
		<!-- <th data-options="field:'payPoints'">payPoints</th> -->
		<!-- <th data-options="field:'alias'">alias</th> -->
    </thead>
</table>

<div style="display:none">
<form id="loginUser_file_form" enctype="multipart/form-data">
	<!-- 解开以下注释 可接受excel文件 -->
	<!-- <input id="loginUser_file" type="file" name="file" accept="application/vnd.ms-excel" onchange="uploadFile('loginUser_file');"/> -->
	<!-- 当前只支持csv格式 -->
	<input id="loginUser_file" type="file" name="file" accept=".csv" onchange="uploadFile('loginUser_file', loginUserTable, refreshLoginUser);"/>
	<input type="submit"/>
</form>
</div>

<div id="loginUser_toolbar" style="padding:5px;height:auto">
<!--     <div style="margin-bottom:5px">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddDialog('#loginUser_form', '#loginUser_dlg')">添加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="showEditDialog('#loginUser_grid', '#loginUser_form', '#loginUser_dlg')">编辑</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="refreshLoginUser()">刷新</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteItem('#loginUser_grid', loginUserTable)">删除</a>
    </div> -->
  <!-- 添加查询条件  -->      
        用户名<input id="loginUser_userName" type="text"/>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchLoginUser()">查询</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearCriteria('#loginUser_toolbar')">清除</a>
  		<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addLoginUserItem()">添加</a> 
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit "onclick="editLoginUserItem()">编辑</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteItem('#loginUser_grid', loginUserTable, 'userId')">删除</a>
<!--         <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="exportLoginUserQuery()">导出</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-excel" onclick="selectFile('#loginUser_file')">导入</a> -->
</div>

<div id="loginUser_dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#loginUser_dlg_buttons">
     <form id="loginUser_form" method="post" novalidate>
     	<input id="loginUser_userId_input" name="userId" type="hidden">
		<div class="loginUser_item">
			<label>用户名</label>
			<input id="loginUser_userName_input" name="loginName">
		</div>
<!-- 		<div class="loginUser_item">
			<label>密码</label>
			<input id="loginUser_password_input" name="password">
		</div> -->
		<div class="loginUser_item">
			<label>手机号</label>
			<input id="loginUser_alias_input" name="cellPhone">
		</div> 
<!-- 		<div class="loginUser_item">
			<label>creditLine</label>
			<input id="loginUser_creditLine_input" name="creditLine">
		</div> -->
<!--	<div class="loginUser_item">
			<label>question</label>
			<input id="loginUser_question_input" name="question">
		</div>
		<div class="loginUser_item">
			<label>qq</label>
			<input id="loginUser_qq_input" name="qq">
		</div>
		<div class="loginUser_item">
			<label>userRank</label>
			<input id="loginUser_userRank_input" name="userRank">
		</div>
		<div class="loginUser_item">
			<label>parentId</label>
			<input id="loginUser_parentId_input" name="parentId">
		</div>
		<div class="loginUser_item">
			<label>addressId</label>
			<input id="loginUser_addressId_input" name="addressId">
		</div>
		<div class="loginUser_item">
			<label>homePhone</label>
			<input id="loginUser_homePhone_input" name="homePhone">
		</div>
		<div class="loginUser_item">
			<label>sex</label>
			<input id="loginUser_sex_input" name="sex">
		</div>
		<div class="loginUser_item">
			<label>birthday</label>
			<input id="loginUser_birthday_input" name="birthday">
		</div>
		<div class="loginUser_item">
			<label>isValidated</label>
			<input id="loginUser_isValidated_input" name="isValidated">
		</div>
		<div class="loginUser_item">
			<label>frozenMoney</label>
			<input id="loginUser_frozenMoney_input" name="frozenMoney">
		</div>
		<div class="loginUser_item">
			<label>flag</label>
			<input id="loginUser_flag_input" name="flag">
		</div>
		<div class="loginUser_item">
			<label>rankPoints</label>
			<input id="loginUser_rankPoints_input" name="rankPoints">
		</div>
		<div class="loginUser_item">
			<label>mobilePhone</label>
			<input id="loginUser_mobilePhone_input" name="mobilePhone">
		</div>
		<div class="loginUser_item">
			<label>email</label>
			<input id="loginUser_email_input" name="email">
		</div>
		<div class="loginUser_item">
			<label>isSpecial</label>
			<input id="loginUser_isSpecial_input" name="isSpecial">
		</div>
		<div class="loginUser_item">
			<label>answer</label>
			<input id="loginUser_answer_input" name="answer">
		</div>
		<div class="loginUser_item">
			<label>passwdQuestion</label>
			<input id="loginUser_passwdQuestion_input" name="passwdQuestion">
		</div>
		<div class="loginUser_item">
			<label>userMoney</label>
			<input id="loginUser_userMoney_input" name="userMoney">
		</div>
		<div class="loginUser_item">
			<label>passwdAnswer</label>
			<input id="loginUser_passwdAnswer_input" name="passwdAnswer">
		</div>
		<div class="loginUser_item">
			<label>payPoints</label>
			<input id="loginUser_payPoints_input" name="payPoints">
		</div>
		<div class="loginUser_item">
			<label>officePhone</label>
			<input id="loginUser_officePhone_input" name="officePhone">
		</div>
		<div class="loginUser_item">
			<label>msn</label>
			<input id="loginUser_msn_input" name="msn">
		</div>
		-->
     </form>
 </div>
 <div id="loginUser_dlg_buttons">
     <a id="loginUser_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDialog('#loginUser_dlg')">取消</a>
 </div>




