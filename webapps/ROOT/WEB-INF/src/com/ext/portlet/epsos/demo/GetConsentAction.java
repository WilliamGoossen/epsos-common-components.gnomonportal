package com.ext.portlet.epsos.demo;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.LocaleUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.ActionConstants;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.ActionResponseImpl;
import com.liferay.util.servlet.ServletResponseUtil;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class GetConsentAction extends PortletAction {

	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res)
		throws Exception {

		EhrPatientClientDto patient = EpsosHelperService.getInstance().getPatientFromRequest(req);;
		EpsosHelperService epsos = EpsosHelperService.getInstance();; 
		SpiritUserClientDto usr = epsos.getEpsosUserInformation(req);;
		User user = PortalUtil.getUser(req);
		ActionRequestImpl reqImpl = (ActionRequestImpl)req;
	    HttpServletRequest treq = reqImpl.getHttpServletRequest();
		ActionResponseImpl resImpl = (ActionResponseImpl)res;
		HttpServletResponse tres = resImpl.getHttpServletResponse();
		try {
			ClassLoader cl = Thread.currentThread().getContextClassLoader();
	        URL url = cl.getResource("com/ext/portlet/epsos/report/epsosConsent.jasper");
			String path = CommonUtil.getRootPath(treq)+ "/WEB-INF/classes/" + "com/ext/portlet/epsos/report/" + "epsosConsent.jasper";
			EpsosHelperImpl impl = new EpsosHelperImpl();
			EpsosHelperService.getInstance().createLog("PATH IS : " + path,usr);
			byte[] consentbytes = impl.getConsentReport(user.getLanguageId(), user.getFullName(), patient);
			
			HttpServletResponse httpRes =
				((ActionResponseImpl)res).getHttpServletResponse();
			String contentType="application/pdf";
			String filename = user.getScreenName() + "_" + patient.getGivenName() + ".pdf";
			if (consentbytes != null)
			{
				httpRes.setContentType(contentType);
				httpRes.setHeader("Content-Disposition","inline; filename=" + filename);  
				ServletResponseUtil.write(CommonUtil.getHttpServletResponse(res), consentbytes);			
			}
			else
				{
				req.setAttribute("exception", "The document is empty");
				setForward(req, "common.failure");
				}
		}
		catch (Exception e) {
			EpsosHelperService.getInstance().createLog("RETRIEVE CONSENT, RESPONSE. ERROR: " + e.getMessage() + ",PATIENT:" + patient.getGivenName(),usr);
			System.err.println("document download error: " + e.getMessage());
			e.printStackTrace();
			req.setAttribute("exception", e.getMessage());
			setForward(req, "common.failure");
		}
	}



}