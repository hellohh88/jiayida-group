package com.joinway.mobile.repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.joinway.common.bean.domain.LoginUser;
import com.joinway.mobile.mapper.MobileMapper;

@Repository
public class MobileRepository {

	private final static Logger log = LoggerFactory.getLogger(MobileRepository.class);
	
	@Autowired MobileMapper mapper;
	
	public LoginUser findLoginUser(String name, String password){
		return mapper.selectLoginUser(name, password);
	}
	
//	public List<TreeMenu> findUserTreeMenus(int userId){
//		return mapper.selectUserTreeMenus(userId);
//	}
	
	public LoginUser findLoginUser(String name){
		return mapper.selectLoginUser(name, null);
	}

}
