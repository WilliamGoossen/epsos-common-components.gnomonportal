package com.ext.portlet.epsos.demo;

import epsos.ccd.gnomon.auditmanager.AuditService;
import epsos.ccd.gnomon.auditmanager.EventActionCode;
import epsos.ccd.gnomon.auditmanager.EventLog;
import epsos.ccd.gnomon.auditmanager.EventOutcomeIndicator;
import epsos.ccd.gnomon.auditmanager.EventType;
import epsos.ccd.gnomon.auditmanager.TransactionName;
import epsos.ccd.gnomon.configmanager.ConfigurationManagerService;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.PartiesService;
import gnomon.hibernate.model.parties.PaPerson;
import gnomon.hibernate.model.parties.PsPartyRoleType;
import gnomon.util.GnPropsUtil;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.opensaml.saml2.core.Assertion;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.consent.PatientConsentObject;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.util.CommonUtil;
import com.ext.util.TitleData;
import com.liferay.portal.action.LoginAction;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.ActionResponseImpl;
import com.liferay.util.Http;
import com.liferay.util.HttpUtil;
import com.liferay.util.servlet.SessionMessages;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.PolicySetItem;
import com.spirit.ehr.ws.client.generated.PolicySetTemplate;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class CheckPatientAccessAction extends PortletAction {

	private static Logger _log = Logger.getLogger("EPSOSLOG");
	
	public void sendAudit(HttpServletRequest req, String patiendID, User user, boolean pin)
	{
	       GregorianCalendar c = new GregorianCalendar();
	        c.setTime(new Date());
	        XMLGregorianCalendar date2 = null;
	        try {
	            date2 = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
	        } catch (DatatypeConfigurationException ex) {

	        }

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
	        /*
	         *    public static EventLog createEventLogConsentPINack(TransactionName EI_TransactionName, 
		   EventActionCode EI_EventActionCode, 
		   XMLGregorianCalendar EI_EventDateTime, EventOutcomeIndicator EI_EventOutcomeIndicator,
           String PC_UserID,String PC_RoleID,
           String HR_UserID, String HR_AlternativeUserID,String HR_RoleID,
           String SC_UserID,String SP_UserID, 
           String AS_AuditSourceId,
           String PS_PatricipantObjectID,
           String ReqM_ParticipantObjectID,
           byte[] ReqM_PatricipantObjectDetail,
           String ResM_ParticipantObjectID,
           byte[] ResM_PatricipantObjectDetail,
           String sourceip,
           String targetip)
	         * 
	         */
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
	    	     patiendID,
	    	     null,
	    	     new byte[1],
	    	     null,
	    	     new byte[1],
	    	     req.getRemoteHost(),req.getRemoteHost());
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
		    	     patiendID,
		    	     null,
		    	     new byte[1],
		    	     null,
		    	     new byte[1],
		    	     req.getRemoteHost(),req.getRemoteHost());
		}
       eventLog1.setEventType(EventType.epsosConsentServicePin);
       asd.write(eventLog1, "13", "2");
	}
	
	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res)
	throws Exception {

		try {
			String patID = req.getParameter("patID");
			String patIDType = ParamUtil.getString(req,"patIDType");
			String docIDType = req.getParameter("docType");
			String patids = ParamUtil.getString(req,"patids");
			String country = req.getParameter("country");	
			String purpose = GetterUtil.get(req.getParameter("purpose"),"TREATMENT");
			String pin = ParamUtil.getString(req,"PIN");
			String forwardAction = req.getParameter("forwardAction");
			String redirect = req.getParameter("redirect");
			String accessAction = req.getParameter("accessAction");			
			String reason = ParamUtil.getString(req, "reason", "");
			
			
			
			EpsosHelperService epsos = EpsosHelperService.getInstance();
			SpiritUserClientDto usr = epsos.getEpsosUserInformation(req);
			SpiritEhrWsClientInterface webservice = epsos.getWebService(req);
			EhrPatientClientDto patient = null;
			patient = EpsosHelperService.getInstance().getPatientFromRequest(req);
			boolean hasPin = false;
		

			User user = PortalUtil.getUser(req);
			if (patient!=null)
			{			
				TitleData titleData = epsos.generatePatientTitleData(req, patient);
				
		
				
				
				if (accessAction != null)
				{

					if (accessAction.equals("checkConfirmation"))
					{
						accessAction = "checkConsent";
						setForward(req, "confirmation");
						return;
					}
					
					if (accessAction.equals("createConfirmation"))
					{
						if (pin.equals("yes")) hasPin=true;
						if (pin.equals("no")) hasPin=false;
						EpsosHelperImpl eh = new EpsosHelperImpl();
						eh.sendAuditLocal(patient, CommonUtil.getHttpServletRequest(req).getRemoteHost(), user.getScreenName(), hasPin);
						if (!hasPin)
						{
							String exceptionPIN=LanguageUtil.get(PortalUtil.getCompanyId(req), PortalUtil.getLocale(CommonUtil.getHttpServletRequest(req)), "error.PIN");
							EpsosHelperService.getInstance().createLog("PIN DOCUMENT DENY:" + patient.getGivenName(),usr);
							req.setAttribute("confirmationFailure", "true");
							req.setAttribute("exception", exceptionPIN);
							setForward(req, "confirmation");
							return;
						}
						EpsosHelperService.getInstance().createLog("CREATE PATIENT CONFIRMATION REQUEST:" + patient.getGivenName(),usr);
						boolean success = epsos.createPatientConfirmation(CommonUtil.getHttpServletRequest(req), patient);
						
						if (success)
						{
							accessAction = "checkConsent";
						}
						else
						{
							EpsosHelperService.getInstance().createLog("CREATE PATIENT CONFIRMATION FAILURE:" + patient.getGivenName(),usr);
							req.setAttribute("confirmationFailure", "true");
							setForward(req, "confirmation");
							return;
						}
					} 
					
					if (accessAction.equals("createConsent"))
					{
						boolean createNewConsent = GetterUtil.getBoolean(req.getParameter("createNewConsent"), true);
						if (reason.equals("consent"))
						{
						Assertion idAs = (Assertion)CommonUtil.getHttpServletRequest(req).getSession().getAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTION);
						usr = EpsosHelperService.getInstance().createPatientConfirmationPlain(usr, purpose, webservice, idAs, patient);
				    	usr.setDisplayName(user.getFullName());
						CommonUtil.getHttpServletRequest(req).getSession().setAttribute(LoginAction.EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr);
						}
						PatientConsentObject result = new PatientConsentObject();
						String address = "";
						if (usr.getPostalAddress() != null)
						{
							for (String a: usr.getPostalAddress())
							{
								address += a + " ";
							}
						}					
						PatientConsentObject successObject = null;
						boolean consentCreated=false;
						if (createNewConsent)
						{
							consentCreated = epsos.addPatientConsent(result, patient, CommonUtil.getHttpServletRequest(req));
						}
						
						if (consentCreated)
						{
							if (accessAction.equals("createConsent") && Validator.isNull(ParamUtil.getString(req,"redirect")))
							{
								SessionMessages.add(req, "request_processed");
								setForward(req, "consentCreated");
								return;
							}
							if (Validator.isNotNull(ParamUtil.getString(req,"redirect")))
								sendRedirect(req,res);
							else
							{
								SessionMessages.add(req, "request_processed");
								setForward(req, forwardAction+"?patID="+patID+"&country="+country+ "&patIDType="+patIDType+ "&docType=" +docIDType + "&forwardAction=" +forwardAction + "&patids=" + patids + "&redirect="+HttpUtil.encodeURL(redirect));
								return;
							}
						}
						else
						{
							req.setAttribute("consentFailure", "true");
							titleData.put("epsos.consent.doctor.name", usr.getDisplayName());
							titleData.put("epsos.consent.doctor.address", address);
							String countryOfOrganization  = epsos.getHomeOrganizationCountry(usr);
							req.setAttribute("countryOfOrganization", countryOfOrganization);
							List<PolicySetGroup> objGroupList = webservice.queryPolicySetsForPatient(patient).getGroupList();																
							req.setAttribute("objGroupList", objGroupList);
							setForward(req, "consent");
							return;
						}
					}

				}
			}
			
			setForward(req, forwardAction+"?patID="+patID+"&country="+country+ "&patIDType="+patIDType+ "&forwardAction=" +forwardAction + "&docType=" +docIDType +"&redirect="+HttpUtil.encodeURL(redirect));
		}
		catch (Exception e) {
			req.setAttribute("exception", e.getMessage());
			e.printStackTrace();
			setForward(req, "common.failure");
			
		}
	}
}
