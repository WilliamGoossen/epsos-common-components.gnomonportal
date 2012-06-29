package com.ext.portlet.parties.contacts.orgchart;

import gnomon.business.GeneralUtils;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.model.parties.PaParty;
import gnomon.hibernate.model.views.ViewResult;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.parties.contacts.ContactForm;
import com.ext.portlet.parties.contacts.highroles.HighRoleDefinition;
import com.ext.portlet.parties.contacts.highroles.HighRoleService;
import com.ext.portlet.parties.lucene.PartiesLuceneUtilities;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PropsUtil;

public class LoadNewOrgChartContactAction extends PortletAction{
	public ActionForward render(ActionMapping mapping, 
			ActionForm form, 
			PortletConfig config,
			RenderRequest request, 
			RenderResponse response) throws Exception 
	{
		ActionForward nextPage = null;
		String lang=GeneralUtils.getLocale(request);
		String defLang = PropsUtil.get("locale.default");
		String selectedID = request.getParameter("selectedID");
		String partyType = request.getParameter("partyType");
		String highRoleId = request.getParameter("highRoleId");
		
		try{
			ContactForm contactForm = (ContactForm)form;
			
			contactForm.setLang(defLang);
			contactForm.setActiveContact(Boolean.TRUE);
			
			if (partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON))
			{
				ViewResult parentView = GnPersistenceService.getInstance(request).getObjectWithLanguage(PaParty.class, Integer.valueOf(selectedID), defLang, new String[]{"langs.description"});
				if (parentView != null)
					contactForm.setOrganizationName(parentView.getField1().toString());
				
				if (Validator.isNotNull(highRoleId)) {
					HighRoleDefinition highRoleDef = HighRoleService.getInstance().getDefinitions().get(highRoleId);
					request.setAttribute("highRoleDefinition", highRoleDef);
				}
			}
			contactForm.prepareFormFields(defLang, request);
			

			nextPage = mapping.findForward("common.success");
		}catch(Exception ex){
			nextPage = mapping.findForward("common.failure");
		}
		return nextPage;
	}
	
	
}
