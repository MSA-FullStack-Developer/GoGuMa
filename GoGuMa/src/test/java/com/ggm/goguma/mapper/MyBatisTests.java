package com.ggm.goguma.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MyBatisTests {
	@Setter(onMethod_ = @Autowired)
	private MyPageMapper mapper;
	
//	@Test
//	public void testDeliveryAddress1() {
//		log.info(mapper.getClass().getName());
//		log.info(mapper.testWithAnnotation());
//	}
//	
//	@Test
//	public void testDeliveryAddress2() {
//		log.info(mapper.getClass().getName());
//		log.info(mapper.getDeliveryAddressList());
//	}
}
