package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryService {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(long parentID) throws Exception;
	
	public String getCategoryName(long categoryID) throws Exception;
	
	/**
	 * 작성자 : 이승준
	 * 작업 날짜 : 22.05.25
	 **/
	public List<CategoryDTO> getMdsCategoryParentList();
	
	public List<CategoryDTO> showCategoryMenu() throws Exception;
}