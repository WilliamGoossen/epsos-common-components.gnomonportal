package com.ext.portlet.parties.contacts;

import edu.emory.mathcs.backport.java.util.Arrays;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.model.parties.PaCountry;
import gnomon.hibernate.model.parties.PaGeographicAddressLanguage;
import gnomon.hibernate.model.parties.PaGroup;
import gnomon.hibernate.model.parties.PaOrganization;
import gnomon.hibernate.model.parties.PaOrganizationNameLanguage;
import gnomon.hibernate.model.parties.PaOrganizationType;
import gnomon.hibernate.model.parties.PaParty;
import gnomon.hibernate.model.parties.PaPerson;
import gnomon.hibernate.model.parties.PsPartyRoleType;
import gnomon.hibernate.model.views.ViewResult;

import java.io.File;
import java.util.List;
import java.util.Locale;
import java.util.Vector;

import javax.portlet.ActionRequest;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.validator.ValidatorForm;

import com.ext.portlet.cms.generic.lucene.LuceneIndexed;
import com.ext.portlet.cms.generic.lucene.LuceneUtilities;
import com.ext.portlet.parties.lucene.PartiesLuceneUtilities;
import com.ext.sql.StrutsFormFields;
import com.ext.sql.StrutsFormFieldsGroupDelimiter;
import com.ext.sql.StrutsFormFieldsTabDelimiter;
import com.ext.util.CommonDefs;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.security.permission.ActionExtKeys;
import com.liferay.portal.kernel.security.permission.PermissionChecker;
import com.liferay.portal.kernel.util.ArrayUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Layout;
import com.liferay.portal.service.permission.PortletPermissionUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.PropsUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.liferay.portlet.RenderRequestImpl;

public class ContactForm extends ValidatorForm implements ContactLiferayUserForm, LuceneIndexed {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public final static String GENDER_MALE = "male",
	GENDER_FEMALE = "female";

	public final static String HOME_TYPE = "home", WORK_TYPE = "work", FAX_TYPE="fax", MOBILE_TYPE="mob";

	public String lang;
	public Integer mainid;
	public Boolean privateContact;
	public Boolean activeContact;
	public String partyType = PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION;
	public String comments;

	public Integer addressId1;
	public String countryId1;
	//public String countryName1;
	public String[] countryIds;
	public String[] countryNames;
	public String addressLine1;
	public String region1;
	public String zipOrPostCode1;
	public String addressType1;
	public String[] addressTypes = new String[]{HOME_TYPE, WORK_TYPE};
	public String[] addressTypeKeys = new String[]{"contacts.addresstype.home", "contacts.addresstype.work"};

	public Integer addressId2;
	public String countryId2;
	//public String countryName2;
	public String addressLine2;
	public String region2;
	public String zipOrPostCode2;
	public String addressType2;

	public Integer addressId3;
	public String countryId3;
	//public String countryName3;
	public String addressLine3;
	public String region3;
	public String zipOrPostCode3;
	public String addressType3;

	public Integer addressId4;
	public String countryId4;
	//public String countryName4;
	public String addressLine4;
	public String region4;
	public String zipOrPostCode4;
	public String addressType4;

	public Integer telephoneId1;
	public String telephone1;
	public String physicalType1;
	public String[] physicalTypes = new String[] {HOME_TYPE, WORK_TYPE, FAX_TYPE, MOBILE_TYPE};
	public String[] physicalTypeKeys = new String[] {
			"contacts.teltype.home", 
			"contacts.teltype.work",
			"contacts.teltype.fax",
	"contacts.teltype.mobile" };

	public Integer telephoneId2;
	public String telephone2;
	public String physicalType2;

	public Integer telephoneId3;
	public String telephone3;
	public String physicalType3;

	public Integer telephoneId4;
	public String telephone4;
	public String physicalType4;

	public Integer emailId1;
	public String email1;

	public Integer emailId2;
	public String email2;

	public Integer emailId3;
	public String email3;

	public Integer emailId4;
	public String email4;

	public Integer webpageId1;
	public String webpage1;

	public Integer webpageId2;
	public String webpage2;

	public Integer webpageId3;
	public String webpage3;

	public Integer webpageId4;
	public String webpage4;

	public Integer afmId;
	public String afm;
	public String registrationAuthority;

	public Integer identifier0Id;
	public String identifier0;
	public String identifier0Authority;

	public Integer identifier1Id;
	public String identifier1;
	public String identifier1Authority;

	public Integer identifier2Id;
	public String identifier2;
	public String identifier2Authority;

	public Integer identifier3Id;
	public String identifier3;
	public String identifier3Authority;

	public Integer identifier4Id;
	public String identifier4;
	public String identifier4Authority;

	public String prefix;
	public String familyName;
	public String firstName;
	public String fatherName;
	public String organizationName;
	public String name;
	public String description;

	public String psPartyRoleTypeId;
	public String[] psPartyRoleTypeIds;
	public String[] psPartyRoleTypeNames;

	public String gender;
	public String[] genders = new String[] { GENDER_MALE, GENDER_FEMALE };
	public String[] genderKeys = new String[] { "parties.manager.person.gender.male",
	"parties.manager.person.gender.female"};
	public String orgtypeid;
	public String[] orgTypeIds;
	public String[] orgTypeNames;

	public boolean createUser;
	public String screenName;
	public String password1;
	public String password2;


	public String occupationTopicIds;


	public String imageView;
	public String imageUpload;
	public String imageUploadContents;
	public String fileUpload;
	public String fileUploadContents;


	public ContactForm(){
	}

