package com.ggm.goguma.dto;

import lombok.Data;

@Data
public class CancelPayDTO {
	private String uid;
	private int cancelAmount;
	private String reason;
	
	//무통장 입금 결제의 경우 필수 조건 사항
	private String refundHolder;
	private String refundBank;
	private String refundAccount;
}
