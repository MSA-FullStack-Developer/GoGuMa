package com.ggm.goguma.dto.coupon;

import java.util.Date;

import lombok.Data;

@Data
public class MemberCouponOrderDTO {
	
	private long memberId;
	private int used;
	private long couponId;
	private String couponName;
	private int benefit;
	private int restriction;
	private String expiration;
	
}
