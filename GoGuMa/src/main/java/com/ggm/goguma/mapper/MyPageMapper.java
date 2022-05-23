package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.DeliveryAddressDTO;

public interface MyPageMapper {
//	@Select("SELECT nickname, recipient, address, contact FROM deliveryaddress")
//	public List<DeliveryAddressDTO> testWithAnnotation();
	
	List<DeliveryAddressDTO> getAddressList(int memberid) throws Exception;

	DeliveryAddressDTO getDefaultAddress(int memberid) throws Exception;
}