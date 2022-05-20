package com.ggm.goguma.dto;

import java.util.List;

import lombok.Data;

@Data
public class CategoryDTO {
	private int categoryID;
	private int parentID;
	private String categoryName;
	private String categoryType;
	private String MD;
	
	private List<CategoryDTO> categoryList;
}