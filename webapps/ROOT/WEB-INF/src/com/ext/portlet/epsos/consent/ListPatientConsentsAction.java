package com.ext.portlet.epsos.consent;

import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.GnRenderAction;
import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.security.permission.ActionExtKeys;
import com.liferay.portal.security.auth.PrincipalException;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class ListPatientConsentsAction extends GnRenderAction {

	@Override
	protected ActionForward renderLocal(ActionMapping mapping, ActionForm form,
			PortletConfig config, RenderRequest req, RenderResponse res)
		throws Exception {
		try {
			EpsosHelperService epsosHelper = EpsosHelperService.getInstance();
			SpiritUserClientDto usr = epsosHelper.getEpsosUserInformation(req);
			String patID = req.getParameter("patID");
			SpiritEhrWsClientInterface webservice = epsosHelper.getWebService(req);
			
			EhrPatientClientDto patFilter = new EhrPatientClientDto();
			EhrPIDClientDto pidDto = new EhrPIDClientDto();
			pidDto.setPatientID(patID);
			patFilter.getPid().add(pidDto);
			List<EhrPatientClientDto> patientResult = webservice.queryPatients(patFilter);
			
			if (patientResult != null && patientResult.size() > 0)
			{
				EhrPatientClientDto patient = patientResult.get(0);
				
				epsosHelper.generatePatientTitleData(req, patient);
				
				List<PatientConsentObject> consentsList = epsosHelper.listPatientConsents(patient, CommonUtil.getHttpServletRequest(req));
				req.setAttribute("consentsList", consentsList);
				
			}
		} catch (Exception e) {
			return mapping.findForward("common.failure");
		}
		
		return mapping.findForward("common.success");
	}
	
	@Override
	protected void checkCustomApplicationLogicPermissions(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			RenderRequest req, RenderResponse res) throws PrincipalException {
	}

	@Override
	protected void checkGnContentPermissions(ActionMapping mapping,
			ActionForm form, PortletConfig config, RenderRequest req,
			RenderResponse res) throws PrincipalException {
	
	}

	@Override
	protected String getFailureForward() {
		return "common.failure";
	}

	@Override
	protected String getPermissionKey() {
		return ActionExtKeys.VIEW;
	}

	

}
