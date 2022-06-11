package com.ggm.goguma.service.serviceClient;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;
import com.ggm.goguma.mapper.ServiceClientMapper;
import com.ggm.goguma.service.order.OrderServiceImpl;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ServiceClientServiceImpl implements ServiceClientService{
	
	@Autowired
	private ServiceClientMapper serviceClientMapper;
	
	// 고객센터 카테고리 조회
	@Override
	public List<ServiceCategoryDTO> getSCategory() throws Exception {
		return serviceClientMapper.getSCategory();
	}


}
