package com.ggm.goguma.exception;

import com.ggm.goguma.constant.OracleError;

public class CouponCreateException extends Exception {

	public CouponCreateException(OracleError error) {
		super(error.getMessage());
	}
}
