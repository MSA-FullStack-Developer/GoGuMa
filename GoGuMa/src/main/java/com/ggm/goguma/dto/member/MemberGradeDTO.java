package com.ggm.goguma.dto.member;

import lombok.Data;

@Data
public class MemberGradeDTO {

	private int id;
	
	private String name;
	
	private int pointPercent;
	
	private int discountPercent;
	
	private int orderCriteria;
	
	private int priceCriteria;
}
