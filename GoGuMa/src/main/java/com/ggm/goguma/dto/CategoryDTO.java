package com.ggm.goguma.dto;

import java.util.List;

import lombok.Data;

@Data
public class CategoryDTO {
	private long categoryID;
	private long parentID;
	private String categoryName;
	private String categoryType;
	private String MD;
	
	private List<CategoryDTO> categoryList;
}