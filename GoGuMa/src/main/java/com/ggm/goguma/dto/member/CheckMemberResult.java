package com.ggm.goguma.dto.member;

import lombok.Data;

@Data
public class CheckMemberResult {

	private String email;
	
	private boolean isExist;
}
