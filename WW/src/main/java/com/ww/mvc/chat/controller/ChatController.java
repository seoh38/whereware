package com.ww.mvc.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ChatController {
	
	@GetMapping("/chat")
	public String chat() {
		
		return "chat/chat";
	}
	
}