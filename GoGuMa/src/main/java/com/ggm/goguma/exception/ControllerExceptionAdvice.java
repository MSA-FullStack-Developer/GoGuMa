package com.ggm.goguma.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.ggm.goguma.dto.DefaultResponseDTO;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class ControllerExceptionAdvice {

	@ExceptionHandler(MethodArgumentNotValidException.class)
	public void methodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e, HttpServletRequest request) {
		log.info(e.getMessage());
		
		log.info(request.getPathInfo());
	}
	
	@ExceptionHandler(NoCertificationException.class)
	public String noCertificationExceptionHandler(NoCertificationException e, HttpServletRequest request) {
		
		String enterPath = request.getPathInfo();
		log.info("[NoCertificationExceptionHandler] 접근한 경로 " + enterPath);
		
		return "redirect:/member/join/start.do";
	}
	
	
	@ExceptionHandler(NotFoundMemberExcption.class)
	public String notFoundMemberExcptionHandler(NotFoundMemberExcption e, HttpServletRequest request) {
		
		
		log.info("[NotFoundMemberExcptionHandler] 찾을 수 없는 멤버");
		
		log.info(request.getPathInfo());
		return "redirect:/member/login.do";
	}
	
	@ExceptionHandler({NotFoundMarketArticleException.class, NotFoundMarketException.class})
	public String notFoundMarketOrArticleExceptionHandler(RuntimeException e) {
		log.error("[NotFoundMarketOrArticleExceptionHandler] error : "+ e.getMessage());
		
		return "error/error404";
	}
	
	@ExceptionHandler({NotFoundReplyException.class, NotAllowedManageReplyException.class})
	public ResponseEntity<DefaultResponseDTO> replyExceptionHandler(Exception e) {
		ResponseEntity<DefaultResponseDTO> entity = null;
		if(e instanceof NotFoundReplyException) {
			DefaultResponseDTO res = DefaultResponseDTO.builder().status(HttpStatus.NOT_FOUND.value()).message(e.getMessage()).build();
			entity = new ResponseEntity<>(res, HttpStatus.NOT_FOUND);
		}
		
		if(e instanceof NotAllowedManageReplyException) {
			DefaultResponseDTO res = DefaultResponseDTO.builder().status(HttpStatus.FORBIDDEN.value()).message(e.getMessage()).build();
			entity = new ResponseEntity<>(res, HttpStatus.FORBIDDEN);
		}
		
		return entity;
	}
	
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String noHandlerFoundExceptionHandler(NoHandlerFoundException e) {
		log.error(e.getMessage());
		return "error/error404";
	}
	
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		log.error(e.getMessage());
		
		
		return "error/error500";
	}
}
