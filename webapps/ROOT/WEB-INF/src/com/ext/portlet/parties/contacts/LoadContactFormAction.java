package com.ext.portlet.parties.contacts;

import gnomon.business.GeneralUtils;
import gnomon.business.LangUtils;
import gnomon.business.StringUtils;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.model.parties.PaParty;
import gnomon.hibernate.model.parties.PaPartyLanguage;
import gnomon.hibernate.model.views.ViewResult;

import java.util.List;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.parties.contacts.groups.members.ListGroupMembersAction;
import com.ext.portlet.parties.lucene.PartiesLuceneUtilities;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PropsUtil;

public class LoadContactFormAction extends PortletAction{
	public ActionForward render(ActionMapping mapping, 
			ActionForm form, 
			PortletConfig config,
			RenderRequest request, 
			RenderResponse response) throws Exception 
	{
		ActionForward nextPage = null;
		String lang=GeneralUtils.getLocale(request);
		String defLang = PropsUtil.get("locale.default");
		lang = StringUtils.check_null(
				request.getParameter("lang"),
				StringUtils.check_null(GeneralUtils.getLocale(request),defLang));
		String loadaction = request.getParameter("loadaction");
		
		try{
			ContactForm contactForm = (ContactForm)form;
			
			String contactid = request.getParameter("mainid");
			if (Validator.isNotNull(contactid))
			{
				Integer contactId = Integer.valueOf(contactid);
				ContactsService.getInstance().loadContact(contactId, lang, contactForm);
				
				if (loadaction.equals("trans"))
				{
					// explicitly set the language in the case of adding a new translation
					contactForm.setLang(lang);
				}
				
				String topicIds = ContactsService.getInstance().handlePersonTopic(contactId, request);
				contactForm.setOccupationTopicIds(topicIds);
				
				List languages = GnPersistenceService.getInstance(null).listObjectLanguages(PaParty.class, contactId);
				java.util.Vector<String> editLangsList = new java.util.Vector<String>();
				for (int i=0; i<languages.size(); i++)
				{
					PaPartyLanguage itemLang = (PaPartyLanguage)languages.get(i);
					editLangsList.add(itemLang.getLang());
				}
				List addLangsList = LangUtils.getEditLocales((RenderRequest)null,editLangsList);
				request.setAttribute("editLangsList", editLangsList);
				request.setAttribute("addLangsList", addLangsList);
			}
			else
			{
				lang = defLang;
				contactForm.setLang(lang);
				contactForm.setActiveContact(true);
			}
			
			contactForm.prepareFormFields(lang, request);
			
		
			
			
			if (Validator.isNotNull(contactid) && contactForm.getPartyType().equals(PartiesLuceneUtilities.PARTY_TYPE_GROUP)) {
				
				List<ViewResult> groupMembers = ListGroupMembersAction.listGroupMembers(contactForm.getMainid(), contactForm.getLang(), "*", request);
				request.setAttribute("groupMembers", groupMembers);
				request.setAttribute("groupid", contactForm.getMainid().toString());

			}
			
			if ("view".equals(loadaction))
				nextPage = mapping.findForward("portlet.ext.parties.contacts.view");
			else
			nextPage = mapping.findForward("portlet.ext.parties.contacts.success");
		}catch(Exception ex){
			nextPage = mapping.findForward("portlet.ext.parties.contacts.failure");
			ex.printStackTrace();
		}
		return nextPage;
	}
	
	
}
