package com.ggm.goguma.constant;

public enum OracleError {
	
	/*오라클 지정 예외, select 시 조회된 데이터가 없을경우 발생*/
	NOT_FOUND_DATA(1403,"데이터를 찾을 수 없습니다."),
	
	/*쿠폰 유효기간이 지났을 경우 발생하는 예외*/
	COUPON_ALREADY_EXPIRE(20000, "쿠폰 유효기간이 지났습니다."),
	
	/*이미 발급 받은 쿠폰을 다시 발급 받을려고 하는 경우 발생하는 예외*/
	MEMBER_ALREADY_GET_COUPON(20001,"이미 해당 쿠폰을 발급 받았습니다.");
	
	private final int code;
	private final String message;
	
	OracleError(int code,String message) {
		this.code = code;
		this.message = message;
	}
	
	public int getCode() {
		return this.code;
	}
	
	public String getMessage() {
		return this.message;
	}
}
