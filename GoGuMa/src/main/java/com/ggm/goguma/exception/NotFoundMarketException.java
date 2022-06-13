package com.ggm.goguma.exception;

public class NotFoundMarketException extends RuntimeException {

	public NotFoundMarketException() {
		super("해당 마켓을 찾을 수 없습니다.");
	}
}
