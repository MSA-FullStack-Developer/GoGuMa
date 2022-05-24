package com.ggm.goguma.security;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	private final MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("[loadUserByUsername] email : " + username);
		MemberDTO member = this.memberMapper
				.findMemberByEmail(username).orElseThrow(() -> new UsernameNotFoundException(username));
		
		log.info("[loadUserByUsername] loadMember : " + member);
		return User.builder()
				.username(member.getEmail())
				.password(member.getPassword())
				.roles(member.getRole().toString())
				.build();
	}
	
	
}
