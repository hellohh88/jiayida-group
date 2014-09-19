package com.joinway.admin.repository;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.joinway.admin.mapper.JiayidaAdminMapper;

@Repository
public class JiayidaAdminRepository {

	@Autowired JiayidaAdminMapper mapper;
	
	public int findCount(CountType type, String from, String to){
		int count = 0;
		
		String f = StringUtils.trimToNull(from);
		String t = StringUtils.trimToNull(to);
		
		if(type == CountType.Login){
			count = mapper.selectLoginCount(f, t);
		}else{
			count = mapper.selectRegisterCount(f, t);
		}
		
		return count;
	}
}
