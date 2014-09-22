package com.joinway.admin.repository;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.joinway.admin.mapper.JiayidaAdminMapper;

@Repository
public class JiayidaAdminRepository {

	@Autowired JiayidaAdminMapper mapper;
	
	public int findLoginCount(CountType type, String from, String to, String contextRoot){
		String f = StringUtils.trimToNull(from);
		String t = StringUtils.trimToNull(to);
		
		return mapper.selectLoginCount(f, t, contextRoot);
	}
	
	public int findRegisterCount(CountType type, String from, String to){
		String f = StringUtils.trimToNull(from);
		String t = StringUtils.trimToNull(to);
		
		return mapper.selectRegisterCount(f, t);
	}
}
