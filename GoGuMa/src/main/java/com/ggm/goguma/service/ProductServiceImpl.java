package com.ggm.goguma.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	
	@Setter(onMethod_ = @Autowired) 
	private ProductMapper productMapper;

	@Override
	public List<ProductDTO> getProductList() throws Exception {
		log.info("getProductList.....");
		
		return productMapper.getProductList();
	}

	@Override
	public long getProductCount() throws Exception {
		return productMapper.getProductCount();
	}

}
