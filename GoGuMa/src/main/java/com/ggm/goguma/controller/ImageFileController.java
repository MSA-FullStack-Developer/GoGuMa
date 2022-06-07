package com.ggm.goguma.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggm.goguma.dto.FileDTO;
import com.ggm.goguma.exception.DownloadFileFailException;
import com.ggm.goguma.service.FileService;

@Controller
@RequestMapping("/image")
public class ImageFileController {
	
	@Autowired
	@Qualifier("DefaultFileSerivce")
	private FileService fileService;

	@GetMapping("/{imageName}.{ext}")
	@ResponseBody
	public ResponseEntity<byte[]> getImage(@PathVariable String imageName,@PathVariable String ext) throws DownloadFileFailException{
	
		String target = imageName + "." + ext;
		FileDTO file = this.fileService.readFile(target);
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", file.getContentType());
		
		ResponseEntity<byte[]> result = new ResponseEntity<byte[]>(file.getStream(), header, HttpStatus.OK);
		
		return result;
	}
}
