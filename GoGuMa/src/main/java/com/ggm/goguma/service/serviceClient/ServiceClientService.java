package com.ggm.goguma.service.serviceClient;

import java.util.List;

import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;

public interface ServiceClientService {

	List<ServiceCategoryDTO> getSCategory() throws Exception;


}
