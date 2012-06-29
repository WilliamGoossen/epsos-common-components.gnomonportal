package com.ext.portlet.epsos.demo;

import gnomon.util.GnPropsUtil;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ViewPatientPrescriptionsAction extends PortletAction {


	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
	{
		EpsosHelperService epsos = null; 
		SpiritUserClientDto usr = null;
		EhrPatientClientDto patient = null;
		SpiritEhrWsClientInterface webservice = null;
		try {
			epsos = EpsosHelperService.getInstance(); 
			usr = epsos.getEpsosUserInformation(request);
			webservice = epsos.getWebService(request);
			
			
			patient = EpsosHelperService.getInstance().getPatientFromRequest(request);
			
			if (patient!=null)
			{
				epsos.generatePatientTitleData(request, patient);
				
				PatientContentClientDto result = null; 
				XdsQArgsDocument qArgs = new XdsQArgsDocument();
				qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");			
				qArgs=EpsosHelperService.getInstance().getArgsForEP();

				EpsosHelperService.getInstance().createLog("EP DOCS QUERY, REQUEST. PATIENT:" + patient.getGivenName(),usr);
				result = webservice.queryDocuments(patient.getPid(), qArgs);
				EpsosHelperService.getInstance().createLog("EP DOCS QUERY, RESPONSE OK. PATIENT:" + patient.getGivenName() + ". Found " + result.getDocuments().size() + " ep docs",usr);
				
				if (result != null && result.getDocuments() != null)
				{
					List<DocumentClientDto> docs =  result.getDocuments();
					ArrayList<DocumentClientDto> filteredDocs = new ArrayList<DocumentClientDto>();
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
					
					request.setAttribute("prescriptionDocuments", filteredDocs);
				}
				
// 				also look for dispensation documents
//				qArgs = new XdsQArgsDocument();
//				qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");
//				if (!useLocalDocument)
//				{
//					// dispenstation documents have class code (LOINC DISPN-X^^2.16.840.1.113883.6.1) 
//					qArgs=EpsosHelperService.getInstance().getArgsForDP();
//				}
//				EpsosHelperService.getInstance().createLog("EDISP DOCS QUERY, REQUEST. PATIENT:" + patient.getGivenName(),usr);
//				result = webservice.queryDocuments(patient.getPid(), qArgs);
//				EpsosHelperService.getInstance().createLog("EDISP DOCS QUERY, RESPONSE OK. PATIENT:" + patient.getGivenName() + ". Found " + result.getDocuments().size() + " ed docs",usr);
//				if (result != null && result.getDocuments() != null)
//				{
//					List<DocumentClientDto> docs =  result.getDocuments();
//					ArrayList<DocumentClientDto> filteredDocs = new ArrayList<DocumentClientDto>();
//					if (docs != null)
//					{
//						for (DocumentClientDto d: docs)
//						{
//							if (d.getMimeType().equals("text/xml"))
//								filteredDocs.add(d);
//						}
//					}
//					
//					request.setAttribute("dispensationDocuments", filteredDocs);
//				}
			}
			
			return mapping.findForward("common.success");
		} catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			User user = PortalUtil.getUser(request);
			EpsosHelperService.getInstance().createLog("DOCS QUERY RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			request.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			return mapping.findForward("common.failure");
			}
			
			EpsosHelperService.getInstance().createLog("DOCS QUERY, RESPONSE ERROR. PATIENT:" + patient.getGivenName() + ",ERROR: " + e.getMessage(),usr);
			e.printStackTrace();
			//request.setAttribute("exception", e.getMessage());
			String fwd = "common.failure";
			if (e.getMessage().contains("4701"))
			{
				request.setAttribute("exception", LanguageUtil.get(PortalUtil.getCompanyId(request), PortalUtil.getLocale(request), "error.4701"));
				if (patient!=null)
				{
					epsos.generatePatientTitleData(request, patient);
					try {
						epsos.createLog("CONSENT QUERY, REQUEST. PATIENT:" + patient.getGivenName(),usr);
						List<PolicySetGroup> objGroupList = webservice.queryPolicySetsForPatient(patient).getGroupList();
						epsos.createLog("CONSENT QUERY, RESPONSE. PATIENT:" + patient.getGivenName(),usr);
						request.setAttribute("objGroupList", objGroupList);
						request.setAttribute("docType", "consent");
						request.setAttribute("redirect", "currentURL");
						fwd="create.consent";
					} catch (Exception e1)
					{
						e1.printStackTrace();
					}
				}
				
			}
			if (e.getMessage().contains("1002"))
			{
				request.setAttribute("exception", LanguageUtil.get(PortalUtil.getCompanyId(request), PortalUtil.getLocale(request), "error.1002"));
				if (patient!=null)
				{
					epsos.generatePatientTitleData(request, patient);
					try {
						request.setAttribute("redirect", "currentURL");
						fwd="confirmation";
					} catch (Exception e1)
					{
						e1.printStackTrace();
					}
				}
				
			}
			else
			{
				request.setAttribute("exception", LanguageUtil.get(PortalUtil.getCompanyId(request), PortalUtil.getLocale(request), e.getMessage()));
				if (patient!=null)
				{
					epsos.generatePatientTitleData(request, patient);
					try {
						request.setAttribute("redirect", "currentURL");
					} catch (Exception e1)
					{
						e1.printStackTrace();
					}
				}
			}
			return mapping.findForward(fwd);
		}
	}

}
