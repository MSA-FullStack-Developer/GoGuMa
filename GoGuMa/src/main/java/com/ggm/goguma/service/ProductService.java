package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.ProductDTO;

public interface ProductService {
	// 상품 목록
	public List<ProductDTO> getProductList(int categoryID) throws Exception;
	
	// 상품 개수
	public long getProductCount(int categoryID) throws Exception;

	// 상품 정보
	public ProductDTO getProductInfo(int productID) throws Exception;
}
