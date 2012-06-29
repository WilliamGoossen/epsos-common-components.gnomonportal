package com.ext.portlet.epsos.demo;

import gnomon.business.FileUploadHelper;
import gnomon.hibernate.model.views.ViewResult;
import gnomon.util.GnPropsUtil;

import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.ext.util.TitleData;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ViewPrescriptionLinesAction extends PortletAction {

	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
		{

		EpsosHelperService epsos = EpsosHelperService.getInstance(); 
		SpiritUserClientDto usr = epsos.getEpsosUserInformation(request);
		try {

			
			SpiritEhrWsClientInterface webservice = epsos.getWebService(request);
			
			String docID = request.getParameter("docID");
			String docType = request.getParameter("docType");

			List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)CommonUtil.getHttpServletRequest(request).getSession().getAttribute("patientDocuments");
			DocumentClientDto doc = patientDocuments.get(Integer.parseInt(docID));		

			EhrPatientClientDto patient = null;
			patient = EpsosHelperService.getInstance().getPatientFromRequest(request);
				
			if (patient!=null)
				{
				TitleData titleData = epsos.generatePatientTitleData(request, patient);
				
				XdsQArgsDocument argDoc = new XdsQArgsDocument();
				XdsQArgsDocument qArgs = new XdsQArgsDocument();
				if (docType.equals("ep"))
				{
					qArgs=EpsosHelperService.getInstance().getArgsForEP();
				}
//				PatientContentClientDto result = webservice.queryDocuments(patient.getPid(), qArgs);
//				DocumentClientDto prescription = null;
//				if (result != null && result.getDocuments() != null)
//				{	
//					for (DocumentClientDto doc: result.getDocuments())
//					{
//						if (doc.getUniqueId().equals(docID))
//						{
//							prescription = doc;							
//							break;
//						}
//					}
//				}
				DocumentClientDto prescription = doc;
				
				if (prescription != null)
				{
					//FOR TESTING PURPOSES
					boolean useLocalDocument = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.use.default.local.document.example"), false);
					if (useLocalDocument) EpsosHelperService.getInstance().createLog("USING LOCAL DOCUMENT FOR EP DOC",null);
					byte[] bytes = null;
					CommonUtil.getHttpServletRequest(request).getSession().putValue("prescription", prescription);				
					if (useLocalDocument)
					{
						bytes = FileUploadHelper.getFile(CommonUtil.getRootPath(this.getServlet().getServletContext())+"FILESYSTEM/"+PortalUtil.getCompanyId(request), "epsos", "epsample_max2.xml");
					}
					else
					{
						bytes = webservice.retrieveDocument(prescription);
					}
					CommonUtil.getHttpServletRequest(request).getSession().putValue("bytes", bytes);
					List<ViewResult> lines = epsos.parsePrescriptionDocumentForPrescriptionLines(bytes);
					
					if (lines != null && lines.size() > 0)
					{
						// fill in title data with prescription header info
						ViewResult line = lines.get(0);
						if (Validator.isNotNull(line.getField15()))
						{
							titleData.put("epsos.demo.prescription.performer", line.getField15());
						}
						if (Validator.isNotNull(line.getField16()))
						{
							titleData.put("epsos.demo.prescription.profession", line.getField16());
						}
						if (Validator.isNotNull(line.getField17()))
						{
							titleData.put("epsos.demo.prescription.facility", line.getField17());
						}
						if (Validator.isNotNull(line.getField18()))
						{
							titleData.put("epsos.demo.prescription.address", line.getField18());
						}
					}
			        request.setAttribute("prescriptionLines", lines);
			        
				}
			}
			
			return mapping.findForward("common.success");
		} catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			User user = PortalUtil.getUser(request);
			EpsosHelperService.getInstance().createLog("PRESCRIPTION LINES. RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			request.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			return mapping.findForward("common.failure");
			}
			
			request.setAttribute("exception", e.getMessage());
			return mapping.findForward("common.failure");
		}
	}
	
	

}
