package com.ggm.goguma.dto.cart;

import java.io.Serializable;

import lombok.Data;

@Data
public class CartDTO implements Serializable { 
	private static final long serialVersionUID = 1L;
	private long cartId;
	private long productId;
	private long memberId;
	private int cartAmount;
	private int cartPrice;
}
