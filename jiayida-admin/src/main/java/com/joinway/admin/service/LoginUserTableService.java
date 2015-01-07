package com.joinway.admin.service;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.joinway.appx.bean.view.TableResultView;
import com.joinway.appx.service.table.CustomTableService;
import com.joinway.appx.service.table.DefaultTableService;
import com.joinway.appx.service.table.TableServiceHelper;
import com.joinway.common.bean.domain.LoginUser;
import com.joinway.utils.CipherUtils;

@Service
public class LoginUserTableService extends DefaultTableService implements CustomTableService {

	@Override
	public String getTargetTableName() {
		return "LOGIN_USER";
	}

	@Override
	public TableResultView saveTable(String table, Map<String, String[]> params) throws Exception {
		LoginUser loginUser = TableServiceHelper.buildEntity(params, LoginUser.class);
		
		if(loginUser.getId() == 0){
			// add user
			String salt = UUID.randomUUID().toString().split("-")[0];
			loginUser.setPassword(CipherUtils.secureEncrypt(loginUser.getPassword(), salt));
			loginUser.setCreateTime(new Date());
			loginUser.setSalt(salt);
		}else{
			// update user
			LoginUser user = repository.find(loginUser.getId(), LoginUser.class);
			if(StringUtils.isBlank(loginUser.getPassword())){
				loginUser.setPassword(user.getPassword());
			}else{
				loginUser.setPassword(CipherUtils.secureEncrypt(loginUser.getPassword(), user.getSalt()));
			}
		}
		
		repository.save(loginUser);
		
		TableResultView view = new TableResultView();
		view.setId(loginUser.getId());
		
		return view;
	}

}
