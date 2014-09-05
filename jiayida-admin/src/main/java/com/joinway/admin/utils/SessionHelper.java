package com.joinway.admin.utils;

import javax.servlet.http.HttpServletRequest;

import com.joinway.admin.bean.UserContext;
import com.joinway.web.audit.AuditConstants;
import com.joinway.web.utils.FrameworkHelper;

public final class SessionHelper {

	static final String UC = "com.joinway.user.context";
	
	public static UserContext getUserContext(){
		return getUserContext(false);
	}
	
	public static UserContext getUserContext(boolean create){
		HttpServletRequest request = FrameworkHelper.getHttpServletRequest();
		
		UserContext uc = (UserContext)request.getSession().getAttribute(UC);
		if(uc == null && create){
			uc = new UserContext();
			
			request.getSession().setAttribute(UC, uc);
		}
		
		return uc;
	}

//	public static String getFlow(){
//		return (String)getHttpServletRequest().getSession().getAttribute(AuditConstants.FLOW_KEY);
//	}
	
//	public static void expireSession(){
//		SecurityHelper.getHttpServletRequest().getSession().invalidate();
//	}
	
//	static void setUserContext(UserContext uc){
//		HttpServletRequest request = getHttpServletRequest();
//		request.setAttribute(UC, uc);
//	}
	
//	static HttpServletRequest getHttpServletRequest(){
//		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
//	}
	
	private SessionHelper(){}
}
