package com.ggm.goguma.exception;

public class NotFoundMarketArticleException extends RuntimeException{
	
	public NotFoundMarketArticleException() {
		super("해당 게시글을 찾을 수 없습니다.");
	}

}
