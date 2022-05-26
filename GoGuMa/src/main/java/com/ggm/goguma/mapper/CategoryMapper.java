package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryMapper {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(long parentID) throws Exception;
	
	public String getCategoryName(long categoryID) throws Exception;
	
	/**
	 * 작성자 : 이승준
	 * 작업 날짜 : 22.05.25
	 * */
	public List<CategoryDTO> findCategoryByMd();
}