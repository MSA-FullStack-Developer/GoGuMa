package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.DeliveryAddressDTO;

public interface MyPageMapper {
//	@Select("SELECT nickname, recipient, address, contact FROM deliveryaddress")
//	public List<DeliveryAddressDTO> testWithAnnotation();
	
	List<DeliveryAddressDTO> getAddressList(long memberid) throws Exception;

	DeliveryAddressDTO getDefaultAddress(long memberid) throws Exception;
	
	void addAddress(DeliveryAddressDTO dto) throws Exception;
	
	void deleteAddress(@Param("memberId") long memberId, @Param("addressId") long addressId) throws Exception;
	
	void setDefault(@Param("memberId") long memberId, @Param("addressId") long addressId) throws Exception;

	void cancelDefault(@Param("memberId") long memberId) throws Exception;
}