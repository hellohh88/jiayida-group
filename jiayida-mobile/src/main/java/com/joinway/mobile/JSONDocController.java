package com.joinway.mobile;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.jsondoc.core.pojo.JSONDoc;
import org.jsondoc.core.util.JSONDocUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/jsondoc")
public class JSONDocController {
	private final static Logger log = LoggerFactory.getLogger(JSONDocController.class);

	@RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public JSONDoc getApi(HttpServletRequest request) {
		String version = "v1";
		String basePath = StringUtils.join(new Object[] { request.getScheme(),
				"://", request.getServerName(), ":", request.getServerPort(),
				request.getContextPath(), "/" });

		log.info("init doc version [{}], doc path [{}]", version, basePath);

		List<String> packages = new ArrayList<String>();
		
		packages.add("com.joinway");
		
		return JSONDocUtils.getApiDoc(version, basePath, packages);
	}
}