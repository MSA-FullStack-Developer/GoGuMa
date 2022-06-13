package com.ggm.goguma.security;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.util.RedirectUrlBuilder;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserLoginFailHandler extends SimpleUrlAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
	
		log.info("[onAuthenticationFailure] exception msg: " + exception.getMessage());
		
	
		String errorMessage = "";
		
		if(exception instanceof BadCredentialsException) {
			errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";
		}  else if(exception instanceof DisabledException) {
			errorMessage = "이미 탈퇴한 회원입니다.";
		}else {
			errorMessage = "죄송합니다. 인증 서버 시스템 오류입니다.";
		}
	
		log.info("[onAuthenticationFailure] errorMessage : " + errorMessage);
		request.setAttribute("error", errorMessage);
		
	
		String encodeResult = URLEncoder.encode(errorMessage, "UTF-8");

		
		getRedirectStrategy().sendRedirect(request, response, "/member/login.do?error="+encodeResult);
	}
	
	

}
