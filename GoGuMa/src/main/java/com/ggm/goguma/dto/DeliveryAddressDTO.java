package com.ggm.goguma.dto;

import lombok.Data;

@Data
public class DeliveryAddressDTO {
	public int addressId;
	public String nickName;
	public String recipient;
	public String address;
	public String contact;
	public int isDefault;
	public int memberId;
}