package com.joinway.admin.repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.joinway.admin.mapper.DriveTraineeMapper;
import com.joinway.common.bean.domain.DriveTrainee;

@Repository
public class DriveTraineeRepository{

	private final static Logger log = LoggerFactory.getLogger(DriveTraineeRepository.class);
	
	@Autowired DriveTraineeMapper mapper;
	
	public void updateLoginUser(String name, String password, int id){
		 mapper.updateLoginUser(name, password, id);
	}
	public void updateDriveTrainee(DriveTrainee driveTrainee){
		 mapper.updateDriveTrainee(driveTrainee);
	}
	public void dealStatus(int id, String dealStatus){
		 mapper.dealStatus(id, dealStatus);
	}
}
