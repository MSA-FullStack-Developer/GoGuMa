package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.ProductDTO;

public interface ProductMapper {
	// 상품 목록
	public List<ProductDTO> getProductList() throws Exception;
	
	// 상품 개수
	long getProductCount() throws Exception;
}
