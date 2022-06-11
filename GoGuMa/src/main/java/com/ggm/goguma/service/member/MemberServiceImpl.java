package com.ggm.goguma.service.member;

import java.util.Calendar;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.ggm.goguma.amazons3.AmazonS3Utils;
import com.ggm.goguma.dto.member.CertificationUserDTO;
import com.ggm.goguma.dto.member.CreateMemberDTO;
import com.ggm.goguma.dto.member.IamportCertificateTokenRspDTO;
import com.ggm.goguma.dto.member.IamportReqDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.dto.member.ResignMemberDTO;
import com.ggm.goguma.exception.CreateMemberFailException;
import com.ggm.goguma.exception.NotFoundMemberExcption;
import com.ggm.goguma.mapper.MemberMapper;
import com.ggm.goguma.service.contract.ContractService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	
	private final ContractService contractService;
	
	private final AmazonS3Utils amazonService;
	
	private final BCryptPasswordEncoder passwordEncoder;
	
	@Value("${iamport.restKey}")
	private String iamportRestKey;

	@Value("${iamport.secret}")
	private String iamportSecret;

	@Value("${iamport.baseAPI}")
	private String baseAPIURL;
	
	
	@Override
	public MemberDTO getMember(String name, String phone) throws NotFoundMemberExcption {
		log.info("[getMember] name, phone" + name + " " + phone);
		log.info(memberMapper.findMemberByNameAndPhone(name, phone));
		return this.memberMapper.findMemberByNameAndPhone(name, phone).orElseThrow(NotFoundMemberExcption::new);
	}


	@Override
	public MemberDTO getMember(String email) throws NotFoundMemberExcption {
	
		return this.memberMapper.findMemberByEmail(email).orElseThrow(NotFoundMemberExcption::new);
	}

	@Override
	public MemberDTO getMemberInfoFromIamport(String impUid) {
		// TODO Auto-generated method stub

		/**
		 * 1. 아임포트 API Access Token 발급
		 */
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);

		IamportReqDTO iamportReq = new IamportReqDTO();
		iamportReq.setImp_key(iamportRestKey);
		iamportReq.setImp_secret(iamportSecret);

		log.info("[getMemberInfoFromIamport] iamportReq : "+iamportReq);
		
		String getTokenAPIUrl = this.baseAPIURL + "/users/getToken";

		HttpEntity<IamportReqDTO> entity = new HttpEntity<IamportReqDTO>(iamportReq, httpHeaders);

		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<IamportCertificateTokenRspDTO> result = restTemplate.exchange(getTokenAPIUrl, HttpMethod.POST,
				entity, IamportCertificateTokenRspDTO.class);

		String token = result.getBody().getResponse().getAccess_token();

		log.info("[getMemberInfoFromIamport] access token : " + token);

		/**
		 * 2.User 정보 가져오기
		 */
		String getCertificatinoAPIUrl = baseAPIURL + "/certifications/" + impUid;

		restTemplate = new RestTemplate();

		
		// 받아온 access token 헤더에 추가
		httpHeaders.set("Authorization", token);
		
		HttpEntity request = new HttpEntity(httpHeaders);

		ResponseEntity<CertificationUserDTO> userInfo = restTemplate.exchange(getCertificatinoAPIUrl, HttpMethod.GET,
				request, CertificationUserDTO.class);

		MemberDTO member = new MemberDTO();
		
		/**
		 * 3. Member 정보 파싱하기
		 * */
	
		String name = userInfo.getBody().getResponse().getName();
		member.setName(name);
		
		String phone = userInfo.getBody().getResponse().getPhone();
		member.setPhone(phone);
		
		String birthday = userInfo.getBody().getResponse().getBirthday(); 
		if(birthday != null && !birthday.isEmpty()) {
			int birthYear = Integer.parseInt(birthday.split("-")[0]);
			Calendar current = Calendar.getInstance();
			int currentYear = current.get(Calendar.YEAR);
			
			int age = currentYear - birthYear;
			member.setAge(age);
		}
		
		log.info("[Member 파싱 결과] member : " + member);
				
		return member;
	}




	@Override
	@Transactional(rollbackFor = Exception.class)
	public void createMember(CreateMemberDTO data) throws CreateMemberFailException {

		try {
			MemberDTO member = MemberDTO.builder()
					.email(data.getEmail())
					.password(this.passwordEncoder.encode(data.getPassword()))
					.name(data.getName())
					.phone(data.getPhone())
					.age(data.getAge())
					.nickName(data.getNickName())
					.birthDate(data.getBirthDate())
					.gender(data.getGender())
					.build();
			
			if(!data.getProfile().isEmpty()) {
				String[] result = this.amazonService.uploadFile("profile", data.getProfile());
				
				String profileImageURL = result[1];
				
				member.setProfileImage(profileImageURL);
			} else {
				member.setProfileImage("https://hd-goguma.s3.ap-northeast-2.amazonaws.com/profile/1654741131039default.png");
			}
		

			this.memberMapper.createMember(member);
			
			log.info("[createMember] created Member : " + member);
			
			for(int contractId: data.getAgreements()) {
				this.contractService.createContractHistory(member.getId(), contractId);
			}
			
		}catch(Exception e) {
			log.error(e.getMessage());
			throw new CreateMemberFailException("계정 생성 실패하였습니다.");
		}
		
	}


	@Override
	public void updateMemberPassword(MemberDTO member) {
		
		member.setPassword(this.passwordEncoder.encode(member.getPassword()));
		
		this.memberMapper.updateMemberPwd(member);
	}


	@Override
	public ResignMemberDTO getResignMember(MemberDTO member) throws Exception {
		return this.memberMapper.findResignMember(member.getId()).orElseThrow(() -> new Exception("탈퇴된 회원 조회 실패"));
	}
	
	

}
