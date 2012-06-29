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

package com.liferay.portal.action;

import static org.junit.Assert.fail;
import epsos.ccd.gnomon.configmanager.ConfigurationManagerService;
import epsos.ccd.netsmart.securitymanager.XMLUtils;
import epsos.ccd.netsmart.securitymanager.sts.client.TRCAssertionRequest;
import gnomon.business.GeneralUtils;
import gnomon.business.SecurityUtils;
import gnomon.business.StringEncrypter;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.OrganizationChartService;
import gnomon.hibernate.PartiesService;
import gnomon.hibernate.model.gn.GnUserTracking;
import gnomon.hibernate.model.parties.PaOrganization;
import gnomon.hibernate.model.parties.PaParty;
import gnomon.hibernate.model.parties.PaPerson;
import gnomon.hibernate.model.parties.PaRegisteredIdentifier;
import gnomon.hibernate.model.parties.PsPartyRoleType;
import gnomon.hibernate.model.views.ViewResult;
import gnomon.util.GnPropsUtil;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.logging.Level;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.portlet.PortletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.opensaml.Configuration;
import org.opensaml.DefaultBootstrap;
import org.opensaml.saml2.core.Assertion;
import org.opensaml.saml2.core.impl.AssertionMarshaller;
import org.opensaml.xml.io.Unmarshaller;
import org.opensaml.xml.io.UnmarshallerFactory;
import org.opensaml.xml.io.UnmarshallingException;
import org.opensaml.xml.parse.BasicParserPool;
import org.opensaml.xml.parse.XMLParserException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.ext.portlet.dms.util.AlfrescoContentUtil;
import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.portlet.epsos.gateway.InitUserObj;
import com.ext.portlet.parties.events.EventsService;
import com.ext.portlet.parties.lucene.Gi9PartiesLuceneIndexer;
import com.ext.util.CommonUtil;
import com.liferay.portal.CookieNotSupportedException;
import com.liferay.portal.NoSuchUserException;
import com.liferay.portal.PasswordExpiredException;
import com.liferay.portal.PortalException;
import com.liferay.portal.SendPasswordException;
import com.liferay.portal.SystemException;
import com.liferay.portal.UserEmailAddressException;
import com.liferay.portal.UserIdException;
import com.liferay.portal.UserLockoutException;
import com.liferay.portal.UserPasswordException;
import com.liferay.portal.UserScreenNameException;
import com.liferay.portal.events.EventsProcessor;
import com.liferay.portal.events.InitAction;
import com.liferay.portal.kernel.servlet.HttpHeaders;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.User;
import com.liferay.portal.model.impl.CompanyImpl;
import com.liferay.portal.security.auth.AuthException;
import com.liferay.portal.security.auth.Authenticator;
import com.liferay.portal.security.ldap.PortalLDAPUtil;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.struts.ActionConstants;
import com.liferay.portal.struts.LastPath;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.CookieKeys;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.PrefsPropsUtil;
import com.liferay.portal.util.PropsUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.util.CookieUtil;
import com.liferay.util.Encryptor;
import com.liferay.util.EncryptorException;
import com.liferay.util.XSSUtil;
import com.liferay.util.ldap.LDAPUtil;
import com.liferay.util.servlet.SessionErrors;
import com.liferay.util.servlet.SessionMessages;
import com.liferay.util.servlet.SessionParameters;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

/**
 * <a href="LoginAction.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 * @author Scott Lee
 *
 */
public class LoginAction extends Action {

