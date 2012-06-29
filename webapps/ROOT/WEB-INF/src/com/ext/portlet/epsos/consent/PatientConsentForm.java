package com.ext.portlet.epsos.consent;

import gnomon.util.GnPropsUtil;

import java.util.Vector;

import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.demo.PatientSearchForm;
import com.ext.sql.StrutsFormFields;
import com.ext.util.CommonDefs;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.RenderRequestImpl;



public class PatientConsentForm extends org.apache.struts.validator.ValidatorForm 
{
	private static final long serialVersionUID = 1L;

	public String consentid;
	public String patID;
	public String country;
	public String[] countryIds;
	public String[] countryNames;
	public String creationDate;
	public String validFrom;
	public String validTo;

	
	public ActionErrors validate(
								ActionMapping mapping,
								HttpServletRequest request)
	{
		
		ActionErrors errors = super.validate(mapping,request);
		return errors;
	}
	
	
	public final void prepareFormFields(PortletRequest request)
	{
		if (request instanceof RenderRequest)
			this.prepareFormFields(((RenderRequestImpl)request).getHttpServletRequest());
		else
			this.prepareFormFields(((ActionRequestImpl)request).getHttpServletRequest());
	}

	public void prepareFormFields(HttpServletRequest request)
	{
		//this.countryIds = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.search.countries.supported"), "GR,UK").split(",");
		//this.countryNames = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.search.countries.supported"), "GR,UK").split(",");
		
		this.countryIds = EpsosHelperService.getInstance().getCountriesFromCS().split(",");
		this.countryNames = EpsosHelperService.getInstance().getCountriesFromCS().split(",");
		
		StrutsFormFields new_field=null;
		Vector<StrutsFormFields>  fields = new Vector<StrutsFormFields>();
		String loadaction = request.getParameter("loadaction");
		boolean readOnly = false;
		if (loadaction == null || loadaction.equals("view") || loadaction.equals("delete"))
			readOnly = true;
		
		new_field = new StrutsFormFields("country","epsos.consent.country","select",false, readOnly);
		new_field.setCollectionProperty("countryIds");
		new_field.setCollectionLabel("countryNames");
		new_field.setOnChange("countrySelectionChanged()");
		fields.addElement(new_field);
		
		fields.addElement(new StrutsFormFields("consentid","consentid","text",true,true));
		fields.addElement(new StrutsFormFields("patID","patID","text",true,true));
		
		fields.addElement(new StrutsFormFields("creationDate","epsos.consent.creationDate","text",false,true));
		
		fields.addElement(new StrutsFormFields("validFrom","epsos.consent.validFrom","date",false, readOnly, true));
		
		fields.addElement(new StrutsFormFields("validTo","epsos.consent.validTo","date",false, readOnly, true));
		
		request.setAttribute(CommonDefs.ATTR_FORM_FIELDS, fields);
	}
	
	
 	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		this.clear();
	}
 
	
	public void clear()
	{
	//	this.date1 = null;

	}


	public String getConsentid() {
		return consentid;
	}


	public void setConsentid(String consentid) {
		this.consentid = consentid;
	}


	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	public String[] getCountryIds() {
		return countryIds;
	}


	public void setCountryIds(String[] countryIds) {
		this.countryIds = countryIds;
	}


	public String[] getCountryNames() {
		return countryNames;
	}


	public void setCountryNames(String[] countryNames) {
		this.countryNames = countryNames;
	}


	public String getCreationDate() {
		return creationDate;
	}


	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}


	public String getValidFrom() {
		return validFrom;
	}


	public void setValidFrom(String validFrom) {
		this.validFrom = validFrom;
	}


	public String getValidTo() {
		return validTo;
	}


	public void setValidTo(String validTo) {
		this.validTo = validTo;
	}

	public void populateFormFromObject(PatientConsentObject obj)
	{
		this.consentid = obj.getConsentid();
		this.patID = obj.getPatientId();
		this.country = obj.getCountry();
		
		if (obj.getCreationDate() != null)
			this.creationDate = EpsosHelperService.dateTimeFormat.format(obj.getCreationDate());
		
		if (obj.getValidFrom() != null)
			this.validFrom = EpsosHelperService.dateFormat.format(obj.getValidFrom());
		
		if (obj.getValidTo() != null)
			this.validTo = EpsosHelperService.dateFormat.format(obj.getValidTo());
		
	}
	
	public void populateObjectFromForm(PatientConsentObject obj)
	{
		obj.setConsentid(this.consentid);
		obj.setPatientId(this.patID);
		obj.setCountry(this.country);
		try {
			obj.setCreationDate(EpsosHelperService.dateTimeFormat.parse(this.creationDate));
		} catch (Exception e1) {}
		try {
			obj.setValidFrom(EpsosHelperService.dateFormat.parse(this.validFrom));
		} catch (Exception e1) {}
		try {
			obj.setValidTo(EpsosHelperService.dateFormat.parse(this.validTo));
		} catch (Exception e1) {}
		
	}


	public String getPatID() {
		return patID;
	}


	public void setPatID(String patID) {
		this.patID = patID;
	}
}
