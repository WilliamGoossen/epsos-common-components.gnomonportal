package com.ext.portlet.epsos.demo;

import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.struts.PortletAction;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ViewDocumentCardAction extends PortletAction {


	public ActionForward render(ActionMapping mapping,
			ActionForm form,
			PortletConfig config,
			RenderRequest request,
			RenderResponse response) throws Exception
	{
		EpsosHelperService epsos = null; 
		SpiritUserClientDto usr = null;
		try {
			epsos = EpsosHelperService.getInstance(); 
			usr = epsos.getEpsosUserInformation(request);
			SpiritEhrWsClientInterface webservice = epsos.getWebService(request);
			
			String docID = request.getParameter("docID");
			
			List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)CommonUtil.getHttpServletRequest(request).getSession().getAttribute("patientDocuments");
			DocumentClientDto doc = patientDocuments.get(Integer.parseInt(docID));
			
			EhrPatientClientDto patient = null;
			patient = EpsosHelperService.getInstance().getPatientFromRequest(request);
				
			if (patient!=null)
			{
				epsos.generatePatientTitleData(request, patient);
				
				XdsQArgsDocument argDoc = new XdsQArgsDocument();
				XdsQArgsDocument qArgs = new XdsQArgsDocument();

				//EpsosHelperService.getInstance().createLog("PATIENT INFORMATION CARD REQUEST",usr);
				//PatientContentClientDto result = webservice.queryDocuments(patient.getPid(), qArgs);
				//EpsosHelperService.getInstance().createLog("PATIENT INFORMATION CARD RESPONSE OK",usr);
				//PatientContentClientDto result = webservice.queryDocuments(list);
//				if (result != null && result.getDocuments() != null)
//				{	
//					for (DocumentClientDto doc: result.getDocuments())
//					{
//						if (doc.getUniqueId().equals(docID))
//						{
//							request.setAttribute("document", doc);
//							break;
//						}
//					}
//				}
				request.setAttribute("document", doc);
			}
			
			return mapping.findForward("common.success");
		} catch (Exception e) {
			//EpsosHelperService.getInstance().createLog("PATIENT INFORMATION CARD RESPONSE ERROR",usr);
			request.setAttribute("exception", e.getMessage());
			return mapping.findForward("common.failure");
		}
	}

}
