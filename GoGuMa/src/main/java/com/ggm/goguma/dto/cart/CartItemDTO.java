package com.ggm.goguma.dto.cart;

import lombok.Data;

@Data
public class CartItemDTO {
	private long cartId;
	private long productId;
	private int cartAmount;
	private String productName;
	private String parentProductName;
	private int cartPrice;
	private int productPrice;
	private String company;
	private int stock;
	private String prodImgUrl;
	private int isThumbNail;
	private int discountPercent;
	private long categoryId;
	private long parentProductId;
}
