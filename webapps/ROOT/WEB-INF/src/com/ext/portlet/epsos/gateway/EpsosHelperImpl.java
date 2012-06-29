package com.ext.portlet.epsos.gateway;

import epsos.ccd.gnomon.auditmanager.AuditService;
import epsos.ccd.gnomon.auditmanager.EventActionCode;
import epsos.ccd.gnomon.auditmanager.EventLog;
import epsos.ccd.gnomon.auditmanager.EventOutcomeIndicator;
import epsos.ccd.gnomon.auditmanager.EventType;
import epsos.ccd.gnomon.auditmanager.TransactionName;
import epsos.ccd.gnomon.configmanager.ConfigurationManager;
import epsos.ccd.gnomon.configmanager.ConfigurationManagerService;
import epsos.ccd.netsmart.securitymanager.sts.client.TRCAssertionRequest;
import gnomon.business.GeneralUtils;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.OrganizationChartService;
import gnomon.hibernate.PartiesService;
import gnomon.hibernate.model.parties.PaOrganization;
import gnomon.hibernate.model.parties.PaParty;
import gnomon.hibernate.model.parties.PaPerson;
import gnomon.hibernate.model.parties.PaRegisteredIdentifier;
import gnomon.hibernate.model.parties.PsPartyRoleType;
import gnomon.hibernate.model.views.ViewResult;
import gnomon.util.GnPropsUtil;

import com.ext.portlet.epsos.demo.PatientSearchForm;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.Principal;
import java.security.cert.CertificateEncodingException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.jws.WebService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;

import org.apache.commons.lang.LocaleUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import org.apache.tools.ant.util.DateUtils;
import org.opensaml.saml2.core.Assertion;
import org.opensaml.saml2.core.impl.AssertionMarshaller;
import org.opensaml.xml.ConfigurationException;
import org.opensaml.xml.io.MarshallingException;
import org.opensaml.xml.util.Base64;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.SearchMask;
import com.ext.sql.StrutsFormFields;
import com.ext.sql.StrutsFormFields2;
import com.ext.sql.StrutsFormFieldsGroupDelimiter;
import com.ext.util.CommonUtil;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.portlet.LiferayWindowState;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.security.auth.Authenticator;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.service.impl.UserLocalServiceImpl;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.PortletURLImpl;
import com.liferay.util.servlet.SessionErrors;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrException_Exception;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.SpiritOrganisationClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.InterfaceFactory;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

@WebService(endpointInterface = "com.ext.portlet.epsos.gateway.EpsosHelper")
public class EpsosHelperImpl implements EpsosHelper {

