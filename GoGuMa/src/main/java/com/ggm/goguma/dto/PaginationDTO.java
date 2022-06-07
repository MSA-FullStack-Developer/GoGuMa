package com.ggm.goguma.dto;

import java.util.List;


import lombok.Data;

@Data
public class PaginationDTO<T> {

	private long totalCount;
	
	private long pageSize;
	
	private long blockSize;
	
	private long pageCount;
	
	private long startPage;
	
	private long endPage;
	
	private long currentPage;
	
	private List<T> data;
}
