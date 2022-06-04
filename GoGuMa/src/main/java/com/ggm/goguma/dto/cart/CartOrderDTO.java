package com.ggm.goguma.dto.cart;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CartOrderDTO{
	
	private String _csrf;
	
	private String allItemSelect;
	
	private List<CartOrderListDTO> cartOrderListDTO;
	
	private int TNP;
	
	private int TDP;
	
	private int TOP;
	
	private CartOrderListDTO productOrder;
}
