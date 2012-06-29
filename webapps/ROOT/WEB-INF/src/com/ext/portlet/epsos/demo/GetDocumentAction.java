package com.ext.portlet.epsos.demo;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.ActionConstants;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.ActionResponseImpl;
import com.liferay.util.servlet.ServletResponseUtil;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class GetDocumentAction extends PortletAction {

	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res)
		throws Exception {

		EhrPatientClientDto patient = null;
		EpsosHelperService epsos = null; 
		SpiritUserClientDto usr = null;
		try {
			byte[] byteArray = null;
			String contentType = null;
			String fileName = "epsos_doc";
			
			epsos = EpsosHelperService.getInstance(); 
			usr = epsos.getEpsosUserInformation(req);

			SpiritEhrWsClientInterface webservice = epsos.getWebService(req);
			
			String docID = req.getParameter("docID");
			String docType = req.getParameter("docType");
			boolean extractPDF = GetterUtil.getBoolean(req.getParameter("extractPDF"), false);
			List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)CommonUtil.getHttpServletRequest(req).getSession().getAttribute("patientDocuments");
			DocumentClientDto doc = patientDocuments.get(Integer.parseInt(docID));		
			patient = epsos.getPatientFromRequest(req);
			EpsosHelperService.getInstance().createLog("Starting the retrieval of the document ..... :" + patient.getGivenName(),usr);
			if (patient!=null)
			{
				XdsQArgsDocument argDoc = new XdsQArgsDocument();
				XdsQArgsDocument qArgs = new XdsQArgsDocument();
				if (docType.equals("ep"))
				{
					qArgs=EpsosHelperService.getInstance().getArgsForEP();
				}
				if (docType.equals("dp"))
				{
					qArgs=EpsosHelperService.getInstance().getArgsForDP();
				}
				if (docType.equals("ps"))
				{
					qArgs=EpsosHelperService.getInstance().getArgsForPS();
				}
				if (docType.equals("consent"))
				{
					qArgs=EpsosHelperService.getInstance().getArgsForC();
				}
				PatientContentClientDto result = webservice.queryDocuments(patient.getPid(), qArgs);

//				if (result != null && result.getDocuments() != null)
//				{	
//					for (DocumentClientDto doc: result.getDocuments())
//					{
						//if (!extractPDF && doc.getUniqueId().equals(docID))
						if (!extractPDF && !doc.getFormatCode().getNodeRepresentation().contains("pdf"))
						{
							EpsosHelperService.getInstance().createLog("RETRIEVE DOC, REQUEST. PATIENT:" + patient.getGivenName(),usr);
							byteArray = webservice.retrieveDocument(doc);
							EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE OK. PATIENT:" + patient.getGivenName(),usr);
							contentType = doc.getMimeType();
							fileName = doc.getName()+"."+contentType.substring(contentType.lastIndexOf('/')+1);
						}
						else if ((extractPDF && doc.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008")) )
						{
							EpsosHelperService.getInstance().createLog("RETRIEVE DOC, REQUEST. PATIENT:" + patient.getGivenName(),usr);
							byteArray = webservice.retrieveDocument(doc);
							EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE OK. PATIENT:" + patient.getGivenName(),usr);
							contentType = "application/pdf";
							fileName = doc.getName()+"."+contentType.substring(contentType.lastIndexOf('/')+1);
						}
						else if (extractPDF)
						{
							List<DocumentClientDto> childDocs = doc.getChildDocuments();
							if (childDocs != null && childDocs.size() > 0) {
								for (DocumentClientDto childDoc: childDocs)
								{
									if (childDoc.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008"))
									{
										EpsosHelperService.getInstance().createLog("RETRIEVE DOC, REQUEST. PATIENT:" + patient.getGivenName(),usr);
										byteArray = webservice.retrieveDocument(childDoc);
										EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE OK. PATIENT:" + patient.getGivenName(),usr);
										contentType = "application/pdf";
										fileName = childDoc.getName()+"."+contentType.substring(contentType.lastIndexOf('/')+1);
										break;
									}
								}
							}
						}
						
						
					}
//				}
//			}
			
			if (extractPDF)
			{
				// the byte-array is an XML document. Need to parse it and find the uuencoded binary pdf part in it
				EpsosHelperService.getInstance().createLog("RETRIEVE PDF, REQUEST. PATIENT:" + patient.getGivenName(),usr);				
				byteArray = epsos.extractPdfPartOfPatientSummaryDocument(byteArray);
				EpsosHelperService.getInstance().createLog("Retrieving ..... :" + patient.getGivenName(),usr);
				EpsosHelperService.getInstance().createLog("RETRIEVE PDF, RESPONSE OK. PATIENT:" + patient.getGivenName(),usr);
				
			}
			
			HttpServletResponse httpRes =
				((ActionResponseImpl)res).getHttpServletResponse();

			if (byteArray != null && contentType != null)
			{
			
				httpRes.setContentType(contentType);
				httpRes.setHeader("Content-Disposition","inline; filename=" + fileName);  
				ServletResponseUtil.write(CommonUtil.getHttpServletResponse(res), byteArray);
				//ServletResponseUtil.sendFile(CommonUtil.getHttpServletRequest(req), httpRes, fileName, byteArray, contentType);			
			//	setForward(req, ActionConstants.COMMON_NULL);
				
			}
			else
				{
				req.setAttribute("exception", "The document is empty");
				setForward(req, "common.failure");
				}
		}
		catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			User user = PortalUtil.getUser(req);
			EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			req.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			setForward(req, "common.failure");
			}
			
			
			EpsosHelperService.getInstance().createLog("RETRIEVE DOC, RESPONSE. ERROR: " + e.getMessage() + ",PATIENT:" + patient.getGivenName(),usr);
			System.err.println("document download error: " + e.getMessage());
			req.setAttribute("exception", e.getMessage());
			setForward(req, "common.failure");
		}
	}



}