package com.joinway.admin.client;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joinway.appx.bean.domain.AuditLog;
import com.joinway.bean.domain.DomainEntity;
import com.joinway.cobot.Cobot;
import com.joinway.cobot.bean.CobotConfig;
import com.joinway.cobot.bean.DataGridConfig;
import com.joinway.cobot.bean.MyBatisConfig;
import com.joinway.common.bean.domain.LoginUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/cobot-servlet-test.xml" })
public class CobotClient extends AbstractJUnit4SpringContextTests {
	
	@Autowired Cobot cobot;
	
	@Test public void test1() throws Exception {
		Class<? extends DomainEntity> type = AuditLog.class;
		
		CobotConfig config = new CobotConfig();
		
		config.setOutputFile("c:/" + type.newInstance().getTableName().toLowerCase());
		config.setOutputFileType("jsp");
		
		DataGridConfig dataGridConfig = new DataGridConfig();
		dataGridConfig.setDataFileType("csv");
		
		cobot.produceTableHtml(type, config, dataGridConfig);
		
		System.out.println("produce table done!");
	}
	
	@Test public void test2() throws Exception {
		Class<? extends DomainEntity> type = LoginUser.class;
		
		CobotConfig config = new CobotConfig();
		config.setOutputFile("c:/" + type.getSimpleName());
		config.setOutputFileType("xml");
		
		MyBatisConfig myBatisConfig = new MyBatisConfig();
		myBatisConfig.setMapperPackage("com.joinway.admin.mapper");
		
		cobot.produceMyBatisMapper(type, config, myBatisConfig);
		
		System.out.println("produce mapper done!");
	}
}

