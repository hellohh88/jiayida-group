package com.joinway.admin.service;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joinway.admin.repository.DriveTraineeRepository;
import com.joinway.appx.bean.view.TableResultView;
import com.joinway.appx.repository.TableRepository;
import com.joinway.appx.service.table.CustomTableService;
import com.joinway.appx.service.table.DefaultTableService;
import com.joinway.bean.logging.annotation.InputLog;
import com.joinway.bean.logging.annotation.OutputLog;
import com.joinway.common.bean.domain.DriveTrainee;
import com.joinway.common.bean.domain.LoginUser;
import com.joinway.utils.CipherUtils;

@Service
public class DriveTraineeTableService extends DefaultTableService implements CustomTableService {

	@Autowired DriveTraineeRepository driveTraineeRepository;
	
	@Autowired TableRepository tableRepository;
	
	@Override
	public String getTargetTableName() {
		return "DRIVE_TRAINEE";
	}

	@InputLog
	@OutputLog
	@Transactional(rollbackFor=Throwable.class)
	public TableResultView saveTable(String table, Map<String, String[]> params) throws Exception {
		int id = super.getDomainKey(params);
		TableResultView view = null;
		try{
			LoginUser loginUser = super.buildEntity(params, LoginUser.class);
			loginUser.setPassword(CipherUtils.encrypt(loginUser.getPassword()));
			DriveTrainee driveTrainee = super.buildEntity(params, DriveTrainee.class);
			if(id == 0){
				Date nowDate = new Date();
				
				loginUser.setCreateTime(nowDate);
				tableRepository.save(loginUser);
				
				driveTrainee.setRegisterDate(nowDate);
				driveTrainee.setId(loginUser.getId());
				driveTrainee.setExamStatus(1);
				driveTrainee.setDealStatus(0);
				tableRepository.save(driveTrainee);
				
			}else{
				driveTraineeRepository.updateLoginUser(loginUser.getLoginName(), loginUser.getPassword(), loginUser.getId());
				
				driveTrainee.setId(loginUser.getId());
				driveTraineeRepository.updateDriveTrainee(driveTrainee);
			}
	
			view = new TableResultView();
			view.setId(id);
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
		return view;
	}

	
}