	public final static PsPartyRoleType PHARMACIST = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "pharmacist");
	public final static PsPartyRoleType PHYSICIAN = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "physician");
	public final static PsPartyRoleType NURSE = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "nurse");
	public final static PsPartyRoleType ADMINISTRATOR = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "administrator");

	
	@Resource WebServiceContext wsc;  

	//@Resource private static WebServiceContext ctx;
	private static SpiritEhrWsClientInterface webservice=null;
 	
	public EpsosHelperImpl(){
		
		if (webservice==null) {
			String epsosWebServiceURL = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.webservice.url"), "");
			webservice = InterfaceFactory.createEhrWsInterface(epsosWebServiceURL,true);
		}
			}
	
	public static InitUserObj createEpsosUserInformation(HttpServletRequest req, HttpServletResponse res, String language,SpiritEhrWsClientInterface webservice, long userId, long companyId, String login, boolean loginViaPortal) throws CustomException
	{	
		InitUserObj initUserObj = new InitUserObj();
        SpiritUserClientDto usr = null;
		boolean epsosUsrcreated = false;
		PartiesService partiesServ = PartiesService.getInstance();
		PaPerson person = partiesServ.getPaPerson(userId);
		boolean isPhysician = partiesServ.partyHasRoleType(person.getMainid(), PHYSICIAN.getMainid());
		boolean isPharmacist = partiesServ.partyHasRoleType(person.getMainid(), PHARMACIST.getMainid());
		boolean isNurse = partiesServ.partyHasRoleType(person.getMainid(), NURSE.getMainid());
		boolean isAdministrator = partiesServ.partyHasRoleType(person.getMainid(), ADMINISTRATOR.getMainid());
		boolean isRoot = false;
		String orgName="";
		Assertion assertion = null;
		Vector perms = new Vector();
		User user2=null;
		try {
			user2 = UserLocalServiceUtil.getUserByScreenName(companyId, login);
		} catch (PortalException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SystemException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if (user2.getScreenName().equals("root"))
				{
				isRoot=true;
				}
		String username = user2.getScreenName();
		String rolename="";
		if (loginViaPortal)
		{		
		// login to Spirit Client
			
		String prefix="urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:";
		
		if (user2.getScreenName().equals("root"))
		
		{
			rolename="medical doctor";
			String doctor_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "medical.doctor.perms"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
			String p[] = new String[3];

			perms.add(prefix+"PRD-026"); // patient search
			perms.add(prefix+"PRD-013"); // patient card
			perms.add(prefix+"PRD-005");
		}
		if (isPhysician)
		{
			rolename="medical doctor";
			String doctor_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "medical.doctor.perms"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
			String p[] = doctor_perms.split(",");
			for (int k=0;k<p.length;k++)
				{
				perms.add(prefix+p[k]);
				}
			}
		if (isPharmacist)
		{
			rolename="pharmacist";
			String pharm_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "pharmacist.perms"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
			String p1[] = pharm_perms.split(",");
			for (int k=0;k<p1.length;k++)
				{
				perms.add(prefix+p1[k]);
				}
			}
		
		if (isNurse)
		{
			rolename="nurse";
			String nurse_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "nurse.perms"),"PRD-006,PRD-004,PRD-010");
			String p1[] = nurse_perms.split(",");
			for (int k=0;k<p1.length;k++)
				{
				perms.add(prefix+p1[k]);
				}
			}
			
		if (isAdministrator)
		{
			rolename="administrator";
			String admin_perms = GetterUtil.getString(GnPropsUtil.get("portalb", "nurse.administrator"),"PRD-006,PRD-003,PRD-005,PRD-010,PRD-016,PPD-004,PPD-032,PPD-046,POE-006");
			String p1[] = admin_perms.split(",");
			for (int k=0;k<p1.length;k++)
				{
				perms.add(prefix+p1[k]);
				}
			}
		
		OrganizationChartService orgServ = OrganizationChartService.getInstance();
		PaOrganization parent = orgServ.getParentDepartment(person.getMainid(), null, orgServ.getRelHasEmployee().getMainid());			
		
		orgName="HOSPITALS";//v.getField1().toString();
		String poc="POC";
		String orgId = companyId+"";
		String orgType = "N/A";
		try
		{
		ViewResult v = GnPersistenceService.getInstance(null).getObjectWithLanguage(PaParty.class,parent.getMainid(),language, new String[]{"langs.description"});
		orgId=parent.getMainid()+"";
		orgType=parent.getPaOrganizationType().getSystemCode();
	    
	    PaRegisteredIdentifier userIdent = partiesServ.getRegisteredIdentifierForParty(person.getMainid(), "PointOfCare");
		if (userIdent != null)
			poc = userIdent.getIdentifier();
		}
		catch (Exception e) {
			_log.info("error getting parent org");
		}
		_log.info("trying to create assertion");
		assertion = EpsosHelperService.createAssertion(username,rolename,orgName,orgId,orgType,"TREATMENT",poc,perms);
		_log.info("assertion created");
		}
		else
		{
		
		String prefix="urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:";
		perms.add(prefix+"PRD-006"); // patient search
		perms.add(prefix+"PRD-003"); // patient card
		perms.add(prefix+"PRD-005");
		perms.add(prefix+"PRD-010");
		perms.add(prefix+"PRD-016");
		perms.add(prefix+"PPD-004");
		perms.add(prefix+"PPD-032"); // consent
		perms.add(prefix+"PPD-046"); // dispensation	
		perms.add(prefix+"POE-006");
		
		assertion = EpsosHelperService.createAssertion("gnomon","medical doctor","GNOMON","1.2.3",
				"Pharmacy","TREATMENT","hospgr",perms);

		}
			
		if (isPhysician || isPharmacist || isNurse)
		{
			
		    ConfigurationManagerService cms = ConfigurationManagerService.getInstance();

		    String KEY_ALIAS = cms.getProperty("javax.net.ssl.key.alias"); //GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_ALIAS"),"server1");
	        String PRIVATE_KEY_PASS = cms.getProperty("javax.net.ssl.privateKeyPassword"); //GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_PASSWORD"),"spirit");   
			
	        try
	        {
			EpsosHelperService.signSAMLAssertion(assertion,KEY_ALIAS,PRIVATE_KEY_PASS.toCharArray());
	        }
	        catch (Exception e)
	        {
	        	return null;
	        }
	        AssertionMarshaller marshaller = new AssertionMarshaller();
	        Element element=null;;
			try {
				element = marshaller.marshall(assertion);
			} catch (MarshallingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        Document document = element.getOwnerDocument();        
	        _log.info("Creating assertions method for user " + username + " and role " + rolename);
		    try
			{	        	
	        usr = webservice.initUser(document.getDocumentElement());
	        epsosUsrcreated = true;
	        sendAutitEpsos91(req,res,user2.getFullName(),user2.getEmailAddress(),orgName,rolename,assertion.getID());
			}
			catch (Exception e)
			{
			EpsosHelperService.getInstance().createLog("ERROR Getting user object from WS " + e.getMessage(),null,Priority.FATAL);
			e.printStackTrace();
			throw new CustomException("ERROR_WS_LOGIN","ERROR Getting user object from WS " + e.getMessage());
//			SessionErrors.add(req, e.getMessage());		
			}
			EpsosHelperService.getInstance().createLog("Getting user object from WS " + usr.getCommomName(),usr);
			usr.setDisplayName(user2.getFullName());
			initUserObj.setAssertion(assertion);
			initUserObj.setUsr(usr);
//			req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTIONID, assertion.getID());
//	        req.getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTION, assertion);	        
//			req.getSession().setAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr);
			}
		else
		{
			if (!(login.equals("root")))
					{
					throw new CustomException("USER_NOT_PROPER","User doesn't belong to epSOS role so you can't login");
//					SessionErrors.add(req, "User doesn't belong to epSOS role so you can't login");
					}
		}
			return initUserObj;
	}
	
	public static InitUserObj createEpsosUserInformation(String language,SpiritEhrWsClientInterface webservice, long userId, long companyId, String login, boolean loginViaPortal) throws CustomException
	{
		return createEpsosUserInformation(null,null,language,webservice,userId,companyId,login,loginViaPortal);
	}
	
    /**
	     * @param  EI_EventActionCode Possible values according to D4.5.6 are E,R,U,D
	     * @param  EI_EventDateTime The datetime the event occured
	     * @param  EI_EventOutcomeIndicator <br>
	     *         0 for full success <br>
	     *         1 in case of partial delivery <br>
	     *         4 for temporal failures <br>
	     *         8 for permanent failure <br>
	     * @param  PC_UserID Point of Care: Oid of the department
	     * @param  PC_RoleID Role of the department
	     * @param  HR_UserID Identifier of the HCP initiated the event
	     * @param  HR_RoleID Role of the HCP initiated the event
	     * @param  HR_AlternativeUserID Human readable name of the HCP as given in the Subject-ID
	     * @param  SC_UserID The string encoded CN of the TLS certificate of the NCP triggered the epsos operation
	     * @param  SP_UserID The string encoded CN of the TLS certificate of the NCP processed the epsos operation
	     * @param  AS_AuditSourceId the iso3166-2 code of the country responsible for the audit source
	     * @param  ET_ObjectID The string encoded UUID of the returned document
	     * @param  ReqM_ParticipantObjectID String-encoded UUID of the request message
	     * @param  ReqM_PatricipantObjectDetail The value MUST contain the base64 encoded security header.
	     * @param  ResM_ParticipantObjectID String-encoded UUID of the response message
	     * @param  ResM_PatricipantObjectDetail The value MUST contain the base64 encoded security header.
	     * @param  sourceip The IP Address of the source Gateway
	     * @param  targetip The IP Address of the target Gateway
	     */
	public static void sendAutitEpsos91(HttpServletRequest request, HttpServletResponse response,String fullname, String email, String orgname, String rolename, String message)
	{
        
    	ConfigurationManagerService cms = ConfigurationManagerService.getInstance();
    	String KEY_ALIAS = cms.getProperty("javax.net.ssl.key.alias"); 
    	String KEYSTORE_LOCATION =cms.getProperty("javax.net.ssl.keyStore");
    	String PRIVATE_KEY_PASS = cms.getProperty("javax.net.ssl.privateKeyPassword");
    	String KEY_STORE_PASS =cms.getProperty("javax.net.ssl.keyStorePassword"); 
    	java.security.cert.Certificate cert = null;
    	String name="";
    	try {
		    // Load the keystore in the user's home directory
		    FileInputStream is = new FileInputStream(KEYSTORE_LOCATION);
		    KeyStore keystore = KeyStore.getInstance("JKS");
		    keystore.load(is,KEY_STORE_PASS.toCharArray());
		    // Get certificate
		    cert = keystore.getCertificate(KEY_ALIAS);
		    
		    try {
		        // List the aliases
		        Enumeration enum1 = keystore.aliases();
		        for (; enum1.hasMoreElements(); ) {
		            String alias = (String)enum1.nextElement();

		            if (cert instanceof X509Certificate) {
		                X509Certificate x509cert = (X509Certificate)cert;

		                // Get subject
		                Principal principal = x509cert.getSubjectDN();
		                String subjectDn = principal.getName();
		                name=subjectDn;

		                // Get issuer
		                principal = x509cert.getIssuerDN();
		                String issuerDn = principal.getName();
		            }
		        }
		    } catch (KeyStoreException e) {
		    }
		    
		    
		    
		} catch (KeyStoreException e) {
		} catch (java.security.cert.CertificateException e) {
		} catch (NoSuchAlgorithmException e) {
		} catch (java.io.IOException e) {
		}
		
		 String secHead = "No security header provided";
		 String basedSecHead = Base64.encodeBytes(secHead.getBytes());
		 String reqm_participantObjectID = "00000000-0000-0000-0000-000000000000";
		 String resm_participantObjectID = "00000000-0000-0000-0000-000000000000";
		
		 InetAddress sourceIP=null;
         try {
             sourceIP = InetAddress.getLocalHost();
         } catch (UnknownHostException ex) { }
         
         
        String PC_UserID=orgname + "<saml:" + email + ">";
		String PC_RoleID="Other";
		if (rolename.equals("medical doctor")) PC_RoleID="Resident Physician";
		if (rolename.equals("pharmacist")) PC_RoleID="Pharmacy";
		String HR_UserID= fullname + "<saml:" + email + ">";
		String HR_RoleID=rolename;
		String HR_AlternativeUserID="";
		String SC_UserID=name;
		String SP_UserID=name;

		String AS_AuditSourceId=ConfigurationManager.getInstance().getProperty("ncp.country");
		String ET_ObjectID=message;
		byte[] ResM_PatricipantObjectDetail=new byte[1];
		
		AuditService asd = new AuditService();
        GregorianCalendar c = new GregorianCalendar();
        c.setTime(new Date());
        XMLGregorianCalendar date2 = null;
        try {
            date2 = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
        } catch (DatatypeConfigurationException ex) {
        }
        EventLog eventLog1 = EventLog.createEventLogHCPIdentity(
        		TransactionName.epsosHcpAuthentication,
        		EventActionCode.EXECUTE,
        		date2,
        		EventOutcomeIndicator.FULL_SUCCESS,
        		PC_UserID,PC_RoleID,
        		HR_UserID,HR_RoleID,
        		HR_AlternativeUserID,
        		SC_UserID,
        		SP_UserID,
        		AS_AuditSourceId,
        		ET_ObjectID,
        		reqm_participantObjectID,
        		basedSecHead.getBytes(),
        		resm_participantObjectID,
        		ResM_PatricipantObjectDetail,
        		sourceIP.getHostAddress(),
        		"N/A");
        eventLog1.setEventType(EventType.epsosHcpAuthentication);
        asd.write(eventLog1, "13", "2");
	}
	
	@Override
	public SpiritUserClientDto initUser(String username,String password) throws CustomException {
		String language = "el_GR";
		long companyId = 95945;
		User user=null;
		try {
			user = UserLocalServiceUtil.getUserByScreenName(companyId, username);
		} catch (PortalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		InitUserObj initUserObj = null;
	
		int auth = epsosAuthenticate(username,password);
		_log.info("####>> LOGIN " + username + "__" + password + "__" + auth);
		if (auth==Authenticator.SUCCESS)
		{		
			initUserObj = createEpsosUserInformation(language, webservice, user.getUserId(), companyId, username, true);       
			return initUserObj.getUsr();
			}
		else
		{
			throw new CustomException("LOGIN_ERROR_PORTAL","Error authenticating user");
		}
	}
	
	
	
	/**
	 * Returns a vector odf struts form fields
	 * @param country Input Argument is the country we want to get the fields required to build the search form
	 * 
	 * You need the following properties to build your input form: formFieldName, formFieldKey
	 * In order to get the label of this field you have to call the getTranslation method
	 * 
	 */
	@Override
	public Vector<StrutsFormFields> getFieldsForCountryFromNCP(
			String country, String language) {
		
		//String[] attrs = EpsosHelperService.getInstance().getCountryIdsFromCS(country);
		Vector attrs = EpsosHelperService.getInstance().getCountryIdsFromCS(country);
		
		StrutsFormFields new_field=null;
		Vector<StrutsFormFields> fields = new Vector<StrutsFormFields>();
		
		new_field = new StrutsFormFields("country",EpsosHelperService.getPortalTranslation("patient.data.country",language),"select",false);
		new_field.setCollectionProperty("countryIds");
		new_field.setCollectionLabel("countryNames");
		new_field.setOnChange("countrySelectionChanged()");
		fields.addElement(new_field);
		
//		fields.addElement(new StrutsFormFields("pid","epsos.demo.search.pid","text",false));
		
		if (Validator.isNotNull(country))
		{
			boolean DEFAULT_DEMOGRAPHICS = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.search.demographics.default"), false);
			boolean countryDemographics = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.search.demographics."+country), DEFAULT_DEMOGRAPHICS);
			//String[] countryPatientIds = attrs[0].split(",");	
			
			if (attrs != null && attrs.size() > 0)
			{
				// ids
				int i=1;
				//for (String cid: countryPatientIds)
				for (int j=0;j<attrs.size();j++)
				{
					SearchMask sm = (SearchMask) attrs.get(j);
					String cid = sm.getDomain();
					if (Validator.isNotNull(cid.trim()))
					{
						fields.addElement(new StrutsFormFields("pid"+i,EpsosHelperService.getPortalTranslation(sm.getLabel(),language),"text",false));
						i++;
					}
				}
			}
			
			if (countryDemographics)
			{			
				// demographics
				fields.addElement(new StrutsFormFields("givenName",EpsosHelperService.getPortalTranslation("patient.data.givenname",language),"text",false));
				fields.addElement(new StrutsFormFields("surName",EpsosHelperService.getPortalTranslation("patient.data.surname",language),"text",false));
				fields.addElement(new StrutsFormFields("birthDate",EpsosHelperService.getPortalTranslation("patient.data.birth.date",language),"date",false));
				new_field = new StrutsFormFields("sex",EpsosHelperService.getPortalTranslation("patient.data.sex",language),"select",false);  
				new_field.setCollectionProperty("sexIds");
				new_field.setCollectionLabel("sexNames");
				fields.addElement(new_field);
				fields.addElement(new StrutsFormFields("street",EpsosHelperService.getPortalTranslation("patient.data.street.address",language),"text",false)); 
				fields.addElement(new StrutsFormFields("zipCode",EpsosHelperService.getPortalTranslation("patient.data.code",language),"text",false)); 
				fields.addElement(new StrutsFormFields("city",EpsosHelperService.getPortalTranslation("patient.data.city",language),"text",false)); 
			}
			
		}
		return fields;
	}

	
	/**
	 * Returns the translation of an input field
	 * @param field the key that you want to get the translation label
	 * 
	 */
	@Override
	public String getTranslation(String field) {
		String translation = getTranslationLang(field,"el","GR");
		return translation;
	}

	@Override
	public String getLanguageTranslation(String field, String language, String country) {
		String translation = getTranslationLang(field,language,country);
		return translation;
	}
	
	@Override
	public String getTranslationLang(String field, String language, String country) {
		String translation = LanguageUtil.get(95945, new Locale(language,country), field, "");
		_log.debug("get translation for " + field + " for language " + language + "_" + country + ": " + translation);
		return translation;
	}

	
	@Override
	public List<EhrPatientClientDto> searchPatients(String xml) throws CustomException {
		PatientSearchForm form = new PatientSearchForm();
		//xml="<?xml version='1.0'?><form><field><name>country</name>" +
		//"<value>SE</value></field><field><name>pid</name>" +
		//"<value>192405038569</value></field>" +
		//"</form>";
		form = EpsosHelperService.getInstance().TransferXMLToForm(xml);
		EhrPatientClientDto patFilter = EpsosHelperService.getInstance().createPatFilter(form);
		List<EhrPatientClientDto> result = null;
		try {
			result = webservice.queryPatients(patFilter);
		} catch (Exception e) {
			if (e.getMessage().contains("1002"))
				throw new CustomException("ERROR_1002",e.getMessage());
			else if (e.getMessage().contains("4701"))
				throw new CustomException("ERROR_4701",e.getMessage());
			else if (e.getMessage().contains("LOGIN_REQUIRED"))
				throw new CustomException("ERROR_LOGIN_REQUIRED",e.getMessage());
			else
					throw new CustomException("ERROR_GET_PATIENTS",e.getMessage());
				

		}
		if (Validator.isNull(result))
			throw new CustomException("ERROR_NO_PATIENTS","");
	
		return result;
	}

	/** 
	 * 
	 * Returns the list of the supported countries in comma seperated format
	 */
	@Override
	public String ListCountries() {
		String languages = EpsosHelperService.getInstance().getCountriesFromCS();
		_log.debug("LIST COUNTRIES : " + languages);
//		String languages = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.search.countries.supported"), "");
		return languages;
	}


	
	@Override
	public boolean CreatePatientConfirmation(EhrPatientClientDto patient, String country, String purposeOfUse, String username) throws CustomException {	
		boolean created=false;
		try
		{
		long companyId = 95945;
		User user = UserLocalServiceUtil.getUserByScreenName(companyId, username);
		InitUserObj initUserObj = createEpsosUserInformation("el_GR", webservice, user.getUserId(), companyId, username, true);
		EpsosHelperService.getInstance().createPatientConfirmationPlain(initUserObj.getUsr(), purposeOfUse, webservice, initUserObj.getAssertion(), patient);
		created=true;
		} catch (Exception e) {
			throw new CustomException("ERROR_CREATE_CONFIRMATION",e.getMessage());
		}		
		return created;
		
	}

	
	@Override
	public List<DocumentClientDto> queryPatientEPDocs(EhrPatientClientDto patient) throws CustomException {

		ArrayList<DocumentClientDto> filteredDocs = null;
		try {
			//EhrPatientClientDto patient = EpsosHelperService.getInstance().getPatientFromID(webservice, patID, patIDType, country,null);
			if (patient!=null)
			{			
				PatientContentClientDto result = null; 
				XdsQArgsDocument qArgs = new XdsQArgsDocument();
				qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");
				boolean useLocalDocument = false; // GetterUtil.getBoolean(GnPropsUtil.get("epsos", "epsos.use.default.local.document.example"), false);
				if (!useLocalDocument)
				{			
					qArgs=EpsosHelperService.getInstance().getArgsForEP();
				}
				result = webservice.queryDocuments(patient.getPid(), qArgs);
			
				if (result != null && result.getDocuments() != null)
				{
					List<DocumentClientDto> docs =  result.getDocuments();
					filteredDocs = new ArrayList<DocumentClientDto>();
					if (docs != null)
					{
						for (DocumentClientDto d: docs)
						{
							d.setMimeType("text/xml");
							if (d.getMimeType().equals("text/xml"))
								filteredDocs.add(d);
							
							List<DocumentClientDto> childDocs = d.getChildDocuments();
							if (childDocs != null && childDocs.size() > 0) {
								for (DocumentClientDto childDoc: childDocs)
								{
									// set mime-type of this child document to pdf
									childDoc.setMimeType("application/pdf");
									filteredDocs.add(childDoc);
								}
							}
						}
					}
					
				}
				
			}
			
		} catch (Exception e) {
			if (e.getMessage().contains("1002"))
				throw new CustomException("ERROR_1002",e.getMessage());
			else
				throw new CustomException("ERROR_GET_EPDOCS",e.getMessage());
		}
		if (Validator.isNotNull(filteredDocs) && filteredDocs.size()==0) {
			throw new CustomException("NO_EPDOCS_FOUND","");
		}
		
		return filteredDocs;
	}


	@Override
	public byte[] getCDADocument(String docID,EhrPatientClientDto patient) throws CustomException {

		EpsosHelperService epsos = null; 
		SpiritUserClientDto usr = null;
		byte[] byteArray = null;
		
		try {
			
			String contentType = null;
			String fileName = "epsos_doc";
			
			epsos = EpsosHelperService.getInstance(); 

			if (patient!=null)
			{
			XdsQArgsDocument argDoc = new XdsQArgsDocument();
			XdsQArgsDocument qArgs = new XdsQArgsDocument();
			qArgs=EpsosHelperService.getInstance().getArgsForEP();
			PatientContentClientDto result = webservice.queryDocuments(patient.getPid(), qArgs);
			if (result != null && result.getDocuments() != null)
			{	
				for (DocumentClientDto doc: result.getDocuments())
				{
					if (doc.getUniqueId().equals(docID))
					//if (doc.getFormatCode().getNodeRepresentation().equals("urn:epSOS:ep:pre:2010"))
					{
						EpsosHelperService.getInstance().createLog("RETRIEVE DOC, REQUEST. PATIENT:" + patient.getGivenName(),usr);
						byteArray = webservice.retrieveDocument(doc);
						EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE OK. PATIENT:" + patient.getGivenName(),usr);
						contentType = doc.getMimeType();
						break;
					}				
				}
			}
			
			}
		}
		catch (Exception e) {
			EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE ERROR. PATIENT:" + patient.getGivenName(),usr);
			throw new CustomException("ERROR_GET_DOCUMENT",e.getMessage());
		}
		
		
		return byteArray;
	}

	


	@Override	
	public boolean writeCDADocument(byte[] bytes, EhrPatientClientDto patient,
			String country,String language,String fullname) throws CustomException 
			{
		boolean dispCreated=false;
		EpsosHelperService epsos = EpsosHelperService.getInstance();
		try
		{
		epsos.writeDispensationDocument(webservice, bytes, null, patient, country, null, language, fullname);
		dispCreated=true;
		}
		catch (Exception e)
		{
		e.printStackTrace();
		throw new CustomException("GENEX001",e.getMessage());			
		}
		return dispCreated;
	}
	
	@Override
	public String transformCDA(byte[] prescription, String language)  throws CustomException 
	{
	String ret = "";
	try
	{
	String xmlfile = new String(prescription,"UTF-8");
	
	com.gnomon.xslt.EpsosXSLTransformer xlsClass= new com.gnomon.xslt.EpsosXSLTransformer();
	String lang1 = language.replace("_","-");
	ret= xlsClass.transform(xmlfile,lang1,"");
	}
	catch (Exception e)
	{
		throw new CustomException("CDA_ERROR_CONVERT",e.getMessage());			
	}	
	return ret;
	}
	
	@Override
	public boolean writeDispensationDocumentFromEP(byte[] prescription, SpiritUserClientDto usr, EhrPatientClientDto patient, 
			ViewResult prescribedLine, String dispensedId, String dispensedProduct, boolean isSubstitute, String dispensedQuantity, String country, String language,boolean sent)  throws CustomException 
		{
		
		ViewResult d_line = new ViewResult(
				prescribedLine.getMainid(), 
				dispensedId, 
				dispensedProduct, 
				isSubstitute,
				prescribedLine.getField3()+"", 
				prescribedLine.getField4()+"", 
				prescribedLine.getField4()+"",
				dispensedQuantity,
				prescribedLine.getField8()+"", 
				prescribedLine.getField14()+"",  
				prescribedLine.getField19()+"", 
				prescribedLine.getField2()+""); 
		
		
		boolean result=false;
		
		ArrayList<ViewResult> dispensedLines = new ArrayList<ViewResult>();
		dispensedLines.add(d_line);
		String fullname=usr.getDisplayName();
		if (Validator.isNull(usr.getDisplayName())) fullname="N/A"; 
		try
		{
		EpsosHelperService epsos = EpsosHelperService.getInstance();
		List<ViewResult> lines = epsos.parsePrescriptionDocumentForPrescriptionLines(prescription);
		prescription = epsos.generateDispensationDocumentFromPrescription(prescription, lines, dispensedLines, usr);
		if (sent)
		{
		epsos.uploadDispensationDocument(webservice, prescription, patient,country,usr,language,fullname);
		}
		result=true;
		}
		catch (Exception e)
		{
			throw new CustomException("DISP_ERROR_SUBMIT",e.getMessage());			
		}	
		return result;
	}
	
	private SpiritUserClientDto createTestSpiritUser(String uid,String givenname, String surname, String orgDN, String orgname)
	{
		SpiritUserClientDto spiritUser = new SpiritUserClientDto();
		spiritUser.getUid().add(uid);
		spiritUser.getGivenName().add(givenname);
		spiritUser.getSurname().add(surname);
		SpiritOrganisationClientDto org = new SpiritOrganisationClientDto();
		org.setOrganisationDN(orgDN);
		org.setOrganisationName(orgname);
		spiritUser.setHomeOrganisation(org);
		return spiritUser;
	}
	
	public EhrPatientClientDto createTestPatient(String patid, String givenname)
	{
		EhrPatientClientDto patient = new EhrPatientClientDto();
		EhrPIDClientDto pid = new EhrPIDClientDto();
		pid.setPatientID(patid);
		patient.getPid().add(pid);
		patient.setGivenName(givenname);
		return patient;
	}
	
	@Override
	public boolean writeDispensationDocument(String prescriptionID, SpiritUserClientDto usr, EhrPatientClientDto patient, 
			ViewResult prescribedLine, String dispensedId, String dispensedProduct, boolean isSubstitute, String dispensedQuantity, String country, String language, boolean sent)  throws CustomException 
		{
		
		byte[] bytes = getCDADocument(prescriptionID, patient);
		return writeDispensationDocumentFromEP(bytes,usr,patient,prescribedLine,dispensedId,dispensedProduct,isSubstitute,dispensedQuantity,country,language,sent);		
	}
	
	@Override
	public List<ViewResult> getCDAPrescriptionLinesFromEP(byte[] bytes, EhrPatientClientDto patient) throws CustomException {
		List<ViewResult> lines = null;
		try
		{
		EpsosHelperService epsos = EpsosHelperService.getInstance();
		lines = epsos.parsePrescriptionDocumentForPrescriptionLines(bytes);
		}
		catch (Exception e)
		{
			throw new CustomException("GENEX001",e.getMessage());	
		}
		return lines;
	}
	
	@Override
	public List<ViewResult> getCDAPrescriptionLines(String docID, EhrPatientClientDto patient) throws CustomException {
		byte[] bytes = getCDADocument(docID,patient);
		return getCDAPrescriptionLinesFromEP(bytes,patient);
	}

	@Override
	public List<PolicySetGroup> queryPolicySets(EhrPatientClientDto patient) throws CustomException  {
		List<PolicySetGroup> objGroupList = null;
		try
		{	
		objGroupList = webservice.queryPolicySetsForPatient(patient).getGroupList();
		}
		catch (Exception e)
		{
			throw new CustomException("GENEX001",e.getMessage());
		}
		return objGroupList;
	}

	
	@Override
	public boolean WriteConsentPolicy(EhrPatientClientDto patient, String country,
			String language, String policies, String fromdate, String todate)
			throws CustomException {

		boolean consenCreated = false;
		try
			{
			consenCreated = EpsosHelperService.getInstance().writeConsent(webservice, patient,country,language, policies, fromdate, todate);		
			}
			catch (Exception e)
			{
			throw new CustomException("GENEX001",e.getMessage());
			}
		return consenCreated;
	}

	@Override
	public byte[] getPDFDocument(DocumentClientDto doc,EhrPatientClientDto patient) throws CustomException {

		EpsosHelperService epsos = null;
		epsos = EpsosHelperService.getInstance();
		byte[] byteArray = null;
		try
		{
		byteArray = webservice.retrieveDocument(doc);
		byteArray = epsos.extractPdfPartOfPatientSummaryDocument(byteArray);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new CustomException("GENEX001",e.getMessage());

		}
		return byteArray;
	}

	@Override
	public int Authenticate(long companyid, String username, String password)
			throws CustomException {
		int  auth = 0;
		try {
			auth = UserLocalServiceUtil.authenticateByScreenName(companyid, username, password, null,null);
		} catch (PortalException e) {
			throw new CustomException("GENEX0010",e.getMessage());
		} catch (SystemException e) {
			throw new CustomException("GENEX0020",e.getMessage());
		}
		return auth;
	}
	
	@Override
	public int epsosAuthenticate(String username, String password) throws CustomException {
		int auth=0;
		try {
			auth=Authenticate(95945,username,password);
		} catch (CustomException e) {
			e.printStackTrace();
		}
		return auth;
		}

	@Override
	public boolean sendAuditLocal(EhrPatientClientDto patient, String remoteHost, String screenName, boolean pin) throws CustomException {
		boolean auditSent = false;
		try
		{
		User user = UserLocalServiceUtil.getUserByScreenName(95945, screenName);
	    GregorianCalendar c = new GregorianCalendar();
	    c.setTime(new Date());
	    XMLGregorianCalendar date2 = null;
	    date2 = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
	    String username = user.getScreenName();
	    String emailAddress = user.getEmailAddress();
	    String[] email = emailAddress.split("@");
	    String samlUser = user.getFullName() + "<saml:" + email[0] + "@" + "saml:" + email[1] + ">";
		PsPartyRoleType PHARMACIST = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "pharmacist");
		PsPartyRoleType PHYSICIAN = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "physician");
		PsPartyRoleType NURSE = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "nurse");
		PsPartyRoleType ADMINISTRATOR = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "administrator");
		PartiesService partiesServ = PartiesService.getInstance();
		PaPerson person = partiesServ.getPaPerson(user.getUserId());
	    boolean isPhysician = partiesServ.partyHasRoleType(person.getMainid(), PHYSICIAN.getMainid());
		boolean isPharmacist = partiesServ.partyHasRoleType(person.getMainid(), PHARMACIST.getMainid());
		boolean isNurse = partiesServ.partyHasRoleType(person.getMainid(), NURSE.getMainid());
		boolean isAdministrator = partiesServ.partyHasRoleType(person.getMainid(), ADMINISTRATOR.getMainid());
	    
	    String userRole = "";
	    if (isPhysician) userRole="phycisian";
	    if (isPharmacist) userRole="pharmacist";
	    if (isNurse) userRole="nurse";
	    if (isAdministrator) userRole="admin";
	    
	    AuditService asd = new AuditService();
	    ConfigurationManagerService cms = ConfigurationManagerService.getInstance(); 
		EventLog eventLog1 = null;
		if (pin)
		{

	    eventLog1 = EventLog.createEventLogConsentPINdny(
	    	     TransactionName.epsosConsentServicePin,
	    	     EventActionCode.READ,
	    	     date2,
	    	     EventOutcomeIndicator.FULL_SUCCESS,
	    	     samlUser,"Hospital",
	    	     samlUser, samlUser, userRole,
	    	     samlUser,
	    	     samlUser,
	    	     cms.getProperty("ncp.country"),
	    	     patient.getPid().get(0)+"",
	    	     null,
	    	     new byte[1],
	    	     null,
	    	     new byte[1],
	    	     remoteHost,remoteHost);
		}
		else
		{
		    eventLog1 = EventLog.createEventLogConsentPINdny(
		    	     TransactionName.epsosConsentServicePin,
		    	     EventActionCode.READ,
		    	     date2,
		    	     EventOutcomeIndicator.FULL_SUCCESS,
		    	     samlUser,"Hospital",
		    	     samlUser, samlUser, userRole,
		    	     samlUser,
		    	     samlUser,
		    	     cms.getProperty("ncp.country"),
		    	     patient.getPid().get(0)+"",
		    	     null,
		    	     new byte[1],
		    	     null,
		    	     new byte[1],
		    	     remoteHost,remoteHost);
		}
       eventLog1.setEventType(EventType.epsosConsentServicePin);
       asd.write(eventLog1, "13", "2");
       auditSent = true;
		   } catch (DatatypeConfigurationException e) {
			   _log.error(e.getMessage());
				throw new CustomException("DATE_CONVERSION_ERROR","");
		} catch (PortalException e) {
			throw new CustomException("USER_NOT_FOUND","");
		} catch (SystemException e) {
			throw new CustomException("USER_NOT_FOUND","");
		} 
       return auditSent;
	}
	
	@Override
	public boolean sendAudit(EhrPatientClientDto patient, String screenName, boolean pin) throws CustomException {
		MessageContext mc = wsc.getMessageContext();  
		HttpServletRequest req = (HttpServletRequest) mc.get(MessageContext.SERVLET_REQUEST);
		String remoteHost = req.getRemoteAddr();
		return sendAuditLocal(patient, remoteHost, screenName, pin);
	}
	
	@Override
	public byte[] getConsentReport(String lang2, String fullname, EhrPatientClientDto patient) throws CustomException
	{
		byte[] bytes = null;
		try
		{
		String language="";
		String country = patient.getCountry();
		String langFromCountry = LocaleUtils.languagesByCountry(country).get(0)+"";
		String patientLang = patient.getLanguage();
		if (Validator.isNotNull(patientLang)) language=patientLang;
		if (Validator.isNull(language)) language=langFromCountry;
		if (Validator.isNull(language)) language="en_GB";
		String language2 = lang2;
		_log.info("LANGUAGE=" + language + "-" + lang2);
		Map parameters = new HashMap();
		parameters.put("IS_IGNORE_PAGINATION", new Boolean(false));		
		XMLGregorianCalendar xgc = patient.getBirthdate();
		Date  newDate = xgc.toGregorianCalendar().getTime();
		parameters.put("givenname", patient.getGivenName());
		parameters.put("givenname_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.givenname", language));
		parameters.put("givenname_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.givenname", language2));
		parameters.put("familyname", patient.getFamilyName());
		parameters.put("familyname_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.surname", language));
		parameters.put("familyname_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.surname", language2));
		parameters.put("streetaddress", patient.getStreetAddress());
		parameters.put("streetaddress_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.street.address", language));
		parameters.put("streetaddress_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.street.address", language2));
		parameters.put("zipcode", patient.getZip());
		parameters.put("zipcode_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.code", language));
		parameters.put("zipcode_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.code", language2));
		parameters.put("city", patient.getCity());
		parameters.put("city_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.city", language));
		parameters.put("city_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.city", language2));
		parameters.put("country", patient.getCountry());
		parameters.put("country_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.country", language));
		parameters.put("country_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.country", language2));
		parameters.put("birthdate", DateUtils.format(newDate,"yyyy-MM-dd"));
		parameters.put("birthdate_label_lang1", EpsosHelperService.getPortalTranslation("patient.data.birth.date", language));
		parameters.put("birthdate_label_lang2", EpsosHelperService.getPortalTranslation("patient.data.birth.date", language2));
		String consentText = EpsosHelperService.getConsentText(language);
		String consentText2 = EpsosHelperService.getConsentText(language2);
		parameters.put("consent_text", consentText);
		parameters.put("consent_text_2", consentText2);
		parameters.put("printedby", fullname);
		parameters.put("lang1", language);
		parameters.put("lang2", language2);
		parameters.put("date", DateUtils.format(new Date(),"yyyy-MM-dd"));
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
	    URL url = cl.getResource("com/ext/portlet/epsos/report/epsosConsent.jasper");
	    String path = url.getPath();
	    _log.info("PATH IS " + path);
		bytes = EpsosHelperService.getInstance().printReport(path, "Consent Report", parameters);
		}
		catch (Exception e)
		{
			throw new CustomException("ERROR_PIN_CREATION","Error creating pin document. " + e.getMessage());
		}
		return bytes;
	}
	
	
	private static Logger _log = Logger.getLogger("EPSOSLOG");
}