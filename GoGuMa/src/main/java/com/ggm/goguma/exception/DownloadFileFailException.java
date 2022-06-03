package com.ggm.goguma.exception;

public class DownloadFileFailException extends Exception {

	public DownloadFileFailException(String message) {
		super(message);
	}
	
	public DownloadFileFailException() {
		super("다운로드에 실패하였습니다.");
	}
}
