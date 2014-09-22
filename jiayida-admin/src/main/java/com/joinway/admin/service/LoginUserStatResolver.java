package com.joinway.admin.service;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinway.admin.bean.view.LoginUserCountView;
import com.joinway.admin.repository.CountType;
import com.joinway.admin.repository.JiayidaAdminRepository;
import com.joinway.admin.service.highcharts.ChartConstants;
import com.joinway.appx.bean.view.ChartView;
import com.joinway.appx.service.charts.ChartResolver;
import com.joinway.appx.utils.RequestUtils;

@Service
public class LoginUserStatResolver implements ChartResolver {

	@Autowired JiayidaAdminRepository repository;
	
	@Override
	public ChartView render(Map<String, String[]> params) {
		String from = StringUtils.replace(RequestUtils.getParam(ChartConstants.Param.FROM, params), "-", "");
		String to = StringUtils.replace(RequestUtils.getParam(ChartConstants.Param.TO, params), "-", "");
		String contextRoot = RequestUtils.getParam(ChartConstants.Param.CONTEXT_ROOT, params);
		
		LoginUserCountView view = new LoginUserCountView();
		
		int loginCount = repository.findLoginCount(CountType.Login, from, to, contextRoot);
		int registerCount = repository.findRegisterCount(CountType.Regiser, from, to);
		
		view.setLoginCount(loginCount);
		view.setRegisterCount(registerCount);
		
		return view;
	}

	@Override
	public String getName() {
		return "login_user";
	}

}
