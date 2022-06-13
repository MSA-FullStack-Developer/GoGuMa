package com.ggm.goguma.dto.member;

import lombok.Data;

@Data
public class ContractDTO {
	
	private long id;

	private String title;
	
	private String content;
	
	private boolean isRequired;
}
