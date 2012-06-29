package com.ext.portlet.epsos.consent;

import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.validator.ValidatorForm;

import com.ext.portlet.GnProcessAction;
import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.util.CommonUtil;
import com.liferay.portal.kernel.security.permission.ActionExtKeys;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.security.auth.PrincipalException;
import com.liferay.portlet.ActionRequestImpl;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class UpdatePatientConsentAction extends GnProcessAction {

	@Override
	protected void processActionLocal(ActionMapping mapping, ActionForm form,
			PortletConfig config, ActionRequest req, ActionResponse res)
			throws Exception {
		
		PatientConsentForm consentForm = (PatientConsentForm)form;
		
		ActionErrors errors = ((ValidatorForm)consentForm).validate(mapping, ((ActionRequestImpl)req).getHttpServletRequest());
		if (errors != null && !errors.isEmpty())
		{
			req.setAttribute(Globals.ERROR_KEY, errors);
			consentForm.prepareFormFields(req);
			setForward(req,"common.validation");
			return;
		}
		
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
				
				PatientConsentObject consentObject = epsosHelper.getPatientConsentById(consentForm.getConsentid(), patient, CommonUtil.getHttpServletRequest(req));
				consentForm.populateObjectFromForm(consentObject);
				epsosHelper.updatePatientConsent(consentObject, patient, CommonUtil.getHttpServletRequest(req));
				
				if (Validator.isNotNull(ParamUtil.getString(req,"redirect")))
					sendRedirect(req,res);
				else
					setForward(req, "/ext/epsos/consent/list?patID="+patient.getPid().get(0).getPatientID());
				
			}
		} catch (Exception e) {
			setForward(req,"common.failure");
		}
	}
	

	
	@Override
	protected String getFailureForward() {
		return "common.failure";
	}

	@Override
	protected String getPermissionKey() {
		return ActionExtKeys.EDIT;
	}
	
	@Override
	protected void checkCustomApplicationLogicPermissions(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest req, ActionResponse res) throws PrincipalException {
	}

	@Override
	protected void checkGnContentPermissions(ActionMapping mapping,
			ActionForm form, PortletConfig config, ActionRequest req,
			ActionResponse res) throws PrincipalException {
	}
}