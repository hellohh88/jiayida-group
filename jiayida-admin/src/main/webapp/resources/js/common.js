var appName = '';	// app root context

// tab容器的id
var jtabId = '#tab';

/**
 * 用户信息
 * resendPage - 要重发消息的页面标识
 * userId - 当前登录用户id
 */ 
var UC = UC ? UC : new Object();

function showErrorMessage(text, title){
	var t = typeof(title) != 'undefined' && title != null ? title : '错误';
	showMessage(text, t, 'error');
}

function showInformationMessage(text, title){
	var t = typeof(title) != 'undefined' && title != null ? title : '提示';
	showMessage(text, t, 'info');
}

function showQuestionMessage(text, title){
	var t = typeof(title) != 'undefined' && title != null ? title : '确认';
	showMessage(text, t, 'question');
}

function showWarningMessage(text, title){
	var t = typeof(title) != 'undefined' && title != null ? title : '警告';
	showMessage(text, t, 'warning');
}

function showMessage(text, title, icon){
	$.messager.alert(title, text, icon);
}

function showConfirmMessage(text, callback, title){
	var t = typeof(title) != 'undefined' && title != null ? title : '确认';
	$.messager.confirm(t, text , callback);
}

function initDataGrid(jid, aurl, pageSize, pageList) {
	
	console.log(aurl);
	var size = 30;
	var list = [ 20, 30, 40, 50 ];

	if (pageSize && pageSize > 0) {
		size = pageSize;
	}

	if (pageList) {
		list = pageList;
	}

	$(jid).datagrid({
		loadFilter : function(data) {
			if (data.code == 0) {
				return data.record;
			} else {
				handleError(data.code);
				return "";
			}
		},
		url : aurl,
		pageSize : size,
		pageList : list,
		pagination : true,
		fit : true,
		singleSelect : false,
		method : 'post'
	});
	//debugger;
	console.log('done init data grid');
}

function refreshDataGrid(jgridId){
	$(jgridId).datagrid('reload');
}

function searchDataGrid(jid, json) {
	$(jid).datagrid('load', json);
}


function refreshDataGrid(jid, json){
	$(jid).datagrid('load', json);
}

function showAddDialog(jformId, jdlgId, title){
	$(jformId).form('clear');

	$(jdlgId).dialog({
		title: title ? title : '添加',
		modal: true
	});
	
	$(jdlgId).dialog('open');
}

function showEditDialog(jgridId, jformId, jdlgId, title, callback){
	var rows = $(jgridId).datagrid('getSelections');

	var flag = false;
	
	if(!rows || rows.length == 0){
		showWarningMessage('请选择要编辑的行');
	}else if(rows.length > 1){
		showWarningMessage('只能选择一行进行编辑');
	}else{
		flag = true;
		
		$(jformId).form('load',rows[0]);
			$(jdlgId).dialog({
			title: title ? title : '编辑',
			modal: true
		});
		$(jdlgId).dialog('open');
		
		(callback && typeof(callback) === "function") && callback(rows[0]);
	} 
	
	return flag;
}

function closeDialog(jdlgId) {
	$(jdlgId).dialog('close')
}

/**
 * actionContext contains below fields
 * action - update/add
 * idName - id name of domain object, such as userId
 * idValue - the target id value
 * table - the target table name
 */
function saveItem(jgridId, jformId, jdlgId, tableName, actionContext) {
	$(jformId).form('submit', {
		url : 'save/' + tableName + '.json',
		onSubmit : function() {
			var flag = $(this).form('validate');
			if(flag && actionContext){
				var action = actionContext.action;
				 
				if(action == 'add'){
					var idName = actionContext.idName;
					var idValue = actionContext.idValue;
					var table = actionContext.table;
				 
					$.get('search/' + table + '.json?' + idName + '=' + idValue, function(data){
						if(data && data.code == 0 && data.record && data.record.total > 0){
							showErrorMessage('数据已存在');
							flag = false;
						}
					});
				}
			}
				 
			return flag;
		},
		success : function(data) {
			//console.log(data);
			var view = JSON.parse(data);
			console.log(view);
			if (view.code == 0) {
				// save success
				closeDialog(jdlgId);
				refreshDataGrid(jgridId);
			} else {
				showErrorMessage('保存失败');
				handleError(data.code);
			}
		}
	});
}

function deleteItem(jgridId, tableName, idName){
    var rows = $(jgridId).datagrid('getSelections');
    
    if(rows && rows.length > 0){
		showConfirmMessage('是否删除选中的数据？', function(r){
			if(r){
		        var ids = '';
		        for(var i = 0; i < rows.length; i++){
		        	var obj = rows[i];
		        	
		        	ids += eval('obj.' + idName) + ',';
		        }
		        ids = ids.substring(0, ids.length - 1);
		        //console.log(ids);
		        
	            $.post(appName + 'delete/' + tableName + '.json', {id:ids}, function(data){
	            console.log(data.code);
	                if (data.code != 0){
	                	showErrorMessage('删除失败');
	                	handleError(data.code);
	                }else{
	                	refreshDataGrid(jgridId);
	                }
	            }, 'json');
		    }
		});
    }else{
    	showWarningMessage('请选择要删除的行');
    }
}

