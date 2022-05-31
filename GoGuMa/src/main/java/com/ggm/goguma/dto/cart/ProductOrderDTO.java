package com.ggm.goguma.dto.cart;

import lombok.Data;

@Data
public class ProductOrderDTO {
	
	private long cartId;
	private long productId;
	private int ordQty;
}
