package com.ggm.goguma.service.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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

	/* *
	 * 작성자 : 이승준
	 * 작업 날짜 : 22.05.25
	 * */
	@Override
	public List<CategoryDTO> getMdsCategoryParentList() {
		return this.categoryMapper.findCategoryByMd();
	}
	
	// 카테고리 메뉴
	public List<CategoryDTO> showCategoryMenu() throws Exception {
		List<CategoryDTO> parentCategory = this.getCategoryParentList(); // 부모 카테고리 목록
		
		parentCategory.forEach(cate -> {
			try {
				List<CategoryDTO> categoryList = this.getCategoryList(cate.getCategoryID());
				cate.setCategoryList(categoryList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
		
		return parentCategory;
	}
}