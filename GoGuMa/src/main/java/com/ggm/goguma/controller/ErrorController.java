package com.ggm.goguma.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
@RequestMapping("/error")
public class ErrorController {

	@GetMapping("/error404")
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public String errorNotFoundPage() {
		
		return "error/error404";
	}
	
	
//	@GetMapping("/error500")
//	@ResponseStatus(code = HttpStatus)
//	public String errorAccessDenied() {
//		
//		return "error/error403";
//	}
}
