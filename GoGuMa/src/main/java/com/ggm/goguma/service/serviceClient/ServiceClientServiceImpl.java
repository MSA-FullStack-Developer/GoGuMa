package com.ggm.goguma.service.serviceClient;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.ServiceClientDTO;
import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;
import com.ggm.goguma.mapper.ServiceClientMapper;
import com.ggm.goguma.service.order.OrderServiceImpl;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ServiceClientServiceImpl implements ServiceClientService{
	
	@Autowired
	private ServiceClientMapper serviceClientMapper;
	
	private long pageSize = 10;
	
	// 고객센터 카테고리 조회
	@Override
	public List<ServiceCategoryDTO> getSCategory() throws Exception {
		return serviceClientMapper.getSCategory();
	}

	@Override
	public List<ServiceClientDTO> getQnaList(long pg, long memberID) throws Exception {
		long startNum = (pg - 1) * pageSize + 1;
		long endNum = pg * pageSize;
		
		return serviceClientMapper.getQnaList(startNum, endNum, memberID);
	}

	@Override
	public long getQnaCount(long id) throws Exception {
		return serviceClientMapper.getQnaCount(id);
	}

	@Override
	public void insertQna(ServiceClientDTO serviceClientDTO) throws Exception {
		serviceClientMapper.insertQna(serviceClientDTO);
		
	}
	
}