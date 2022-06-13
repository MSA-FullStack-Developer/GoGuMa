package com.ggm.goguma.dto.member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
public class CertificationUserDTO {

private int code;
	
	private String message;
	
	private Response response;
	
	
	@Data
	@NoArgsConstructor
	@AllArgsConstructor
	public class Response {
		
		private String imp_uid;
		
		private String merchant_uid;
		
		private String pg_tid;
		
		private String pg_provider;
		
		private String name;
		
		private String gender;
		
		private int birth;
		
		private String birthday;
		
		private boolean foreigner;
		
		private String phone;
		
		private String carrier;
		
		private boolean certified;
		
		private String unique_key;
		
		private String unique_in_site;
		
		private String origin;
		
		private boolean foreigner_v2;
	}
}
