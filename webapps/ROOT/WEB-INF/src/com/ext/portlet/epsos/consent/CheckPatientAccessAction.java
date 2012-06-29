package com.ext.portlet.epsos.consent;

import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.struts.PortletAction;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class CheckPatientAccessAction extends PortletAction {

	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res)
	throws Exception {

		try {
			String patientid = req.getParameter("patID");
			String forwardAction = req.getParameter("forwardAction");
			String redirect = req.getParameter("redirect");
			String accessAction = req.getParameter("accessAction");
			String country = req.getParameter("country");

			EpsosHelperService epsos = EpsosHelperService.getInstance();
			SpiritUserClientDto usr = epsos.getEpsosUserInformation(req);
			SpiritEhrWsClientInterface webservice = epsos.getWebService(req);
			
			EhrPatientClientDto patient = EpsosHelperService.getInstance().getPatientFromRequest(req);
			
//			EhrPatientClientDto patFilter = new EhrPatientClientDto();
//			EhrPIDClientDto pidDto = new EhrPIDClientDto();
//			pidDto.setPatientID(patientid);
//			patFilter.getPid().add(pidDto);
//			List<EhrPatientClientDto> patientResult = webservice.queryPatients(patFilter);
//			if (patientResult != null && patientResult.size() > 0)
//			{
//				EhrPatientClientDto patient = patientResult.get(0);
				
				epsos.generatePatientTitleData(req, patient);
				

				if (accessAction != null)
				{
					if (accessAction.equals("checkConfirmation"))
					{
						if(epsos.hasPatientConfirmation(CommonUtil.getHttpServletRequest(req), patient))
						{
							setForward(req, forwardAction+"?patID="+patientid+"&country="+country+"&redirect="+redirect);
							return;
						}
						else
						{
							setForward(req, "confirmation");
							return;
						}
					}
					
					if (accessAction.equals("createConfirmation"))
					{
						boolean success = epsos.createPatientConfirmation(CommonUtil.getHttpServletRequest(req), patient);
						if (success)
						{
							setForward(req, forwardAction+"?patID="+patientid+"&country="+country+"&redirect="+redirect);
							return;
						}
						else
						{
							req.setAttribute("confirmationFailure", "true");
							setForward(req, "confirmation");
							return;
						}
					} 

				}
			
			
			setForward(req, forwardAction+"?patID="+patientid+"&country="+country+"&redirect="+redirect);
		}
		catch (Exception e) {
			setForward(req, "common.failure");
			req.setAttribute("exceptionMessage",e.getLocalizedMessage());
		}
	}
}
