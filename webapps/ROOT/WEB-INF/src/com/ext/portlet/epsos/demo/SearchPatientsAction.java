package com.ext.portlet.epsos.demo;

import gnomon.business.XMLUtilities;
import gnomon.util.GnPropsUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.portlet.parties.events.EventsService;
import com.ext.util.CommonUtil;
import com.liferay.portal.events.EventsProcessor;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.CookieKeys;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.PropsUtil;
import com.spirit.ehr.ws.client.generated.EhrDomainClientDto;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class SearchPatientsAction extends PortletAction {


	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
	{
		try {
			CommonUtil.getHttpServletRequest(request).getSession().setAttribute("patients", new ArrayList<EhrPatientClientDto>());
			CommonUtil.getHttpServletRequest(request).getSession().setAttribute("patientDocuments", null);
			// CommonUtil.getHttpServletRequest(request).getSession().setAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTIONID, null);
			PatientSearchForm searchForm = (PatientSearchForm)form;
			User user = PortalUtil.getUser(request);
			searchForm.prepareFormFields(request);
			
			EpsosHelperService epsosHelper = EpsosHelperService.getInstance();
			SpiritUserClientDto usr = epsosHelper.getEpsosUserInformation(request);
			String search  = request.getParameter("search");
			String choiceMade = request.getParameter("choiceMade");
			
			if (Validator.isNull(choiceMade) || choiceMade.equals("false")){
				// 	do nothing, just show the flags
				searchForm.clearForm();
				request.setAttribute("PatientSearchForm", searchForm);

			}
			else if (Validator.isNotNull(search) && search.equals("true") && usr != null)
			{
				// do search here
				EhrPatientClientDto patFilter = EpsosHelperService.getInstance().createPatFilter(searchForm);
					
				SpiritEhrWsClientInterface webservice = EpsosHelperService.getInstance().getWebService(request);
				try {
					EpsosHelperService.getInstance().createLog("PatientIdentificationService REQUEST for country: " + patFilter.getCountry(),usr);				
					List<EhrPatientClientDto> result = webservice.queryPatients(patFilter);
					EpsosHelperService.getInstance().createLog("PatientIdentificationService RESPONSE: Found " + result.size() + " patients",usr);
					request.setAttribute("patientsList", result);
				} catch (Exception e) {
					if (e.getMessage().contains("LOGIN_REQUIRED"))
					{
					EpsosHelperService.getInstance().createLog("PatientIdentificationService RESPONSE ERROR: " + e.getMessage(),usr);
					String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
					String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
					request.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
					return mapping.findForward("common.failure");
					}
					request.setAttribute("patientsList", new ArrayList<EhrPatientClientDto>());
					EpsosHelperService.getInstance().createLog("PatientIdentificationService RESPONSE ERROR: " + e.getMessage(),usr);
					request.setAttribute("exception", e.getMessage());
					return mapping.findForward("common.failure");
					
				}
			}
			else
			{
				searchForm.clearForm();
			}
			
			return mapping.findForward("common.success");
			
		} catch (Exception e) {
			request.setAttribute("exception", e.getMessage());
			return mapping.findForward("common.failure");
		}
	}

}
