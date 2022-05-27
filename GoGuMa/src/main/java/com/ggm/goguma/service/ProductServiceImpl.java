package com.ggm.goguma.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.mapper.ProductMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;
	
	private long pageSize = 8;
	
	@Override
	public List<ProductDTO> getProductList(long pg, long categoryID, String sortType) throws Exception {
		long startNum = (pg - 1) * pageSize + 1;
		long endNum = pg * pageSize;
		
		return productMapper.getProductList(startNum, endNum, categoryID, sortType);
	}

	@Override
	public long getProductCount(long categoryID) throws Exception {
		return productMapper.getProductCount(categoryID);
	}

	@Override
	public ProductDTO getProductInfo(long productID) throws Exception {
		return productMapper.getProductInfo(productID);
	}

	@Override
	public List<ProductDTO> getOptionList(long productID) throws Exception {
		return productMapper.getOptionList(productID);
	}

	@Override
	public long getOptionCount(long productID) throws Exception {
		return productMapper.getOptionCount(productID);
	}

	@Override
	public List<ProductDTO> getSameParentCategoryProductList(long categoryID) {
		
		long offset = 0;
		long limit = 8;
	
		return this.productMapper.findProductListByParentCategoryId(categoryID, offset, limit);
	}

	@Override
	public List<ProductDTO> getSearchList(String keyword, String sortType) throws Exception {
		return productMapper.getSearchList(keyword, sortType);
	}

	@Override
	public long getSearchCount(String keyword) throws Exception {
		return productMapper.getSearchCount(keyword);
	}

}