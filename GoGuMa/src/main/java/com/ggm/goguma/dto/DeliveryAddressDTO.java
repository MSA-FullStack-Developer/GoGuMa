package com.ggm.goguma.dto;

import lombok.Data;

@Data
public class DeliveryAddressDTO {
	private long addressId;
	private String nickName;
	private String recipient;
	private String postCode;
	private String address;
	private String detail;
	private String contact;
	private int isDefault;
	private long memberId;
}