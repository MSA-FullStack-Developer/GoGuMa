package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.ProductDTO;

public interface ProductService {
	// 상품 목록
	public List<ProductDTO> getProductList(long pg, long categoryID, String sortType) throws Exception;
	
	// 상품 개수
	public long getProductCount(long categoryID) throws Exception;

	// 상품 정보
	public ProductDTO getProductInfo(long productID) throws Exception;
	
	// 상품 옵션 목록
	public List<ProductDTO> getOptionList(long productID) throws Exception;

	// 상품 옵션 개수
	public long getOptionCount(long productID) throws Exception;

	// 상품 검색
	public List<ProductDTO> getSearchList(String keyword, String sortType) throws Exception;

	public long getSearchCount(String keyword) throws Exception;
}