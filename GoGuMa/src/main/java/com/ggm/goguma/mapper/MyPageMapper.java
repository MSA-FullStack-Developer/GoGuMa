package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.ggm.goguma.dto.DeliveryAddressDTO;

public interface MyPageMapper {
//	@Select("SELECT nickname, recipient, address, contact FROM deliveryaddress")
//	public List<DeliveryAddressDTO> testWithAnnotation();
	
	List<DeliveryAddressDTO> getDeliveryAddressList(int memberid) throws Exception;
}
