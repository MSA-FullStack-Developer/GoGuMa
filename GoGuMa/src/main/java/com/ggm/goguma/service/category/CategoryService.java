package com.ggm.goguma.service.category;

import java.util.List;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryService {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(long parentID) throws Exception;
	
	public String getCategoryName(long categoryID) throws Exception;
}