package com.ggm.goguma.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.mapper.ProductMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;
	
	//@Value("${pageSize}")
	private long pageSize = 8;

	@Override
	public List<ProductDTO> getProductList(long pg, long categoryID) throws Exception {
		long startNum = (pg - 1) * pageSize + 1;
		long endNum = pg * pageSize;
		
		return productMapper.getProductList(startNum, endNum, categoryID);
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

}