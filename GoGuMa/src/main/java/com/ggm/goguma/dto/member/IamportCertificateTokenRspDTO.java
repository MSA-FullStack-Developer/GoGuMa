package com.ggm.goguma.dto.member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
public class IamportCertificateTokenRspDTO {

private int code;
	
	private String message;
	
	private Response response;
	
	@Data
	@NoArgsConstructor
	@AllArgsConstructor
	public class Response {
		private String access_token;
		private int now;
		private int expired_at;
	}
}
