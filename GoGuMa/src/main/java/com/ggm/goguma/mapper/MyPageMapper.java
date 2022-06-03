package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.OrderDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ReceiptDTO;

public interface MyPageMapper {
//	@Select("SELECT nickname, recipient, address, contact FROM deliveryaddress")
//	public List<DeliveryAddressDTO> testWithAnnotation();
	
	List<ReceiptDTO> getReceiptList(long memberId) throws Exception;
	
	List<OrderDTO> getOrderList(long receiptId) throws Exception;
	
	ReceiptDTO getReceiptDetail(long receiptId) throws Exception;
	
	List<Integer> getEarnablePoint(long receiptId) throws Exception;
	
	List<PointDTO> getPointHistory(long memberId) throws Exception;

	List<PointDTO> getSpecificPointHistory(@Param("memberId") long memberId, @Param("type") String type) throws Exception;

	void updateOrderStatus(@Param("orderId") long orderId, @Param("status") String status) throws Exception;
	
	List<DeliveryAddressDTO> getAddressList(long memberid) throws Exception;

	DeliveryAddressDTO getDefaultAddress(long memberid) throws Exception;

	void addAddress(DeliveryAddressDTO dto) throws Exception;

	void updateAddress(DeliveryAddressDTO dto) throws Exception;
	
	void deleteAddress(@Param("memberId") long memberId, @Param("addressId") long addressId) throws Exception;
	
	void setDefault(@Param("memberId") long memberId, @Param("addressId") long addressId) throws Exception;

	void cancelDefault(@Param("memberId") long memberId) throws Exception;

	int getMemberPoint(@Param("memberId") long memberId) throws Exception;
}