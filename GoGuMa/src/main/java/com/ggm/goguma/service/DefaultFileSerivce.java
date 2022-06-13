package com.ggm.goguma.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ggm.goguma.dto.FileDTO;
import com.ggm.goguma.exception.DownloadFileFailException;
import com.ggm.goguma.exception.UploadFileFailException;

import lombok.extern.log4j.Log4j;

@Service("DefaultFileSerivce")
@Log4j
public class DefaultFileSerivce implements FileService {

	private final String uploadPath = "/Users/tmdwns/Documents/file_repo/goguma";

	@Override
	public List<String> uploadFile(MultipartFile[] uploadFiles) throws UploadFileFailException {

		List<String> uploadedFileNames = new ArrayList<>();

		for (MultipartFile multipartFile : uploadFiles) {

			log.info("[uploadFile] file original Name : " + multipartFile.getOriginalFilename());

			String fileOrgName = multipartFile.getOriginalFilename();

			// 파일 확장자 명 추출
			String ext = FilenameUtils.getExtension(fileOrgName);

			// 파일 확장자 명 검사
			if (!this.validExt(ext)) {
				throw new UploadFileFailException("파일 확장자명이 올바르지 않습니다.(jpg,jpeg,png) / 현재 파일 확장자명 : " + ext);
			}

			String imageName = UUID.randomUUID().toString() + "." + ext;

			File saveFile = new File(this.uploadPath, imageName);

			try {
				if (checkImageType(saveFile)) {
					multipartFile.transferTo(saveFile);
					uploadedFileNames.add(imageName);
				}
			} catch (IOException e) {
				throw new UploadFileFailException(e.getMessage());
			}

		}

		return uploadedFileNames;
	}

	@Override
	public FileDTO readFile(String fileName) throws DownloadFileFailException {

		try {
			File file = new File(this.uploadPath, fileName);
			FileDTO fileDTO = new FileDTO();
			fileDTO.setContentType(Files.probeContentType(file.toPath()));
			fileDTO.setStream(FileCopyUtils.copyToByteArray(file));
			return fileDTO;
		} catch (IOException e) {
			log.error("[readFile] IOException 발생");

			throw new DownloadFileFailException(e.getMessage());
		} catch (Exception e) {
			log.error("[readFile] Exception 발생");

			throw new DownloadFileFailException(e.getMessage());
		}
	}

}
