package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryMapper {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(int parentID) throws Exception;
}
