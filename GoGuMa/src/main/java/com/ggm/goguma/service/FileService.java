package com.ggm.goguma.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ggm.goguma.exception.DownloadFileFailException;
import com.ggm.goguma.exception.UploadFileFailException;

public interface FileService {
	
	String[] suppertExts = {"jpg","jpeg","png"};

	/**
	 * 파일 업로드 메서드 
	 *
	 * return
	 * - List<String> : 파일을 업로드 하고, 업로드 된 파일 이름을 리스트에 담아 반환한다.
	 * */
	List<String> uploadFile(MultipartFile[] uploadFiles) throws UploadFileFailException;
	
	
	/**
	 * 파일 읽어오기 메서드
	 * 
	 * parameter
	 *  - fileName : 읽어올 파일 이름
	 *  
	 * return
	 * 	- byte[] : 읽어온 file을 byte로 변환하여 반환
	 * */
	byte[] readFile(String fileName) throws DownloadFileFailException;
	
	default boolean checkImageType(File file) throws IOException {
		String contentType = Files.probeContentType(file.toPath());
		return contentType.startsWith("image");
	}
	
	default boolean validExt(String ext) {
		
		return Arrays.asList(suppertExts).contains(ext);
	}
}
