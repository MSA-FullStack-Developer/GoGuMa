package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ProductDTO;

public interface ProductMapper {
	// 상품 목록
	public List<ProductDTO> getProductList(@Param("startNum") long startNum, @Param("endNum") long endNum, 
											@Param("categoryID") long categoryID) throws Exception;
	
	// 상품 개수
	public long getProductCount(long categoryID) throws Exception;

	// 상품 정보
	public ProductDTO getProductInfo(long productID) throws Exception;
	
	// 상품 옵션 정보
	public List<ProductDTO> getOptionList(long productID) throws Exception;
}