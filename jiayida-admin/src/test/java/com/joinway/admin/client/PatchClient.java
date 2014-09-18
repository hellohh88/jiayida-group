package com.joinway.admin.client;

import org.junit.Test;

import com.joinway.cobot.tools.CipherClient;

public class PatchClient {

	@Test public void encryptPatch() throws Exception {
		String type = System.getProperty("patch.type");
		String file = System.getProperty("patch.file");
		
		CipherClient.process(new String[]{type, file});
	}
}
