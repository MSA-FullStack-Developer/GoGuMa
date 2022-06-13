package com.ggm.goguma.service.product;

import java.util.List;

import com.ggm.goguma.dto.CategoryDTO;

public interface CategoryService {
	public List<CategoryDTO> getCategoryParentList() throws Exception;
	
	public List<CategoryDTO> getCategoryList(long parentID) throws Exception;
	
	public String getCategoryName(long categoryID) throws Exception;
	
	/* *
	 * 작성자 : 이승준
	 * 작업일 : 22.05.25
	 * */
	public List<CategoryDTO> getMdsCategoryParentList();
	
	public List<CategoryDTO> showCategoryMenu() throws Exception;

	// 상품 번호로 부모 카테고리 번호 조회
	public long getCategoryId(long productID) throws Exception;
}