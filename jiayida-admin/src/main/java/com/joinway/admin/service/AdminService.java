package com.joinway.admin.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.joinway.admin.bean.UserContext;
import com.joinway.admin.bean.domain.AdminUser;
import com.joinway.admin.bean.domain.TreeMenu;
import com.joinway.admin.bean.form.LoginForm;
import com.joinway.admin.bean.form.MassPushForm;
import com.joinway.admin.bean.form.PushAllForm;
import com.joinway.admin.bean.form.RegisterForm;
import com.joinway.admin.bean.form.ResendForm;
import com.joinway.admin.bean.view.LoginView;
import com.joinway.admin.bean.view.LogoutView;
import com.joinway.admin.bean.view.Menu;
import com.joinway.admin.bean.view.PushView;
import com.joinway.admin.bean.view.TreeMenuView;
import com.joinway.admin.repository.AdminRepository;
import com.joinway.admin.repository.DriveTraineeRepository;
import com.joinway.admin.utils.UIHelper;
import com.joinway.appx.bean.push.PushKey;
import com.joinway.appx.repository.SystemRepository;
import com.joinway.appx.repository.TableRepository;
import com.joinway.appx.service.MessagePushService;
import com.joinway.bean.constant.DBValueConstants;
import com.joinway.bean.exception.DuplicateDataException;
import com.joinway.bean.exception.ValidationException;
import com.joinway.bean.logging.annotation.InputLog;
import com.joinway.common.bean.domain.LoginUser;
import com.joinway.utils.CipherUtils;
import com.joinway.utils.data.Filter;
import com.joinway.utils.data.bean.Condition;

@Service
public class AdminService {

	private final static Logger log = LoggerFactory.getLogger(AdminService.class);

	@Autowired AdminRepository repository;

	@Autowired TableRepository tableRepository;

	@Autowired SystemRepository systemRepository;
	
	@Autowired MessagePushService pushService;
	
	@Autowired DriveTraineeRepository driveTraineeRepository;
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView register(RegisterForm form) throws Exception {
		AdminUser adminUser = repository.findAdminUser(form.getName());

		if (adminUser == null) {
			Date currentTime = Calendar.getInstance().getTime();
			adminUser = new AdminUser();
			adminUser.setLoginName(form.getName().toLowerCase());
			adminUser.setPassword(CipherUtils.encrypt(form.getPassword()));
			adminUser.setLastLoginTime(currentTime);
			adminUser.setCreateTime(currentTime);
			adminUser.setLoginCount(1);
		} else {
			throw new DuplicateDataException("user " + form.getName() + " exists");
		}

		tableRepository.save(adminUser);
		LoginForm loginForm = new LoginForm();
		loginForm.setName(form.getName());
		loginForm.setPassword(form.getPassword());

		return createLoginView(adminUser);
	}

	@Transactional(rollbackFor=Throwable.class)
	public LoginView login(LoginForm form) throws Exception {
		AdminUser adminUser = repository.findAdminUser(form.getName(), CipherUtils.encrypt(form.getPassword()));

		if (adminUser == null) {
			throw new ValidationException("user " + form.getName() + " doesn't exits");
		}

		adminUser.setLastLoginTime(Calendar.getInstance().getTime());
		adminUser.setLoginCount(adminUser.getLoginCount() + 1);

		// repository.save(loginUser);
		tableRepository.save(adminUser);
		return createLoginView(adminUser);
	}

	public LogoutView logout() {
		return new LogoutView();
	}

	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	@InputLog
	public TreeMenuView getNavigatorMenus(int userId) throws Exception {
		List<TreeMenu> trees = null;

		trees = tableRepository.find(TreeMenu.class);
		AdminUser au = tableRepository.find(userId, AdminUser.class);
		
		if ("super".equals(au.getLoginName())) {
			trees = tableRepository.find(TreeMenu.class);
			trees = Filter.create(trees, Condition.create("status", DBValueConstants.YES)).result();
		} else {
			trees = repository.findUserTreeMenus(userId);
		}

		TreeMenuView view = new TreeMenuView();

		List<Menu> menus = UIHelper.convert(trees);
		view.setMenus(menus);

		return view;
	}

	@Transactional(rollbackFor=Throwable.class)
	public PushView push(PushAllForm form) throws Exception {
		AdminUser au = tableRepository.find(form.getUserId(), AdminUser.class);
		
		pushService.broadcast(form.getTitle(), form.getText(), au.getLoginName());

		return new PushView();
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public PushView massPush(MassPushForm form, UserContext uc) throws Exception {
		List<PushKey> keys = buildPushKeys(form.getUserId(), form.getTargetUserIds());
		
		pushService.massBroadcast(form.getTitle(), form.getText(), uc.getLoginName(), keys);
		
		return new PushView();
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public PushView resendPush(ResendForm form, UserContext uc) throws Exception {
		List<PushKey> keys = buildPushKeys(form.getUserId(), form.getTargetUserIds());
		
		pushService.resendMassBroadcast(uc.getLoginName(), keys, form.getPageName());
		
		return new PushView();
	}
	
	List<PushKey> buildPushKeys(int senderId, String receiverUserIds) throws Exception {
		String[] userIds = StringUtils.split(receiverUserIds, ",");
		
		List<PushKey> keys = new ArrayList<>();
		
		for(String userId : userIds){
			LoginUser loginUser = tableRepository.find(Integer.valueOf(userId), LoginUser.class);
			
			if(loginUser != null){
				keys.add(new PushKey(Integer.valueOf(userId), loginUser.getImId(), loginUser.getCellPhoneType()));
			}else{
				log.warn("user id {}  was not found", userId);
			}
		}
		
		return keys;
	}
	
	LoginView createLoginView(AdminUser adminUser) {
		LoginView view = new LoginView();
		view.setLoginName(adminUser.getLoginName().toLowerCase());
		view.setLastLoginTime(adminUser.getLastLoginTime());
		view.setLoginCount(adminUser.getLoginCount());
		view.setUserId(adminUser.getId());

		return view;

	}
	public int getLoginNameCount(String loginName, String id) throws Exception {
		
		int count = repository.findLoginNameCount(loginName, id);
		return count;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public boolean dealStauts(String ids, String dealStatus) throws Exception {
		boolean falg = true;
		try{
			String id[] = ids.split(",");
			for(int i = 0; i < id.length; i++){
				driveTraineeRepository.dealStatus(Integer.parseInt(id[i]), dealStatus);
			}
		}catch(Exception e){
			falg = false;
			throw e;
		}
		return falg;
	}
//	boolean isSuperUser(int userId) throws Exception {
//		boolean ret = false;
//
//		List<UserRole> userRoles = tableRepository.find(UserRole.class);
//		List<UserRole> loginUserRoles = Filter.create(userRoles, Condition.create("userId", userId)).result();
//
//		if (CollectionUtils.isNotEmpty(loginUserRoles)) {
//			List<Integer> roleIds = ReflectionUtils.getCollection(loginUserRoles, "roleId", Integer.class);
//			List<Role> roles = tableRepository.find(Role.class);
//			Role superRole = Filter.create(roles, Condition.create("roleName", DBConstants.SUPER_ROLE_NAME)).result().get(0);
//			ret = roleIds.contains(superRole.getRoleId());
//		}
//
//		return ret;
//	}

}


