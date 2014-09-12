package com.joinway.admin.client;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joinway.cobot.ui.bean.DataGridConfig;
import com.joinway.cobot.ui.service.DataGridCobot;
import com.joinway.common.bean.domain.LoginUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/cobot-servlet-test.xml" })
public class CobotClient extends AbstractJUnit4SpringContextTests {
	
	@Autowired DataGridCobot cobot;
	
	@Test public void test1() throws Exception {
//		cobot.produceTableHtml(Weapon.class, "c:/weapon.html");
		DataGridConfig config = new DataGridConfig();
		config.setOutputFile("c:/" + LoginUser.class.newInstance().getTableName().toLowerCase());
		config.setDataFileType("csv");
		
		cobot.produceTableHtml(LoginUser.class, config);
		System.out.println("done!");
	}
}
