package com.joinway.admin.client;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joinway.admin.bean.MassPush;
import com.joinway.cobot.Cobot;
import com.joinway.cobot.bean.CobotConfig;
import com.joinway.cobot.bean.DataGridConfig;
import com.joinway.common.bean.domain.LoginUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/cobot-servlet-test.xml" })
public class CobotClient extends AbstractJUnit4SpringContextTests {
	
	@Autowired Cobot cobot;
	
	@Test public void test1() throws Exception {
//		cobot.produceTableHtml(Weapon.class, "c:/weapon.html");
		CobotConfig config = new CobotConfig();
		config.setOutputFile("c:/" + MassPush.class.newInstance().getTableName().toLowerCase());
		
		DataGridConfig dataGridConfig = new DataGridConfig();
		dataGridConfig.setDataFileType("csv");
		
		cobot.produceTableHtml(MassPush.class, config, dataGridConfig);
		
		System.out.println("produce table done!");
	}
	
	@Test public void test2() throws Exception {
		CobotConfig config = new CobotConfig();
		config.setOutputFile("c:/" + LoginUser.class.getSimpleName());
		config.setOutputFileType("xml");
		
		cobot.produceMyBatisMapper(LoginUser.class, config);
		
		System.out.println("produce mapper done!");
	}
}

