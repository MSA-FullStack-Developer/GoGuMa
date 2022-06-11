package com.ggm.goguma.exception;

public class NotAllowedManageReplyException extends RuntimeException {

	
	public NotAllowedManageReplyException(String message) {
		super(message);
	}
	
	public NotAllowedManageReplyException() {
		super("해당 댓글에 대해 권한이 없습니다.");
	}
}
