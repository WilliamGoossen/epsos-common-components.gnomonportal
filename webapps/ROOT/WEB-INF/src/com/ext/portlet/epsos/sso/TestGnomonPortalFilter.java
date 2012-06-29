package com.ext.portlet.epsos.sso;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.liferay.portal.kernel.util.Validator;

/**
* Filter configuration (in web.xml)
* <filter>
*     <filter-name>TestGnomonPortalFilter</filter-name>
*     <filter-class>com.ext.portlet.epsos.sso.TestGnomonPortalFilter</filter-class>
* </filter>
* 
* <filter-mapping>
*     <filter-name>TestGnomonPortalFilter</filter-name>
*     <url-pattern>*</url-pattern>
* </filter-mapping>
*
*/

public class TestGnomonPortalFilter implements Filter { 

	@Override
	public void destroy() {
		// TODO Auto-generated method stub		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
	      SSOUser lombardyUser = new SSOUser();
	       
	      if (Validator.isNull(((HttpServletRequest) request).getSession().getAttribute("KEY")))
	    		{
	    	  	//Setting the Gnomon Java Bean
	    	 
	          	lombardyUser.setFirstName("Kostas");
	          	lombardyUser.setLastName("Karkaletsis");
	          	lombardyUser.setOrganisationName("AO Desenzano");
	          	lombardyUser.setRole("medical doctors");
	          	lombardyUser.setLogin("kk12345");
	          	lombardyUser.setEmailAddress(lombardyUser.getLogin() + "@lombardy.it");
	          	//KEY has to be the key String used to retrieve the object from the session
	          	((HttpServletRequest) request).getSession().setAttribute("KEY", lombardyUser);
	    		 }
	  		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	
	
}
