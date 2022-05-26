package com.ggm.goguma.dto.cart;

import lombok.Data;

@Data
public class CartOrderListDTOInfo {
	private long cartId;
	private long itemSelect;
	private int ordQty;
	private int productSock;
	private int nrmOriPrc;
	private double disOriPrc;
	private double totOriPrc;
}
