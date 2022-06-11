package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;

public interface ServiceClientMapper {

	List<ServiceCategoryDTO> getSCategory() throws Exception;

}
