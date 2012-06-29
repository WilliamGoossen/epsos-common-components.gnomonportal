package com.ext.portlet.epsos.demo;

import gnomon.business.GeneralUtils;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.PartiesService;
import gnomon.hibernate.model.parties.PaPerson;
import gnomon.hibernate.model.parties.PsPartyRoleType;
import gnomon.util.GnPropsUtil;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.allcolor.yahp.converter.CYaHPConverter;
import org.allcolor.yahp.converter.IHtmlToPdfTransformer;
import org.apache.fop.apps.Driver;
import org.apache.fop.apps.XSLTInputHandler;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.helpers.XMLReaderFactory;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.portlet.LiferayWindowState;
import com.liferay.portal.kernel.util.ByteArrayMaker;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.PortletURLImpl;
import com.liferay.util.servlet.SessionErrors;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class XslTransformDocumentAction extends PortletAction {

	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res)
		throws Exception {

		try {
			byte[] byteArray = null;
			
			EpsosHelperService epsos = EpsosHelperService.getInstance(); 
			SpiritUserClientDto usr = epsos.getEpsosUserInformation(req);
			SpiritEhrWsClientInterface webservice = epsos.getWebService(req);
			
			String docID = req.getParameter("docID");
			String docType = req.getParameter("docType");
			List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)CommonUtil.getHttpServletRequest(req).getSession().getAttribute("patientDocuments");
			DocumentClientDto doc = patientDocuments.get(Integer.parseInt(docID));		

			
			EhrPatientClientDto patient = null;
			patient = EpsosHelperService.getInstance().getPatientFromRequest(req);

			
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
				
//				PatientContentClientDto result = webservice.queryDocuments(patient.getPid(), qArgs);
//				//PatientContentClientDto result = webservice.queryDocuments(list);
//
//				if (result != null && result.getDocuments() != null)
//				{	
//					for (DocumentClientDto doc: result.getDocuments())					
//					{
						System.out.println(doc.getUniqueId() + " --- " + doc.getHomeCommunityId());
						if (doc.getFormatCode().getNodeRepresentation().equals("urn:epSOS:ps:ps:2010"))
						{
							byteArray = webservice.retrieveDocument(doc);
							
						}
						if (doc.getFormatCode().getNodeRepresentation().equals("urn:epSOS:ep:pre:2010") )
						{
							byteArray = webservice.retrieveDocument(doc);
						
						}

						
					}
//				}
//			}
			
			if (byteArray != null)
			{
				try {
					
					// try to find a language specific XSL file
					String lang = GeneralUtils.getLocale(req);
//					String xslFilePath = CommonUtil.getRootPath(req)+"FILESYSTEM"+File.separator+PortalUtil.getCompanyId(req)+File.separator+"epsos"+File.separator;
//					String completePath = xslFilePath+"cda_"+lang+".xsl";
//					File xslFile = new File(completePath);
//					if (!xslFile.exists())
//					{
//						xslFile = new File(xslFilePath+"cda.xsl");
//					}
					
					//String transformedResult = EpsosHelperService.getInstance().convertXMLtoHTML(byteArray,xslFile);
					
					String xmlfile = new String(byteArray,"UTF-8");
					
					com.gnomon.xslt.EpsosXSLTransformer xlsClass= new com.gnomon.xslt.EpsosXSLTransformer();
					String lang1 = lang.replace("_","-");
					PortletURLImpl pURL = null;
					ThemeDisplay themeDisplay =	(ThemeDisplay)req.getAttribute(WebKeys.THEME_DISPLAY);
					ActionRequestImpl request = (ActionRequestImpl)req;
					pURL = new PortletURLImpl(request, "EPSOS_DEMO", themeDisplay.getPlid(), true);
					pURL.setParameter("struts_action", "/ext/epsos/demo/dispensePrescriptionLines");
					pURL.setParameter("docID", docID);
					pURL.setParameter("patID", ParamUtil.getString(request, "patID"));
					pURL.setWindowState(LiferayWindowState.POP_UP);
					PsPartyRoleType PHARMACIST = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "pharmacist");
					PsPartyRoleType PHYSICIAN = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "physician");
					PsPartyRoleType NURSE = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "nurse");
					PsPartyRoleType ADMINISTRATOR = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "administrator");
					String actionURL=pURL.toString();
					PartiesService partiesServ = PartiesService.getInstance();
					User user = PortalUtil.getUser(req);
					PaPerson person = partiesServ.getPaPerson(user.getUserId());
					boolean isPharmacist = partiesServ.partyHasRoleType(person.getMainid(), PHARMACIST.getMainid());
					if (!isPharmacist) actionURL="";
					String transformedResult= xlsClass.transform(xmlfile,lang1,actionURL);
					
					req.setAttribute("transformedResult", transformedResult);
							
//					String xslString = EpsosHelperService.getInstance().convertXMLFileToString(completePath);
//					String xmlString = new String(byteArray);
//					InputSource s1 = new InputSource(new StringReader(xmlString));
//					InputSource s2 = new InputSource(new StringReader(xslString));
					
				} catch (Exception e)
				{
					
					if (e.getMessage().contains("LOGIN_REQUIRED"))
					{
					User user = PortalUtil.getUser(req);
					EpsosHelperService.getInstance().createLog("XSL TRANSFORM RESPONSE ERROR: " + e.getMessage(),usr);
					String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
					String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
					req.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
					setForward(req, "common.failure");
					}
					
					e.printStackTrace();
					SessionErrors.add(req, e.getClass().getName());
					setForward(req, "common.failure");
				}
					
			}
			setForward(req, "common.success");
		}
		catch (Exception e) {		
			System.err.println("document download error: " + e.getMessage());			
			e.printStackTrace();
			req.setAttribute("exception", e.getMessage());
			setForward(req, "common.failure");
		}
	}



}