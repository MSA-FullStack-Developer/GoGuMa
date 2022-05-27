package com.ggm.goguma.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.google.gson.Gson;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		

		log.info("[CustomAuthenticationEntryPoint] not Authentication!!");
		Map<String, String> result = new HashMap<>();
		result.put("code", HttpStatus.UNAUTHORIZED.toString());
		result.put("message", "인증 되지 않은 사용자입니다.");
		
		String json = new Gson().toJson(result);
	
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		response.getWriter().write(json);
	
		
	}

	
}
