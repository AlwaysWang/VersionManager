package com.wt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestAction {
@RequestMapping("/hello")
public String sayhello(){
	return "login";
}
}
