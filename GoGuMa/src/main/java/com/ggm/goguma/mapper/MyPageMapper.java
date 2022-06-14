package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.CouponDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.OrderDTO;
import com.ggm.goguma.dto.OrderPerformanceDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.dto.member.MemberGradeDTO;

public interface MyPageMapper {
//	@Select("SELECT nickname, recipient, address, contact FROM deliveryaddress")
//	public List<DeliveryAddressDTO> testWithAnnotation();
	
	List<ReceiptDTO> getReceiptList(@Param("memberId") long memberId, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;
	
	List<OrderDTO> getOrderList(long receiptId) throws Exception;
	
	ReceiptDTO getReceiptDetail(long receiptId) throws Exception;
	
	void updateOrderStatus(@Param("orderId") long orderId, @Param("status") String status) throws Exception;

	void updateAllOrderStatus(@Param("receiptId")long receiptId, @Param("status")String status)throws Exception;
	
	void makeInquirable(long orderId) throws Exception;
	
	void makeAllInquirable(long receiptId)throws Exception;
	
	void refundAllPoint(long receiptId)throws Exception;
	
	int getMemberPoint(long memberId) throws Exception;
	
	int getEarnedPoint(long memberId) throws Exception;

	int getPurchaseAmount(long memberId) throws Exception;

	int getDiscountAmount(long memberId) throws Exception;
	
	int getEstimatedPoint(long receiptId) throws Exception;
	
	long getReceiptCount(long membeId) throws Exception;
	
	long getAvailableCouponCount(long memberId) throws Exception;

	long getUnavailableCouponCount(long memberId) throws Exception;
	
	long getPointHistoryCount(long memberId) throws Exception;
	
	long getSpecificPointHistoryCount(@Param("memberId") long memberId, @Param("type") String type) throws Exception;
	
	long getPointHistoryCountByPeriod(@Param("memberId") long memberId, @Param("startDate") String startDate, @Param("endDate") String endDate) throws Exception;
	
	long getSpecificPointHistoryCountByPeriod(@Param("memberId") long memberId, @Param("type") String type, @Param("startDate") String startDate, @Param("endDate") String endDate) throws Exception;

	List<PointDTO> getPointHistory(@Param("memberId") long memberId, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;

	List<PointDTO> getSpecificPointHistory(@Param("memberId") long memberId, @Param("type") String type, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;

	List<PointDTO> getPointHistoryByPeriod(@Param("memberId") long memberId, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;

	List<PointDTO> getSpecificPointHistoryByPeriod(@Param("memberId") long memberId, @Param("type") String type, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;
	
	List<CouponDTO> getAvailableCoupon(@Param("memberId") long memberId, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;

	List<CouponDTO> getUnavailableCoupon(@Param("memberId") long memberId, @Param("startNum") long startNum, @Param("endNum") long endNum) throws Exception;
	
	List<DeliveryAddressDTO> getAddressList(long memberid) throws Exception;

	DeliveryAddressDTO getDefaultAddress(long memberid) throws Exception;

	void addAddress(DeliveryAddressDTO dto) throws Exception;

	void updateAddress(DeliveryAddressDTO dto) throws Exception;
	
	void deleteAddress(@Param("memberId") long memberId, @Param("addressId") long addressId) throws Exception;
	
	void setDefault(@Param("memberId") long memberId, @Param("addressId") long addressId) throws Exception;

	void cancelDefault(long memberId) throws Exception;

	String confirmPassword(long memberId) throws Exception;

	void changePassword(@Param("memberId") long memberId, @Param("newPassword") String newPassword) throws Exception;

	void changeInfo(@Param("memberId") long memberId, @Param("profileImage") String profileImage, @Param("nickName") String nickName, @Param("birthDate") String birthDate, @Param("gender") String gender) throws Exception;

	void insertResignMember(@Param("dto") MemberDTO dto, @Param("resignDetail") String resignDetail) throws Exception;

	void disableMember(long memberId) throws Exception;

	List<ReceiptDTO> getReceiptHistoryPages(@Param("memberId") long memberId, @Param("startPages") int startPages) throws Exception;

	OrderPerformanceDTO getOrderPerformance(long memberId) throws Exception;

	List<OrderPerformanceDTO> getOrderPerformanceAll() throws Exception;
	
	List<MemberGradeDTO> getMemberGrade() throws Exception;

	void updateMemberGrade(long memberId, long gradeId) throws Exception;

	
}