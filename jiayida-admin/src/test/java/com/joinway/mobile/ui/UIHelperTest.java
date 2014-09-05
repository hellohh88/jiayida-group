package com.joinway.mobile.ui;

import static java.lang.System.out;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Assert;
import org.junit.Test;

import com.joinway.admin.bean.domain.TreeMenu;
import com.joinway.admin.bean.view.Menu;
import com.joinway.admin.bean.view.TreeMenuView;
import com.joinway.admin.utils.UIHelper;
import com.joinway.utils.json.JsonConverter;

public class UIHelperTest {

	Pattern pattern = Pattern.compile("\\d+"); 
	
	@Test public void test1() throws Exception {
		List<Menu> menus = UIHelper.convert(getMenus("menu1.csv"));
		out.println(JsonConverter.objectToJson(menus));
		
		Assert.assertEquals(2, menus.size());
	}
	
	List<TreeMenu> getMenus(String csv) throws Exception {
		List<TreeMenu> menus = new ArrayList<>();
		
		List<String> lines = FileUtils.readLines(new File(this.getClass().getClassLoader().getResource("data/" + csv).getFile()));
		
		String title = lines.get(0);
		String fields[] = StringUtils.split(title, ",");
		
		for(int i = 1; i < lines.size(); i++){
			TreeMenu menu = new TreeMenu();
			
			for(int j = 0; j < fields.length; j++){
				String[] values = StringUtils.split(lines.get(i), ",");
				
				if(pattern.matcher(values[j]).matches()){
					PropertyUtils.setProperty(menu, fields[j], Integer.valueOf(values[j]));
				}else{
					PropertyUtils.setProperty(menu, fields[j], values[j]);
				}
			}
			
			menus.add(menu);
		}
		
		return menus;
	}
}
