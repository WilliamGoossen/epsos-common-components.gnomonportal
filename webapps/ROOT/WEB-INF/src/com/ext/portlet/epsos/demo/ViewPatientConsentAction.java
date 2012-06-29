package com.ext.portlet.epsos.demo;

import gnomon.business.GeneralUtils;
import gnomon.business.StringUtils;
import gnomon.hibernate.model.ConnectionFactory;
import gnomon.util.GnPropsUtil;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.datatype.XMLGregorianCalendar;

import net.sf.jasperreports.engine.JasperRunManager;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.tools.ant.util.DateUtils;
import org.hibernate.Session;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.ActionResponseImpl;
import com.liferay.util.servlet.ServletResponseUtil;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ViewPatientConsentAction extends PortletAction {

	
	private static Logger _log = Logger.getLogger("EPSOSLOG");
	
	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res)
	throws Exception {

		EpsosHelperService epsos = null;
		SpiritUserClientDto usr = null;
		EhrPatientClientDto patient = null;
		User user = PortalUtil.getUser(req);
		String reason = ParamUtil.getString(req, "reason", "");
		try {
			String action = ParamUtil.getString(req, "action");
			EpsosHelperImpl impl = new EpsosHelperImpl();
			epsos = EpsosHelperService.getInstance();
			usr = epsos.getEpsosUserInformation(req);
			SpiritEhrWsClientInterface webservice = epsos.getWebService(req);
			EhrPatientClientDto result = null;
			result = EpsosHelperService.getInstance().getPatientFromRequest(req);
			patient = result;
			if (patient!=null)
			{
				epsos.generatePatientTitleData(req, patient);

				EpsosHelperService.getInstance().createLog("CONSENT QUERY, REQUEST. PATIENT:" + patient.getGivenName(),usr);			
				List<PolicySetGroup> objGroupList = webservice.queryPolicySetsForPatient(patient).getGroupList();
				EpsosHelperService.getInstance().createLog("CONSENT QUERY, RESPONSE. PATIENT:" + patient.getGivenName(),usr);
				req.setAttribute("objGroupList", objGroupList);
				req.setAttribute("docType", "consent");
				req.setAttribute("reason", reason);
				setForward(req, "common.success");
				setForward(req, "common.success");

			}
			else
				
				setForward(req, "common.failure");
			
		}
		catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			
			EpsosHelperService.getInstance().createLog("CONSENT QUERY, RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			req.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			setForward(req, "common.failure");
			}
			
			setForward(req, "common.failure");
			EpsosHelperService.getInstance().createLog("CONSENT QUERY, RESPONSE ERROR. PATIENT:,ERROR:" + e.getMessage(),usr);
			req.setAttribute("exceptionMessage",e.getLocalizedMessage());
		}
	}
}
