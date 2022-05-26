package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;

public interface OrderMapper {

	List<CartItemDTO> getOrderList(List<CartOrderListDTO> dtoList) throws Exception;

}
