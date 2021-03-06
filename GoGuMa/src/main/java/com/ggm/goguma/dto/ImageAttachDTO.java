package com.ggm.goguma.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class ImageAttachDTO implements Serializable {
	private long imageUUID; // imageID
	private long reviewID;
	private String imageName;
	private String imagePath;
}