package com.joinway.mobile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinway.appx.repository.TableRepository;
import com.joinway.bean.exception.ValidationException;
import com.joinway.common.bean.domain.LoginUser;
import com.joinway.mobile.bean.view.UserView;

@Service
public class UserService {

	@Autowired TableRepository repository;
	
	public UserView getUser(int userId) throws Exception {
		LoginUser user = repository.find(userId, LoginUser.class);
		
		if(user == null){
			throw new ValidationException("用户不存在");
		}
		
		UserView view = new UserView();
		view.setCellPhone(user.getMobilePhone());
		
		return view;
	}
}
