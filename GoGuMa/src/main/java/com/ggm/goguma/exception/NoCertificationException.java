package com.ggm.goguma.exception;


/**
 * 본인 인증이 진행 되지 않은 사용자일 경우 발생하는 예외
 * */
public class NoCertificationException extends RuntimeException {
	
	public NoCertificationException() {
		super();
	}
}
