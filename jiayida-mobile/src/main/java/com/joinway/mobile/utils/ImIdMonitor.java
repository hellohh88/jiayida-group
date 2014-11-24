package com.joinway.mobile.utils;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.joinway.web.input.monitor.InputMonitor;

public class ImIdMonitor implements InputMonitor {

	private final static Logger log = LoggerFactory.getLogger(ImIdMonitor.class);
	
	@Override
	public void watch(Object input, int index) {
		if(StringUtils.isBlank(String.valueOf(input))){
			log.warn("input im id is empty");
		}
	}

}