function clearCriteria(jparentId){
	var pattern = jparentId + ' :input';
	var inputs = $(pattern);

	for(var i = 0; i < inputs.length; i++){
		inputs[i].value = '';
	}
}

function clearInput(jinputId){
	$(jinputId).val('');
}

function checkAndPush(form, url){
	if(!form || !form.title){
		showErrorMessage('通知标题不能为空');
		return;
	}
	
	if(!form || !form.text){
		showErrorMessage("通知内容不能为空");
		return;
	}

	push(form, url);
}

function push(form, url){
	$.ajax({
		type : "post",
		url : appName + url,
		//async: false,
		data : form,
		success : function(data) {
			//showInformationMessage('发送完毕');
		},
		error: function(){
			showErrorMessage('发送失败');
		}
	});
	
	showInformationMessage('发送完毕');
}

function getIdDescOrder(){
	var order = new Object();
	order.name = 'id';
	order.order = 'desc';
	
	var orderBy = new Array();
	orderBy.push(order);
	
	return JSON.stringify(orderBy);
}

/*
function formatGender(val, row){
	var value = val;
	if(val == 'F'){
		value = '女'
	}else if(val == 'M'){
		value = '男'
	}
	return value;
}
*/

function downloadFile(form){
	var fileName;
	
	$.ajax({
		url: 'export.json', 
		type: 'POST',
		async: false,
		data: form,
    	success: function(data) {
	        if(data.code != 0){
	        	showErrorMessage('保存失败');
	        	handleError(data.code);
	        }else{
	        	fileName = data.fileName;
	        }
    	},
    	error: function(XMLHttpRequest, textStatus, errorThrown) {
    		showErrorMessage('网络连接失败')
    	}
    });
	
	console.log(fileName);
	
	window.location.href = 'download/' + fileName + '.json'
}

function selectFile(jfileId){
	showConfirmMessage('导入数据会覆盖原有数据，是否继续？', function(r){
		if(r){
			$(jfileId).click();
		}
	});
}

function uploadFile(fileId, table, callback){
	var fileName;
	
	$.ajaxFileUpload({
        url: 'upload.json', 
        secureuri:false,
        fileElementId: fileId,
        dataType: 'json',
        async: false,
        success: function (data, status){
            if(data.code == 0){
            	fileName = data.fileName;
            	console.log('returned name ' + fileName);
            	
            	if(fileName){
            		$.post('import/' + fileName + '/' + table + '.json', function(data){
            			if(data.code == 0){
					(callback && typeof(callback) === "function") && callback(data);
            				//showInformationMessage('导入成功');
            			}else{
            				showErrorMessage('导入失败');
            				handleError(data.code);
            			}
            		});
            	}else{
            		showErrorMessage('导入失败');
            	}
            }else if(data.code = 1001 || data.code == 1008){
            	showErrorMessage('文件格式错误');
            }else{
            	showErrorMessage('上传失败');
            	handleError(data.code);
            }
        },
        error: function (data, status, e){
        	showErrorMessage('网络连接失败');
        }
    });
}

function resetSelect(jselectId, data, valueName, textName, selectedValue, formatter){
	$(jselectId).empty();
	
	var count = data.record.total;
	
	for(var i = 0; i < count; i++){
		var e = data.record.rows[i];
		var value = eval('e.' + valueName);
		var text = eval('e.' + textName);
		
		var displayText = text;
		if(formatter && typeof(formatter) === "function"){
			displayText = formatter(value, text);
		}
		
		$(jselectId).append('<option value="'+ value + '">' + displayText + '</option>');
	}	
	
	console.log('selected value ' + selectedValue);
	if(selectedValue){
		$(jselectId).val(selectedValue);
	}
}
/*
function resetSelect2(jselectId, data, valueName, textName, selectedValue){
	$(jselectId).empty();
	
	var count = data.record.total;
	
	for(var i = 0; i < count; i++){
		var e = data.record.rows[i];
		var value = eval('e.' + valueName);
		var text = eval('e.' + textName);
		
		$(jselectId).append('<option value="'+ value + '">' + value + ' - ' + text + '</option>');
	}	
	
	console.log('selected value ' + selectedValue);
	if(selectedValue){
		$(jselectId).val(selectedValue);
	}
}
*/
function handleError(code){
	if(code == 1003){
		window.location.href = 'login.html';
	}
}
