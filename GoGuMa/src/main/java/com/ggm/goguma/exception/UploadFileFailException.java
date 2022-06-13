package com.ggm.goguma.exception;

public class UploadFileFailException extends Exception {

	public UploadFileFailException(String message) {
		super(message);
	}
	
	public UploadFileFailException() {
		super("업로드에 실패하였습니다.");
	}
}
