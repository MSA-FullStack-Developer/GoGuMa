package com.ggm.goguma.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.mapper.ProductMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;

	@Override
	public List<ProductDTO> getProductList(int categoryID) throws Exception {
		log.info("getProductList.....");
		
		return productMapper.getProductList(categoryID);
	}

	@Override
	public long getProductCount(int categoryID) throws Exception {
		return productMapper.getProductCount(categoryID);
	}

	@Override
	public ProductDTO getProductInfo(int productID) throws Exception {
		return productMapper.getProductInfo(productID);
	}

	@Override
	public List<ProductDTO> getOptionList(int productID) throws Exception {
		return productMapper.getOptionList(productID);
	}

}
