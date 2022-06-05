package com.ggm.goguma.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class ControllerExceptionAdvice {

	@ExceptionHandler(MethodArgumentNotValidException.class)
	public void MethodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e, HttpServletRequest request) {
		log.info(e.getMessage());
		
		log.info(request.getPathInfo());
	}
	
	@ExceptionHandler(NoCertificationException.class)
	public String NoCertificationExceptionHandler(NoCertificationException e, HttpServletRequest request) {
		
		String enterPath = request.getPathInfo();
		log.info("[NoCertificationExceptionHandler] 접근한 경로 " + enterPath);
		
		return "redirect:/member/join/start.do";
	}
	
	
	@ExceptionHandler(NotFoundMemberExcption.class)
	public String NotFoundMemberExcptionHandler(NotFoundMemberExcption e, HttpServletRequest request) {
		
		
		log.info("[NotFoundMemberExcptionHandler] 찾을 수 없는 멤버");
		
		log.info(request.getPathInfo());
		return "redirect:/member/login.do";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String NoHandlerFoundExceptionHandler(NoHandlerFoundException e) {
		log.error(e.getMessage());
		return "error/error404";
	}
	
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String ExceptionHandler(Exception e) {
		log.error(e.getMessage());
		
		return "error/error500";
	}
}