	public final static PsPartyRoleType PHARMACIST = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "pharmacist");
	public final static PsPartyRoleType PHYSICIAN = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "physician");
	public final static PsPartyRoleType NURSE = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "nurse");
	public final static PsPartyRoleType ADMINISTRATOR = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "administrator");
	public final static String EPSOS_LOGIN_INFORMATION_ATTRIBUTE = "com.ext.portlet.epsos.LOGIN_INFORMATION";
	public final static String EPSOS_WEBSERVICE_ATTRIBUTE = "com.ext.portlet.epsos.WEB_SERVICE";
	
	public static String getLogin(
			HttpServletRequest req, String paramName, Company company)
	throws PortalException, SystemException {

		String login = req.getParameter(paramName);

		if ((login == null) || (login.equals(StringPool.NULL))) {
			login = GetterUtil.getString(
					CookieUtil.get(req.getCookies(), CookieKeys.LOGIN));

			if (Validator.isNull(login) &&
					company.getAuthType().equals(CompanyImpl.AUTH_TYPE_EA)) {

				login = "@" + company.getMx();
			}
		}

		login = XSSUtil.strip(login);

		return login;
	}

	public static String EncryptPassword(String password)
	{
		String encryptedString="";
		String encryptionScheme = "DES";
		String encryptionKey = "123456789012345678901234567890";
		try	{

			StringEncrypter encrypter = new StringEncrypter(encryptionScheme,encryptionKey );
			encryptedString = encrypter.encrypt(password);
			return encryptedString;

		} catch (Exception e) {

			return encryptedString;
		}
	}

	//GNOMON Gi9
	public static void addSessionAttributes(HttpSession ses, HashMap map) {
		if (map==null) return;
		Set keys = map.keySet();
		if (keys==null) return;

		Iterator iter = keys.iterator();
		while (iter.hasNext()) {
			String name = (String)iter.next();
			ses.setAttribute(name, map.get(name));
		}
	}

	//GNOMON Gi9
	public static HashMap getUserCarryAttributes(HttpSession ses) {

		HashMap result = new HashMap();

		Enumeration enu = ses.getAttributeNames();

		while (enu.hasMoreElements()) {
			String name = (String)enu.nextElement();

			if (name.startsWith("USER_CARRY")) {

				result.put(name, ses.getAttribute(name));

			}
		}

		return result;
	}

	public static void login(
			HttpServletRequest req, HttpServletResponse res, String login,
			String password, boolean rememberMe)
	throws Exception {

		CookieKeys.validateSupportCookie(req);

		HttpSession ses = req.getSession();

		long userId = GetterUtil.getLong(login);

		int authResult = Authenticator.FAILURE;

		Company company = PortalUtil.getCompany(req);

		//
		boolean ldaplogin = false;
		if (PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.LDAP_AUTH_ENABLED).equals("true"))
		{
			LdapContext ctx = PortalLDAPUtil.getContext(company.getCompanyId());
			String accountname="";
			try {
				User user1 = UserLocalServiceUtil.getUserByScreenName(company.getCompanyId(), login);
				Properties env = new Properties();

				String baseProviderURL = PrefsPropsUtil.getString(
						company.getCompanyId(), PropsUtil.LDAP_BASE_PROVIDER_URL);
				String userDN = PrefsPropsUtil.getString(
						company.getCompanyId(), PropsUtil.LDAP_USERS_DN);
				String baseDN = PrefsPropsUtil.getString(
						company.getCompanyId(), PropsUtil.LDAP_BASE_DN);
				String filter = PrefsPropsUtil.getString(
						company.getCompanyId(), PropsUtil.LDAP_AUTH_SEARCH_FILTER);
				filter = StringUtil.replace(
						filter,
						new String[] {
								"@company_id@", "@email_address@", "@screen_name@", "@user_id@"
						},
						new String[] {
								String.valueOf(company.getCompanyId()), "", login,
								login
						});
				try {
					SearchControls cons = new SearchControls(
							SearchControls.SUBTREE_SCOPE, 1, 0, null, false, false);

					NamingEnumeration enu = ctx.search(userDN, filter, cons);
					if (enu.hasMoreElements()) {
						SearchResult result = (SearchResult)enu.nextElement();
						accountname=result.getName();
					}
				}
				catch (Exception e1) {
					e1.printStackTrace();
				}	

				env.put(
						Context.INITIAL_CONTEXT_FACTORY,
						PrefsPropsUtil.getString(PropsUtil.LDAP_FACTORY_INITIAL));
				env.put(
						Context.PROVIDER_URL,
						LDAPUtil.getFullProviderURL(baseProviderURL, baseDN));
				env.put(Context.SECURITY_PRINCIPAL, accountname + "," + userDN);
				env.put(Context.SECURITY_CREDENTIALS, password);

				new InitialLdapContext(env, null);
				ldaplogin=true;
				System.out.println("LDAP Login");
			}
			catch (Exception e) {
				SessionErrors.add(req, "ldapAuthentication");
				e.printStackTrace();
				System.out.println("LDAP error login");
				return;
			}
		}

		//


		Map headerMap = new HashMap();

		Enumeration enu1 = req.getHeaderNames();

		while (enu1.hasMoreElements()) {
			String name = (String)enu1.nextElement();

			Enumeration enu2 = req.getHeaders(name);

			List headers = new ArrayList();

			while (enu2.hasMoreElements()) {
				String value = (String)enu2.nextElement();

				headers.add(value);
			}

			headerMap.put(name, (String[])headers.toArray(new String[0]));
		}

		Map parameterMap = req.getParameterMap();

		if (company.getAuthType().equals(CompanyImpl.AUTH_TYPE_EA)) {
			authResult = UserLocalServiceUtil.authenticateByEmailAddress(
					company.getCompanyId(), login, password, headerMap,
					parameterMap);

			userId = UserLocalServiceUtil.getUserIdByEmailAddress(
					company.getCompanyId(), login);
		}
		else if (company.getAuthType().equals(CompanyImpl.AUTH_TYPE_SN)) {
			authResult = UserLocalServiceUtil.authenticateByScreenName(
					company.getCompanyId(), login, password, headerMap,
					parameterMap);

			userId = UserLocalServiceUtil.getUserIdByScreenName(
					company.getCompanyId(), login);
		}
		else if (company.getAuthType().equals(CompanyImpl.AUTH_TYPE_ID)) {
			authResult = UserLocalServiceUtil.authenticateByUserId(
					company.getCompanyId(), userId, password, headerMap,
					parameterMap);
		}

		boolean OTPAuth = false;


		if (GetterUtil.getBoolean(PropsUtil.get("use.yubicoauthentication"),false)==true) 
		{
			String otppasswd=ParamUtil.getString(req, "otp");
			String userslist = GetterUtil.getString(PropsUtil.get("yubico.users.not.require.otp"),"root");
			if (userslist.contains(login))
			{
				authResult = Authenticator.SUCCESS;
			}
			else
			{
				OTPAuth = SecurityUtils.verifyOTP(otppasswd,login);
				if (authResult==Authenticator.SUCCESS && OTPAuth)
				{
					authResult = Authenticator.SUCCESS;
				}
				else
				{
					authResult = Authenticator.FAILURE;
				}
			}
		}

		if (PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.LDAP_AUTH_ENABLED).equals("true"))
		{
			if (!login.equals("root"))
			{
				if (ldaplogin) {authResult=Authenticator.SUCCESS;}
			}
		}

		if (authResult == Authenticator.SUCCESS) {
			
			boolean loginViaPortal=true;

			setLoginCookies(req,res,ses,userId,rememberMe);
			// login to epsos
			String language = GeneralUtils.getLocale(req);
			SpiritEhrWsClientInterface webService = EpsosHelperService.getInstance().getWebService(req);

			InitUserObj initUserObj = EpsosHelperImpl.createEpsosUserInformation(req,res,language, webService, userId,  company.getCompanyId(), login, loginViaPortal);
	        SpiritUserClientDto usr = initUserObj.getUsr();
	        Assertion assertion = initUserObj.getAssertion();
	        
	        if (Validator.isNotNull(usr))
		        {
				req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTIONID, assertion.getID());
		        req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTION, assertion);	        
				req.getSession().setAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr);
		        }
	        else
		        {
	        	SessionErrors.add(req, "User doesn't belong to epSOS role so you can't login");	
		        }
	        
			if (Validator.isNull(usr) && (!(login.equals("root")))) 
				{
				try {
					Cookie cookie = new Cookie(CookieKeys.ID, StringPool.BLANK);
					cookie.setMaxAge(0);
					cookie.setPath("/");

					CookieKeys.addCookie(res, cookie);

					cookie = new Cookie(CookieKeys.PASSWORD, StringPool.BLANK);
					cookie.setMaxAge(0);
					cookie.setPath("/");

					CookieKeys.addCookie(res, cookie);

					try {
						ses.invalidate();
					}
					catch (Exception e) {
					}
					
					}
					catch (Exception e) {
						req.setAttribute(PageContext.EXCEPTION, e);

					}
				throw new AuthException();
				
				}
			
		}
		else {
			throw new AuthException();
		}
	}

	
	public static void setLoginCookies(HttpServletRequest req, HttpServletResponse res, HttpSession ses, long userId, boolean rememberMe) throws PortalException, SystemException, EncryptorException
	{
		if (GetterUtil.getBoolean(PropsUtil.get(
				PropsUtil.SESSION_ENABLE_PHISHING_PROTECTION))) {

			// Invalidate the previous session to prevent phishing

			LastPath lastPath = (LastPath)ses.getAttribute(
					WebKeys.LAST_PATH);

			// GNOMON Gi9: KEEP ANY USER_CARRY ATTRIBUTES (for example shopping cart)
			HashMap userCarryAttributes = getUserCarryAttributes(ses);

			try
			{
			ses.invalidate();
			}
			catch (Exception e)
			{
				_log.info("Session has already invalidated");
			}

			ses = req.getSession(true);

			addSessionAttributes(ses, userCarryAttributes);

			if (lastPath != null) {
				ses.setAttribute(WebKeys.LAST_PATH, lastPath);
			}
		}

		// Set cookies

		String domain = PropsUtil.get(PropsUtil.SESSION_COOKIE_DOMAIN);

		User user = UserLocalServiceUtil.getUserById(userId);
		Company company = CompanyLocalServiceUtil.getCompanyById(user.getCompanyId());
		String userIdString = String.valueOf(userId);

		ses.setAttribute("j_username", userIdString);
		ses.setAttribute("j_password", user.getPassword());
		ses.setAttribute("j_remoteuser", userIdString);

		ses.setAttribute(WebKeys.USER_PASSWORD, user.getPassword());

		Cookie idCookie = new Cookie(
				CookieKeys.ID,
				UserLocalServiceUtil.encryptUserId(userIdString));

		if (Validator.isNotNull(domain)) {
			idCookie.setDomain(domain);
		}

		idCookie.setPath(StringPool.SLASH);

		Cookie passwordCookie = new Cookie(
				CookieKeys.PASSWORD,
				Encryptor.encrypt(company.getKeyObj(), user.getPassword()));

		if (Validator.isNotNull(domain)) {
			passwordCookie.setDomain(domain);
		}

		passwordCookie.setPath(StringPool.SLASH);

		int loginMaxAge = GetterUtil.getInteger(
				PropsUtil.get(PropsUtil.COMPANY_SECURITY_AUTO_LOGIN_MAX_AGE),
				CookieKeys.MAX_AGE);

		if (GetterUtil.getBoolean(
				PropsUtil.get(PropsUtil.SESSION_DISABLED))) {

			rememberMe = true;
		}

		if (rememberMe) {
			idCookie.setMaxAge(loginMaxAge);
			passwordCookie.setMaxAge(loginMaxAge);
		}
		else {
			idCookie.setMaxAge(0);
			passwordCookie.setMaxAge(0);
		}

		Cookie loginCookie = new Cookie(CookieKeys.LOGIN, user.getLogin());

		if (Validator.isNotNull(domain)) {
			loginCookie.setDomain(domain);
		}

		loginCookie.setPath(StringPool.SLASH);
		loginCookie.setMaxAge(loginMaxAge);

		Cookie screenNameCookie = new Cookie(
				CookieKeys.SCREEN_NAME,
				Encryptor.encrypt(company.getKeyObj(), user.getScreenName()));

		if (Validator.isNotNull(domain)) {
			screenNameCookie.setDomain(domain);
		}

		screenNameCookie.setPath(StringPool.SLASH);
		screenNameCookie.setMaxAge(loginMaxAge);

		CookieKeys.addCookie(res, idCookie);
		CookieKeys.addCookie(res, passwordCookie);
		CookieKeys.addCookie(res, loginCookie);
		CookieKeys.addCookie(res, screenNameCookie);
		
		//add entry to user tracking if needed
		boolean trackUser = GetterUtil.getBoolean(PropsUtil.get(user.getCompanyId(), "gn.user.tracking.enabled"), false);
		if (trackUser)
		{
			GnUserTracking track = new GnUserTracking();
			track.setCompanyId(user.getCompanyId());
			track.setUserId(user.getUserId());
			track.setLoginDate(new Date());
			String fromIp = req.getHeader("X-Forwarded-For");
			if (Validator.isNull(fromIp))
				fromIp = req.getRemoteAddr() + 
				         (Validator.isNotNull(req.getRemoteHost()) && 
				          !req.getRemoteAddr().equals(req.getRemoteHost()) ? 
				         "( "+ req.getRemoteHost() +" )" : "");
			
			
			track.setFromIp(fromIp);
			GnPersistenceService.getInstance(null).createObject(track);
		}
		EventsService.getInstance().createEvent(user, "PortalAuth", "User " + user.getScreenName() + " has logged in " + req.getServerName(),"loginaction", null);
	}

