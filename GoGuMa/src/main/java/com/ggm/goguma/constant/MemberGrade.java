package com.ggm.goguma.constant;

public enum MemberGrade {
	SILVER(1),
	GOLD(2),
	PLATINUM(3),
	DIAMOND(4);
	
	private final int value;
	
	private MemberGrade(int value) {
		this.value = value;
	}
	
	public int getValue() {
		return this.value;
	}
	
}
