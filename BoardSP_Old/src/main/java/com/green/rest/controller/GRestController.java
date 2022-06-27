package com.green.rest.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.pds.service.PdsService;

//  @RestController : ajax 에서 사용될 명령 모은것
//  @Controller + @Responsebody  
@RestController
public class GRestController {

	@Autowired
	private   PdsService   pdsService;
	
	@RequestMapping(value = "/deleteFile",
			method        = RequestMethod.GET,
			headers       = "Accept=application/json" )
	public  void  deleteFile(
		@RequestParam  HashMap<String, Object> map	) {
		
		System.out.println("deleteFile map:" + map);
		
		pdsService.deleteUploadFile( map );
		
	}   
	
}




