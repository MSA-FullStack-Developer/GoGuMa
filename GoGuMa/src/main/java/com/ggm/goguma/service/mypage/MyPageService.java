package com.ggm.goguma.service.mypage;

import java.util.List;

import com.ggm.goguma.dto.CouponDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.OrderDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.UpdateMemberDTO;
import com.ggm.goguma.dto.member.MemberDTO;

public interface MyPageService {
	List<ReceiptDTO> getReceiptHistory(long memberId) throws Exception;
	
	List<ReceiptDTO> getReceiptList(long memberId) throws Exception;
	
	List<OrderDTO> getOrderList(long receiptId) throws Exception;
	
	ReceiptDTO getReceiptDetail(long receiptId) throws Exception;
	
	void updateOrderStatus(long orderId, String status) throws Exception;	
	
	long getEarnablePoint(long receiptId) throws Exception;
	
	long getPointHistoryCount(long memberId, String type, String startDate, String endDate) throws Exception;
	
	long getCouponCount(long memberId, String type) throws Exception;
	
	List<PointDTO> getPointHistory(long memberId, String type, long page, String startDate, String endDate) throws Exception;

	List<CouponDTO> getCouponHistory(long memberId, String type, long page) throws Exception;
	
	List<DeliveryAddressDTO> getAddressList(long memberId) throws Exception;

	DeliveryAddressDTO getDefaultAddress(long memberId) throws Exception;

	void addAddress(DeliveryAddressDTO dto) throws Exception;
	
	void updateAddress(DeliveryAddressDTO dto) throws Exception;
	
	void deleteAddress(long memberId, long addressId) throws Exception;
	
	void setDefault(long memberId, long addressId) throws Exception;

	void cancelDefault(long memberId) throws Exception;

	int getMemberPoint(long memberId) throws Exception;

	boolean confirmPassword(String userPassword, String comparePassword) throws Exception;

	boolean changePassword(String curPassword, String newPassword, MemberDTO dto) throws Exception;
	
	boolean changeInfo(UpdateMemberDTO updateDTO, MemberDTO memberDTO) throws Exception;

	boolean resignMember(String resignDetail, String userPassword, MemberDTO dto) throws Exception;
}