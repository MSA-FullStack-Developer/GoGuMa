package com.ggm.goguma.dto.serviceClient;

import lombok.Data;

/**
 * @author Moon Seokho
 * 고객센터 카테고리 정보를 위한 DTO
 */
@Data
public class ServiceCategoryDTO {
	private long categoryId;
	private String categoryName;
}
