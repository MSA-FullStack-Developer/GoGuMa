package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ProductDTO;

public interface ProductMapper {
	// 상품 목록
	public List<ProductDTO> getProductList(@Param("startNum") long startNum,
											@Param("endNum") long endNum, 
											@Param("categoryID") long categoryID,
											@Param("sortType") String sortType) throws Exception;
	
	// 상품 개수
	public long getProductCount(long categoryID) throws Exception;

	// 상품 정보
	public ProductDTO getProductInfo(long productID) throws Exception;
	
	// 상품 옵션 목록
	public List<ProductDTO> getOptionList(long productID) throws Exception;
	
	// 상품 옵션 개수
	public long getOptionCount(long productID) throws Exception;
	
	
	/**
	 * 작성자 : 이승준
	 * 작업일 : 22.05.25
	 * */
	//대분류 카테고리 아이디로 해당 카테고리에 속한 최신 상품 목록 조회
	public List<ProductDTO> findProductListByParentCategoryId(@Param("categoryID") long categoryID, @Param("offset") long offset, @Param("limit") long limit);


	// 상품 검색
	public List<ProductDTO> getSearchList(@Param("keyword") String keyword, @Param("sortType") String sortType) throws Exception;

	public long getSearchCount(@Param("keyword") String keyword) throws Exception;

}