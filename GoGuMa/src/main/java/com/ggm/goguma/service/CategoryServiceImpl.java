package com.ggm.goguma.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.mapper.CategoryMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryMapper categoryMapper;
	
	@Override
	public List<CategoryDTO> getCategoryParentList() throws Exception {
		log.info("getCategoryList.....");
		
		return categoryMapper.getCategoryParentList();
	}

	@Override
	public List<CategoryDTO> getCategoryList(@Param(value="parentID") long parentID) throws Exception {
		return categoryMapper.getCategoryList(parentID);
	}

	@Override
	public String getCategoryName(long categoryID) throws Exception {
		return categoryMapper.getCategoryName(categoryID);
	}

}