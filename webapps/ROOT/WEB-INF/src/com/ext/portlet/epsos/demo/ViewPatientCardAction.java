package com.ext.portlet.epsos.demo;

import gnomon.util.GnPropsUtil;

import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ViewPatientCardAction extends PortletAction {


	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
	{
		
		EhrPatientClientDto patient = null;
		EpsosHelperService epsos = null; 
		SpiritUserClientDto usr = null;
		try {
			epsos = EpsosHelperService.getInstance(); 
			usr = epsos.getEpsosUserInformation(request);
			EhrPatientClientDto result = null;
			result = epsos.getPatientFromRequest(request);
			request.setAttribute("patient", result);
			
			return mapping.findForward("common.success");
		} catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			User user = PortalUtil.getUser(request);
			EpsosHelperService.getInstance().createLog("PATIENT CARD, RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			request.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			setForward(request, "common.failure");
			}
			
			request.setAttribute("exception", e.getMessage());
			return mapping.findForward("common.failure");
		}
	}

}
