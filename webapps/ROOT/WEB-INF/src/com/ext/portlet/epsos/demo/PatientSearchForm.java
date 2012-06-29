package com.ext.portlet.epsos.demo;

import gnomon.util.GnPropsUtil;

import java.util.Vector;

import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.sql.StrutsFormFields;
import com.ext.sql.StrutsFormFieldsGroupDelimiter;
import com.ext.util.CommonDefs;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.RenderRequestImpl;



public class PatientSearchForm extends org.apache.struts.validator.ValidatorForm 
{
	private static final long serialVersionUID = 1L;
	
	private final static String[] SEX_IDS = new String[]{"", "M", "F"};
	private final static String[] SEX_NAMES = new String[]{"", "epsos.demo.search.sex.M", "epsos.demo.search.sex.F"};
	
	public String givenName;
	public String surName;
	public String birthDate;
	public String sex;
	public String[] sexIds = SEX_IDS;
	public String[] sexNames = SEX_NAMES;
	public String street;
	public String zipCode;
	public String city;
	public String country;
	public String[] countryIds;
	public String[] countryNames;
	public String pid;
	public String pid1;
	public String pid2;
	public String pid3;
	public String pid4;
	public String pid5;
	public String ssnNumber;
	public String driversLicense;
	public String accountNumber;

	
	public ActionErrors validate(
								ActionMapping mapping,
								HttpServletRequest request)
	{
		
		ActionErrors errors = super.validate(mapping,request);
		return errors;
	}
	
	public void clearForm()
	{
		this.pid="";
		this.pid1="";
		this.pid2="";
		this.accountNumber="";
		this.birthDate="";
		this.city="";
		this.driversLicense="";
		this.givenName="";
		this.pid3="";
		this.pid4="";
		this.pid5="";
		this.sex="";
		this.ssnNumber="";
		this.street="";
		this.surName="";
		this.zipCode="";	
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
		//this.countryNames = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.search.countries.supported.keys"), "GR,UK").split(",");
		User user;
		String language = "en_US";
		try {
			user = PortalUtil.getUser(request);
			language = user.getLanguageId();
		} catch (PortalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.countryIds = EpsosHelperService.getInstance().getCountriesFromCS().split(",");
		this.countryNames = EpsosHelperService.getInstance().getCountriesLabelsFromCS(language).split(",");
		
		EpsosHelperImpl eh = new EpsosHelperImpl();

		
		Vector<StrutsFormFields> fields = eh.getFieldsForCountryFromNCP(country,language);	
		request.setAttribute(CommonDefs.ATTR_FORM_FIELDS, fields);
	}
	
	
 	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		this.clear();
	}
 
	
	public void clear()
	{


	}

	public String getGivenName() {
		return givenName;
	}

	public void setGivenName(String givenName) {
		this.givenName = givenName;
	}

	public String getSurName() {
		return surName;
	}

	public void setSurName(String surName) {
		this.surName = surName;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	


	public String[] getSexIds() {
		return sexIds;
	}


	public void setSexIds(String[] sexIds) {
		this.sexIds = sexIds;
	}


	public String[] getSexNames() {
		return sexNames;
	}


	public void setSexNames(String[] sexNames) {
		this.sexNames = sexNames;
	}


	public String getSsnNumber() {
		return ssnNumber;
	}


	public void setSsnNumber(String ssnNumber) {
		this.ssnNumber = ssnNumber;
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


	public String getDriversLicense() {
		return driversLicense;
	}


	public void setDriversLicense(String driversLicense) {
		this.driversLicense = driversLicense;
	}


	public String getAccountNumber() {
		return accountNumber;
	}


	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}


	public String getPid1() {
		return pid1;
	}


	public void setPid1(String pid1) {
		this.pid1 = pid1;
	}


	public String getPid2() {
		return pid2;
	}


	public void setPid2(String pid2) {
		this.pid2 = pid2;
	}


	public String getPid3() {
		return pid3;
	}


	public void setPid3(String pid3) {
		this.pid3 = pid3;
	}


	public String getPid4() {
		return pid4;
	}


	public void setPid4(String pid4) {
		this.pid4 = pid4;
	}


	public String getPid5() {
		return pid5;
	}


	public void setPid5(String pid5) {
		this.pid5 = pid5;
	}

	public String getPid(int index)
	{
		switch (index)
		{
		case 0: return this.pid; 
		case 1: return this.pid1;
		case 2: return this.pid2;
		case 3: return this.pid3;
		case 4: return this.pid4;
		case 5: return this.pid5;
		default: return this.pid;
		}
	}
	

}