//	public static SpiritUserClientDto createEpsosUserInformation(String language,SpiritEhrWsClientInterface webservice, long userId, long companyId, String login, boolean loginViaPortal) throws Exception
//	{	
//        SpiritUserClientDto usr = null;
//		boolean epsosUsrcreated = false;
//		PartiesService partiesServ = PartiesService.getInstance();
//		PaPerson person = partiesServ.getPaPerson(userId);
//		boolean isPhysician = partiesServ.partyHasRoleType(person.getMainid(), PHYSICIAN.getMainid());
//		boolean isPharmacist = partiesServ.partyHasRoleType(person.getMainid(), PHARMACIST.getMainid());
//		boolean isNurse = partiesServ.partyHasRoleType(person.getMainid(), NURSE.getMainid());
//		boolean isAdministrator = partiesServ.partyHasRoleType(person.getMainid(), ADMINISTRATOR.getMainid());
//		boolean isRoot = false;
//		
//		Assertion assertion = null;
//		Vector perms = new Vector();
//		User user2=UserLocalServiceUtil.getUserByScreenName(companyId, login);
//		if (user2.getScreenName().equals("root"))
//				{
//				isRoot=true;
//				}
//		String username = user2.getScreenName();
//		String rolename="";
//		if (loginViaPortal)
//		{		
//		// login to Spirit Client
//			
//		String prefix="urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:";
//		
//		if (user2.getScreenName().equals("root"))
//		
//		{
//			rolename="medical doctor";
//			String doctor_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "medical.doctor.perms"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
//			String p[] = new String[3];
//
//			perms.add(prefix+"PRD-026"); // patient search
//			perms.add(prefix+"PRD-013"); // patient card
//			perms.add(prefix+"PRD-005");
//		}
//		if (isPhysician)
//		{
//			rolename="medical doctor";
//			String doctor_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "medical.doctor.perms"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
//			String p[] = doctor_perms.split(",");
//			for (int k=0;k<p.length;k++)
//				{
//				perms.add(prefix+p[k]);
//				}
//			}
//		if (isPharmacist)
//		{
//			rolename="pharmacist";
//			String pharm_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "pharmacist.perms"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
//			String p1[] = pharm_perms.split(",");
//			for (int k=0;k<p1.length;k++)
//				{
//				perms.add(prefix+p1[k]);
//				}
//			}
//		
//		if (isNurse)
//		{
//			rolename="nurse";
//			String nurse_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "nurse.perms"),"PRD-006,PRD-004,PRD-010");
//			String p1[] = nurse_perms.split(",");
//			for (int k=0;k<p1.length;k++)
//				{
//				perms.add(prefix+p1[k]);
//				}
//			}
//			
//		if (isAdministrator)
//		{
//			rolename="administrator";
//			String admin_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "nurse.administrator"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
//			String p1[] = admin_perms.split(",");
//			for (int k=0;k<p1.length;k++)
//				{
//				perms.add(prefix+p1[k]);
//				}
//			}
//		
//		OrganizationChartService orgServ = OrganizationChartService.getInstance();
//		PaOrganization parent = orgServ.getParentDepartment(person.getMainid(), null, orgServ.getRelHasEmployee().getMainid());			
//		
//		String orgName="HOSPITALS";//v.getField1().toString();
//		String poc="POC";
//		String orgId = companyId+"";
//		String orgType = "N/A";
//		try
//		{
//		ViewResult v = GnPersistenceService.getInstance(null).getObjectWithLanguage(PaParty.class,parent.getMainid(),language, new String[]{"langs.description"});
//		orgId=parent.getMainid()+"";
//		orgType=parent.getPaOrganizationType().getSystemCode();
//	    
//	    PaRegisteredIdentifier userIdent = partiesServ.getRegisteredIdentifierForParty(person.getMainid(), "PointOfCare");
//		if (userIdent != null)
//			poc = userIdent.getIdentifier();
//		}
//		catch (Exception e) {
//			_log.info("error getting parent org");
//		}
//		_log.info("trying to create assertion");
//		assertion = EpsosHelperService.createAssertion(username,rolename,orgName,orgId,
//		orgType,"TREATMENT",poc,perms);
//		_log.info("assertion created");
//		}
//		else
//		{
//		
//		String prefix="urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:";
//		perms.add(prefix+"PRD-006"); // patient search
//		perms.add(prefix+"PRD-003"); // patient card
//		perms.add(prefix+"PRD-005");
//		perms.add(prefix+"PRD-010");
//		perms.add(prefix+"PRD-016");
//		perms.add(prefix+"PPD-004");
//		perms.add(prefix+"PPD-032"); // consent
//		perms.add(prefix+"PPD-046"); // dispensation	
//		perms.add(prefix+"POE-006");
//		
//		assertion = EpsosHelperService.createAssertion("gnomon","medical doctor","GNOMON","1.2.3",
//				"Pharmacy","TREATMENT","hospgr",perms);
//
//		}
//			
//		if (isPhysician || isPharmacist || isNurse)
//		{
//			
//		    ConfigurationManagerService cms = ConfigurationManagerService.getInstance();
//
//		    String KEY_ALIAS = cms.getProperty("javax.net.ssl.key.alias"); //GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_ALIAS"),"server1");
//	        String PRIVATE_KEY_PASS = cms.getProperty("javax.net.ssl.privateKeyPassword"); //GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_PASSWORD"),"spirit");   
//			
//	        try
//	        {
//			EpsosHelperService.signSAMLAssertion(assertion,KEY_ALIAS,PRIVATE_KEY_PASS.toCharArray());
//	        }
//	        catch (Exception e)
//	        {
//	        	return null;
//	        }
//	        AssertionMarshaller marshaller = new AssertionMarshaller();
//	        Element element = marshaller.marshall(assertion);
//	        Document document = element.getOwnerDocument();
//	        
//	        EpsosHelperService.getInstance().createLog("Creating assertions method for user " + username + " and role " + rolename,null,Priority.INFO);
//	        _log.info("Creating assertions method for user " + username + " and role " + rolename);
//		    try
//			{	        	
//	        usr = webservice.initUser(document.getDocumentElement());
//	        epsosUsrcreated = true;
//	        
//			}
//			catch (Exception e)
//			{
//			EpsosHelperService.getInstance().createLog("ERROR Getting user object from WS " + e.getMessage(),null,Priority.FATAL);
//			e.printStackTrace();
//			SessionErrors.add(req, e.getMessage());		
//			}
//			EpsosHelperService.getInstance().createLog("Getting user object from WS " + usr.getCommomName(),usr);
//			usr.setDisplayName(user2.getFullName());
//			req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTIONID, assertion.getID());
//	        req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTION, assertion);	        
//			req.getSession().setAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr);
//			}
//		else
//		{
//			if (!(login.equals("root")))
//					{
//					SessionErrors.add(req, "User doesn't belong to epSOS role so you can't login");
//					}
//		}
//			return usr;
//	}
	
	public ActionForward execute(
			ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res)
	throws Exception {

		HttpSession ses = req.getSession();

		ThemeDisplay themeDisplay =
			(ThemeDisplay)req.getAttribute(WebKeys.THEME_DISPLAY);

		if (ses.getAttribute("j_username") != null &&
				ses.getAttribute("j_password") != null) {

			if (GetterUtil.getBoolean(
					PropsUtil.get(PropsUtil.PORTAL_JAAS_ENABLE))) {

				return mapping.findForward("/portal/touch_protected.jsp");
			}
			else {
				res.sendRedirect(themeDisplay.getPathMain());

				return null;
			}
		}

		String cmd = ParamUtil.getString(req, Constants.CMD);

		if (cmd.equals("already-registered")) {
			try {
				login(req, res);

				if (GetterUtil.getBoolean(
						PropsUtil.get(PropsUtil.PORTAL_JAAS_ENABLE))) {

					return mapping.findForward("/portal/touch_protected.jsp");
				}
				else {
					String redirect = ParamUtil.getString(req, "redirect");

					if (Validator.isNotNull(redirect)) {
						res.sendRedirect(redirect);
					}
					else {
						res.sendRedirect(themeDisplay.getPathMain());
					}

					return null;
				}
			}
			catch (Exception e) {
				if (e instanceof AuthException) {
					Throwable cause = e.getCause();

					if (cause instanceof PasswordExpiredException ||
							cause instanceof UserLockoutException) {

						SessionErrors.add(req, cause.getClass().getName());
					}
					else {
						SessionErrors.add(req, e.getClass().getName());
					}

					return mapping.findForward("portal.login");
				}
				else if (e instanceof CookieNotSupportedException ||
						e instanceof NoSuchUserException ||
						e instanceof PasswordExpiredException ||
						e instanceof UserEmailAddressException ||
						e instanceof UserIdException ||
						e instanceof UserLockoutException ||
						e instanceof UserPasswordException ||
						e instanceof UserScreenNameException) {

					SessionErrors.add(req, e.getClass().getName());

					return mapping.findForward("portal.login");
				}
				else {
					req.setAttribute(PageContext.EXCEPTION, e);

					return mapping.findForward(ActionConstants.COMMON_ERROR);
				}
			}
		}
		else if (cmd.equals("forgot-password")) {
			try {
				sendPassword(req);

				return mapping.findForward("portal.login");
			}
			catch (Exception e) {
				if (e instanceof NoSuchUserException ||
						e instanceof SendPasswordException ||
						e instanceof UserEmailAddressException) {

					SessionErrors.add(req, e.getClass().getName());

					return mapping.findForward("portal.login");
				}
				else {
					req.setAttribute(PageContext.EXCEPTION, e);

					return mapping.findForward(ActionConstants.COMMON_ERROR);
				}
			}
		}
		else {
			return mapping.findForward("portal.login");
		}
	}

	protected void login(HttpServletRequest req, HttpServletResponse res)
	throws Exception {

		String login = ParamUtil.getString(req, "login").toLowerCase();
		String password = ParamUtil.getString(
				req, SessionParameters.get(req, "password"));
		boolean rememberMe = ParamUtil.getBoolean(req, "rememberMe");

		login(req, res, login, password, rememberMe);
	}

	protected void sendPassword(HttpServletRequest req) throws Exception {
		String emailAddress = ParamUtil.getString(req, "emailAddress");

		String remoteAddr = req.getRemoteAddr();
		String remoteHost = req.getRemoteHost();
		String userAgent = req.getHeader(HttpHeaders.USER_AGENT);

		UserLocalServiceUtil.sendPassword(
				PortalUtil.getCompanyId(req), emailAddress, remoteAddr, remoteHost,
				userAgent);

		SessionMessages.add(req, "request_processed", emailAddress);
	}

	private static Logger _log = Logger.getLogger(LoginAction.class);
	
}