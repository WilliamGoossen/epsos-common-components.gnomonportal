package com.ext.portlet.epsos.consent;

import gnomon.business.StringUtils;

import java.util.Date;
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
import com.ext.util.TitleData;
import com.liferay.portal.kernel.security.permission.ActionExtKeys;
import com.liferay.portal.kernel.security.permission.PermissionChecker;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Layout;
import com.liferay.portal.security.auth.PrincipalException;
import com.liferay.portal.service.permission.PortletPermissionUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.WebKeys;
import com.liferay.portlet.RenderRequestImpl;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class LoadPatientConsentAction extends GnRenderAction {

	@Override
	protected ActionForward renderLocal(ActionMapping mapping, ActionForm form,
			PortletConfig config, RenderRequest req, RenderResponse res)
		throws Exception {

		PatientConsentForm consentForm = (PatientConsentForm)form;
		
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
				
				TitleData titleData = epsosHelper.generatePatientTitleData(req, patient);
				
				String loadaction = StringUtils.check_null(req.getParameter("loadaction"),"view");
				if (loadaction.equals("add"))
				{
					consentForm.setCreationDate(EpsosHelperService.dateTimeFormat.format(new Date()));
					consentForm.prepareFormFields(req);
					
					titleData.put("epsos.consent.doctor.name", usr.getDisplayName());
					String address = "";
					if (usr.getPostalAddress() != null)
					{
						for (String a: usr.getPostalAddress())
						{
							address += a + " ";
						}
					}
					titleData.put("epsos.consent.doctor.address", address);
					
					return mapping.findForward("common.add");
				}
				else
				{
					// load consent from web service
					String consentid = req.getParameter("consentid");
					PatientConsentObject consent = epsosHelper.getPatientConsentById(consentid, patient, CommonUtil.getHttpServletRequest(req));
					if (consent != null)
						consentForm.populateFormFromObject(consent);
					else
						return mapping.findForward("common.failure");
	
					titleData.put("epsos.consent.doctor.name", consent.getDoctorName());
					titleData.put("epsos.consent.doctor.address", consent.getDoctorAddress());
					consentForm.prepareFormFields(req);
					
					if (loadaction.equals("view"))
						return mapping.findForward("common.view");
					else if (loadaction.equals("edit"))
						return mapping.findForward("common.edit");
					else if (loadaction.equals("delete"))
							return mapping.findForward("common.delete");
				}
			}
		} catch (Exception e) {
			return mapping.findForward("common.failure");
		}
		
		return mapping.findForward("common.failure");
	}
	
	@Override
	protected void checkCustomApplicationLogicPermissions(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			RenderRequest req, RenderResponse res) throws PrincipalException {
		
		String loadaction = StringUtils.check_null(req.getParameter("loadaction"),"view");
		ThemeDisplay themeDisplay =	(ThemeDisplay)req.getAttribute(WebKeys.THEME_DISPLAY);
		PermissionChecker permissionChecker = themeDisplay.getPermissionChecker();
		Layout layout = themeDisplay.getLayout();
		String portletId = ((RenderRequestImpl)req).getPortletName();
		
		if (Validator.isNotNull(loadaction) && !loadaction.equals("view"))
		{
			try {
				// ensure that there are permissions for the given loadaction
				if (!PortletPermissionUtil.contains(
						permissionChecker, layout.getPlid(), portletId,
						
						(loadaction.equals("add") ? ActionExtKeys.ADD :
							(loadaction.equals("delete") ? ActionExtKeys.DELETE :
								ActionExtKeys.EDIT))
						)) {
					throw new PrincipalException();
				}
			} catch (Exception e) { 
				if (e instanceof PrincipalException)
					throw (PrincipalException)e;
			}
		}
		
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
