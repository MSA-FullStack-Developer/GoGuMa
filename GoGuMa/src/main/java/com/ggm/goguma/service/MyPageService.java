package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.DeliveryAddressDTO;

public interface MyPageService {
	List<DeliveryAddressDTO> getAddressList(long memberid) throws Exception;

	DeliveryAddressDTO getDefaultAddress(long memberid) throws Exception;

	void addAddress(DeliveryAddressDTO dto) throws Exception;
	
	void updateAddress(DeliveryAddressDTO dto) throws Exception;
	
	void deleteAddress(long memberId, long addressId) throws Exception;
	
	void setDefault(long memberId, long addressId) throws Exception;

	void cancelDefault(long memberId) throws Exception;

	int getMemberPoint(long memberId) throws Exception;
}
