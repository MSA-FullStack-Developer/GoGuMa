package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.DeliveryAddressDTO;

public interface MyPageService {
	List<DeliveryAddressDTO> getDeliveryAddressList(int memberid) throws Exception;
}
