package com.wt.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor1 implements HandlerInterceptor {
	private List<String> excludedUrls;
	      public void setExcludeUrls(List<String> excludeUrls) {
	         this.excludedUrls = excludeUrls;
	      }
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {

		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		System.out.println("进入拦截器");
		String requestUri = request.getRequestURI();
		          for (String url : excludedUrls) {
		             if (requestUri.endsWith(url)) {
		                 return true;
		             }
		         }
		      
	System.out.println("这个是jsp");
return false;
}
}