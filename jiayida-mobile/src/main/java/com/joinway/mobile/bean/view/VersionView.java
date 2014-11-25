package com.joinway.mobile.bean.view;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.view.View;

@ApiObject(name = "VersionView", description = "查询客户端最新版本信息")
public class VersionView extends View {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1943074176986474964L;

	@ApiObjectField(description = "最新程序的版本")
	String version;
	
	@ApiObjectField(description = "下载地址")
	String url;

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
