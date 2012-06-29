/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.liferay.portal.security.auth;

import gnomon.business.GeneralUtils;
import gnomon.hibernate.PartiesService;
import gnomon.hibernate.model.parties.PaPerson;

import java.util.Calendar;
import java.util.Locale;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.portlet.epsos.gateway.InitUserObj;
import com.ext.portlet.epsos.sso.SSOUser;
import com.liferay.portal.NoSuchUserException;
import com.liferay.portal.action.LoginAction;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.User;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.util.OpenIdUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.util.PwdGenerator;
import com.liferay.util.servlet.SessionErrors;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opensaml.saml2.core.Assertion;

/**
 * <a href="OpenIdAutoLogin.java.html"><b><i>View Source</i></b></a>
 *
 * @author Jorge Ferrer
 *
 */
public class LombardyAutoLogin implements AutoLogin {

	public String[] login(HttpServletRequest req, HttpServletResponse res)
		throws AutoLoginException {
		String[] credentials = null;
		User user = null;
		SSOUser ssoUser =  (SSOUser) ((HttpServletRequest) req).getSession().getAttribute("KEY");
		if (Validator.isNotNull(ssoUser))
		{
		ssoUser.setLanguage("it");			
		Locale locale = getLocaleFromLang(ssoUser.getLanguage());
		
		HttpServletRequest httpReq = (HttpServletRequest)req;
		HttpServletResponse httpRes = (HttpServletResponse)res;
		HttpSession ses = httpReq.getSession();
		
		// check to see if sso user is already login
		String jUserName = (String)ses.getAttribute("j_username");
		//	if (false)
		if (Validator.isNull(jUserName))
				{
				long companyId = 95945;
				Company company=null;
				try {
					company = CompanyLocalServiceUtil.getCompanyById(companyId);
					} catch (Exception e1) {
						SessionErrors.add(httpReq, "Can't login with SSO");
					}	
				try {
						user = UserLocalServiceUtil.getUserByScreenName(companyId, ssoUser.getLogin());
						_log.info(">> SSO : User " + ssoUser.getLogin() + " Exists");
					}
				catch (NoSuchUserException nsue) {
						if (Validator.isNotNull(ssoUser.getFirstName()) && Validator.isNotNull(ssoUser.getLastName()) && Validator.isNotNull(ssoUser.getEmailAddress())) 
						{
						try {
							_log.info(" >> Gi9 SSO : Try to create user " + ssoUser.getLogin());
							user = addUser(companyId, ssoUser.getFirstName(), ssoUser.getLastName(), ssoUser.getEmailAddress(),ssoUser.getLogin(), locale);
							user.setActive(true);
							if (Validator.isNotNull(user))
									{
									PartiesService partiesServ = PartiesService.getInstance();
									PaPerson person = partiesServ.getPaPerson(user.getUserId());
									if (ssoUser.getRole().equals("medical doctors"))
											PartiesService.getInstance().addRoleToParty(person.getMainid()+"", LoginAction.PHYSICIAN.getMainid()+"");
									if (ssoUser.getRole().equals("Pharmacists"))
											PartiesService.getInstance().addRoleToParty(person.getMainid()+"", LoginAction.PHYSICIAN.getMainid()+"");
									if (ssoUser.getRole().equals("Nursing professionals"))
										PartiesService.getInstance().addRoleToParty(person.getMainid()+"", LoginAction.NURSE.getMainid()+"");
									}
							}
						catch (Exception e) 
							{
							e.printStackTrace();
							}
						}
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			if (Validator.isNotNull(user))
			{
			try
			{
			_log.info(">> Gi9 SSO : Do the login for " + ssoUser.getLogin() );
			boolean loginViaPortal=true;
	
			// login to epsos
			String language = GeneralUtils.getLocale(req);
			SpiritEhrWsClientInterface webService = EpsosHelperService.getInstance().getWebService(req);

			InitUserObj initUserObj = EpsosHelperImpl.createEpsosUserInformation(language, webService, user.getUserId(),company.getCompanyId(), user.getLogin(), loginViaPortal);
	        SpiritUserClientDto usr = initUserObj.getUsr();
	        Assertion assertion = initUserObj.getAssertion();
	        //SpiritUserClientDto usr = iniLoginAction.createEpsosUserInformation(httpReq, user.getUserId(), company.getCompanyId(), user.getLogin(), loginViaPortal);
			boolean epsosLogin = Validator.isNotNull(usr);
			if (epsosLogin) 	
				{
//				LoginAction.setLoginCookies(httpReq,httpRes,ses,user.getUserId(),false);
				httpReq.getSession().setAttribute(LoginAction.EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr);
				req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTIONID, assertion.getID());
		        req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTION, assertion);	        
				_log.info(">> Gi9 SSO : Portal cookies set");
				}
			
			_log.info(">> Gi9 SSO : InitUser -- Login to NCP for " + ssoUser.getLogin());
			if (!epsosLogin && (!(user.getLogin().equals("root")))) 
				{
				SessionErrors.add(httpReq, "Can't login with SSO");
				}
			}
			catch (Exception e)
			{
			SessionErrors.add(httpReq, "Can't login with SSO");
			e.printStackTrace();
			}
			}
			else
			{
				SessionErrors.add(httpReq, "Can't login with SSO");
			}

				
				
	}
		}
		credentials = new String[3];
		if (Validator.isNotNull(user))
		{
		credentials[0] = String.valueOf(user.getUserId());
		credentials[1] = user.getPassword();
		credentials[2] = Boolean.TRUE.toString();
		}
		return credentials;
	}

	private Locale getLocaleFromLang(String lang)
	{
		Locale locale = new Locale("en","US");
		if (lang.equals("it")) locale = new Locale("it","IT");
		return locale;
	}
	
	protected User addUser(
			long companyId, String firstName, String lastName,
			String emailAddress, String screenName, Locale locale)
		throws Exception {

		long creatorUserId = 0;
		boolean autoPassword = false;
		String password1 = PwdGenerator.getPassword();
		String password2 = password1;
		boolean autoScreenName = false;
		String middleName = StringPool.BLANK;
		int prefixId = 0;
		int suffixId = 0;
		boolean male = true;
		int birthdayMonth = Calendar.JANUARY;
		int birthdayDay = 1;
		int birthdayYear = 1970;
		String jobTitle = StringPool.BLANK;
		long organizationId = 0;
		long locationId = 0;
		boolean sendEmail = false;

		return UserLocalServiceUtil.addUser(
			creatorUserId, companyId, autoPassword, password1, password2,
			autoScreenName, screenName, emailAddress, locale, firstName,
			middleName, lastName, prefixId, suffixId, male, birthdayMonth,
			birthdayDay, birthdayYear, jobTitle, organizationId, locationId,
			sendEmail);
	}
	
	private static Log _log = LogFactory.getLog(OpenIdAutoLogin.class);

}