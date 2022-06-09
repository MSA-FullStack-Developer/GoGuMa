package com.ggm.goguma.dto.cart;

import java.util.List;

import com.ggm.goguma.dto.DeliveryAddressDTO;

import lombok.Data;

@Data
public class TransactionDTO {
	private long receiptId;
	private String impUid;
	private String status;
	private List<ProductOrderDTO> products;
	private DeliveryAddressDTO address;
	private String requirement;
	private int originalPrice;
	private int membershipDiscount;
	private long couponId;
	private int couponDiscount;
	private int usagePoint;
	private int totalPrice;
	
}
