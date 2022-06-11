package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryMapper {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(long parentID) throws Exception;
	
	public String getCategoryName(long categoryID) throws Exception;
	
	/* *
	 * 작성자 : 이승준
	 * 작업일 : 22.05.25
	 * */
	public List<CategoryDTO> findCategoryByMd();
	
	/* *
	 * 작성자 : 이승준
	 * 작업일 : 22.06.03
	 * */
	public CategoryDTO findCategoryById(@Param("id") long categoryId);
	
	// 상품 번호로 부모 카테고리 번호 조회
	public long getCategoryId(long productID) throws Exception;
}