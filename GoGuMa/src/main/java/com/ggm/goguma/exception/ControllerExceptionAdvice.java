package com.ggm.goguma.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class ControllerExceptionAdvice {

	
	@ExceptionHandler(NoCertificationException.class)
	public String NoCertificationExceptionHandler(NoCertificationException e, HttpServletRequest request) {
		
		String enterPath = request.getPathInfo();
		log.info("[NoCertificationExceptionHandler] 접근한 경로 " + enterPath);
		
		return "redirect:/member/join/start.do";
	}
	
}