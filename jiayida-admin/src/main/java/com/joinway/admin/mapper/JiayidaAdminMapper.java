package com.joinway.admin.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface JiayidaAdminMapper {

	int selectRegisterCount(@Param("from") String from, @Param("to") String to);
	
	int selectLoginCount(@Param("from") String from, @Param("to") String to, @Param("contextRoot") String contextRoot);
	
}
