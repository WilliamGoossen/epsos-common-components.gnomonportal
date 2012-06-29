package com.ext.portlet.epsos.demo;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ViewPatientDocumentsAction extends PortletAction {


	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
	{
		IheClassificationClientDto classC = null;
		SpiritUserClientDto usr = null;
		EhrPatientClientDto patient = null;
		EpsosHelperService epsos = EpsosHelperService.getInstance();
		SpiritEhrWsClientInterface webservice = null;
		
		try {
			usr = epsos.getEpsosUserInformation(request);
			webservice = epsos.getWebService(request);
						
			patient = EpsosHelperService.getInstance().getPatientFromRequest(request);
			if (patient!=null)
			{
				epsos.generatePatientTitleData(request, patient);
				
				PatientContentClientDto result = null; 
				XdsQArgsDocument qArgs = new XdsQArgsDocument();
			
				// FOR TESTING PURPOSES
				boolean useLocalDocument = false; //GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.use.default.local.document.example"), false);
				if (!useLocalDocument)
				{
				qArgs=EpsosHelperService.getInstance().getArgsForPS();					
				}
				String formatCode="";
				EpsosHelperService.getInstance().createLog("PS DOCS QUERY, REQUEST" + " PATIENT:" + patient.getGivenName() ,usr);
				result = webservice.queryDocuments(patient.getPid(), qArgs);
				EpsosHelperService.getInstance().createLog("PS DOCS QUERY, RESPONSE OK. PATIENT:" + patient.getGivenName(),usr);
				if (result != null && result.getDocuments() != null)
				{
					List<DocumentClientDto> docs =  result.getDocuments();
					ArrayList<DocumentClientDto> filteredDocs = new ArrayList<DocumentClientDto>();
					if (docs != null && docs.size() > 0)
					{
						for (DocumentClientDto d: docs)
						{
							formatCode=d.getFormatCode().getNodeRepresentation();
							if ( formatCode.equals("urn:epSOS:ps:ps:2010") || formatCode.equals("urn:ihe:iti:xds-sd:pdf:2008"))
							//if (d.getMimeType().equals("text/xml") || d.getMimeType().equals("application/pdf"))
							{
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
					else
					{
						// used just once to upload valid sample documents on a patient id
						//epsos.uploadPHRDocument(webservice, "E:\\j2ee\\apps3.4\\gi9-eservices\\webapps\\ROOT\\FILESYSTEM\\95945\\epsos\\HUVR_PatientSummarySample_stable_v10August.xml", patient, usr, CommonUtil.getHttpServletRequest(request), true);
						//epsos.uploadPHRDocument(webservice, "E:\\j2ee\\apps3.4\\gi9-eservices\\webapps\\ROOT\\FILESYSTEM\\95945\\epsos\\PHRExtract.pdf", patient, usr, CommonUtil.getHttpServletRequest(request), false);
						
					}
					request.setAttribute("patientDocuments", filteredDocs);
					//epsos.uploadPrescriptionDocument(webservice, "E:\\j2ee\\apps3.4\\gi9-eservices\\webapps\\ROOT\\FILESYSTEM\\95945\\epsos\\HUVR_ePrescription_Representative_Data.xml", patient, usr, CommonUtil.getHttpServletRequest(request));
				}
			}
			String fwd = "common.success";
			return mapping.findForward(fwd);
		} catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			User user = PortalUtil.getUser(request);
			EpsosHelperService.getInstance().createLog("PS DOCS QUERY, RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			request.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			return mapping.findForward("common.failure");
			}
			
			EpsosHelperService.getInstance().createLog("PS DOCS QUERY, RESPONSE ERROR. PATIENT:" + patient.getGivenName() + e.getMessage(),usr);
			
			e.printStackTrace();
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
			else
				
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