	public ActionErrors validate(
			ActionMapping mapping,
			HttpServletRequest request)
	{

		ActionErrors errors = super.validate(mapping,request);
		String reqPartyType = request.getParameter("partyType");
		Long companyId = PortalUtil.getCompanyId(request);
		Locale locale = PortalUtil.getLocale(request);
		if ( (this.partyType != null && this.partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON)) ||
				(reqPartyType != null && reqPartyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON)))
		{
			// names are mandatory
			if (Validator.isNull(this.firstName))
			{
				ActionMessage mesg = new ActionMessage("errors.required", LanguageUtil.get(companyId, locale,  "parties.manager.person.firstname"));
				if (errors == null) errors = new ActionErrors();
				errors.add("firstName", mesg);
			}
			if (Validator.isNull(this.familyName))
			{
				ActionMessage mesg = new ActionMessage("errors.required", LanguageUtil.get(companyId, locale,  "parties.manager.person.familyname"));
				if (errors == null) errors = new ActionErrors();
				errors.add("familyName", mesg);
			}
		}
		else if ( (this.partyType != null && this.partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)) ||
				(reqPartyType != null && reqPartyType.equals(PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)))
		{
			if (Validator.isNull(this.organizationName))
			{
				ActionMessage mesg = new ActionMessage("errors.required", LanguageUtil.get(companyId, locale,  "parties.manager.organization.name"));
				if (errors == null) errors = new ActionErrors();
				errors.add("organizationName", mesg);
			}
		}
		else if ( (this.partyType != null && this.partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_GROUP)) ||
				(reqPartyType != null && reqPartyType.equals(PartiesLuceneUtilities.PARTY_TYPE_GROUP)))
		{
			if (Validator.isNull(this.name))
			{
				ActionMessage mesg = new ActionMessage("errors.required", LanguageUtil.get(companyId, locale,  "contacts.group.name"));
				if (errors == null) errors = new ActionErrors();
				errors.add("name", mesg);
			}
		}
		return errors;
	}

	public void clear(){
		prefix = "";
		firstName = "";

		gender = "";

		addressId1 = 0;
		countryId1 = "0";
		addressLine1 = "";
		region1 = "";
		zipOrPostCode1 = "";
		addressType1 = "";
		addressId2 = 0;
		countryId2 = "";
		addressLine2 = "";
		region2 = "";
		zipOrPostCode2 = "";
		addressType2 = "";
		addressId3 = 0;
		countryId3 = "";
		addressLine3 = "";
		region3 = "";
		zipOrPostCode3 = "";
		addressType3 = "";
		addressId4 = 0;
		countryId4 = "";
		addressLine4 = "";
		region4 = "";
		zipOrPostCode4 = "";
		addressType4 = "";
		telephoneId1 = 0;
		telephone1 = "";
		physicalType1 = "";
		telephoneId2 = 0;
		telephone2 = "";
		physicalType2 = "";
		telephoneId3 = 0;
		telephone3 = "";
		physicalType3 = "";
		telephoneId4 = 0;
		telephone4 = "";
		physicalType4 = "";
		emailId1 = 0;
		email1 = "";
		emailId2 = 0;
		email2 = "";
		emailId3 = 0;
		email3 = "";
		emailId4 = 0;
		email4 = "";
		webpageId1 = 0;
		webpage1 = "";
		webpageId2 = 0;
		webpage2 = "";
		webpageId3 = 0;
		webpage3 = "";
		webpageId4 = 0;
		webpage4 = "";
		afmId = 0;
		afm = "";
		registrationAuthority = "";
		identifier0Id = 0;
		identifier0 = "";
		identifier0Authority = "";
		identifier1Id = 0;
		identifier1 = "";
		identifier1Authority = "";
		identifier2Id = 0;
		identifier2 = "";
		identifier2Authority ="";
		identifier3Id = 0;
		identifier3 = "";
		identifier3Authority = "";
		identifier4Id = 0;
		identifier4 = "";
		identifier4Authority = "";

		familyName = "";

		fatherName = "";
		organizationName = "";
		name = "";
		description = "";
		psPartyRoleTypeId = "";

		orgtypeid = "";
	}

	private void populateLists(String lang)
	{
		GnPersistenceService serv = GnPersistenceService.getInstance(null);
		List countries = serv.listObjectsWithLanguage(null, PaCountry.class, lang, new String[] {"langs.name"}, null, "langs.name");
		if (countries != null && countries.size() > 0 )
		{
			this.countryIds = new String[countries.size() + 1];
			this.countryNames = new String[countries.size() + 1];
			this.countryIds[0] = "";
			this.countryNames[0] = "";
			for (int i=0; i<countries.size(); i++)
			{
				ViewResult countryView = (ViewResult)countries.get(i);
				this.countryIds[i+1] = countryView.getMainid().toString();
				this.countryNames[i+1] = countryView.getField1().toString();
			}
		}
		else
		{
			this.countryIds = new String[1];
			this.countryNames = new String[1];
			this.countryIds[0] = "";
			this.countryNames[0] = "";
		}

		List orgTypes = serv.listObjectsWithLanguage(null, PaOrganizationType.class, lang, new String[] {"langs.name"}, null, "langs.name");
		if (orgTypes != null && orgTypes.size() > 0 )
		{
			this.orgTypeIds = new String[orgTypes.size() + 1];
			this.orgTypeNames = new String[orgTypes.size() + 1];
			this.orgTypeIds[0] = "";
			this.orgTypeNames[0] = "";
			for (int i=0; i<orgTypes.size(); i++)
			{
				ViewResult orgType = (ViewResult)orgTypes.get(i);
				this.orgTypeIds[i+1] = orgType.getMainid().toString();
				this.orgTypeNames[i+1] = orgType.getField1().toString();
			}
		}
		else
		{
			this.orgTypeIds = new String[1];
			this.orgTypeNames = new String[1];
			this.orgTypeIds[0] = "";
			this.orgTypeNames[0] = "";
		}

		List psPartyRoleTypes = serv.listObjectsWithLanguage(null, PsPartyRoleType.class, lang, new String[] {"langs.name"}, null, "langs.name");
		if (psPartyRoleTypes != null && psPartyRoleTypes.size() > 0 )
		{
			this.psPartyRoleTypeIds = new String[psPartyRoleTypes.size() + 1];
			this.psPartyRoleTypeNames = new String[psPartyRoleTypes.size() + 1];
			this.psPartyRoleTypeIds[0] = "";
			this.psPartyRoleTypeNames[0] = "";
			for (int i=0; i<psPartyRoleTypes.size(); i++)
			{
				ViewResult psPartyRoleType = (ViewResult)psPartyRoleTypes.get(i);
				this.psPartyRoleTypeIds[i+1] = psPartyRoleType.getMainid().toString();
				this.psPartyRoleTypeNames[i+1] = gnomon.business.StringUtils.check_null(psPartyRoleType.getField1(),"");
			}
		}
		else
		{
			this.psPartyRoleTypeIds = new String[1];
			this.psPartyRoleTypeNames = new String[1];
			this.psPartyRoleTypeIds[0] = "";
			this.psPartyRoleTypeNames[0] = "";
		}
	}

	public String getCountryNameForCountryId(String id)
	{
		String result = "";
		List<String> countryIdList = Arrays.asList(this.countryIds);
		int index = countryIdList.indexOf(id);
		if (index != -1 && index >=0 && index<= this.countryNames.length)
			result = this.countryNames[index];
		return result;
	}

	public void prepareFormFields(String lang, 
			PortletRequest request){
		HttpServletRequest httpReq = (request instanceof ActionRequest) ? 
				((ActionRequestImpl)request).getHttpServletRequest() :
					((RenderRequestImpl)request).getHttpServletRequest();

				prepareFormFields(lang, httpReq);
	}

	public void prepareFormFields(String lang,
			HttpServletRequest request){

		ThemeDisplay themeDisplay = (ThemeDisplay)request.getAttribute(WebKeys.THEME_DISPLAY);
		Layout layout = themeDisplay.getLayout();
		PermissionChecker permissionChecker = themeDisplay.getPermissionChecker();
		String portletId = "PA_CONTACTS";
		boolean hasAdmin = false;
		try {
			hasAdmin = PortletPermissionUtil.contains(
					permissionChecker, layout.getPlid(), portletId,
					ActionExtKeys.ADMINISTRATE);
		} catch (Exception ae) {}

		PortletRequest req = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
		PortletPreferences prefs = req.getPreferences();
		if (req instanceof RenderRequest)
		{
			String portletResource = "PA_CONTACTS"; 
			try {
				PortletConfig config = (PortletConfig) req.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_CONFIG);
				if (!portletResource.equals(config.getPortletName())) // case of myAccount portlet
					prefs = Validator.isNull(portletResource)? prefs : PortletPreferencesFactoryUtil.getPortletSetup((RenderRequest)req, portletResource, false, false);
				else
					prefs = Validator.isNull(portletResource)? prefs : PortletPreferencesFactoryUtil.getPortletSetup((RenderRequest)req, portletResource, true, true);
			} catch (Exception e) {}
		}
		else
		{
			String portletResource = "PA_CONTACTS"; //ParamUtil.getString(request, "portletResource");
			try {
				PortletConfig config = (PortletConfig) req.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_CONFIG);
				if (!portletResource.equals(config.getPortletName())) // case of myAccount portlet
					prefs = Validator.isNull(portletResource)? prefs : PortletPreferencesFactoryUtil.getPortletSetup((ActionRequest)req, portletResource, false, false);
				else
					prefs = Validator.isNull(portletResource)? prefs : PortletPreferencesFactoryUtil.getPortletSetup((ActionRequest)req, portletResource, true, true);
			} catch (Exception e) {}
		}
		boolean reduceFields = GetterUtil.getBoolean(prefs.getValue("reduceFields", StringPool.BLANK), false);
		boolean showSimpleForm = GetterUtil.getBoolean(prefs.getValue("showSimpleForm", StringPool.BLANK), false);
		boolean showMultiLingualForm = GetterUtil.getBoolean(prefs.getValue("showMultiLingualForm", StringPool.BLANK), false);

		populateLists(lang);

		boolean readOnlyFlag = false;
		String loadaction = request.getParameter("loadaction");
		if (loadaction != null && (loadaction.equals("delete") || loadaction.equals("view")))
			readOnlyFlag = true;
		request.setAttribute("loadaction", loadaction);
		boolean loadActionIsTrans = false;
		if (loadaction != null && loadaction.equals("trans"))
			loadActionIsTrans = true;
		boolean loadActionIsView = false;
		if (loadaction != null && loadaction.equals("view"))
			loadActionIsView = true;
		
		reduceFields = reduceFields || loadActionIsView; // always simplify form if loadaction = view
		showSimpleForm = showSimpleForm || loadActionIsView; // always simplify form if loadaction = view
		showMultiLingualForm = showMultiLingualForm && !loadActionIsView; // always simplify form if loadaction = view

		String party_type = this.partyType;
		String reqPartyType = request.getParameter("partyType");
		if (reqPartyType != null)
			party_type = reqPartyType;
		request.setAttribute("partyType", party_type);

		String struts_action = request.getParameter("struts_action");
		boolean insideMyAccountPortlet = false;
		if (struts_action != null && !struts_action.startsWith("/ext/parties/"))
			insideMyAccountPortlet = true;

		Vector<StrutsFormFields> fields = new Vector<StrutsFormFields>();
		StrutsFormFields new_field = null;

		fields.addElement(new StrutsFormFields("mainid","mainid","text",true, true));
		//		new_field = new StrutsFormFieldsGroupDelimiter("name","contacts.search.name");
		//		new_field.setColumn("column-left");
		//		fields.addElement(new_field);
		if (!insideMyAccountPortlet && !reduceFields)
		{
			fields.addElement(new StrutsFormFields("privateContact","contacts.search.private","boolean",false, readOnlyFlag));
		}
		else
		{
			fields.addElement(new StrutsFormFields("privateContact","contacts.search.private","boolean",true, true));
		}
		if (!insideMyAccountPortlet  && showMultiLingualForm)
			fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text", false, true));
		else
			fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",true, true));

		if (party_type.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON))
		{
			fields.addElement(new StrutsFormFields("prefix","parties.manager.person.prefix","text",false, readOnlyFlag));
			fields.addElement(new StrutsFormFields("familyName","parties.manager.person.familyname","text",false, readOnlyFlag, true));
			fields.addElement(new StrutsFormFields("firstName","parties.manager.person.firstname","text",false, readOnlyFlag, true));
			fields.addElement(new StrutsFormFields("fatherName","parties.manager.person.fathername","text",false, readOnlyFlag));
			new_field = new StrutsFormFields("gender", "parties.manager.person.gender", "select", false, readOnlyFlag || loadActionIsTrans);
			new_field.setCollectionProperty("genders");
			new_field.setCollectionLabel("genderKeys");
			fields.addElement(new_field);

			renderOccupationTopicField(fields, readOnlyFlag, party_type, request);

			if (!insideMyAccountPortlet) {
				String addToOrgChart = request.getParameter("addToOrgChart");
				if (addToOrgChart != null && addToOrgChart.equals("true"))
				{
					// organization is predefined
					new_field = new StrutsFormFields("organizationName","parties.persons.companyName","tag_lookup",false, true);
					new_field.setUploadFilePath(PaOrganizationNameLanguage.class.getName()+".name");
					fields.addElement(new_field);

					// but you must chose role
					new_field = new StrutsFormFields("psPartyRoleTypeId", "parties.manager.relatedparty.role", "select", false, readOnlyFlag || loadActionIsTrans);
					new_field.setCollectionProperty("psPartyRoleTypeIds");
					new_field.setCollectionLabel("psPartyRoleTypeNames");
					fields.addElement(new_field);
				}
				else
				{
					new_field = new StrutsFormFields("organizationName","parties.persons.companyName","tag_lookup",false, readOnlyFlag || loadActionIsTrans);
					new_field.setUploadFilePath(PaOrganizationNameLanguage.class.getName()+".name");
					fields.addElement(new_field);
				}
			}

			if (!loadActionIsTrans)
			{
				renderUploadFields(fields, readOnlyFlag, request);
			}

		}
		else if (party_type.equals(PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION))
		{
			fields.addElement(new StrutsFormFields("organizationName","parties.manager.organization.name","text",false, readOnlyFlag, true));
			new_field = new StrutsFormFields("orgtypeid", "parties.manager.organization.typeid", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("orgTypeIds");
			new_field.setCollectionLabel("orgTypeNames");
			fields.addElement(new_field);
			
			renderOccupationTopicField(fields, readOnlyFlag, party_type, request);
			
		}
		else if (party_type.equals(PartiesLuceneUtilities.PARTY_TYPE_GROUP))
		{
			fields.addElement(new StrutsFormFields("name","contacts.group.name","text",false, readOnlyFlag, true));
			fields.addElement(new StrutsFormFields("description","description","textarea",false, readOnlyFlag));
		}
		fields.addElement(new StrutsFormFields("comments", "contacts.search.comments", "textarea", false, readOnlyFlag));

		if (!showSimpleForm)
			fields.addElement(new StrutsFormFieldsTabDelimiter("contacts.tab.0"));

		new_field = new StrutsFormFieldsGroupDelimiter("geoaddress","contacts.search.address");
		//new_field.setColumn("column-left");
		fields.addElement(new_field);
		new_field = new StrutsFormFields("addressType1", "parties.addresses.geographic.type", "select", false, readOnlyFlag);
		new_field.setCollectionProperty("addressTypes");
		new_field.setCollectionLabel("addressTypeKeys");
		fields.add(new_field);
		fields.addElement(new StrutsFormFields("addressId1","addressId1","text",true, true));
		fields.addElement(new StrutsFormFields("addressLine1","parties.addresses.geographic.addressline","text",false, readOnlyFlag));
		//fields.addElement(new StrutsFormFields("region1","parties.addresses.geographic.region","text",false, readOnlyFlag));
		new_field = new StrutsFormFields("region1","parties.addresses.geographic.region","tag_lookup",false, readOnlyFlag);
		new_field.setUploadFilePath(PaGeographicAddressLanguage.class.getName()+".region");
		fields.addElement(new_field);
		fields.addElement(new StrutsFormFields("zipOrPostCode1","parties.addresses.geographic.ziporpostcode","text",false, readOnlyFlag));
		//if (!insideMyAccountPortlet) {
		new_field = new StrutsFormFields("countryId1", "parties.addresses.geographic.country", "select", false, readOnlyFlag || loadActionIsTrans);
		new_field.setCollectionProperty("countryIds");
		new_field.setCollectionLabel("countryNames");
		fields.add(new_field);
		//		} else
		//		{
		//			new_field = new StrutsFormFields("countryName1", "parties.addresses.geographic.country", "text", false, readOnlyFlag);
		//			fields.add(new_field);
		//		}

		if (!loadActionIsTrans)
		{
			new_field = new StrutsFormFieldsGroupDelimiter("emailaddress","contacts.search.email");
			//	new_field.setColumn("column-left");
			fields.addElement(new_field);
			fields.addElement(new StrutsFormFields("emailId1","emailId1","text",true, true));
			fields.addElement(new StrutsFormFields("email1","parties.addresses.email","text",false, readOnlyFlag || loadActionIsTrans));


			if (party_type.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON) &&
					loadaction != null && loadaction.equals("add") &&
					hasAdmin)
			{
				boolean alwaysCreateLiferayUser = false;
				try{
					alwaysCreateLiferayUser = GetterUtil.getBoolean(prefs.getValue("alwaysCreateLiferayUser", StringPool.BLANK), false);
				} catch (Exception e) {}

				if (alwaysCreateLiferayUser)
				{
					this.createUser = true;
					fields.addElement(new StrutsFormFields("createUser","parties.manager.person.createuser","boolean",false, true));
				}
				else
				{
					fields.addElement(new StrutsFormFields("createUser","parties.manager.person.createuser","boolean",false, readOnlyFlag));
				}
				fields.addElement(new StrutsFormFields("screenName","parties.manager.person.newuserid","text",false, readOnlyFlag));
				new_field = new StrutsFormFields("password1","parties.manager.person.password1","text",false, readOnlyFlag);
				new_field.setSecretTextField(true);
				fields.addElement(new_field);
				new_field = new StrutsFormFields("password2","parties.manager.person.password2","text",false, readOnlyFlag);
				new_field.setSecretTextField(true);
				fields.addElement(new_field);
			}
			else if (party_type.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON) &&
					loadaction != null && !loadaction.equals("add") &&
					hasAdmin)
			{
				fields.addElement(new StrutsFormFields("screenName","parties.manager.person.newuserid","text",false, true));
			}

			if (hasAdmin)
			{
				fields.addElement(new StrutsFormFields("activeContact","contacts.search.active","boolean",false, readOnlyFlag));
			}
			else
			{
				fields.addElement(new StrutsFormFields("activeContact","contacts.search.active","boolean",true, true));
			}
		}

		if (!loadActionIsTrans)
		{
			new_field = new StrutsFormFieldsGroupDelimiter("teladdress","contacts.search.phone");
			//new_field.setColumn("column-right");
			fields.addElement(new_field);
			new_field = new StrutsFormFields("physicalType1", "contacts.telecom.teltype", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("physicalTypes");
			new_field.setCollectionLabel("physicalTypeKeys");
			//new_field.setOptionLabels(physicalTypeKeys);
			//new_field.setOptionValues(physicalTypes);
			//new_field.setSelectedOptionValues(physicalTypes);
			if (showSimpleForm)
			{
				this.physicalType1 = WORK_TYPE;
				new_field.setReadonly(true);
			}
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("telephoneId1","telephoneId1","text",true, true));
			fields.addElement(new StrutsFormFields("telephone1","parties.addresses.telecom.phonenumber","text",false, readOnlyFlag));

			new_field = new StrutsFormFields("physicalType2", "contacts.telecom.teltype", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("physicalTypes");
			new_field.setCollectionLabel("physicalTypeKeys");
			if (showSimpleForm)
			{
				this.physicalType2 = FAX_TYPE;
				new_field.setReadonly(true);
			}
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("telephoneId2","telephoneId1","text",true, true));
			fields.addElement(new StrutsFormFields("telephone2","parties.addresses.telecom.phonenumber","text",false, readOnlyFlag));

			//if (insideMyAccountPortlet) {

			boolean showAFM = true;
			try {
				String idTypeCSVHiddenFromUser = PropsUtil.get(PortalUtil.getCompanyId(request),"parties.registered.identifier.userhidden.types");
				String[] idHiddenTypes = idTypeCSVHiddenFromUser.split(",");
				String taxNumber = PropsUtil.get(PortalUtil.getCompanyId(request), "parties.registered.identifier.type.afm");
				if (idHiddenTypes != null)
				{
					for (String id: idHiddenTypes)
					{
						if (id.equals(taxNumber))
							showAFM = false;
					}
				}
			} catch (Exception e) {}


			if (showAFM) {
				new_field = new StrutsFormFieldsGroupDelimiter("webaddress","parties.persons.afm");
				fields.addElement(new_field);
				fields.addElement(new StrutsFormFields("afmId","afmId","text",true, true));
				fields.addElement(new StrutsFormFields("afm","parties.persons.afm","text",false, readOnlyFlag));
				fields.addElement(new StrutsFormFields("registrationAuthority","parties.organizations.registrationAuthority","text",false, readOnlyFlag));
			}

			renderIdFields(fields, readOnlyFlag, request, hasAdmin);

			//}
			new_field = new StrutsFormFieldsGroupDelimiter("webaddress","contacts.search.webpage");
			//new_field.setColumn("column-right");
			fields.addElement(new_field);
			fields.addElement(new StrutsFormFields("webpageId1","webpageId1","text",true, true));
			fields.addElement(new StrutsFormFields("webpage1","parties.addresses.webpage","text",false, readOnlyFlag));
		}

		if (!showSimpleForm)
		{
			fields.addElement(new StrutsFormFieldsTabDelimiter("contacts.tab.1"));

			fields.addElement(new StrutsFormFieldsGroupDelimiter("geoaddress","contacts.search.address"));
			new_field = new StrutsFormFields("addressType2", "parties.addresses.geographic.type", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("addressTypes");
			new_field.setCollectionLabel("addressTypeKeys");
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("addressId2","addressId1","text",true, true));
			fields.addElement(new StrutsFormFields("addressLine2","parties.addresses.geographic.addressline","text",false, readOnlyFlag));
			//fields.addElement(new StrutsFormFields("region2","parties.addresses.geographic.region","text",false, readOnlyFlag));
			new_field = new StrutsFormFields("region2","parties.addresses.geographic.region","tag_lookup",false, readOnlyFlag);
			new_field.setUploadFilePath(PaGeographicAddressLanguage.class.getName()+".region");
			fields.addElement(new_field);
			fields.addElement(new StrutsFormFields("zipOrPostCode2","parties.addresses.geographic.ziporpostcode","text",false, readOnlyFlag));
			//if (!insideMyAccountPortlet) {
			new_field = new StrutsFormFields("countryId2", "parties.addresses.geographic.country", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("countryIds");
			new_field.setCollectionLabel("countryNames");
			fields.add(new_field);
			//		} else
			//		{
			//			new_field = new StrutsFormFields("countryName2", "parties.addresses.geographic.country", "text", false, readOnlyFlag);
			//			fields.add(new_field);
			//		}

			new_field = new StrutsFormFields("addressType3", "parties.addresses.geographic.type", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("addressTypes");
			new_field.setCollectionLabel("addressTypeKeys");
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("addressId3","addressId1","text",true, true));
			fields.addElement(new StrutsFormFields("addressLine3","parties.addresses.geographic.addressline","text",false, readOnlyFlag));
			//fields.addElement(new StrutsFormFields("region3","parties.addresses.geographic.region","text",false, readOnlyFlag));
			new_field = new StrutsFormFields("region3","parties.addresses.geographic.region","tag_lookup",false, readOnlyFlag);
			new_field.setUploadFilePath(PaGeographicAddressLanguage.class.getName()+".region");
			fields.addElement(new_field);
			fields.addElement(new StrutsFormFields("zipOrPostCode3","parties.addresses.geographic.ziporpostcode","text",false, readOnlyFlag));
			//if (!insideMyAccountPortlet) {
			new_field = new StrutsFormFields("countryId3", "parties.addresses.geographic.country", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("countryIds");
			new_field.setCollectionLabel("countryNames");
			fields.add(new_field);
			//		} else
			//		{
			//			new_field = new StrutsFormFields("countryName3", "parties.addresses.geographic.country", "text", false, readOnlyFlag);
			//			fields.add(new_field);
			//		}

			new_field = new StrutsFormFields("addressType4", "parties.addresses.geographic.type", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("addressTypes");
			new_field.setCollectionLabel("addressTypeKeys");
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("addressId4","addressId1","text",true, true));
			fields.addElement(new StrutsFormFields("addressLine4","parties.addresses.geographic.addressline","text",false, readOnlyFlag));
			//fields.addElement(new StrutsFormFields("region4","parties.addresses.geographic.region","text",false, readOnlyFlag));
			new_field = new StrutsFormFields("region4","parties.addresses.geographic.region","tag_lookup",false, readOnlyFlag);
			new_field.setUploadFilePath(PaGeographicAddressLanguage.class.getName()+".region");
			fields.addElement(new_field);
			fields.addElement(new StrutsFormFields("zipOrPostCode4","parties.addresses.geographic.ziporpostcode","text",false, readOnlyFlag));
			//if (!insideMyAccountPortlet) {
			new_field = new StrutsFormFields("countryId4", "parties.addresses.geographic.country", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("countryIds");
			new_field.setCollectionLabel("countryNames");
			fields.add(new_field);
			//		} else
			//		{
			//			new_field = new StrutsFormFields("countryName4", "parties.addresses.geographic.country", "text", false, readOnlyFlag);
			//			fields.add(new_field);
			//		}

			fields.addElement(new StrutsFormFieldsGroupDelimiter("teladdress","contacts.search.phone"));
			new_field = new StrutsFormFields("physicalType3", "contacts.telecom.teltype", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("physicalTypes");
			new_field.setCollectionLabel("physicalTypeKeys");
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("telephoneId3","telephoneId1","text",true, true));
			fields.addElement(new StrutsFormFields("telephone3","parties.addresses.telecom.phonenumber","text",false, readOnlyFlag));
			new_field = new StrutsFormFields("physicalType4", "contacts.telecom.teltype", "select", false, readOnlyFlag);
			new_field.setCollectionProperty("physicalTypes");
			new_field.setCollectionLabel("physicalTypeKeys");
			fields.add(new_field);
			fields.addElement(new StrutsFormFields("telephoneId4","telephoneId1","text",true, true));
			fields.addElement(new StrutsFormFields("telephone4","parties.addresses.telecom.phonenumber","text",false, readOnlyFlag));


			fields.addElement(new StrutsFormFieldsGroupDelimiter("emailaddress","contacts.search.email"));
			fields.addElement(new StrutsFormFields("emailId2","emailId1","text",true, true));
			fields.addElement(new StrutsFormFields("email2","parties.addresses.email","text",false, readOnlyFlag));
			fields.addElement(new StrutsFormFields("emailId3","emailId1","text",true, true));
			fields.addElement(new StrutsFormFields("email3","parties.addresses.email","text",false, readOnlyFlag));
			fields.addElement(new StrutsFormFields("emailId4","emailId1","text",true, true));
			fields.addElement(new StrutsFormFields("email4","parties.addresses.email","text",false, readOnlyFlag));

			fields.addElement(new StrutsFormFieldsGroupDelimiter("webaddress","contacts.search.webpage"));
			fields.addElement(new StrutsFormFields("webpageId2","webpageId1","text",true, true));
			fields.addElement(new StrutsFormFields("webpage2","parties.addresses.webpage","text",false, readOnlyFlag));
			fields.addElement(new StrutsFormFields("webpageId3","webpageId1","text",true, true));
			fields.addElement(new StrutsFormFields("webpage3","parties.addresses.webpage","text",false, readOnlyFlag));
			fields.addElement(new StrutsFormFields("webpageId4","webpageId1","text",true, true));
			fields.addElement(new StrutsFormFields("webpage4","parties.addresses.webpage","text",false, readOnlyFlag));

		}

		request.setAttribute(CommonDefs.ATTR_FORM_FIELDS, fields);
	}

	/**
	 * Renders a topic selector struts field for the occupation field .
	 * It checks the preferences : <BR>
	 * <UL>
	 * <LI>topic-id : The root topic for the occupation. If not set, the field will not be rendered.
	 * <LI>multy-select-topic : Specifies the type of the topic (single.multy selection).
	 * <LI>
	 * </UL>
	 * @param fields
	 * @param request
	 */
	private void renderOccupationTopicField(Vector<StrutsFormFields> fields, boolean readOnlyFlag, String party_type, HttpServletRequest request){
		PortletRequest req = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
		try{
			// Get preferences for the topic field
			PortletPreferences prefs = req.getPreferences();
			String portletResource = "PA_CONTACTS"; //ParamUtil.getString(request, "portletResource");
			if (Validator.isNotNull(portletResource)) {
				PortletConfig config = (PortletConfig) req.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_CONFIG);
				if (!portletResource.equals(config.getPortletName())) // case of myAccount portlet
					prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, false, false);
				else
					prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
			}
			
			int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
			String topicPartyType = GetterUtil.getString(prefs.getValue("topic-party-type", StringPool.BLANK));
			
			boolean showTopicField = instanceTopicId > 0;
			if (!"all".equals(topicPartyType))
				showTopicField = party_type.equals(topicPartyType) && showTopicField;
			String multySelectTopic = prefs.getValue("multy-select-topic", "browse_topics_one");

			if (showTopicField) {
				StrutsFormFields new_field = new StrutsFormFields("occupationTopicIds","parties.manager.person.occupation", multySelectTopic, false, readOnlyFlag);
				
				fields.addElement(new_field);

			}
		}catch(Exception ex){
			
		}
	}
	
	
	private void renderIdFields(Vector<StrutsFormFields> fields, boolean readOnlyFlag, HttpServletRequest request, boolean hasAdmin){
		String idTypesCSV = GetterUtil.getString(PropsUtil.get(PortalUtil.getCompanyId(request),"parties.registered.identifier.types"),"");
		String idTypeKeysCSV = GetterUtil.getString(PropsUtil.get(PortalUtil.getCompanyId(request),"parties.registered.identifier.typekeys"),"");
		//Key added to support hiding selected identifiers from non admin users. 
		//Backward compatibility: if none specified, all identifiers will be available in MyAccount portlet (even for simple users)

		String idTypeCSVHiddenFromUser = GetterUtil.getString(PropsUtil.get(PortalUtil.getCompanyId(request),"parties.registered.identifier.userhidden.types"),"");
		
		String[] idTypes = idTypesCSV.split(",");
		String[] idTypeKeys = idTypeKeysCSV.split(",");
		String[] idHiddenTypes = (Validator.isNotNull(idTypeCSVHiddenFromUser)) ? idTypeCSVHiddenFromUser.split(",") : new String[] {};
		
		boolean showIdentifierAuthority = false;
		PortletRequest req = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
		try{
			// Get preferences for the topic field
			PortletPreferences prefs = req.getPreferences();
			String portletResource = "PA_CONTACTS"; //ParamUtil.getString(request, "portletResource");
			if (Validator.isNotNull(portletResource)) {
				PortletConfig config = (PortletConfig) req.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_CONFIG);
				if (!portletResource.equals(config.getPortletName())) // case of myAccount portlet
					prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, false, false);
				else
					prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
			}
			showIdentifierAuthority = GetterUtil.getBoolean(prefs.getValue("showIdentifierAuthority", StringPool.BLANK), false);
		} catch (Exception e){
			
		}
		
		for (int i=0; i<idTypes.length && i<=4; i++)
		{
			String type = idTypes[i];
			if (!type.equals(GetterUtil.getString(PropsUtil.get(PortalUtil.getCompanyId(request),"parties.registered.identifier.type.afm"),"")) && 
					(hasAdmin || !ArrayUtil.contains(idHiddenTypes, type)))
			{
				StrutsFormFields new_field = new StrutsFormFieldsGroupDelimiter("identifierGroup"+i,idTypeKeys[i]);
				fields.addElement(new_field);
				fields.addElement(new StrutsFormFields("identifier"+i+"Id","identifier"+i+"Id","text",true, true));
				fields.addElement(new StrutsFormFields("identifier"+i,"parties.manager.identifier.identifier","text",false, readOnlyFlag));

				if (showIdentifierAuthority)
					fields.addElement(new StrutsFormFields("identifier"+i+"Authority","parties.manager.identifier.registrationauthority","text",false, readOnlyFlag));
			}
		}
	}


	private void renderUploadFields(Vector<StrutsFormFields> fields, boolean readOnlyFlag, HttpServletRequest request){
		PortletRequest req = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
		try{
			// Get preferences for the topic field
			PortletPreferences prefs = req.getPreferences();
			String portletResource = "PA_CONTACTS"; 
			if (Validator.isNotNull(portletResource)) {
				PortletConfig config = (PortletConfig) req.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_CONFIG);
				if (!portletResource.equals(config.getPortletName())) // case of myAccount portlet
					prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, false, false);
				else
					prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
			}

			boolean showImageUpload = GetterUtil.getBoolean(prefs.getValue("showImageUpload", StringPool.BLANK), false);
			boolean showFileUpload = GetterUtil.getBoolean(prefs.getValue("showFileUpload", StringPool.BLANK), false);

			if (showImageUpload) {
				StrutsFormFields new_field = new StrutsFormFields("imageUploadContents","parties.upload.image","fileupload",false, readOnlyFlag);
				new_field.setClearDate(true);
				if (Validator.isNotNull(this.imageUpload)) {
					String filePath = GetterUtil.getString(PropsUtil.get("parties.upload.path.image"), CommonDefs.DEFAULT_STORE_PATH)+ this.mainid+File.separator;
					new_field.setUploadFilePath("FILESYSTEM"+File.separator + com.liferay.portal.util.PortalUtil.getCompanyId(request) + File.separator + filePath);
					new_field.setFileName(this.imageUpload);
					fields.addElement(new_field);

					// Image
					new_field = new StrutsFormFields("imageView","","image",false, true);
					String imageViewPath = "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath;
					imageViewPath = imageViewPath.replace('\\', '/');
					new_field.setUploadFilePath(imageViewPath);
					new_field.setImgWidth("50");
					new_field.setImgHeight("80");
					new_field.setFileName(this.imageUpload);
					fields.addElement(new_field);
				} else{
					fields.addElement(new_field);
				}
			}


			if (showFileUpload) {
				StrutsFormFields new_field = new StrutsFormFields("fileUploadContents","parties.upload.file","fileupload",false, readOnlyFlag);
				new_field.setClearDate(true);
				if (Validator.isNotNull(this.fileUpload)) {
					String filePath = GetterUtil.getString(PropsUtil.get("parties.upload.path.file"), CommonDefs.DEFAULT_STORE_PATH)+ this.mainid+File.separator;
					new_field.setUploadFilePath("FILESYSTEM"+File.separator + com.liferay.portal.util.PortalUtil.getCompanyId(request) + File.separator + filePath);
					new_field.setFileName(this.fileUpload);
					fields.addElement(new_field);

				} else{
					fields.addElement(new_field);
				}
			}
		}catch(Exception ex){

		}
	}


	public String getOccupationTopicIds() {
		return occupationTopicIds;
	}

	public void setOccupationTopicIds(String occupationTopicIds) {
		this.occupationTopicIds = occupationTopicIds;
	}

	public Integer getAddressId1() {
		return addressId1;
	}

	public void setAddressId1(Integer addressId1) {
		this.addressId1 = addressId1;
	}

	public Integer getAddressId2() {
		return addressId2;
	}

	public void setAddressId2(Integer addressId2) {
		this.addressId2 = addressId2;
	}

	public Integer getAddressId3() {
		return addressId3;
	}

	public void setAddressId3(Integer addressId3) {
		this.addressId3 = addressId3;
	}

	public Integer getAddressId4() {
		return addressId4;
	}

	public void setAddressId4(Integer addressId4) {
		this.addressId4 = addressId4;
	}

	public String getAddressLine1() {
		return addressLine1;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public String getAddressLine2() {
		return addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public String getAddressLine3() {
		return addressLine3;
	}

	public void setAddressLine3(String addressLine3) {
		this.addressLine3 = addressLine3;
	}

	public String getAddressLine4() {
		return addressLine4;
	}

	public void setAddressLine4(String addressLine4) {
		this.addressLine4 = addressLine4;
	}

	public String getAddressType1() {
		return addressType1;
	}

	public void setAddressType1(String addressType1) {
		this.addressType1 = addressType1;
	}

	public String getAddressType2() {
		return addressType2;
	}

	public void setAddressType2(String addressType2) {
		this.addressType2 = addressType2;
	}

	public String getAddressType3() {
		return addressType3;
	}

	public void setAddressType3(String addressType3) {
		this.addressType3 = addressType3;
	}

	public String getAddressType4() {
		return addressType4;
	}

	public void setAddressType4(String addressType4) {
		this.addressType4 = addressType4;
	}

	public String[] getAddressTypeKeys() {
		return addressTypeKeys;
	}

	public void setAddressTypeKeys(String[] addressTypeKyes) {
		this.addressTypeKeys = addressTypeKyes;
	}

	public String[] getAddressTypes() {
		return addressTypes;
	}

	public void setAddressTypes(String[] addressTypes) {
		this.addressTypes = addressTypes;
	}

	public String getAfm() {
		return afm;
	}

	public void setAfm(String afm) {
		this.afm = afm;
	}

	public Integer getAfmId() {
		return afmId;
	}

	public void setAfmId(Integer afmId) {
		this.afmId = afmId;
	}

	public String getCountryId1() {
		return countryId1;
	}

	public void setCountryId1(String countryId1) {
		this.countryId1 = countryId1;
	}

	public String getCountryId2() {
		return countryId2;
	}

	public void setCountryId2(String countryId2) {
		this.countryId2 = countryId2;
	}

	public String getCountryId3() {
		return countryId3;
	}

	public void setCountryId3(String countryId3) {
		this.countryId3 = countryId3;
	}

	public String getCountryId4() {
		return countryId4;
	}

	public void setCountryId4(String countryId4) {
		this.countryId4 = countryId4;
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

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getEmail3() {
		return email3;
	}

	public void setEmail3(String email3) {
		this.email3 = email3;
	}

	public String getEmail4() {
		return email4;
	}

	public void setEmail4(String email4) {
		this.email4 = email4;
	}

	public Integer getEmailId1() {
		return emailId1;
	}

	public void setEmailId1(Integer emailId1) {
		this.emailId1 = emailId1;
	}

	public Integer getEmailId2() {
		return emailId2;
	}

	public void setEmailId2(Integer emailId2) {
		this.emailId2 = emailId2;
	}

	public Integer getEmailId3() {
		return emailId3;
	}

	public void setEmailId3(Integer emailId3) {
		this.emailId3 = emailId3;
	}

	public Integer getEmailId4() {
		return emailId4;
	}

	public void setEmailId4(Integer emailId4) {
		this.emailId4 = emailId4;
	}

	public String getFamilyName() {
		return familyName;
	}

	public void setFamilyName(String familyName) {
		this.familyName = familyName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String[] getGenderKeys() {
		return genderKeys;
	}

	public void setGenderKeys(String[] genderKeys) {
		this.genderKeys = genderKeys;
	}

	public String[] getGenders() {
		return genders;
	}

	public void setGenders(String[] genders) {
		this.genders = genders;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public Integer getMainid() {
		return mainid;
	}

	public void setMainid(Integer mainid) {
		this.mainid = mainid;
	}


	public String getOrganizationName() {
		return organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	public String getOrgtypeid() {
		return orgtypeid;
	}

	public void setOrgtypeid(String orgtypeid) {
		this.orgtypeid = orgtypeid;
	}

	public String[] getOrgTypeIds() {
		return orgTypeIds;
	}

	public void setOrgTypeIds(String[] orgTypeIds) {
		this.orgTypeIds = orgTypeIds;
	}

	public String[] getOrgTypeNames() {
		return orgTypeNames;
	}

	public void setOrgTypeNames(String[] orgTypeNames) {
		this.orgTypeNames = orgTypeNames;
	}

	public String getPhysicalType1() {
		return physicalType1;
	}

	public void setPhysicalType1(String physicalType1) {
		this.physicalType1 = physicalType1;
	}

	public String getPhysicalType2() {
		return physicalType2;
	}

	public void setPhysicalType2(String physicalType2) {
		this.physicalType2 = physicalType2;
	}

	public String getPhysicalType3() {
		return physicalType3;
	}

	public void setPhysicalType3(String physicalType3) {
		this.physicalType3 = physicalType3;
	}

	public String getPhysicalType4() {
		return physicalType4;
	}

	public void setPhysicalType4(String physicalType4) {
		this.physicalType4 = physicalType4;
	}

	public String[] getPhysicalTypeKeys() {
		return physicalTypeKeys;
	}

	public void setPhysicalTypeKeys(String[] physicalTypeKeys) {
		this.physicalTypeKeys = physicalTypeKeys;
	}

	public String[] getPhysicalTypes() {
		return physicalTypes;
	}

	public void setPhysicalTypes(String[] physicalTypes) {
		this.physicalTypes = physicalTypes;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public Boolean getPrivateContact() {
		return privateContact;
	}

	public void setPrivateContact(Boolean privateContact) {
		this.privateContact = privateContact;
	}

	public String getRegion1() {
		return region1;
	}

	public void setRegion1(String region1) {
		this.region1 = region1;
	}

	public String getRegion2() {
		return region2;
	}

	public void setRegion2(String region2) {
		this.region2 = region2;
	}

	public String getRegion3() {
		return region3;
	}

	public void setRegion3(String region3) {
		this.region3 = region3;
	}

	public String getRegion4() {
		return region4;
	}

	public void setRegion4(String region4) {
		this.region4 = region4;
	}

	public String getRegistrationAuthority() {
		return registrationAuthority;
	}

	public void setRegistrationAuthority(String registrationAuthority) {
		this.registrationAuthority = registrationAuthority;
	}

	public String getTelephone1() {
		return telephone1;
	}

	public void setTelephone1(String telephone1) {
		this.telephone1 = telephone1;
	}

	public String getTelephone2() {
		return telephone2;
	}

	public void setTelephone2(String telephone2) {
		this.telephone2 = telephone2;
	}

	public String getTelephone3() {
		return telephone3;
	}

	public void setTelephone3(String telephone3) {
		this.telephone3 = telephone3;
	}

	public String getTelephone4() {
		return telephone4;
	}

	public void setTelephone4(String telephone4) {
		this.telephone4 = telephone4;
	}

	public Integer getTelephoneId1() {
		return telephoneId1;
	}

	public void setTelephoneId1(Integer telephoneId1) {
		this.telephoneId1 = telephoneId1;
	}

	public Integer getTelephoneId2() {
		return telephoneId2;
	}

	public void setTelephoneId2(Integer telephoneId2) {
		this.telephoneId2 = telephoneId2;
	}

	public Integer getTelephoneId3() {
		return telephoneId3;
	}

	public void setTelephoneId3(Integer telephoneId3) {
		this.telephoneId3 = telephoneId3;
	}

	public Integer getTelephoneId4() {
		return telephoneId4;
	}

	public void setTelephoneId4(Integer telephoneId4) {
		this.telephoneId4 = telephoneId4;
	}

	public String getWebpage1() {
		return webpage1;
	}

	public void setWebpage1(String webpage1) {
		this.webpage1 = webpage1;
	}

	public String getWebpage2() {
		return webpage2;
	}

	public void setWebpage2(String webpage2) {
		this.webpage2 = webpage2;
	}

	public String getWebpage3() {
		return webpage3;
	}

	public void setWebpage3(String webpage3) {
		this.webpage3 = webpage3;
	}

	public String getWebpage4() {
		return webpage4;
	}

	public void setWebpage4(String webpage4) {
		this.webpage4 = webpage4;
	}

	public Integer getWebpageId1() {
		return webpageId1;
	}

	public void setWebpageId1(Integer webpageId1) {
		this.webpageId1 = webpageId1;
	}

	public Integer getWebpageId2() {
		return webpageId2;
	}

	public void setWebpageId2(Integer webpageId2) {
		this.webpageId2 = webpageId2;
	}

	public Integer getWebpageId3() {
		return webpageId3;
	}

	public void setWebpageId3(Integer webpageId3) {
		this.webpageId3 = webpageId3;
	}

	public Integer getWebpageId4() {
		return webpageId4;
	}

	public void setWebpageId4(Integer webpageId4) {
		this.webpageId4 = webpageId4;
	}

	public String getZipOrPostCode1() {
		return zipOrPostCode1;
	}

	public void setZipOrPostCode1(String zipOrPostCode1) {
		this.zipOrPostCode1 = zipOrPostCode1;
	}

	public String getZipOrPostCode2() {
		return zipOrPostCode2;
	}

	public void setZipOrPostCode2(String zipOrPostCode2) {
		this.zipOrPostCode2 = zipOrPostCode2;
	}

	public String getZipOrPostCode3() {
		return zipOrPostCode3;
	}

	public void setZipOrPostCode3(String zipOrPostCode3) {
		this.zipOrPostCode3 = zipOrPostCode3;
	}

	public String getZipOrPostCode4() {
		return zipOrPostCode4;
	}

	public void setZipOrPostCode4(String zipOrPostCode4) {
		this.zipOrPostCode4 = zipOrPostCode4;
	}


	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}



	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPartyType() {
		return partyType;
	}

	public void setPartyType(String partyType) {
		this.partyType = partyType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}
	//
	//	public String getCountryName1() {
	//		return countryName1;
	//	}
	//
	//	public void setCountryName1(String countryName1) {
	//		this.countryName1 = countryName1;
	//	}
	//
	//	public String getCountryName2() {
	//		return countryName2;
	//	}
	//
	//	public void setCountryName2(String countryName2) {
	//		this.countryName2 = countryName2;
	//	}
	//
	//	public String getCountryName3() {
	//		return countryName3;
	//	}
	//
	//	public void setCountryName3(String countryName3) {
	//		this.countryName3 = countryName3;
	//	}
	//
	//	public String getCountryName4() {
	//		return countryName4;
	//	}
	//
	//	public void setCountryName4(String countryName4) {
	//		this.countryName4 = countryName4;
	//	}

	public Integer getIdentifier1Id() {
		return identifier1Id;
	}

	public void setIdentifier1Id(Integer identifier1Id) {
		this.identifier1Id = identifier1Id;
	}

	public String getIdentifier1() {
		return identifier1;
	}

	public void setIdentifier1(String identifier1) {
		this.identifier1 = identifier1;
	}

	public String getIdentifier1Authority() {
		return identifier1Authority;
	}

	public void setIdentifier1Authority(String identifier1Authority) {
		this.identifier1Authority = identifier1Authority;
	}

	public Integer getIdentifier2Id() {
		return identifier2Id;
	}

	public void setIdentifier2Id(Integer identifier2Id) {
		this.identifier2Id = identifier2Id;
	}

	public String getIdentifier2() {
		return identifier2;
	}

	public void setIdentifier2(String identifier2) {
		this.identifier2 = identifier2;
	}

	public String getIdentifier2Authority() {
		return identifier2Authority;
	}

	public void setIdentifier2Authority(String identifier2Authority) {
		this.identifier2Authority = identifier2Authority;
	}

	public Integer getIdentifier3Id() {
		return identifier3Id;
	}

	public void setIdentifier3Id(Integer identifier3Id) {
		this.identifier3Id = identifier3Id;
	}

	public String getIdentifier3() {
		return identifier3;
	}

	public void setIdentifier3(String identifier3) {
		this.identifier3 = identifier3;
	}

	public String getIdentifier3Authority() {
		return identifier3Authority;
	}

	public void setIdentifier3Authority(String identifier3Authority) {
		this.identifier3Authority = identifier3Authority;
	}

	public Integer getIdentifier4Id() {
		return identifier4Id;
	}

	public void setIdentifier4Id(Integer identifier4Id) {
		this.identifier4Id = identifier4Id;
	}

	public String getIdentifier4() {
		return identifier4;
	}

	public void setIdentifier4(String identifier4) {
		this.identifier4 = identifier4;
	}

	public String getIdentifier4Authority() {
		return identifier4Authority;
	}

	public void setIdentifier4Authority(String identifier4Authority) {
		this.identifier4Authority = identifier4Authority;
	}

	public Integer getIdentifier0Id() {
		return identifier0Id;
	}

	public void setIdentifier0Id(Integer identifier0Id) {
		this.identifier0Id = identifier0Id;
	}

	public String getIdentifier0() {
		return identifier0;
	}

	public void setIdentifier0(String identifier0) {
		this.identifier0 = identifier0;
	}

	public String getIdentifier0Authority() {
		return identifier0Authority;
	}

	public void setIdentifier0Authority(String identifier0Authority) {
		this.identifier0Authority = identifier0Authority;
	}

	public boolean isCreateUser() {
		return createUser;
	}

	public void setCreateUser(boolean createUser) {
		this.createUser = createUser;
	}

	public String getScreenName() {
		return screenName;
	}

	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}

	public String getPassword1() {
		return password1;
	}

	public void setPassword1(String password1) {
		this.password1 = password1;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getPsPartyRoleTypeId() {
		return psPartyRoleTypeId;
	}

	public void setPsPartyRoleTypeId(String psPartyRoleTypeId) {
		this.psPartyRoleTypeId = psPartyRoleTypeId;
	}

	public String[] getPsPartyRoleTypeIds() {
		return psPartyRoleTypeIds;
	}

	public void setPsPartyRoleTypeIds(String[] psPartyRoleTypeIds) {
		this.psPartyRoleTypeIds = psPartyRoleTypeIds;
	}

	public String[] getPsPartyRoleTypeNames() {
		return psPartyRoleTypeNames;
	}

	public void setPsPartyRoleTypeNames(String[] psPartyRoleTypeNames) {
		this.psPartyRoleTypeNames = psPartyRoleTypeNames;
	}

	public Boolean getActiveContact() {
		return activeContact;
	}

	public void setActiveContact(Boolean activeContact) {
		this.activeContact = activeContact;
	}

	public String getImageUpload() {
		return imageUpload;
	}

	public void setImageUpload(String imageUpload) {
		this.imageUpload = imageUpload;
	}

	public String getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(String fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getImageView() {
		return imageView;
	}

	public void setImageView(String imageView) {
		this.imageView = imageView;
	}

	@Override
	public Class getLuceneClass() {
		if (this.partyType != null && this.partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON))
		{
			return PaPerson.class;
		}
		else if (this.partyType != null && this.partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION))
		{
			return PaOrganization.class;
		}
		else if (this.partyType != null && this.partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_GROUP))
		{
			return PaGroup.class;
		}
		else
			return PaParty.class;
	}

	@Override
	public String getLuceneDate() {
		return LuceneUtilities.format.format(new java.util.Date());
	}

	@Override
	public String getLuceneDescription() {
		return "description";
	}

	@Override
	public String getLuceneFile() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getLucenePortlet() {
		return "PA_CONTACTS";
	}

	@Override
	public String getLuceneTitle() {
		return "description";
	}

	@Override
	public String getLuceneURL() {
		return "/ext/parties/contacts/load";
	}


}
