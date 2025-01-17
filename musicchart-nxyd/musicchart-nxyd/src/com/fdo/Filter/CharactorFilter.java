package com.fdo.Filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * @author Danny
 *
 */
public class CharactorFilter implements Filter {

	@Override
	public void destroy(){}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		//response.setContentType("text/html;charset=utf-8");
		//request.setCharacterEncoding("utf-8");    
		chain.doFilter(request, response);    
	}

	@Override
	public void init(FilterConfig config) throws ServletException {}

}