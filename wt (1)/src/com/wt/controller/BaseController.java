package com.wt.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class BaseController {
	protected void outputString(HttpServletResponse response, String content){
		response.setContentType("text/html;charset=utf-8");
		try{
			
			PrintWriter out = response.getWriter();
			out.println(content);
			out.flush();
			out.close();
		}catch(Exception ex){
			
		}
		
	}
	public static void main(String[] args) {
		
	}

}
