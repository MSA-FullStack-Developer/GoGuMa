package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryService {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(int parentID) throws Exception;
	
	public String getCategoryName(int categoryID) throws Exception;
}
