package com.ggm.goguma.service.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.cart.CartItemDTO;
import com.ggm.goguma.dto.cart.CartOrderListDTO;
import com.ggm.goguma.mapper.OrderMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public List<CartItemDTO> getOrderList(List<CartOrderListDTO> dtoList) throws Exception {
		return orderMapper.getOrderList(dtoList);
	}

}
