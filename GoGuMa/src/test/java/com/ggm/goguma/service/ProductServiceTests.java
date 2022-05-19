package com.ggm.goguma.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:**/*-context.xml"})
public class ProductServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private ProductMapper productMapper;

    @Test
    public void testExist() {
    	log.info(productMapper);
    	assertNotNull(productMapper);
    }
    
	@Test
	public void getProductListTest() throws Exception {
		/* 상품 목록 */
		List<ProductDTO> list = productMapper.getProductList();
		for(int i = 0; i < list.size(); i++) {
			System.out.println("Result......." + i + " : " + list.get(i));
		}
		
		/* 상품 개수 */
		long result = productMapper.getProductCount();
		System.out.println("Result.........." + result);
	}
}
