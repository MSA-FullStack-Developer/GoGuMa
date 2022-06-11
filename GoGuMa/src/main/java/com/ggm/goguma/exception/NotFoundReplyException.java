package com.ggm.goguma.exception;

public class NotFoundReplyException extends RuntimeException {
	
	public NotFoundReplyException() {
		super("해당 댓글을 찾을 수 없습니다.");
	}
	
	public NotFoundReplyException(String message) {
		super(message);
	}

}
