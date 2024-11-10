package com.taohan.online.exam.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
  *
  * <p>Title: LoginInterceptor</p>
  * <p>Description: 登录拦截器</p>
  * @author: taohan
  * @date: 2018-8-17
  * @time: 下午3:02:43
  * @version: 1.0
  */

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private Logger logger = Logger.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		if (session.getAttribute("loginTeacher") != null) {
			return true;
		} else {
			logger.info("检测到未登录访问后台内容操作");
			//如果没有登录，跳转至登录页面
			response.sendRedirect("admin/login.jsp");
			
			return false;
		}
	}
}
