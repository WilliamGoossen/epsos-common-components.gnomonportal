package com.ext.portlet.epsos;

import epsos.ccd.gnomon.configmanager.ConfigurationManagerService;
import epsos.ccd.netsmart.securitymanager.XMLUtils;
import epsos.ccd.netsmart.securitymanager.sts.client.TRCAssertionRequest;
import gnomon.business.FileUploadHelper;
import gnomon.business.GeneralUtils;
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.model.ConnectionFactory;
import gnomon.hibernate.model.epsos.EpsosPatientConfirmation;
import gnomon.hibernate.model.parties.PsPartyRoleType;
import gnomon.hibernate.model.views.ViewResult;
import gnomon.util.GnPropsUtil;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.URL;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.Vector;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletRequest;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

import org.hibernate.Query;
import org.hibernate.Session;
import org.jfree.util.Log;
import org.opensaml.Configuration;
import org.opensaml.DefaultBootstrap;
import org.opensaml.common.SAMLObjectBuilder;
import org.opensaml.common.SAMLVersion;
import org.opensaml.common.SignableSAMLObject;
import org.opensaml.saml2.core.Advice;
import org.opensaml.saml2.core.Assertion;
import org.opensaml.saml2.core.AssertionIDRef;
import org.opensaml.saml2.core.Attribute;
import org.opensaml.saml2.core.AttributeStatement;
import org.opensaml.saml2.core.AttributeValue;
import org.opensaml.saml2.core.AuthnContext;
import org.opensaml.saml2.core.AuthnContextClassRef;
import org.opensaml.saml2.core.AuthnStatement;
import org.opensaml.saml2.core.Conditions;
import org.opensaml.saml2.core.Issuer;
import org.opensaml.saml2.core.NameID;
import org.opensaml.saml2.core.Subject;
import org.opensaml.saml2.core.SubjectConfirmation;
import org.opensaml.saml2.core.impl.AssertionMarshaller;
import org.opensaml.saml2.core.impl.IssuerBuilder;
import org.opensaml.xml.ConfigurationException;
import org.opensaml.xml.XMLObjectBuilder;
import org.opensaml.xml.XMLObjectBuilderFactory;
import org.opensaml.xml.io.MarshallingException;
import org.opensaml.xml.io.Unmarshaller;
import org.opensaml.xml.io.UnmarshallerFactory;
import org.opensaml.xml.io.UnmarshallingException;
import org.opensaml.xml.parse.BasicParserPool;
import org.opensaml.xml.parse.XMLParserException;
import org.opensaml.xml.schema.XSString;
import org.opensaml.xml.schema.XSURI;
import org.opensaml.xml.security.SecurityConfiguration;
import org.opensaml.xml.security.SecurityHelper;
import org.opensaml.xml.security.credential.Credential;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import org.allcolor.yahp.converter.CYaHPConverter;
import org.allcolor.yahp.converter.IHtmlToPdfTransformer;
import org.apache.commons.codec.binary.Base64;
import org.apache.fop.apps.Fop;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import org.apache.tools.ant.util.DateUtils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.ext.portlet.epsos.consent.PatientConsentObject;
import com.ext.portlet.epsos.demo.PatientSearchForm;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.sql.StrutsFormFields;
import com.ext.util.CommonDefs;
import com.ext.util.CommonUtil;
import com.ext.util.TitleData;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.action.LoginAction;
import com.liferay.portal.kernel.portlet.LiferayWindowState;
import com.liferay.portal.kernel.util.ByteArrayMaker;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.ActionResponseImpl;
import com.liferay.portlet.PortletURLImpl;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrDomainClientDto;
import com.spirit.ehr.ws.client.generated.EhrException_Exception;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.OrganisationalRolesClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.PolicySetItem;
import com.spirit.ehr.ws.client.generated.SourceSubmissionClientDto;
import com.spirit.ehr.ws.client.generated.SpiritOrganisationClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.SubmissionSetClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.InterfaceFactory;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;


public class EpsosHelperService {

	
	static private BASE64Encoder encoder = new BASE64Encoder();
	static private BASE64Decoder decoder = new BASE64Decoder();
	
	public final static String EPSOS_PATID_DEL1 = "___";
	public final static String EPSOS_PATID_DEL2 = "!!!";
	public final static String EPSOS_LOGIN_INFORMATION_ATTRIBUTE = "com.ext.portlet.epsos.LOGIN_INFORMATION";
	public final static String EPSOS_LOGIN_INFORMATION_ASSERTIONID = "com.ext.portlet.epsos.ASSERTIONID";
	public final static String EPSOS_LOGIN_INFORMATION_ASSERTION = "com.ext.portlet.epsos.ASSERTION";
	public final static String EPSOS_WEBSERVICE_ATTRIBUTE = "com.ext.portlet.epsos.WEB_SERVICE";

	public final static String EPSOS_USERNAME = "EPSOS_USERNAME";
	public final static String EPSOS_PASSWORD = "EPSOS_PASSWORD";
	
	public final static SimpleDateFormat dateFormat = new SimpleDateFormat(CommonDefs.DATE_FORMAT);
	public final static SimpleDateFormat dateTimeFormat = new SimpleDateFormat(CommonDefs.DATE_TIME_FORMAT);
	public final static SimpleDateFormat dateMetaDataFormat = new SimpleDateFormat("yyyyMMdd");

	private static EpsosHelperService instance = null;
	private static String epsosWebServiceURL;
	public static String defaultUserName;
	public static String defaultPassword;
	public static String mainPatientIdType;
	
	public final static PsPartyRoleType PHARMACIST = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "pharmacist");
	public final static PsPartyRoleType PHYSICIAN = (PsPartyRoleType)GnPersistenceService.getInstance(null).getOrCreateSystemType(PsPartyRoleType.class, "physician");
	
	private final static String XML_LOINC_SYSTEM = "LOINC",
	                            XML_LOINC_CODESYSTEM = "2.16.840.1.113883.6.1",
	                            XML_PRESCRIPTION_TEMPLATEID =  "1.3.6.1.4.1.12559.11.10.1.3.1.1.1",
	                            XML_PRESCRIPTION_ENTRY_TEMPLATEID = "1.3.6.1.4.1.12559.11.10.1.3.1.2.1",
	                            	
	                            XML_DISPENSATION_TEMPLATEID = "1.3.6.1.4.1.12559.11.10.1.3.1.1.2",
	                            XML_DISPENSATION_LOINC_CODE = "60593-1",
	                            XML_DISPENSATION_LOINC_CODESYSTEMNAME = "LOINC",
	                            XML_DISPENSATION_LOINC_CODESYSTEM = "2.16.840.1.113883.6.1",
	
	                            XML_DISPENSATION_TITLE = "Medication dispensed",
	                            XML_DISPENSATION_ENTRY_TEMPLATEID = "1.3.6.1.4.1.12559.11.10.1.3.1.2.2",
	                            XML_DISPENSATION_ENTRY_PARENT_TEMPLATEID = "2.16.840.1.113883.10.20.1.8", 
	                            XML_DISPENSTATION_ENTRY_REFERENCEID = "1.3.6.1.4.1.12559.11.10.1.3.1.3.2",
	                            XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE1 = "2.16.840.1.113883.10.20.1.34",
	                            XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE2 = "1.3.6.1.4.1.19376.1.5.3.1.4.7.3",
	                            XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE3 = "1.3.6.1.4.1.12559.11.10.1.3.1.3.3",
	                            XML_DISPENSATION_ENTRY_SUPPLY_ID_ROOT = "2.16.840.1.113883.2.19.40.5.410286.10.11",
	                            XML_DISPENSATION_PERFORMER_ID_ROOT = "1.3.6.1.4.1.19376.1.5.3.1.2.3",
	                            XML_DISPENSATION_PRODUCT_EPSOSNS = "urn:epsos-org:ep:medication",
	                            XML_DISPENSATION_PRODUCT_CLASSCODE = "MANU",
	                            XML_DISPENSATION_PRODUCT_TEMPLATE1 = "1.3.6.1.4.1.19376.1.5.3.1.4.7.2",
	                            XML_DISPENSATION_PRODUCT_TEMPLATE2 = "2.16.840.1.113883.10.20.1.53",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_CLASSCODE = "MMAT",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_CONTENT_CLASSCODE = "CONT",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_DETERMINERCODE = "KIND",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_CONTAINER_DETERMINERCODE = "INSTANCE",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_TEMPLATE = "1.3.6.1.4.1.12559.11.10.1.3.1.3.1",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_FORMCODE_SYSTEM = "1.3.6.1.4.1.12559.11.10.1.3.1.42.2",
	                            XML_DISPENSATION_PRODUCT_MATERIAL_CONTAINER_FORMCODE_SYSTEM = "1.3.6.1.4.1.12559.11.10.1.3.1.42.3"
	                            ;
	 
	private static Base64 decode = new Base64();
	
	private EpsosHelperService(){
		epsosWebServiceURL = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.webservice.url"), "");
		defaultUserName = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.webservice.username"), "");
		defaultPassword = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.webservice.password"), "");
		mainPatientIdType = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.patient.identifier.main.type"), "PI");
	}

	public void createLog(String message,SpiritUserClientDto usr)
	{
	String credentials = "";
	if (usr!=null)
	{
		credentials="USER: " + usr.getCommomName() + ",ROLE: " + usr.getLoginRole();
	}
	_log.info(credentials + " " + message);
	}
	
	public PatientSearchForm TransferXMLToForm(String xml)
	{
		PatientSearchForm psf = new PatientSearchForm();
		
		try {
			  _log.info("The requested xml is");
			  _log.info(xml);
			  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			  DocumentBuilder db = dbf.newDocumentBuilder();
			  ByteArrayInputStream bis = new ByteArrayInputStream(xml.getBytes());
			  Document doc = db.parse(bis);
			  doc.getDocumentElement().normalize();
			  NodeList nodeLst = doc.getElementsByTagName("field");

			  for (int s = 0; s < nodeLst.getLength(); s++) {

			    Node fstNode = nodeLst.item(s);
			    
			    if (fstNode.getNodeType() == Node.ELEMENT_NODE) {
			  
			      Element fstElmnt = (Element) fstNode;
			      NodeList fstNmElmntLst = fstElmnt.getElementsByTagName("name");
			      Element fstNmElmnt = (Element) fstNmElmntLst.item(0);
			      NodeList fstNm = fstNmElmnt.getChildNodes();
			      _log.info("FieldName: "  + ((Node) fstNm.item(0)).getNodeValue());
			      String fieldname = ((Node) fstNm.item(0)).getNodeValue();
			      NodeList lstNmElmntLst = fstElmnt.getElementsByTagName("value");
			      Element lstNmElmnt = (Element) lstNmElmntLst.item(0);
			      NodeList lstNm = lstNmElmnt.getChildNodes();
			      String fieldvalue="";
			      try
			      {
			      fieldvalue = ((Node) lstNm.item(0)).getNodeValue();
			      }
			      catch (Exception e)
			      {}
			      _log.info("FieldValue : " + fieldvalue);
			      
			    if (fieldname.equals("givenName")) { psf.setGivenName(fieldvalue);}
			    if (fieldname.equals("surName")) { psf.setSurName(fieldvalue);}
			    if (fieldname.equals("birthDate")) { psf.setBirthDate(fieldvalue);}
			    if (fieldname.equals("sex")) { psf.setSex(fieldvalue);}
			    if (fieldname.equals("street")) { psf.setStreet(fieldvalue);}
			    if (fieldname.equals("zipCode")) { psf.setZipCode(fieldvalue);}
			    if (fieldname.equals("city")) { psf.setCity(fieldvalue);}
			    if (fieldname.equals("country")) { psf.setCountry(fieldvalue);}
			    if (fieldname.equals("pid")) { psf.setPid(fieldvalue);}
			    if (fieldname.equals("pid1")) { psf.setPid1(fieldvalue);}
			    if (fieldname.equals("pid2")) { psf.setPid2(fieldvalue);}
			    if (fieldname.equals("pid3")) { psf.setPid3(fieldvalue);}
			    if (fieldname.equals("pid4")) { psf.setPid4(fieldvalue);}
			    if (fieldname.equals("pid5")) { psf.setPid5(fieldvalue);}
			    if (fieldname.equals("driversLicense")) { psf.setDriversLicense(fieldvalue);}
			    if (fieldname.equals("accountNumber")) { psf.setAccountNumber(fieldvalue);}
			    
			    }

			  }
			  } catch (Exception e) {
			    e.printStackTrace();
			  }
		
		
		return psf;
	}
	
	public EhrPatientClientDto createPatFilter(PatientSearchForm searchForm)
	{
		EhrPatientClientDto patFilter = new EhrPatientClientDto();
		if (Validator.isNotNull(searchForm.getSurName()))
			patFilter.setFamilyName(searchForm.getSurName());
		
		if (Validator.isNotNull(searchForm.getGivenName()))
			patFilter.setGivenName(searchForm.getGivenName());
		
		if (Validator.isNotNull(searchForm.getBirthDate()))
		{
			try {
				Date date = EpsosHelperService.dateFormat.parse(searchForm.getBirthDate());
				GregorianCalendar cal = (GregorianCalendar)GregorianCalendar.getInstance();
				cal.setTime(date);
				XMLGregorianCalendar xmlCal = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
				patFilter.setBirthdate(xmlCal);
			} catch (Exception e){}
		}
		
		if (Validator.isNotNull(searchForm.getSex()))
			patFilter.setSex(searchForm.getSex());
		
		if (Validator.isNotNull(searchForm.getStreet())) 
			patFilter.setStreetAddress(searchForm.getStreet());
		
		if (Validator.isNotNull(searchForm.getZipCode()))
			patFilter.setZip(searchForm.getZipCode());
		
		if (Validator.isNotNull(searchForm.getCity()))
			patFilter.setCity(searchForm.getCity());
		
		if (Validator.isNotNull(searchForm.getCountry()))
			patFilter.setCountry(searchForm.getCountry());
		
		
		// Identifier criteria
		if (Validator.isNotNull(searchForm.country))
		{
			String DEFAULT_PATIENT_IDS = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.search.patient.ids.default"), "ssnNumber,driversLicense,accountNumber");
			//String[] countryPatientIds = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.search.patient.ids."+searchForm.country), DEFAULT_PATIENT_IDS).split(",");
			
			EpsosHelperImpl eh = new EpsosHelperImpl();
			Vector countryPatientIds = EpsosHelperService.getInstance().getCountryIdsFromCS(searchForm.getCountry());
//			Vector<StrutsFormFields> fields = eh.getFieldsForCountryFromNCP(searchForm.getCountry());
			
//			String mainPIDType = GetterUtil.getString(GnPropsUtil.get("portalb", "epsos.patient.identifier.main.type"), "PI");
//			
//			if (Validator.isNotNull(searchForm.getPid())) {
//				EhrPIDClientDto pidDto = new EhrPIDClientDto();
//				pidDto.setPatientID(searchForm.getPid());
//				pidDto.setPatientIDType(mainPIDType);
//				
//				String RRI_OID = GetterUtil.getString(GnPropsUtil.get("portalb", "RRI." + searchForm.getCountry()), "");
//				EhrDomainClientDto domain = new EhrDomainClientDto();
//				domain.setAuthUniversalID(RRI_OID);
//				pidDto.setDomain(domain);
//				
//				patFilter.getPid().add(pidDto);
//			}
			
			String idType="";
			if (countryPatientIds != null && countryPatientIds.size() > 0)
			{
				int i=1;
				for (int j=0; j<countryPatientIds.size(); j++)
				//for (String idType: countryPatientIds)
				{
					SearchMask sm = (SearchMask) countryPatientIds.get(j);
					idType = sm.getDomain();
					if (idType != null && !idType.equals("none") && Validator.isNotNull(searchForm.getPid(i)))
					{
						EhrPIDClientDto pidDto = new EhrPIDClientDto();
						pidDto.setPatientID(searchForm.getPid(i));
						//pidDto.setPatientIDType(idType);
						
						EhrDomainClientDto domain = new EhrDomainClientDto();
						domain.setAuthUniversalID(idType);
						pidDto.setDomain(domain);
						
						patFilter.getPid().add(pidDto);
					}
					i++;
				}
			}
		}
		
		if (Validator.isNotNull(searchForm.getSsnNumber()))
			patFilter.setSsnNumber(searchForm.getSsnNumber());
		
		if (Validator.isNotNull(searchForm.getDriversLicense()))
			patFilter.setDrivingLicense(searchForm.getDriversLicense());

		if (Validator.isNotNull(searchForm.getAccountNumber()))
			patFilter.setAccountNumber(searchForm.getAccountNumber());
		
		return patFilter;
	}
	
	public void createLog(String message,SpiritUserClientDto usr, Priority priority)
	{
	String credentials = "";
	if (usr!=null)
	{
		credentials="USER: " + usr.getCommomName() + ",ROLE: " + usr.getLoginRole();
	}
	_log.log(priority,credentials + " " + message);

	}
	
	
	private static Logger _log = Logger.getLogger("EPSOSLOG");
	
	public static final synchronized EpsosHelperService getInstance(){
		if (instance == null){
			instance = new EpsosHelperService();
		}
		return instance;
	}

	public final SpiritEhrWsClientInterface getWebService(PortletRequest request)
	{
		return this.getWebService(CommonUtil.getHttpServletRequest(request));
	}

	public static void setupSSL(String enpointUrl, boolean sslDebug) {

        if (enpointUrl == null || !enpointUrl.startsWith("https")) {
            _log.info("setupSSL: no HTTPS found -> no setup needed");
            return;
        }

        // enable SSL-Debuging
        if (sslDebug) {
            System.setProperty("javax.net.debug", "ssl");
        }

        ConfigurationManagerService cms = ConfigurationManagerService.getInstance();
       
        // Setting Cert-Props
        System.setProperty("javax.net.ssl.trustStore", cms.getProperty("javax.net.ssl.trustStore"));
        System.setProperty("javax.net.ssl.trustStorePassword", cms.getProperty("javax.net.ssl.trustStorePassword"));
        System.setProperty("javax.net.ssl.keyStore", cms.getProperty("javax.net.ssl.keyStore"));
        System.setProperty("javax.net.ssl.keyStorePassword", cms.getProperty("javax.net.ssl.keyStorePassword"));

        HostnameVerifier hv = new HostnameVerifier() {
			@Override
		      public boolean verify(String urlHostName, SSLSession session) {
                System.out.println("URL Host: expected: " + urlHostName + " found: " + session.getPeerHost());
                return true;
            }
        };
        HttpsURLConnection.setDefaultHostnameVerifier(hv);
    }
	
//	public final SpiritEhrWsClientInterface getWebService()
//	{
//		SpiritEhrWsClientInterface webService = null;
//		try {				
//				webService = InterfaceFactory.createEhrWsInterface(epsosWebServiceURL,true);
//		} 
//		catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//		return webService;
//	}
	
	public final SpiritEhrWsClientInterface getWebService(HttpServletRequest request)
	{
		SpiritEhrWsClientInterface webService = null;
		EpsosHelperService.getInstance().createLog("NCP URL=" + epsosWebServiceURL,null);
		System.out.println("NCP URL=" + epsosWebServiceURL);
		try {
			
			webService = (SpiritEhrWsClientInterface)request.getSession().getAttribute(EPSOS_WEBSERVICE_ATTRIBUTE);
			if (webService == null)
			{
				setupSSL(epsosWebServiceURL,true);
				webService = InterfaceFactory.createEhrWsInterface(epsosWebServiceURL,true);
				request.getSession().setAttribute(EPSOS_WEBSERVICE_ATTRIBUTE, webService);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return webService;
	}

	public static Document createDomFromString(String inputFile)
	  {
	  
	  Document doc=null;
	  // Instantiate the document to be signed
	  try
	  {
	  DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	  dbFactory.setNamespaceAware(true);
	  doc = dbFactory
			       .newDocumentBuilder()
			       .parse(StringToStream(inputFile));
	  }
	  catch (Exception e)
	  {
	//  logger.error(e.getMessage());
	  }
	  return doc;

	  }
	
    public static InputStream StringToStream (String text)
    {
        InputStream is = null;
        try {
            is = new ByteArrayInputStream(text.getBytes());
        } catch (Exception e) {
     }
        return is;
    }

    private static enum SignatureType {
    	SIGN_BY_ID,
    	SIGN_BY_PATH,
    	SIGN_WHOLE_DOCUMENT
        };
    


    @SuppressWarnings("deprecation")
	public static void signSAMLAssertion(SignableSAMLObject as, String keyAlias, char[] keyPassword)
    throws Exception {
        //String KEY_STORE_NAME="Unknown-1";
        //String KEY_STORE_PASS="spirit";
        //String PRIVATE_KEY_PASS="spirit";
        //String KEY_ALIAS="server1";
        
    	ConfigurationManagerService cms = ConfigurationManagerService.getInstance();
    	
        //String KEY_STORE_NAME =GetterUtil.getString(GnPropsUtil.get("portalb", "KEYSTORE_LOCATION"),"Unknown-1");

    	String KEYSTORE_LOCATION =cms.getProperty("javax.net.ssl.keyStore");
        String KEY_STORE_PASS =cms.getProperty("javax.net.ssl.keyStorePassword"); //GetterUtil.getString(GnPropsUtil.get("portalb", "KEYSTORE_PASSWORD"),"spirit");
        String KEY_ALIAS = cms.getProperty("javax.net.ssl.key.alias"); //GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_ALIAS"),"server1");
        String PRIVATE_KEY_PASS = cms.getProperty("javax.net.ssl.privateKeyPassword"); //GetterUtil.getString(GnPropsUtil.get("portalb", "PRIVATEKEY_PASSWORD"),"spirit");
        _log.debug("-------" + KEYSTORE_LOCATION);
        _log.debug("-------" +KEY_STORE_PASS);
        _log.debug("-------" +KEY_ALIAS);
        _log.debug("-------" +PRIVATE_KEY_PASS);
        

    	
    	KeyStoreManager keyManager = new DefaultKeyStoreManager();
 //KeyPair kp = null;
 X509Certificate cert = null;
//check if we must use the default key
 PrivateKey privateKey =null;
 PublicKey publicKey =null;
if(keyAlias==null)
{
  // kp = keyManager.getDefaultPrivateKey();
   cert = (X509Certificate) keyManager.getDefaultCertificate();

} else {
	KeyStore keyStore = KeyStore.getInstance("JKS");
	ClassLoader cl = Thread.currentThread().getContextClassLoader();
	File file = new File(KEYSTORE_LOCATION);
	keyStore.load(
			new FileInputStream(file),
			KEY_STORE_PASS.toCharArray()
	);

	
	privateKey = (PrivateKey) keyStore.getKey(
			    KEY_ALIAS,
			    PRIVATE_KEY_PASS.toCharArray()
			);

	X509Certificate cert1 = (X509Certificate) keyStore.getCertificate(KEY_ALIAS);
	publicKey = cert1.getPublicKey();

    //kp = keyManager.getPrivateKey(keyAlias, keyPassword);
    cert = (X509Certificate) keyManager.getCertificate(keyAlias);
}

	org.opensaml.xml.signature.Signature sig = (org.opensaml.xml.signature.Signature) Configuration.getBuilderFactory().getBuilder(org.opensaml.xml.signature.Signature.DEFAULT_ELEMENT_NAME).buildObject(org.opensaml.xml.signature.Signature.DEFAULT_ELEMENT_NAME);
 

    Credential signingCredential = SecurityHelper.getSimpleCredential(cert, privateKey);

    //sig.setCanonicalizationAlgorithm(SignatureConstants.TRANSFORM_C14N_EXCL_OMIT_COMMENTS);
    sig.setSigningCredential(signingCredential);
   // sig.setKeyInfo(SecurityHelper.getKeyInfoGenerator(signingCredential, null, null).generate(signingCredential));
    sig.setSignatureAlgorithm("http://www.w3.org/2000/09/xmldsig#rsa-sha1");
    sig.setCanonicalizationAlgorithm("http://www.w3.org/2001/10/xml-exc-c14n#");

    SecurityConfiguration secConfig = Configuration.getGlobalSecurityConfiguration();
    try {
        SecurityHelper.prepareSignatureParams(sig, signingCredential, secConfig, null);
    }
    catch (SecurityException e) {
        throw new SMgrException(e.getMessage(), e);
    }

    as.setSignature(sig);
    try {
        Configuration.getMarshallerFactory().getMarshaller(as).marshall(as);
    }
    catch (MarshallingException e) {
        throw new SMgrException(e.getMessage(), e);
    }
    try {
    	org.opensaml.xml.signature.Signer.signObject(sig);
    }
    catch (Exception e)
    {
    	e.printStackTrace();
    }



}

   
    public static void sendXMLtoStream(Document doc, OutputStream out) {
        try {
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer trans = tf.newTransformer();
            //trans.setOutputProperty(OutputKeys.INDENT, "yes");
            trans.transform(new DOMSource(doc), new StreamResult(out));
        }
        catch (TransformerException ex) {
           ex.printStackTrace();
        }
    }

    public static Assertion createAssertion(String username,String role, String organization, String organizationId, 
    		String facilityType, String purposeOfUse, String xspaLocality, java.util.Vector permissions) 
    {
		// assertion
    	Assertion assertion = null;
		try {
			DefaultBootstrap.bootstrap();
			XMLObjectBuilderFactory builderFactory = Configuration.getBuilderFactory();

			SAMLObjectBuilder<Assertion> builder = (SAMLObjectBuilder<Assertion>) builderFactory.getBuilder(Assertion.DEFAULT_ELEMENT_NAME);

			// Create the NameIdentifier
	        SAMLObjectBuilder nameIdBuilder = (SAMLObjectBuilder) builderFactory.getBuilder(NameID.DEFAULT_ELEMENT_NAME);
	        NameID nameId = (NameID) nameIdBuilder.buildObject();
	        nameId.setValue(username);
	        //nameId.setNameQualifier(strNameQualifier);
	        nameId.setFormat(NameID.UNSPECIFIED);
	        
		
			assertion = create(Assertion.class,Assertion.DEFAULT_ELEMENT_NAME);
			
			String assId = "_"+UUID.randomUUID();
			assertion.setID(assId);
			assertion.setVersion(SAMLVersion.VERSION_20);
			assertion.setIssueInstant(new org.joda.time.DateTime().minusHours(3));

		
			Subject subject = create(Subject.class,Subject.DEFAULT_ELEMENT_NAME);
			assertion.setSubject(subject);
			subject.setNameID(nameId);
	        

							
	        //Create and add Subject Confirmation
	        SubjectConfirmation subjectConf = create (SubjectConfirmation.class,SubjectConfirmation.DEFAULT_ELEMENT_NAME);
	        subjectConf.setMethod(SubjectConfirmation.METHOD_SENDER_VOUCHES);
	        assertion.getSubject().getSubjectConfirmations().add(subjectConf);

	 
	        //Create and add conditions
	        Conditions conditions = create(Conditions.class,Conditions.DEFAULT_ELEMENT_NAME);
	        org.joda.time.DateTime now = new org.joda.time.DateTime();
	        conditions.setNotBefore(now.minusMinutes(1));
	        conditions.setNotOnOrAfter(now.plusHours(2)); // According to Spec
	        assertion.setConditions(conditions);
	        
//	        AudienceRestriction ar = create(AudienceRestriction.class,AudienceRestriction.DEFAULT_ELEMENT_NAME);
//	        Audience aud = create(Audience.class,Audience.DEFAULT_ELEMENT_NAME);
//	        aud.setAudienceURI("aaa");
	        
//	        conditions.s
			
	        Issuer issuer = new IssuerBuilder().buildObject();
	        issuer.setValue("urn:idp:countryB");
	        issuer.setNameQualifier("urn:epsos:wp34:assertions");
			assertion.setIssuer(issuer);
	        
			
			 //Add and create the authentication statement
	        AuthnStatement authStmt = create(AuthnStatement.class,AuthnStatement.DEFAULT_ELEMENT_NAME);
	        authStmt.setAuthnInstant(now.minusHours(2));
	        assertion.getAuthnStatements().add(authStmt);
		
	        
	       //Create and add AuthnContext
	        AuthnContext ac = create(AuthnContext.class,AuthnContext.DEFAULT_ELEMENT_NAME);
	        AuthnContextClassRef accr =create(AuthnContextClassRef.class,AuthnContextClassRef.DEFAULT_ELEMENT_NAME);
	        accr.setAuthnContextClassRef(AuthnContext.PASSWORD_AUTHN_CTX);
	        ac.setAuthnContextClassRef(accr);
	        authStmt.setAuthnContext(ac);       

	        AttributeStatement attrStmt =create(AttributeStatement.class,AttributeStatement.DEFAULT_ELEMENT_NAME);
	        
	        
	        // XSPA Subject
	        Attribute attrPID = createAttribute(builderFactory,"XSPA subject",
	        		"urn:oasis:names:tc:xacml:1.0:subject:subject-id",username,"","");      	        
	        attrStmt.getAttributes().add(attrPID);
	        // XSPA Role        
	        Attribute attrPID_1 = createAttribute(builderFactory,"XSPA role",
	        		"urn:oasis:names:tc:xacml:2.0:subject:role",role,"","");
	        attrStmt.getAttributes().add(attrPID_1);       
	        // HITSP Clinical Speciality
	/*        Attribute attrPID_2 = createAttribute(builderFactory,"HITSP Clinical Speciality",
	        		"urn:epsos:names:wp3.4:subject:clinical-speciality",role,"","");
	        attrStmt.getAttributes().add(attrPID_2);
	        */   
	        // XSPA Organization
	        Attribute attrPID_3 = createAttribute(builderFactory,"XSPA Organization",
	        		"urn:oasis:names:tc:xspa:1.0:subject:organization",organization,"","");
	        attrStmt.getAttributes().add(attrPID_3);   
	        // XSPA Organization ID
	        Attribute attrPID_4 = createAttribute(builderFactory,"XSPA Organization ID",
	        		"urn:oasis:names:tc:xspa:1.0:subject:organization-id",organizationId,"AA","");
	        attrStmt.getAttributes().add(attrPID_4);
	          

//	        // On behalf of
//	        Attribute attrPID_4 = createAttribute(builderFactory,"OnBehalfOf",
//			"urn:epsos:names:wp3.4:subject:on-behalf-of",organizationId,role,"");
//			attrStmt.getAttributes().add(attrPID_4);
	        
	        // epSOS Healthcare Facility Type
	        Attribute attrPID_5 = createAttribute(builderFactory,"epSOS Healthcare Facility Type",
	        		"urn:epsos:names:wp3.4:subject:healthcare-facility-type",facilityType,"","");
	        attrStmt.getAttributes().add(attrPID_5);
	        // XSPA Purpose of Use
	        Attribute attrPID_6 = createAttribute(builderFactory,"XSPA Purpose Of Use",
	        		"urn:oasis:names:tc:xspa:1.0:subject:purposeofuse",purposeOfUse,"","");
	        attrStmt.getAttributes().add(attrPID_6);
	        // XSPA Locality
	        Attribute attrPID_7 = createAttribute(builderFactory,"XSPA Locality",
	        		"urn:oasis:names:tc:xspa:1.0:environment:locality",xspaLocality,"","");
	        attrStmt.getAttributes().add(attrPID_7);
	        // HL7 Permissions
	        Attribute attrPID_8 = createAttribute(builderFactory,"Hl7 Permissions",
	        		"urn:oasis:names:tc:xspa:1.0:subject:hl7:permission");
	        Iterator itr = permissions.iterator();
	        while(itr.hasNext())
	        {
	        	attrPID_8 = AddAttributeValue(builderFactory,attrPID_8,itr.next().toString(),"","");
	        }
	        attrStmt.getAttributes().add(attrPID_8);
	       
	        assertion.getStatements().add(attrStmt);

		} catch (ConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		               
        return assertion;
    }

    public static Assertion createTRCAWithRef(EhrPatientClientDto patient,String purposeOfUse, String refAssertionId)
	throws ConfigurationException
	{
    return createTRCAWithRef("portalb@epsos.eu",patient,purposeOfUse,refAssertionId);
	}

    
    public static Assertion createTRCAWithRef(String email,EhrPatientClientDto patient,String purposeOfUse, String refAssertionId)
	throws ConfigurationException
{
// assertion
DefaultBootstrap.bootstrap();
XMLObjectBuilderFactory builderFactory = Configuration.getBuilderFactory();

SAMLObjectBuilder<Assertion> builder = (SAMLObjectBuilder<Assertion>) builderFactory.getBuilder(Assertion.DEFAULT_ELEMENT_NAME);

// Create the NameIdentifier
SAMLObjectBuilder nameIdBuilder = (SAMLObjectBuilder) builderFactory.getBuilder(NameID.DEFAULT_ELEMENT_NAME);
NameID nameId = (NameID) nameIdBuilder.buildObject();
nameId.setValue(email);
nameId.setFormat(NameID.EMAIL);     

Assertion assertion = create(Assertion.class,Assertion.DEFAULT_ELEMENT_NAME);

assertion.setID("_"+UUID.randomUUID());
assertion.setVersion(SAMLVersion.VERSION_20);
assertion.setIssueInstant(new org.joda.time.DateTime().minusHours(3));

Subject subject = create(Subject.class,Subject.DEFAULT_ELEMENT_NAME);
assertion.setSubject(subject);
subject.setNameID(nameId);  
				
//Create and add Subject Confirmation
SubjectConfirmation subjectConf = create (SubjectConfirmation.class,SubjectConfirmation.DEFAULT_ELEMENT_NAME);
subjectConf.setMethod(SubjectConfirmation.METHOD_SENDER_VOUCHES);
assertion.getSubject().getSubjectConfirmations().add(subjectConf);

String refAssId = refAssertionId;

// Advice
//Create and add Advice
Advice advice = create (Advice.class,Advice.DEFAULT_ELEMENT_NAME);
assertion.setAdvice(advice);

//Create and add AssertionIDRef
AssertionIDRef aIdRef = create(AssertionIDRef.class,AssertionIDRef.DEFAULT_ELEMENT_NAME);
aIdRef.setAssertionID(refAssId);
advice.getAssertionIDReferences().add(aIdRef);

//Advice advice = create(Advice.class,Advice.DEFAULT_ELEMENT_NAME);
//AssertionIDReference air = create(AssertionIDReference.class,AssertionIDReference.DEFAULT_ELEMENT_NAME);
//air.setReference(refAssId);
//advice.getAssertionIDReferences().add(air);
//assertion.setAdvice(advice);

//Create and add conditions
Conditions conditions = create(Conditions.class,Conditions.DEFAULT_ELEMENT_NAME);
org.joda.time.DateTime now = new org.joda.time.DateTime();
conditions.setNotBefore(now.minusHours(4));
conditions.setNotOnOrAfter(now.plusDays(1)); // According to Spec
assertion.setConditions(conditions);   

Issuer issuer = new IssuerBuilder().buildObject();
issuer.setValue("urn:idp:countryB");
issuer.setNameQualifier("urn:epsos:wp34:assertions");
assertion.setIssuer(issuer);    

 //Add and create the authentication statement
AuthnStatement authStmt = create(AuthnStatement.class,AuthnStatement.DEFAULT_ELEMENT_NAME);
authStmt.setAuthnInstant(now.minusHours(1));
assertion.getAuthnStatements().add(authStmt);

//Create and add AuthnContext
AuthnContext ac = create(AuthnContext.class,AuthnContext.DEFAULT_ELEMENT_NAME);
AuthnContextClassRef accr =create(AuthnContextClassRef.class,AuthnContextClassRef.DEFAULT_ELEMENT_NAME);
accr.setAuthnContextClassRef(AuthnContext.PREVIOUS_SESSION_AUTHN_CTX);
ac.setAuthnContextClassRef(accr);
authStmt.setAuthnContext(ac);       

AttributeStatement attrStmt =create(AttributeStatement.class,AttributeStatement.DEFAULT_ELEMENT_NAME);       

String pat = patient.getPid().get(0).getPatientID() + "^^^&" +  patient.getPid().get(0).getDomain().getAuthUniversalID() +
"&" + patient.getPid().get(0).getDomain().getAuthUniversalIDType();
// XSPA Subject
Attribute attrPID = createAttribute(builderFactory,"XSPA subject",
		"urn:oasis:names:tc:xacml:1.0:resource:resource-id",pat,"","");      	        
attrStmt.getAttributes().add(attrPID);
// XSPA Purpose of Use
Attribute attrPID_6 = createAttribute(builderFactory,"XSPA Purpose Of Use",
		"urn:oasis:names:tc:xspa:1.0:subject:purposeofuse",purposeOfUse,"","");
attrStmt.getAttributes().add(attrPID_6);

assertion.getStatements().add(attrStmt);
return assertion;
}

    
   
    
    public static Assertion createTRCA(HttpServletRequest req, String email,EhrPatientClientDto patient,String purposeOfUse)
    		throws ConfigurationException
    { 	
    	String refAssId = req.getSession().getAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTIONID)+"";
        Assertion assertion = createTRCAWithRef(email,patient,purposeOfUse,refAssId);
   	
    	return assertion;
    }

    public EhrPatientClientDto getPatientFromID(SpiritEhrWsClientInterface webservice, String patID, String patIDType, String country, String patids) throws EhrException_Exception
    {	
    	EhrPatientClientDto patFilter = null;
    	try
    	{
		patFilter = new EhrPatientClientDto();
		EhrPIDClientDto pidDto = new EhrPIDClientDto();

		if (Validator.isNull(patids))
		{
		pidDto.setPatientID(patID);
		pidDto.setPatientIDType(patIDType);
		patFilter.setCountry(country);
		String RRI_OID = GetterUtil.getString(GnPropsUtil.get("portalb", "RRI." + country), "");
		EhrDomainClientDto domain = new EhrDomainClientDto();
		domain.setAuthUniversalID(RRI_OID);
		pidDto.setDomain(domain);
		patFilter.getPid().add(pidDto);
		}
		else
		{
		String[] pats = patids.split(EPSOS_PATID_DEL2);
		for (int j=0; j<pats.length; j++)
		{		
		String[] patIdentifiers = pats[j].split(EPSOS_PATID_DEL1);
		for (int i=0; i<patIdentifiers.length; i++)
			{
			pidDto.setPatientID(patIdentifiers[0]);
			pidDto.setPatientIDType(patIdentifiers[1]);
			pidDto.setEhrPIDType(Integer.parseInt(patIdentifiers[5]));
			patFilter.setCountry(country);
//			String RRI_OID = GetterUtil.getString(GnPropsUtil.get("portalb", "RRI." + country), "");
			EhrDomainClientDto domain = new EhrDomainClientDto();
			domain.setAuthUniversalID(patIdentifiers[2]);
			domain.setAuthUniversalIDType(patIdentifiers[3]);
			domain.setAuthNamespaceID(patIdentifiers[4]);
			
			pidDto.setDomain(domain);
			patFilter.getPid().add(pidDto);		
			}
		}
		}
    	}
    	catch (Exception e)
    	{
    		return null;
    	}
		
		List<EhrPatientClientDto> result = null; 
		try
		{
		result = webservice.queryPatients(patFilter);
		}
		catch (Exception e)
		{
		_log.error("Error quering specific patient");
		}
		if (result != null && result.size() > 0)
		{
		return result.get(0);
		}
		else
		{
			return null;
		}
    }
    
    
    public EhrPatientClientDto getPatientFromRequest(PortletRequest request) throws EhrException_Exception
    {

    	List<EhrPatientClientDto> patients = (List<EhrPatientClientDto>)CommonUtil.getHttpServletRequest(request).getSession().getAttribute("patients");
    	String patID = ParamUtil.getString(request,"patID");
		_log.info("#### GETTING PATIENT FROM SESSION : "  + patID);
		EhrPatientClientDto patient = patients.get(Integer.parseInt(patID));
		return patient;
    }
    
	public final SpiritUserClientDto getEpsosUserInformation(PortletRequest request)
	{
		SpiritUserClientDto usr = null;

		try {
			HttpServletRequest httpReq = CommonUtil.getHttpServletRequest(request); 
			usr = (SpiritUserClientDto)httpReq.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
			} catch (Exception e)
		{
			e.printStackTrace();
		}
		return usr;
	}
	
	public static Attribute createAttribute(XMLObjectBuilderFactory builderFactory, String FriendlyName, String oasisName)
	{
       Attribute attrPID = create(Attribute.class,Attribute.DEFAULT_ELEMENT_NAME);
       attrPID.setFriendlyName(FriendlyName);
       attrPID.setName(oasisName);
       attrPID.setNameFormat(Attribute.URI_REFERENCE);
       return attrPID;
	}
	
	public static Attribute AddAttributeValue(XMLObjectBuilderFactory builderFactory, Attribute attribute,String value,String namespace, String xmlschema)
	{
	       XMLObjectBuilder stringBuilder = builderFactory.getBuilder(XSString.TYPE_NAME);
	       XSString attrValPID = (XSString) stringBuilder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSString.TYPE_NAME);
	       attrValPID.setValue(value);
	       attribute.getAttributeValues().add(attrValPID);	
	       return attribute;
	}
	
	public static Attribute createAttribute(XMLObjectBuilderFactory builderFactory, String FriendlyName, String oasisName, String value, String namespace, String xmlschema)
	{
       Attribute attrPID = create(Attribute.class,Attribute.DEFAULT_ELEMENT_NAME);
       attrPID.setFriendlyName(FriendlyName);
       attrPID.setName(oasisName);
       attrPID.setNameFormat(Attribute.URI_REFERENCE);
       //Create and add the Attribute Value 
       
       XMLObjectBuilder stringBuilder = null; 

       
       if (namespace.equals(""))
       {
    	   XSString attrValPID=null;
    	   stringBuilder = builderFactory.getBuilder(XSString.TYPE_NAME);
    	   attrValPID = (XSString) stringBuilder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME,XSString.TYPE_NAME);
    	   attrValPID.setValue(value);
           attrPID.getAttributeValues().add(attrValPID);
       }
       else
       {
    	   XSURI attrValPID=null;
    	   stringBuilder = builderFactory.getBuilder(XSURI.TYPE_NAME);
       attrValPID = (XSURI) stringBuilder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSURI.TYPE_NAME);
       attrValPID.setValue(value);
       attrPID.getAttributeValues().add(attrValPID);
       }
       
       return attrPID;
	}
	
	  public static <T> T create (Class<T> cls, QName qname)
	    {
	        return (T) ((XMLObjectBuilder)
	                Configuration.getBuilderFactory ().getBuilder (qname)).buildObject (qname);
	    }
	
	public final void logoutFromWebservice(HttpSession session)
	{
		SpiritUserClientDto usr = null;
		SpiritEhrWsClientInterface webService = null;
		try {
			usr = (SpiritUserClientDto)session.getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
			webService = (SpiritEhrWsClientInterface)session.getAttribute(EPSOS_WEBSERVICE_ATTRIBUTE);
			if (usr != null && webService != null)
			{
				webService.usrLogout();
				session.removeAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
				session.removeAttribute(EPSOS_WEBSERVICE_ATTRIBUTE);
			}	
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public final static String formatCreationTimeString(String creationTime)
	{
		String result = creationTime;
		if (creationTime != null && creationTime.length() == 14)
		{
			String year = creationTime.substring(0,4);
			String month = creationTime.substring(4,6);
			String day = creationTime.substring(6,8);
			String hour = creationTime.substring(8,10);
			String minute = creationTime.substring(10,12);
			String second = creationTime.substring(12);
			result = day+"/"+month+"/"+year+" "+hour+":"+minute+":"+second;
		}
		return result;
	}


	public final static Object[] callWebServiceForLoginOrganizationAndRole(SpiritUserClientDto usr)
	{
		OrganisationalRolesClientDto orgRole0 = usr.getOrganisationalRoles().get(0);
		SpiritOrganisationClientDto loginOrg = new SpiritOrganisationClientDto();
		loginOrg.setOrganisationDN(orgRole0.getOrganisationDN());
		loginOrg.setOrganisationName(orgRole0.getOrganisationName());

		String loginRole = orgRole0.getModuleRoles().get(0).getRoles().get(0);

		//TODO instead of this, we should call a web service here to get to this information:
		// String organizationDN
		// String organizationName
		// String loginRole

		Object[] result = new Object[2];
		result[0] = loginOrg;
		result[1] = loginRole;
		return result;
	}

	/**
	 * This method checks to see if a patient has given a confirmation for the currently logged in organization, and it
	 * is within its validity dates. It will return true if that is the case, false otherwise. It will also return true
	 * if no patient confirmation is required for the current country (or the default setting) according to the corresponding
	 * portal-ext.property
	 * @param request
	 * @param patient
	 * @return
	 */
	public final boolean hasPatientConfirmation(HttpServletRequest request, EhrPatientClientDto patient)
	{
		boolean result = false;
		try
		{
		boolean requiresConfirmation = true; //;GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.search.requires.patient.confirmation.default"), false);
		//int limitDays = GetterUtil.getInteger(GnPropsUtil.get("portalb", "epsos.search.patient.confirmation.duration.default"), -1);

		String country = request.getParameter("country");
		String patientIDType = request.getParameter("patIDType");
		//if (Validator.isNotNull(country))
		//{
//			requiresConfirmation = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.search.requires.patient.confirmation."+country), requiresConfirmation);
//			limitDays = GetterUtil.getInteger(GnPropsUtil.get("portalb", "epsos.search.patient.confirmation.duration."+country), limitDays);
//		}

		if (requiresConfirmation)
		{
			boolean denyConfirmation = false; // GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.always.show.confirmation.denied"), false);
			if (denyConfirmation)
				return false; // for demo purposes, even if a confirmation is found, return false to force new confirmation creation

			result = false;
			SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
			if (usr != null)
			{
				String orgid = usr.getLoginOrganisation().getOrganisationDN()+":"+usr.getLoginOrganisation().getOrganisationName();
				String patid = null;
				List<EhrPIDClientDto> ids =  patient.getPid();
				if (ids != null)
				{
					for (EhrPIDClientDto id: ids)
					{
						if (id.getPatientIDType().equals(patientIDType))
						{
							patid = id.getPatientID();
							break;
						}
					}
				}

				if (orgid != null && patid != null)
				{
//					Date now = new Date();
//					String hql = "from gnomon.hibernate.model.epsos.EpsosPatientConfirmation c where c.companyId = "+PortalUtil.getCompanyId(request)+
//					" and c.organizationId = '"+orgid +"' and c.patientId = '"+patid+"' and c.validFrom <= ? and (c.validTo >= ? or c.validTo is null)";
//					Session session = ConnectionFactory.getInstance().getSession();
//					try {
//						Query q = session.createQuery(hql);
//						q.setTimestamp(0, now);
//						q.setTimestamp(1, now);
//						List resultList = q.list();
//						if (resultList != null && resultList.size() > 0)
//							result = true;
//					} catch (Exception e)
//					{
//						e.printStackTrace();
//					} finally
//					{
//						if (session != null)
//							try {
//								session.close();
//							} catch (Exception e1) {}
//					}
				}
			}
		}
		result=true;
		}
		catch (Exception e) {result=false;}
		return result;
	}

	private static Assertion loadSamlAssertionAsResource(String filename) throws FileNotFoundException
    {
        Assertion hcpIdentityAssertion = null;
        try {
            BasicParserPool ppMgr = new BasicParserPool();
            ppMgr.setNamespaceAware(true);
            // Parse metadata file
            InputStream in = new FileInputStream(filename);//ClassLoader.getSystemResourceAsStream(filename);
            Document samlas = ppMgr.parse(in);
            Element samlasRoot = samlas.getDocumentElement();
            // Get apropriate unmarshaller
            UnmarshallerFactory unmarshallerFactory = Configuration.getUnmarshallerFactory();
            Unmarshaller unmarshaller = unmarshallerFactory.getUnmarshaller(samlasRoot);
            // Unmarshall using the document root element, an EntitiesDescriptor in this case
            hcpIdentityAssertion = (Assertion) unmarshaller.unmarshall(samlasRoot);
        }
        catch (UnmarshallingException ex) {
         
        }        catch (XMLParserException ex) {
         
        }

        return hcpIdentityAssertion;


    }
	
	
	
	public static Assertion loadSamlAssertionAsResourceFromXML(String xmlin) throws FileNotFoundException
    {
        Assertion hcpIdentityAssertion = null;
        try {
            BasicParserPool ppMgr = new BasicParserPool();
            ppMgr.setNamespaceAware(true);
            // Parse metadata file
            InputStream in = StringToStream(xmlin);//ClassLoader.getSystemResourceAsStream(filename);
            Document samlas = ppMgr.parse(in);
            Element samlasRoot = samlas.getDocumentElement();
            // Get apropriate unmarshaller
            UnmarshallerFactory unmarshallerFactory = Configuration.getUnmarshallerFactory();
            Unmarshaller unmarshaller = unmarshallerFactory.getUnmarshaller(samlasRoot);
            // Unmarshall using the document root element, an EntitiesDescriptor in this case
            hcpIdentityAssertion = (Assertion) unmarshaller.unmarshall(samlasRoot);
        }
        catch (UnmarshallingException ex) {
         
        }        catch (XMLParserException ex) {
         
        }

        return hcpIdentityAssertion;
    }
	
	public static String getPortalTranslation(String key, String language)
	{
		String translation = "";
		language = language.replaceAll("_", "-");
		try
		{
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        URL url = cl.getResource("content/language/application/" + language + "/SpiritEhrPortal.xml");
        
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		dbf.setValidating(false);
		dbf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(url.getFile());
		doc.getDocumentElement().normalize();
		XPath xpath = XPathFactory.newInstance().newXPath();
		translation = xpath.evaluate("//*[@key='" + key + "']", doc);
		if (Validator.isNull(translation)) translation = key; 
		}
		catch (Exception e)
		{
		Log.error(e.getMessage());
		}
		return translation;
	}
	
	public static String getConsentText(String language)
	{
		String translation = "";
		language = language.replaceAll("_", "-");
		try
		{
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        URL url = cl.getResource("content/language/consent/Consent_LegalText_" + language + ".xml");
        
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		dbf.setValidating(false);
		dbf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(url.getFile());
		doc.getDocumentElement().normalize();
		XPath xpath = XPathFactory.newInstance().newXPath();
		
		String xpathExpression = "/Consent/LegalText";
		NodeList nodes = (NodeList) xpath.evaluate
			       (xpathExpression, doc, XPathConstants.NODESET);
		translation = nodes.item(0).getTextContent();	
		}
		catch (Exception e)
		{
		Log.error("Error getting consent text for country " + language);
		}
		return translation;
	}
	public final SpiritUserClientDto createPatientConfirmationPlain(SpiritUserClientDto usr, String purpose, SpiritEhrWsClientInterface webservice, Assertion idAs, EhrPatientClientDto patient) throws PortalException, SystemException
	{
		//User user = PortalUtil.getUser(request);
		//SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		SpiritUserClientDto usr1 = null;
		EpsosHelperService epsos = null;
		
		boolean created=false;
		EpsosHelperService.getInstance().createLog("PURPOSE OF USE:" + patient.getGivenName() + " " + purpose ,usr);
		
		Document document = null;
		Document signedDoc = null;
		try {
	        // netsmart assertion
			String pat = "";
	        try
	        {
	        epsos = EpsosHelperService.getInstance(); 
	        pat = patient.getPid().get(0).getPatientID() + "^^^&" +  patient.getPid().get(0).getDomain().getAuthUniversalID() +
	        	"&" + patient.getPid().get(0).getDomain().getAuthUniversalIDType();
            TRCAssertionRequest req1 = new TRCAssertionRequest.Builder(idAs, pat)
                    .PurposeOfUse(purpose)
                    .build();           
            Assertion trc = req1.request();
            //TODO EXIT IF ERROR
	        AssertionMarshaller marshaller = new AssertionMarshaller();
	        Element element = marshaller.marshall(trc);
	        document = element.getOwnerDocument();	
	        //EpsosHelperService.sendXMLtoStream(document,System.out);
	        }
	        catch (Exception e)
	        {
	        	EpsosHelperService.getInstance().createLog("ERROR CREATING ASSERTION:" + patient.getGivenName() + " " + purpose ,usr);	        	
	        }
	        
	        // netsmart assertion
	        
			EpsosHelperService.getInstance().createLog("CREATING TRCA : " + pat,usr);
	    	usr1 = webservice.setTRCAssertion(document.getDocumentElement());    
	    	//request.getSession().setAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr);
	    	created=true;
		} catch (Exception e2) {
			e2.printStackTrace();		
		}
		return usr1;
	}
	/**
	 * This method will create a patient confirmation entry in the database, valid for the currently logged in 
	 * organization and for the time limit set for the currnt country (or the default setting) from the corresponding
	 * portal-ext.property. If the setting is that no patient confirmation is required, then this method does nothing.
	 * If a currently valid confirmation is available in the database for a different organization, then it is invalidated
	 * and replaced by this new one instead.
	 * @param request
	 * @param patient
	 * @return
	 * @throws SystemException 
	 * @throws PortalException 
	 */
	public final boolean createPatientConfirmation(HttpServletRequest request, EhrPatientClientDto patient) throws PortalException, SystemException
	{
		boolean created = false;
		EpsosHelperService epsos = EpsosHelperService.getInstance();;
		User user = PortalUtil.getUser(request);
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		String purpose = request.getParameter("purpose");
		SpiritEhrWsClientInterface webService = epsos.getWebService(request);
		Assertion idAs = (Assertion)request.getSession().getAttribute(EpsosHelperService.EPSOS_LOGIN_INFORMATION_ASSERTION);
		
		SpiritUserClientDto usr1 = null;
		try
			{
			usr1 = createPatientConfirmationPlain(usr, purpose, webService, idAs, patient);
			usr1.setDisplayName(user.getFullName());
			request.getSession().setAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE, usr1);
			created = true;
			}
		catch (Exception e)
			{
			_log.error("Error creating patient confirmation" + e.getMessage());
			e.printStackTrace();
			}
		return created;
	}

	public final boolean hasCurrentOrganizationPatientConsent(EhrPatientClientDto patient, HttpServletRequest request)
	{
		return (getCurrentOrganizationPatientConsent(patient, request) != null);
	}

	public XdsQArgsDocument getArgsForDP()
	{
		XdsQArgsDocument qArgs = new XdsQArgsDocument();

		String fc_cs = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.coding.scheme"), "2.16.840.1.113883.6.1");
		String fc_nr = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.code"), "60593-1");
		String fc_v = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.epsos.coding.scheme"), "urn:epsos:ep:dis:2010");		
		
		qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");
		IheClassificationClientDto classC = new IheClassificationClientDto();
		classC.setNodeRepresentation(fc_nr);
		classC.setValue(fc_v);
		classC.getSchema().add(fc_cs);					
		qArgs.getClassCodes().add(classC);
		return qArgs;

	}

	public XdsQArgsDocument getArgsForC()
	{
		XdsQArgsDocument qArgs = new XdsQArgsDocument();

		String fc_cs = GetterUtil.getString(GnPropsUtil.get("portalb", "pc.coding.scheme"), "2.16.840.1.113883.6.1");
		String fc_nr = GetterUtil.getString(GnPropsUtil.get("portalb", "pc.code"), "57016-8");
		String fc_v = GetterUtil.getString(GnPropsUtil.get("portalb", "pc.epsos.coding.scheme"), "urn:ihe:iti:bppc:2007");		
		
		qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");
		IheClassificationClientDto classC = new IheClassificationClientDto();
		classC.setNodeRepresentation(fc_nr);
		classC.setValue(fc_v);
		classC.getSchema().add(fc_cs);					
		qArgs.getClassCodes().add(classC);
		return qArgs;

	}
	
	
	public XdsQArgsDocument getArgsForEP()
	{
		XdsQArgsDocument qArgs = new XdsQArgsDocument();

		String fc_cs = GetterUtil.getString(GnPropsUtil.get("portalb", "ep.coding.scheme"), "2.16.840.1.113883.6.1");
		String fc_nr = GetterUtil.getString(GnPropsUtil.get("portalb", "ep.code"), "57833-6");
		String fc_v = GetterUtil.getString(GnPropsUtil.get("portalb", "ep.epsos.coding.scheme"), "urn:epSOS:ep:pre:2010");		
		
		qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");
		IheClassificationClientDto classC = new IheClassificationClientDto();
		classC.setNodeRepresentation(fc_nr);				
		classC.setValue(fc_v);
		classC.getSchema().add(fc_cs);				
		qArgs.getClassCodes().add(classC);
		return qArgs;

	}
	
	public XdsQArgsDocument getArgsForPS()
	{
		XdsQArgsDocument qArgs = new XdsQArgsDocument();

		String fc_cs = GetterUtil.getString(GnPropsUtil.get("portalb", "ps.coding.scheme"), "2.16.840.1.113883.6.1");
		String fc_nr = GetterUtil.getString(GnPropsUtil.get("portalb", "ps.code"), "60591-5");
		String fc_v = GetterUtil.getString(GnPropsUtil.get("portalb", "ps.epsos.coding.scheme"), "urn:epSOS:ps:ps:2010");		

		qArgs.getDocumentStatus().add("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Approved");
		IheClassificationClientDto classC = new IheClassificationClientDto();
		classC.setNodeRepresentation(fc_nr);
		classC.setValue(fc_v);
		classC.getSchema().add(fc_cs);					
		qArgs.getClassCodes().add(classC);
		return qArgs;

	}
	
	
	public final List<PolicySetGroup> getCurrentOrganizationPatientConsent(EhrPatientClientDto patient, HttpServletRequest request)
	{
		List<PolicySetGroup> result = null;
		
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		String countryA = patient.getCountry();
		String countryB = getHomeOrganizationCountry(usr);
		if (usr != null && countryA != null && countryB != null)
		{
			// call document query webservice, with consent format code to see if such a document exists
			SpiritEhrWsClientInterface webservice = this.getWebService(request);
			
			try {
			EpsosHelperService.getInstance().createLog("QUERY POLICY SETS:" + patient.getGivenName(),usr);
			result = webservice.queryPolicySetsForPatient(patient).getGroupList();
			EpsosHelperService.getInstance().createLog("QUERY POLICY SETS: FOUND " + result.size() + " " + patient.getGivenName(),usr);
			} catch (Exception e1) {
				if (e1 instanceof EhrException_Exception)
				{
					return null;  // no consent found
				}
			}

			boolean denyConsent = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.always.show.consent.denied"), false);
			if (denyConsent)
				return null; // for demo purposes, even if a consent is found, return NONE to force new consent creation
			/**
			 * 
			 * 
			XdsQArgsDocument qArgs = new XdsQArgsDocument();
			// format codes for consent documents is urn:ihe:iti:bppc-sd:2007 ^^ 1.3.6.1.4.1.19376.1.2.3
			IheClassificationClientDto formatCode = new IheClassificationClientDto();
			formatCode.setNodeRepresentation("urn:ihe:iti:bppc-sd:2007");
			formatCode.setValue("urn:ihe:iti:bppc:2007");
			formatCode.getSchema().add("1.3.6.1.4.1.19376.1.2.3");
			qArgs.getFormatCodes().add(formatCode);
			PatientContentClientDto consentQueryResult = null; 
			try {
				consentQueryResult = webservice.queryDocuments(patient.getPid(), qArgs);
			} catch (Exception e1) {
				if (e1 instanceof EhrException_Exception)
				{
					return null;  // no consent found
				}
			}
			if (consentQueryResult == null || consentQueryResult.getDocuments() == null || consentQueryResult.getDocuments().size() < 1)
				return null;
			 
			result = new PatientConsentObject(); 
			
			//WILL-NOT-BE-DONE populate from web service result
			 
			result.setConsentid(consentQueryResult.getDocuments().get(0).getUUID());
			result.setPatientId(patient.getPid().get(0).getPatientID());
			Calendar cal = Calendar.getInstance();
			Date now = cal.getTime();
			cal.add(Calendar.MONTH, 1);
			Date nowPlus1Month = cal.getTime();
			result.setCreationDate(now);
			result.setValidFrom(now);
			result.setValidTo(nowPlus1Month);
			result.setDoctorName(usr.getDisplayName());
			String address = "";
			if (usr.getPostalAddress() != null)
			{
				for (String a: usr.getPostalAddress())
				{
					address += a + " ";
				}
			}
			result.setDoctorAddress(address);
			result.setCountry(getHomeOrganizationCountry(usr));
			**/
		}
		return result;
	}

	public final PatientConsentObject getPatientConsentById(String consentid, EhrPatientClientDto patient, HttpServletRequest request)
	{
		PatientConsentObject result = null;
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr != null && patient != null)
		{
			SpiritEhrWsClientInterface webservice = this.getWebService(request);
			XdsQArgsDocument qArgs = new XdsQArgsDocument();
						
			String fc_nr = GetterUtil.getString(GnPropsUtil.get("portalb", "pc.ihe.sd.coding.scheme"), "urn:ihe:iti:bppc-sd:2007");
			String fc_v  = GetterUtil.getString(GnPropsUtil.get("portalb", "pc.ihe.coding.scheme"), "urn:ihe:iti:bppc:2007");
			String fc_schema = GetterUtil.getString(GnPropsUtil.get("portalb", "pc.coding.scheme"), "2.16.840.1.113883.6.1");
			
			// format codes for consent documents is urn:ihe:iti:bppc-sd:2007 ^^ 1.3.6.1.4.1.19376.1.2.3
			// See http://gazelle.ihe.net/?q=node/133
			IheClassificationClientDto formatCode = new IheClassificationClientDto();
			formatCode.setNodeRepresentation(fc_nr);
			formatCode.setValue(fc_v);
			formatCode.getSchema().add(fc_schema);
			qArgs.getFormatCodes().add(formatCode);
			
			PatientContentClientDto consentQueryResult = null; 
			try {
				consentQueryResult = webservice.queryDocuments(patient.getPid(), qArgs);
			} catch (Exception e1) {
				
			}
			if (consentQueryResult == null || consentQueryResult.getDocuments() == null || consentQueryResult.getDocuments().size() < 1)
				return null;
			else
			{
				for (DocumentClientDto doc: consentQueryResult.getDocuments())
				{
					if (doc.getUniqueId().equals(consentid))
					{
						result = new PatientConsentObject();

						//WILL-NOT-BE-DONE populate from web service result 
						result.setConsentid(consentid);
						result.setPatientId(patient.getPid().get(0).getPatientID());
						Calendar cal = Calendar.getInstance();
						Date now = cal.getTime();
						cal.add(Calendar.MONTH, 1);
						Date nowPlus1Month = cal.getTime();
						result.setCreationDate(now);
						result.setValidFrom(now);
						result.setValidTo(nowPlus1Month);
						result.setDoctorName(usr.getDisplayName());
						String address = "";
						if (usr.getPostalAddress() != null)
						{
							for (String a: usr.getPostalAddress())
							{
								address += a + " ";
							}
						}
						result.setDoctorAddress(address);
						result.setCountry(getHomeOrganizationCountry(usr));
						break;
					}
				}
			}
			
		}
		return result;
	}

	public final boolean addPatientConsent(PatientConsentObject object, EhrPatientClientDto patient, HttpServletRequest request)
	{
		boolean consentCreated=false;
		PatientConsentObject result = null;
		
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr != null)
		{
			//upload consent document
			try {
				SpiritEhrWsClientInterface webservice = this.getWebService(request);
				
				List<PolicySetGroup> objGroupList = webservice.queryPolicySetsForPatient(patient).getGroupList();

				
				String[] policyids = request.getParameterValues("policyid");
				
				if (policyids != null && objGroupList != null)
				{
					for (PolicySetGroup g: objGroupList)
					{
						// first unselect all policies:
						for (PolicySetItem i: g.getPolicySetItemList())
						{
							i.setSelected(false);
						}
						
						// then only select the ones selected by the user in the interface
						for (String id: policyids)
						{
							String groupCode = id.substring(0, id.indexOf("$$$"));
							if (groupCode.equals(g.getCode()))
							{
								String policyId = id.substring(id.indexOf("$$$")+3);
								for (PolicySetItem i: g.getPolicySetItemList())
								{
									if (i.getPolicySetId().equals(policyId))
									{
										i.setSelected(true);
										GregorianCalendar cal = (GregorianCalendar)GregorianCalendar.getInstance();
										Date fromDate = GetterUtil.getDate(request.getParameter(groupCode+"$$$"+policyId+"_fromDate"), dateTimeFormat, null);
										if (fromDate != null)
										{
											cal.setTime(fromDate);
											XMLGregorianCalendar fromCal = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
											i.setEffectiveDateFrom(fromCal);
										}
										Date toDate = GetterUtil.getDate(request.getParameter(groupCode+"$$$"+policyId+"_toDate"), dateTimeFormat, null);
										if (toDate != null)
										{
											cal.setTime(toDate);
											XMLGregorianCalendar toCal = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
											i.setEffectiveDateTo(toCal);
										}
									}
								}
							}
						}
					}
				}
				EpsosHelperService.getInstance().createLog("CREATE PATIENT CONSENT REQUEST:" + patient.getGivenName(),usr);
				webservice.saveConsent(patient, GeneralUtils.getLocale(request), "Patient Consent", objGroupList);
				consentCreated=true;
				EpsosHelperService.getInstance().createLog("CREATE PATIENT CONSENT RESPONSE OK:" + patient.getGivenName(),usr);
				
			} catch (Exception e1)
			{
				EpsosHelperService.getInstance().createLog("CREATE PATIENT CONSENT RESPONSE FAILURE:" + patient.getGivenName() + ".ERROR: " + e1.getMessage(),usr);
				request.setAttribute("exception", e1.getMessage());
				e1.printStackTrace();
			}

			//result = object;
		}
		return consentCreated;
	}

	@Deprecated
	public static boolean writeConsent(SpiritEhrWsClientInterface webservice, String patID, String patIDType, String country, String language, String policy, String fromdate, String todate)
	{
		EhrPatientClientDto patient = null;
		try {
			patient = EpsosHelperService.getInstance().getPatientFromID(webservice, patID, patIDType, country,null);
		} catch (EhrException_Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return writeConsent(webservice,patient,country,language,policy,fromdate,todate);
	}

	public static boolean writeConsent(SpiritEhrWsClientInterface webservice, EhrPatientClientDto patient, String country, String language, String policy, String fromdate, String todate)
	{
		boolean consentCreated=false;
		PatientConsentObject result = null;
		if (true)
		{
			//upload consent document
			try {
				List<PolicySetGroup> objGroupList = webservice.queryPolicySetsForPatient(patient).getGroupList();
				
				String[] policyids = new String[] {policy};
				if (policyids != null && objGroupList != null)
				{
					for (PolicySetGroup g: objGroupList)
					{
						// first unselect all policies:
						for (PolicySetItem i: g.getPolicySetItemList())
						{
							i.setSelected(false);
						}
						
						// then only select the ones selected by the user in the interface
						for (String id: policyids)
						{
							
							String groupCode = id.substring(0, id.indexOf("$$$"));
							_log.info("groupode=" + groupCode);
							if (groupCode.equals(g.getCode()))
							{
								String policyId = id.substring(id.indexOf("$$$")+3);
								_log.info("policyid=" + policyId);
								for (PolicySetItem i: g.getPolicySetItemList())
								{
									if (i.getPolicySetId().equals(policyId))
									{
										i.setSelected(true);
										GregorianCalendar cal = (GregorianCalendar)GregorianCalendar.getInstance();
										Date fromDate = GetterUtil.getDate(fromdate, dateTimeFormat, null);
										if (fromDate != null)
										{
											cal.setTime(fromDate);
											XMLGregorianCalendar fromCal = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
											i.setEffectiveDateFrom(fromCal);
										}
										Date toDate = GetterUtil.getDate(todate, dateTimeFormat, null);
										if (toDate != null)
										{
											cal.setTime(toDate);
											XMLGregorianCalendar toCal = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
											i.setEffectiveDateTo(toCal);
										}
									}
								}
							}
						}
					}
				}
				EpsosHelperService.getInstance().createLog("CREATE PATIENT CONSENT REQUEST:" + patient.getGivenName(),null);
				webservice.saveConsent(patient, language, "Patient Consent", objGroupList);
				consentCreated=true;
				EpsosHelperService.getInstance().createLog("CREATE PATIENT CONSENT RESPONSE OK:" + patient.getGivenName(),null);
				
			} catch (Exception e1)
			{
				EpsosHelperService.getInstance().createLog("CREATE PATIENT CONSENT RESPONSE FAILURE:" + patient.getGivenName() + ".ERROR: " + e1.getMessage(),null);
				e1.printStackTrace();
			}

			//result = object;
		}
		return consentCreated;
	}
	

	public final void updatePatientConsent(PatientConsentObject object, EhrPatientClientDto patient, HttpServletRequest request)
	{
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr != null && patient != null &&  object != null)
		{
			//WILL-NOT-BE-DONE call web service here to update a specific consent for the given patient

		}
	}

	public final void deletePatientConsent(PatientConsentObject object, EhrPatientClientDto patient, HttpServletRequest request)
	{
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr != null && patient != null && object != null)
		{
			//WILL-NOT-BE-DONE call web service here to delete a specific consent for the given patient

		}
	}


	public final List<PatientConsentObject> listPatientConsents(EhrPatientClientDto patient, HttpServletRequest request)
	{
		ArrayList<PatientConsentObject> result = null;
		SpiritUserClientDto usr = (SpiritUserClientDto)request.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr!= null && patient != null)
		{
			//WILL-NOT-BE-DONE call web service here to get a list of patient consents for the given patient, and the country of the doctor Organization
			result = new ArrayList<PatientConsentObject>();

			PatientConsentObject entry = new PatientConsentObject();
			entry.setConsentid("1");
			entry.setPatientId(patient.getPid().get(0).getPatientID());
			Calendar cal = Calendar.getInstance();
			Date now = cal.getTime();
			cal.add(Calendar.MONTH, 1);
			Date nowPlus1Month = cal.getTime();
			entry.setCreationDate(now);
			entry.setValidFrom(now);
			entry.setValidTo(nowPlus1Month);
			entry.setDoctorName(usr.getDisplayName());
			String address = "";
			if (usr.getPostalAddress() != null)
			{
				for (String a: usr.getPostalAddress())
				{
					address += a + " ";
				}
			}
			entry.setDoctorAddress(address);
			entry.setCountry(getHomeOrganizationCountry(usr));

			result.add(entry);
		}
		return result;
	}



	public TitleData generatePatientTitleData(PortletRequest req, EhrPatientClientDto patient)
	{
		XMLGregorianCalendar xgc = patient.getBirthdate();
		Date  newDate = xgc.toGregorianCalendar().getTime();
		TitleData titleData = new TitleData();
		titleData.put("epsos.demo.search.givenName", patient.getGivenName());
		titleData.put("epsos.demo.search.familyName", patient.getFamilyName());
		titleData.put("epsos.demo.search.streetAddress", patient.getStreetAddress());
		titleData.put("epsos.demo.search.zip", patient.getZip());
		titleData.put("epsos.demo.search.city", patient.getCity());
		titleData.put("epsos.demo.search.country", patient.getCountry());
		titleData.put("epsos.demo.search.birthdate",EpsosHelperService.dateFormat.format(newDate));
		titleData.setRequest(req);
		return titleData;
	}

	public String getHomeOrganizationCountry(SpiritUserClientDto usr)
	{
		String result = null;
		if (usr != null && usr.getHomeOrganisation() != null && usr.getHomeOrganisation().getOrganisationDN() != null)
		{
			String[] dns = usr.getHomeOrganisation().getOrganisationDN().split(",");
			if (dns != null)
			{
				for (String dn: dns)
				{
					dn = dn.toUpperCase();
					if (dn.startsWith("C="))
						result = dn.substring(2);
				}
			}
		}
		return result;
	}


	public List<ViewResult> parsePrescriptionDocumentForPrescriptionLines(byte[] bytes)
	{
		ArrayList<ViewResult> lines = new ArrayList<ViewResult>();
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document dom  = db.parse(new ByteArrayInputStream(bytes));

			XPath xpath = XPathFactory.newInstance().newXPath();
			
			// header xpaths
//			XPathExpression performerPrefixExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/assignedPerson/name/prefix");
//			XPathExpression performerSurnameExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/assignedPerson/name/family");
//			XPathExpression performerGivenNameExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/assignedPerson/name/given");
//			XPathExpression professionExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/functionCode");
//			XPathExpression facilityNameExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/representedOrganization/name");
//			XPathExpression facilityAddressStreetExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/representedOrganization/addr/streetAddressLine");
//			XPathExpression facilityAddressZipExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/representedOrganization/addr/postalCode");
//			XPathExpression facilityAddressCityExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/representedOrganization/addr/city");
//			XPathExpression facilityAddressCountryExpr = xpath.compile("/ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/representedOrganization/addr/country");
			
			
			XPathExpression performerPrefixExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/assignedPerson/name/prefix");
			XPathExpression performerSurnameExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/assignedPerson/name/family");
			XPathExpression performerGivenNameExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/assignedPerson/name/given");
			XPathExpression professionExpr = xpath.compile("/ClinicalDocument/author/functionCode");
			XPathExpression facilityNameExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/representedOrganization/name");
			XPathExpression facilityAddressStreetExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/representedOrganization/addr/streetAddressLine");
			XPathExpression facilityAddressZipExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/representedOrganization/addr/postalCode");
			XPathExpression facilityAddressCityExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/representedOrganization/addr/city");
			XPathExpression facilityAddressCountryExpr = xpath.compile("/ClinicalDocument/author/assignedAuthor/representedOrganization/addr/country");
			XPathExpression prescriptionIDExpr = xpath.compile("/ClinicalDocument/component/structuredBody/component/section[templateId/@root='1.3.6.1.4.1.12559.11.10.1.3.1.2.1']");
					
			
			String performer = "";
			Node performerPrefix = (Node) performerPrefixExpr.evaluate(dom, XPathConstants.NODE);
			if (performerPrefix != null)
			{
				performer += performerPrefix.getTextContent().trim() + " ";
			}
			Node performerSurname = (Node) performerSurnameExpr.evaluate(dom, XPathConstants.NODE);
			if (performerSurname != null)
			{
				performer += performerSurname.getTextContent().trim();
			}
			Node performerGivenName = (Node) performerGivenNameExpr.evaluate(dom, XPathConstants.NODE);
			if (performerGivenName != null)
			{
				performer += " "+performerGivenName.getTextContent().trim();
			}
			
			String profession = "";
			Node professionNode = (Node) professionExpr.evaluate(dom, XPathConstants.NODE);
			if (professionNode != null)
			{
				profession += professionNode.getAttributes().getNamedItem("displayName").getNodeValue();
			}
			
			String facility = "";
			Node facilityNode = (Node) facilityNameExpr.evaluate(dom, XPathConstants.NODE);
			if (facilityNode != null)
			{
				facility += facilityNode.getTextContent().trim();
			}
			
			String address = "";
			Node street = (Node) facilityAddressStreetExpr.evaluate(dom, XPathConstants.NODE);
			if ( street != null)
			{
				address += street.getTextContent().trim();
			}
			Node zip = (Node) facilityAddressZipExpr.evaluate(dom, XPathConstants.NODE);
			if (zip != null)
			{
				address += ", "+zip.getTextContent().trim();
			}
			Node city = (Node) facilityAddressCityExpr.evaluate(dom, XPathConstants.NODE);
			if ( city != null)
			{
				address += ", "+city.getTextContent().trim();
			}
			Node country = (Node) facilityAddressCountryExpr.evaluate(dom, XPathConstants.NODE);
			if ( country != null)
			{
				address += ", "+country.getTextContent().trim();
			}
			
			
			// for each prescription component, search for its entries and make up the list
			String prescriptionID = "";
			NodeList prescriptionIDNodes = (NodeList) prescriptionIDExpr.evaluate(dom, XPathConstants.NODESET);
			if (prescriptionIDNodes != null && prescriptionIDNodes.getLength() > 0)
			{
				XPathExpression idExpr = xpath.compile("id");
				XPathExpression entryExpr = xpath.compile("entry/substanceAdministration");
				XPathExpression nameExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/name");

				XPathExpression freqExpr = xpath.compile("effectiveTime[@type='PIVL_TS']/period");
				XPathExpression doseExpr = xpath.compile("doseQuantity");
				XPathExpression doseExprLow = xpath.compile("low");
				XPathExpression doseExprHigh = xpath.compile("high");
				XPathExpression doseFormExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/formCode");
				XPathExpression packQuantityExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/asContent/quantity/numerator[@type='epsos:PQ']");
				XPathExpression packQuantityExpr2 = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/asContent/quantity/denominator[@type='epsos:PQ']");
				XPathExpression packTypeExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/asContent/containerPackagedMedicine/formCode");
				
				XPathExpression packageExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/asContent/containerPackagedMedicine/capacityQuantity");
				
				XPathExpression ingredientExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/ingredient[@classCode='ACTI']/ingredient/code");
				XPathExpression strengthExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/ingredient[@classCode='ACTI']/quantity/numerator[@type='epsos:PQ']");
				XPathExpression strengthExpr2 = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/ingredient[@classCode='ACTI']/quantity/denominator[@type='epsos:PQ']");
				
				XPathExpression nrOfPacksExpr = xpath.compile("entryRelationship/supply/quantity");
				//XPathExpression nrOfPacksExpr = xpath.compile("consumable/manufacturedProduct/manufacturedMaterial/asContent/quantity/denominator[@type='epsos:PQ']");

				XPathExpression routeExpr = xpath.compile("routeCode");
				XPathExpression lowExpr = xpath.compile("effectiveTime[@type='IVL_TS']/low");
				XPathExpression highExpr = xpath.compile("effectiveTime[@type='IVL_TS']/high");
				XPathExpression patientInstrEexpr = xpath.compile("entryRelationship/act/code[@code='PINSTRUCT']/../text/reference[@value]");
				XPathExpression fillerInstrEexpr = xpath.compile("entryRelationship/act/code[@code='FINSTRUCT']/../text/reference[@value]");
				XPathExpression substituteInstrExpr = xpath.compile("entryRelationship[@typeCode='SUBJ'][@inversionInd='true']/observation[@classCode='OBS']/value");
				
				XPathExpression prescriberPrefixExpr = xpath.compile("author/assignedAuthor/assignedPerson/name/prefix");
				XPathExpression prescriberSurnameExpr = xpath.compile("author/assignedAuthor/assignedPerson/name/family");
				XPathExpression prescriberGivenNameExpr = xpath.compile("author/assignedAuthor/assignedPerson/name/given");
				
				for (int p=0; p< prescriptionIDNodes.getLength(); p++)
				{
					Node sectionNode = prescriptionIDNodes.item(p);
					Node pIDNode = (Node)idExpr.evaluate(sectionNode, XPathConstants.NODE);
					if (pIDNode != null)
						try
					{
						prescriptionID = pIDNode.getAttributes().getNamedItem("extension").getNodeValue();
						//	prescriptionID = pIDNode.getAttributes().getNamedItem("root").getNodeValue();
					}
					catch (Exception e){
						
						}
					else
						prescriptionID = "";
					
					String prescriber = "";
					Node prescriberPrefix = (Node) prescriberPrefixExpr.evaluate(sectionNode, XPathConstants.NODE);
					if (prescriberPrefix != null)
					{
						prescriber += prescriberPrefix.getTextContent().trim() + " ";
					}
					Node prescriberSurname = (Node) prescriberSurnameExpr.evaluate(sectionNode, XPathConstants.NODE);
					if (prescriberSurname != null)
					{
						prescriber += prescriberSurname.getTextContent().trim();
					}
					Node prescriberGivenName = (Node) prescriberGivenNameExpr.evaluate(sectionNode, XPathConstants.NODE);
					if (prescriberGivenName != null)
					{
						prescriber += " "+ prescriberGivenName.getTextContent().trim();
					}
					
					if (Validator.isNull(prescriber))
						prescriber = performer;
					
					// PRESCRIPTION ITEMS
					NodeList entryList = (NodeList)entryExpr.evaluate(sectionNode, XPathConstants.NODESET);
					if (entryList != null && entryList.getLength() >0)
					{
						for (int i=0; i<entryList.getLength(); i++)
						{
							ViewResult line = new ViewResult(i);

							Node entryNode = entryList.item(i);
							
							

							
							String materialID = "";
							Node materialIDNode = (Node)idExpr.evaluate(entryNode, XPathConstants.NODE);
							if (materialIDNode != null)
							{
								try
								{
								materialID = materialIDNode.getAttributes().getNamedItem("extension").getNodeValue();
								}
								catch (Exception e)
								{
									System.out.println("Error getting material");
								}
							}
							
							Node materialName = (Node) nameExpr.evaluate(entryNode, XPathConstants.NODE);
							String name = materialName.getTextContent().trim();

							String packsString = "";
							Node doseForm = (Node)doseFormExpr.evaluate(entryNode, XPathConstants.NODE);
							if (doseForm != null)
								packsString = doseForm.getAttributes().getNamedItem("displayName").getNodeValue();

							Node packageExpr1 = (Node)packageExpr.evaluate(entryNode, XPathConstants.NODE);
							Node packType = (Node)packTypeExpr.evaluate(entryNode, XPathConstants.NODE);
							Node packQuant = (Node)packQuantityExpr.evaluate(entryNode, XPathConstants.NODE);
							Node packQuant2 = (Node)packQuantityExpr2.evaluate(entryNode, XPathConstants.NODE);
							
							String dispensedPackage = "";
							String dispensedPackageUnit = "";
							if (packageExpr1!=null)
							{
								dispensedPackage = packageExpr1.getAttributes().getNamedItem("value").getNodeValue();
								dispensedPackageUnit = packageExpr1.getAttributes().getNamedItem("unit").getNodeValue();
							}
							if (packQuant != null && packType != null && packQuant2 != null)
							{
								packsString += "#"+packType.getAttributes().getNamedItem("displayName").getNodeValue() + "#"+
								packQuant.getAttributes().getNamedItem("value").getNodeValue();
								String unit = packQuant.getAttributes().getNamedItem("unit").getNodeValue();
								if (unit != null && !unit.equals("1"))
									packsString += " "+unit;
								String denom = packQuant2.getAttributes().getNamedItem("value").getNodeValue();
								if (denom != null && !denom.equals("1"))
								{
									packsString += " / "+denom;
									unit = packQuant2.getAttributes().getNamedItem("unit").getNodeValue();
									if (unit != null && !unit.equals("1"))
										packsString += " "+unit;
								}

							}
							
							String ingredient = "";
							Node ingrNode = (Node)ingredientExpr.evaluate(entryNode, XPathConstants.NODE);
							if (ingrNode != null)
							{
								ingredient += ingrNode.getAttributes().getNamedItem("code").getNodeValue() + " - " 
								+ingrNode.getAttributes().getNamedItem("displayName").getNodeValue();
							}
							
							String strength = "";
							Node strengthExprNode = (Node)strengthExpr.evaluate(entryNode, XPathConstants.NODE);
							Node strengthExprNode2 = (Node)strengthExpr2.evaluate(entryNode, XPathConstants.NODE);
							if (strengthExprNode != null && strengthExprNode2 != null )
							{
								try
								{
								strength = strengthExprNode.getAttributes().getNamedItem("value").getNodeValue();
								}
								catch (Exception e) {
									_log.error("Error parsing strength");
									strength="";}
								String unit = "";
								String unit2 = "";
								try
								{
								unit = strengthExprNode.getAttributes().getNamedItem("unit").getNodeValue();
								}
								catch (Exception e) {_log.error("Error parsing unit");}
								if (unit != null && !unit.equals("1"))
									strength += " "+unit;
								String denom = "";
								try
								{
								denom = strengthExprNode2.getAttributes().getNamedItem("value").getNodeValue();
								}
								catch (Exception e) {_log.error("Error parsing denom");}
								if (denom != null) // && !denom.equals("1"))
								{
									strength += " / "+denom;
									try
									{
									unit2 = strengthExprNode2.getAttributes().getNamedItem("unit").getNodeValue();
									}
									catch (Exception e) {_log.error("Error parsing unit 2");}
									if (unit2 != null && !unit2.equals("1"))
										strength += " "+unit2;
								}

							}
							

							String nrOfPacks = "";
							Node nrOfPacksNode = (Node)nrOfPacksExpr.evaluate(entryNode, XPathConstants.NODE);
							if (nrOfPacksNode != null)
							{
								if (nrOfPacksNode.getAttributes().getNamedItem("value") != null)
									nrOfPacks = nrOfPacksNode.getAttributes().getNamedItem("value").getNodeValue();
								if  (nrOfPacksNode.getAttributes().getNamedItem("unit") != null )
								{
									String unit = nrOfPacksNode.getAttributes().getNamedItem("unit").getNodeValue();
									if (unit != null && !unit.equals("1"))
										nrOfPacks += " "+unit;
								}
							}

							String doseString = "";
							Node dose = (Node)doseExpr.evaluate(entryNode, XPathConstants.NODE);
							if (dose != null)
							{
								if (dose.getAttributes().getNamedItem("value") != null)
								{
									doseString = dose.getAttributes().getNamedItem("value").getNodeValue();
									if (dose.getAttributes().getNamedItem("unit") != null)
									{
										String unit = dose.getAttributes().getNamedItem("unit").getNodeValue();
										if (unit != null && !unit.equals("1"))
											doseString += " "+unit;
									}
								}
								else
								{
									String lowString = "", highString = "";
									Node lowDoseNode = (Node)doseExprLow.evaluate(dose, XPathConstants.NODE);
									if (lowDoseNode != null && lowDoseNode.getAttributes().getNamedItem("value") != null)
									{
										lowString = lowDoseNode.getAttributes().getNamedItem("value").getNodeValue();
										if (lowDoseNode.getAttributes().getNamedItem("unit") != null) {
											String unit = lowDoseNode.getAttributes().getNamedItem("unit").getNodeValue();
											if (unit != null && !unit.equals("1"))
												lowString += " "+unit;
										}
									}
									Node highDoseNode = (Node)doseExprHigh.evaluate(dose, XPathConstants.NODE);
									if (highDoseNode != null && highDoseNode.getAttributes().getNamedItem("value") != null)
									{
										highString = highDoseNode.getAttributes().getNamedItem("value").getNodeValue();
										if (highDoseNode.getAttributes().getNamedItem("unit") != null)
										{
											String unit = highDoseNode.getAttributes().getNamedItem("unit").getNodeValue();
											if (unit != null && !unit.equals("1"))
												highString += " "+unit;
										}
									}

									doseString = Validator.isNotNull(lowString)? lowString : "";
									if (Validator.isNotNull(highString) && !lowString.equals(highString))
									{
										doseString = Validator.isNotNull(doseString) ? doseString + " - " + highString : highString;
									}
								}
							}

							String freqString = "";
							Node period = (Node)freqExpr.evaluate(entryNode, XPathConstants.NODE);
							if (period != null)
							{
							try
							{
							freqString = getSafeString(period.getAttributes().getNamedItem("value").getNodeValue()+period.getAttributes().getNamedItem("unit").getNodeValue());
							}
							catch (Exception e)
							{
							_log.error("### Error getting freqstring");
							}
							}

							String routeString = "";
							Node route = (Node)routeExpr.evaluate(entryNode, XPathConstants.NODE);
							if (route != null)
								try
								{
								routeString = getSafeString(route.getAttributes().getNamedItem("displayName").getNodeValue());
								}
							catch (Exception e)
							{
								_log.error("error getting route string");
							}

							String patientString = "";
							Node patientInfo = (Node)patientInstrEexpr.evaluate(entryNode, XPathConstants.NODE);
							if (patientInfo != null)
								try
								{
								patientString = getSafeString(patientInfo.getAttributes().getNamedItem("value").getNodeValue());
								}
							catch (Exception e)
							{
								_log.error("error getting route string");
							}

							String fillerString = "";
							Node fillerInfo = (Node)fillerInstrEexpr.evaluate(entryNode, XPathConstants.NODE);
							if (fillerInfo != null)
								try
								{
								fillerString = getSafeString(fillerInfo.getAttributes().getNamedItem("value").getNodeValue());
								}
							catch (Exception e)
							{
								_log.error("error getting route string");
							}

							String lowString = "";
							Node lowNode = (Node)lowExpr.evaluate(entryNode, XPathConstants.NODE);
							if (lowNode != null)
							{
								try
								{
								lowString = lowNode.getAttributes().getNamedItem("value").getNodeValue();							
								lowString = dateDecorate(lowString);
								}
								catch (Exception e)
								{
									_log.error("Error parsing low node ...");
								}
								
							}

							String highString = "";
							Node highNode = (Node)highExpr.evaluate(entryNode, XPathConstants.NODE);
							if (highNode != null)
							{
								try
								{
								highString = highNode.getAttributes().getNamedItem("value").getNodeValue();
								highString = dateDecorate(highString);
								}
								catch (Exception e)
								{
									_log.error("Error parsing high node ...");
								}
							}

							Boolean substitutionPermitted = Boolean.TRUE;
							Node substituteNode = (Node)substituteInstrExpr.evaluate(entryNode, XPathConstants.NODE);
							if (substituteNode != null)
							{
								String substituteValue = "";
								try
								{
								substituteValue = substituteNode.getAttributes().getNamedItem("code").getNodeValue();
								}
								catch(Exception e)
								{
									substituteValue="N";	
								}
								if (substituteValue.equals("N")) {substitutionPermitted=false;}
								if (substituteValue.equals("EC")) {substitutionPermitted=true;}
								if (!substituteValue.equals("N") && !substituteValue.equals("EC")) {substitutionPermitted=false;}
								
//								try {
//									substitutionPermitted = new Boolean(substituteValue);
//								} catch (Exception e) {
//									substitutionPermitted=false;
//								}
							}

							line.setField1(name);
							line.setField2(ingredient);
							line.setField3(strength);
							line.setField4(packsString);
							
							line.setField5(doseString);
							line.setField6(freqString);
							line.setField7(routeString);
							line.setField8(nrOfPacks);
							
							line.setField9(lowString);
							line.setField10(highString);
							
							line.setField11(patientString);
							line.setField12(fillerString);
							
							line.setField13(prescriber);

							// entry header information
							line.setField14(prescriptionID);
							
							// prescription header information
							line.setField15(performer);
							line.setField16(profession);
							line.setField17(facility);
							line.setField18(address);
							
							line.setField19(materialID);
							
							line.setField20(substitutionPermitted);
							line.setField21(dispensedPackage);
							line.setField22(dispensedPackageUnit);
							line.setMainid(lines.size());

							lines.add(line);
						}
					}
					
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return lines;
	}

	private String dateDecorate(String input)
	{
		String result = input;
		if (input != null)
		{
			try {
				String year = input.substring(0,4);
				String month = input.substring(4,6);
				String day = input.substring(6);
				result = day + "/"+month+"/"+year;
			} catch (Exception e) {}
		}
		return result;
	}
	
	
	public byte[] generateDispensationDocumentFromPrescription(byte[] bytes, List<ViewResult> lines, List<ViewResult> dispensedLines, SpiritUserClientDto doctor) 
	{
		byte[] bytesED=null;
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document dom  = db.parse(new ByteArrayInputStream(bytes));
			
			XPath xpath = XPathFactory.newInstance().newXPath();
			
			// fixes 
			// First I have to check if exists in order not to create it
			fixNode(dom,xpath,
					"/ClinicalDocument/legalAuthenticator/assignedEntity/representedOrganization/addr",
					"state","N/A");
					
			// add telecom to patient role
			fixNode(dom,xpath,
					"/ClinicalDocument/author/assignedAuthor/representedOrganization/addr",
					"state","N/A");
			
			// add street Address Line
			fixNode(dom,xpath,
					"/ClinicalDocument/legalAuthenticator/assignedEntity/representedOrganization/addr",
					"streetAddressLine","N/A");
			
			// add City
			fixNode(dom,xpath,
					"/ClinicalDocument/legalAuthenticator/assignedEntity/representedOrganization/addr",
					"city","N/A");
			// add postalcode
			fixNode(dom,xpath,
					"/ClinicalDocument/legalAuthenticator/assignedEntity/representedOrganization/addr",
					"postalCode","N/A");
			
			fixNode(dom,xpath,
					"/ClinicalDocument/author/assignedAuthor/representedOrganization/addr",
					"streetAddressLine","N/A");
			
			fixNode(dom,xpath,
					"/ClinicalDocument/author/assignedAuthor/representedOrganization/addr",
					"city","N/A");
			
			fixNode(dom,xpath,
					"/ClinicalDocument/author/assignedAuthor/representedOrganization/addr",
					"postalCode","N/A");
			
			changeNode(dom,xpath,
					"/ClinicalDocument/author/assignedAuthor/representedOrganization",
					"name","N/A");
			
			fixNode(dom,xpath,
					"/ClinicalDocument/component/structuredBody/component/section/entry/supply/entryRelationship/substanceAdministration/author/assignedAuthor/representedOrganization/addr",
					"postalCode","N/A");
			
			String ful_ext="";
			String ful_root="";
			XPathExpression ful1 = xpath.compile("/ClinicalDocument/component/structuredBody/component/section/id");
			NodeList fulRONodes = (NodeList) ful1.evaluate(dom, XPathConstants.NODESET);
			
			if (fulRONodes.getLength()>0)
			{
				for (int t=0; t<fulRONodes.getLength(); t++)
				{		
					Node AddrNode = fulRONodes.item(t);
					try
					{
					ful_ext = AddrNode.getAttributes().getNamedItem("extension").getNodeValue()+"";
					ful_root = AddrNode.getAttributes().getNamedItem("root").getNodeValue()+"";
					}
					catch (Exception e) {}
				}
			}
			
	
			
//			// fix infullfillment
//			XPathExpression rootNodeExpr = xpath.compile("/ClinicalDocument");
//			Node rootNode = (Node)rootNodeExpr.evaluate(dom, XPathConstants.NODE);
//			
//			try
//			{
//			Node infulfilment = null;
//			XPathExpression salRO = xpath.compile("/ClinicalDocument/inFulfillmentOf");
//			NodeList salRONodes = (NodeList) salRO.evaluate(dom, XPathConstants.NODESET);
//			if (salRONodes.getLength()==0)
//			{
//			XPathExpression salAddr = xpath.compile("/ClinicalDocument/relatedDocument");
//			NodeList salAddrNodes = (NodeList) salAddr.evaluate(dom, XPathConstants.NODESET);
//			if (salAddrNodes.getLength()>0)
//			{
//				for (int t=0; t<salAddrNodes.getLength(); t++)
//				{		
//					Node AddrNode = salAddrNodes.item(t);
//					Node order = dom.createElement("inFulfillmentOf");
//					//legalNode.appendChild(order);
//					/*
//					 * <relatedDocument typeCode="XFRM">
//					*		<parentDocument>
//					*   	<id extension="2601010002.pdf.ep.52105899467.52105899468:39" root="2.16.840.1.113883.2.24.2.30"/>
//					*							</parentDocument>
//					*						</relatedDocument>
//					 * 
//					 * 
//					 */
//					//Node order1 = dom.createElement("order");
//					Node order1 = dom.createElement("relatedDocument");
//					Node parentDoc = dom.createElement("parentDocument");
//					addAttribute(dom, parentDoc, "typeCode", "XFRM");
//					order1.appendChild(parentDoc);
//				
//					Node orderNode = dom.createElement("id");
//					addAttribute(dom, orderNode, "extension",ful_ext);
//					addAttribute(dom, orderNode, "root", ful_root);
//					parentDoc.appendChild(orderNode);
//					rootNode.insertBefore(order, AddrNode);	
//					infulfilment = rootNode.cloneNode(true);
//					
//				}
//			}
//			}
//			}
//			catch (Exception e)
//			{
//				_log.error("Error fixing node inFulfillmentOf ...");
//			}
			
			
			XPathExpression Telecom = xpath.compile("/ClinicalDocument/author/assignedAuthor/representedOrganization");
			NodeList TelecomNodes = (NodeList) Telecom.evaluate(dom, XPathConstants.NODESET);
			if (TelecomNodes.getLength()==0)
			{
				for (int t=0; t<TelecomNodes.getLength(); t++)
				{			
					Node TelecomNode = TelecomNodes.item(t);
					Node telecom = dom.createElement("telecom");
					addAttribute(dom, telecom, "use", "WP");
					addAttribute(dom, telecom, "value", "mailto:demo@epsos.eu");					
					TelecomNode.insertBefore(telecom, TelecomNodes.item(0));
				}
			}
			
			
			// header xpaths
			XPathExpression clinicalDocExpr = xpath.compile("/ClinicalDocument");
			Node clinicalDocNode = (Node)clinicalDocExpr.evaluate(dom, XPathConstants.NODE);
			if (clinicalDocNode != null)
			{
				addAttribute(dom, clinicalDocNode, "xmlns", "urn:hl7-org:v3");
				addAttribute(dom, clinicalDocNode, "xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
				addAttribute(dom, clinicalDocNode, "xsi:schemaLocation", "urn:hl7-org:v3 CDASchema/CDA_extended.xsd");
				addAttribute(dom, clinicalDocNode, "classCode", "DOCCLIN");
				addAttribute(dom, clinicalDocNode, "moodCode", "EVN");
			}
			
			
			
			
			XPathExpression docTemplateIdExpr = xpath.compile("/ClinicalDocument/templateId");
			XPathExpression docCodeExpr = xpath.compile("/ClinicalDocument/code[@codeSystemName='"+XML_LOINC_SYSTEM+"' and @codeSystem='"+XML_LOINC_CODESYSTEM+"']");			
			XPathExpression docTitleExpr = xpath.compile("/ClinicalDocument/title");

			// change templateId / LOINC code / title to dispensation root code
			NodeList templateIdNodes = (NodeList) docTemplateIdExpr.evaluate(dom, XPathConstants.NODESET);
			if (templateIdNodes != null)
			{
				for (int t=0; t<templateIdNodes.getLength(); t++)
				{
					Node templateIdNode = templateIdNodes.item(t);
					templateIdNode.getAttributes().getNamedItem("root").setNodeValue(XML_DISPENSATION_TEMPLATEID);
					
					if (t > 0)
						templateIdNode.getParentNode().removeChild(templateIdNode); // remove extra templateId nodes
				}
			}
			Node codeNode = (Node)docCodeExpr.evaluate(dom, XPathConstants.NODE);
			if (codeNode != null)
			{
				if (codeNode.getAttributes().getNamedItem("code") != null)
					codeNode.getAttributes().getNamedItem("code").setNodeValue(XML_DISPENSATION_LOINC_CODE);
				if (codeNode.getAttributes().getNamedItem("displayName") != null)
					codeNode.getAttributes().getNamedItem("displayName").setNodeValue("eDispensation");
				if (codeNode.getAttributes().getNamedItem("codeSystemName") != null)
					codeNode.getAttributes().getNamedItem("codeSystemName").setNodeValue(XML_DISPENSATION_LOINC_CODESYSTEMNAME);
				if (codeNode.getAttributes().getNamedItem("codeSystem") != null)
					codeNode.getAttributes().getNamedItem("codeSystem").setNodeValue(XML_DISPENSATION_LOINC_CODESYSTEM);
			}
			Node titleNode = (Node)docTitleExpr.evaluate(dom, XPathConstants.NODE);
			if (titleNode != null)
			{
				titleNode.setTextContent(XML_DISPENSATION_TITLE);
			}
			
			XPathExpression sectionExpr = xpath.compile("/ClinicalDocument/component/structuredBody/component/section[templateId/@root='"+XML_PRESCRIPTION_ENTRY_TEMPLATEID+"']");
			XPathExpression substanceExpr = xpath.compile("entry/substanceAdministration");			
			XPathExpression idExpr = xpath.compile("id");
			NodeList prescriptionNodes = (NodeList) sectionExpr.evaluate(dom, XPathConstants.NODESET);
			
			
			
	


		//	substanceAdministration.appendChild(newAuthorNode);
			
			
			
			
			if (prescriptionNodes != null && prescriptionNodes.getLength() > 0)
			{
				
				// calculate list of prescription ids to keep
				// calculate list of prescription lines to keep
				Set<String> prescriptionIdsToKeep = new HashSet<String>();
				Set<String> materialIdsToKeep = new HashSet<String>();
				HashMap<String, Node> materialReferences = new HashMap<String, Node>();
				if (dispensedLines != null && dispensedLines.size() > 0)
				{
					for (int i=0; i<dispensedLines.size(); i++)
					{
						ViewResult d_line = dispensedLines.get(i);
						materialIdsToKeep.add((String)d_line.getField10());
						prescriptionIdsToKeep.add((String)d_line.getField9());
					}
				}
				
				Node structuredBodyNode = null;
				for (int p=0; p<prescriptionNodes.getLength(); p++)
				{
					// for each one of the prescription nodes (<component> tags) check if their id belongs to the list of prescription Ids to keep in dispensation document
					Node sectionNode = prescriptionNodes.item(p);
					Node idNode = (Node)idExpr.evaluate(sectionNode, XPathConstants.NODE);
					String prescrId = idNode.getAttributes().getNamedItem("extension").getNodeValue(); 
					if (prescriptionIdsToKeep.contains(prescrId))
					{
						NodeList substanceAdministrationNodes = (NodeList)substanceExpr.evaluate(sectionNode, XPathConstants.NODESET);
						if (substanceAdministrationNodes != null && substanceAdministrationNodes.getLength() > 0)
						{
							for (int s=0; s<substanceAdministrationNodes.getLength(); s++)
							{
								// for each of the entries (substanceAdministration tags) within this prescription node
								// check if the materialid in question is one of the dispensed ones, else do nothing
								Node substanceAdministration = (Node)substanceAdministrationNodes.item(s);
								Node substanceIdNode = (Node)idExpr.evaluate(substanceAdministration, XPathConstants.NODE);
								String materialid = "";
								try
								{
								materialid=substanceIdNode.getAttributes().getNamedItem("extension").getNodeValue();
								}
								catch (Exception e)
								{
									_log.error("error setting materialid");
								}
								

								
								if (materialIdsToKeep.contains(materialid))
								{
									// if the materialid is one of the dispensed ones, keep the substanceAdminstration node intact,
									// as it will be used as an entryRelationship in the dispensation entry we will create
									Node entryRelationshipNode = dom.createElement("entryRelationship");
									addAttribute(dom, entryRelationshipNode, "typeCode", "REFR");
									addTemplateId(dom, entryRelationshipNode, XML_DISPENSTATION_ENTRY_REFERENCEID);
									
									entryRelationshipNode.appendChild(substanceAdministration);
									materialReferences.put(materialid, entryRelationshipNode);
									
								}
							}
						}
					}
					
					// 	Then delete this node, dispensed lines will be written afterwards
					Node componentNode = sectionNode.getParentNode(); // component
					structuredBodyNode = componentNode.getParentNode(); // structuredBody
					structuredBodyNode.removeChild(componentNode);
				
				}
					
				// at the end of this for loop, prescription lines are removed from the document, and materialReferences hashmap contains
				// a mapping from materialId to ready nodes containing the entry relationship references to the corresponding prescription lines
				Node dispComponent = dom.createElement("component");
				Node dispSection = dom.createElement("section");
				
				addTemplateId(dom, dispSection, XML_DISPENSATION_ENTRY_PARENT_TEMPLATEID);
				addTemplateId(dom, dispSection, XML_DISPENSATION_ENTRY_TEMPLATEID);
				
				Node dispIdNode = dom.createElement("id");
				//addAttribute(dom, dispIdNode, "root", prescriptionIdsToKeep.iterator().next());
				addAttribute(dom, dispIdNode, "root", ful_root);
				addAttribute(dom, dispIdNode, "extension", ful_ext);
				dispSection.appendChild(dispIdNode);
				
				Node sectionCodeNode = dom.createElement("code");
				addAttribute(dom, sectionCodeNode, "code", "60590-7");
				addAttribute(dom, sectionCodeNode, "displayName", XML_DISPENSATION_TITLE);
				addAttribute(dom, sectionCodeNode, "codeSystem", XML_DISPENSATION_LOINC_CODESYSTEM);
				addAttribute(dom, sectionCodeNode, "codeSystemName", XML_DISPENSATION_LOINC_CODESYSTEMNAME);
				dispSection.appendChild(sectionCodeNode);
				
				Node title = dom.createElement("title");
				title.setTextContent(XML_DISPENSATION_TITLE);
				dispSection.appendChild(title);
				
				Node text = dom.createElement("text");
				Node textContent = this.generateDispensedLinesHtml(dispensedLines, db);
				textContent = textContent.cloneNode(true);
				dom.adoptNode(textContent);
				text.appendChild(textContent);
				dispSection.appendChild(text);
				dispComponent.appendChild(dispSection);
				
				structuredBodyNode.appendChild(dispComponent);
				
				for (int i=0; i<dispensedLines.size(); i++)
				{
					ViewResult d_line = dispensedLines.get(i);
					String materialid = (String)d_line.getField10();
					// for each dispensed line create a dispensation entry in the document, and use the entryRelationship calculated above
					Node entry = dom.createElement("entry");
					Node supply = dom.createElement("supply");
					addAttribute(dom, supply, "classCode", "SPLY");
					addAttribute(dom, supply, "moodCode", "EVN");

					// add templateId tags
					addTemplateId(dom, supply, XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE1);
					addTemplateId(dom, supply, XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE2);
					addTemplateId(dom, supply, XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE3);

					// add id tag
					Node supplyId = dom.createElement("id");
					addAttribute(dom, supplyId, "root", XML_DISPENSATION_ENTRY_SUPPLY_ID_ROOT);
					addAttribute(dom, supplyId, "extension", (String)d_line.getField1());
					supply.appendChild(supplyId);
					
					// add quantity tag
					Node quantity = dom.createElement("quantity");
					String nrOfPacks = (String)d_line.getField8();
					nrOfPacks = nrOfPacks.trim();
					String value = nrOfPacks;
					String unit = "1";
					if (nrOfPacks.indexOf(" ") != -1)
					{
						value = nrOfPacks.substring(0, nrOfPacks.indexOf(" "));
						unit = nrOfPacks.substring(nrOfPacks.indexOf(" ")+1);
					}
					addAttribute(dom, quantity, "value", (String)d_line.getField7());
					addAttribute(dom, quantity, "unit", (String)d_line.getField12());
					supply.appendChild(quantity);
					
					// add product tag
					addProductTag(dom, supply, d_line, materialReferences.get(materialid));
										
					// add performer tag
					addPerformerTag(dom, supply, doctor);
												
					// add entryRelationship tag
				    supply.appendChild(materialReferences.get(materialid));

				    // add substitution relationship tag
					if (d_line.getField3() != null && ((Boolean)d_line.getField3()).booleanValue())
					{
						Node substitutionNode = dom.createElement("entryRelationship");
						addAttribute(dom, substitutionNode, "typeCode", "COMP");
						Node substanceAdminNode = dom.createElement("substanceAdministration");
						addAttribute(dom, substanceAdminNode, "classCode", "SBADM");
						addAttribute(dom, substanceAdminNode, "moodCode", "INT");
						
						
						Node seqNode = dom.createElement("doseQuantity");
						addAttribute(dom, seqNode, "value", "1");
						addAttribute(dom, seqNode, "unit", "1");
						substanceAdminNode.appendChild(seqNode);
						substitutionNode.appendChild(substanceAdminNode);
						// changed quantity
						if (lines.get(0).getField21().equals(d_line.getField7()))
						{
							
						}
						// changed name
						if (lines.get(0).getField11().equals(d_line.getField2()))
						{
							
						}
						supply.appendChild(substitutionNode);
					}
					entry.appendChild(supply);
					dispSection.appendChild(entry);
				}
							
			}
			
			// copy author tag from eprescription
			XPathExpression authorExpr = xpath.compile("/ClinicalDocument/author");
			Node oldAuthorNode = (Node)authorExpr.evaluate(dom, XPathConstants.NODE);
			Node newAuthorNode = oldAuthorNode.cloneNode(true);
			
			XPathExpression substExpr = xpath.compile("/ClinicalDocument/component/structuredBody/component/section/entry/supply/entryRelationship/substanceAdministration");
			NodeList substNodes = (NodeList) substExpr.evaluate(dom, XPathConstants.NODESET);

			XPathExpression entryRelExpr = xpath.compile("/ClinicalDocument/component/structuredBody/component/section/entry/supply/entryRelationship/substanceAdministration/entryRelationship");
			NodeList entryRelNodes = (NodeList) entryRelExpr.evaluate(dom, XPathConstants.NODESET);
			Node entryRelNode = (Node)entryRelExpr.evaluate(dom, XPathConstants.NODE);

			
			if (substNodes != null)
			{
//				for (int t=0; t<substNodes.getLength(); t++)
//				{			
				    int t=0;
					Node substNode = substNodes.item(t);										
					substNode.insertBefore(newAuthorNode, entryRelNode);
//				}
			}
			
			
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");

			//initialize StreamResult with File object to save to file
			StreamResult result = new StreamResult(new StringWriter());
			DOMSource source = new DOMSource(dom);
			transformer.transform(source, result);

			String xmlString = result.getWriter().toString();
			bytesED = xmlString.getBytes();
			System.out.println(xmlString);

			
		} catch (Exception e) 
		{
			_log.error(e.getMessage());
		}
		
		return bytesED;
	}
	
	
	/**
	 * Create an attribute node of the form attributeName="attributeValue" and add it to node
	 * @param dom
	 * @param node
	 * @param attributeName
	 * @param attributeValue
	 */
	private void addAttribute(Document dom, Node node, String attributeName, String attributeValue)
	{
		Attr rootAttr = dom.createAttribute(attributeName);
		rootAttr.setValue(attributeValue);
		node.getAttributes().setNamedItem(rootAttr);
	}
	
	
	/**
	 * Create a tag of the form <templateId root="rootValue"> and append it under node
	 * @param dom
	 * @param node
	 * @param rootValue
	 */
	private void addTemplateId(Document dom, Node node, String rootValue)
	{
		Node dispTempl = dom.createElement("templateId");
		Attr rootAttr = dom.createAttribute("root");
		rootAttr.setValue(rootValue);
		dispTempl.getAttributes().setNamedItem(rootAttr);
		node.appendChild(dispTempl);
	}
	
	
	private Node generateDispensedLinesHtml(List<ViewResult> dispensedLines, DocumentBuilder db)
	{
		String result = null;
		StringBuffer buf = new StringBuffer(1000);
		buf.append("<table><caption>Dispensed Items</caption>");
		buf.append("<thead><tr styleCode=\"border-bottom: 2px solid black\">");
		buf.append("<td>Identifier</td><td>Name</td><td>Strength</td><td>Form</td><td>Package</td><td>Quantity</td><td>Number of Packs</td></tr></thead><tbody>");
		for (int i=0; i<dispensedLines.size(); i++)
		{
			ViewResult d_line = dispensedLines.get(i);
			/**
			 * ViewResult d_line = new ViewResult(id, dispensed_id, dispensed_name, substitute,
									dispensed_strength, dispensed_form, dispensed_package, dispensed_quantity, 
									dispensed_nrOfPacks, prescriptionid, materialid, active);
			 */
			
			
			buf.append("<tr>");
			
			buf.append("<td>");
			buf.append(d_line.getField9());
			buf.append("</td>");

			buf.append("<td>");
			buf.append(d_line.getField2());
			buf.append("</td>");

			buf.append("<td>");
			buf.append(d_line.getField4());
			buf.append("</td>");

			buf.append("<td>");
			buf.append(d_line.getField5());
			buf.append("</td>");

			buf.append("<td>");
			buf.append(d_line.getField6());
			buf.append("</td>");

			buf.append("<td>");
			buf.append(d_line.getField7());
			buf.append("</td>");

			buf.append("<td>");
			buf.append(d_line.getField8());
			buf.append("</td>");

			
			buf.append("</tr>");
		}
		buf.append("</tbody></table>");
		result = buf.toString();
		
		try {
			Document dom  = db.parse(new ByteArrayInputStream(result.getBytes()));
			return dom.getFirstChild();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * Add a tag of the form below under the given node:
	 * 
	 * <product>
								<manufacturedProduct xmlns:epsos="urn:epsos-org:ep:medication" classCode="MANU">
									<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2'/>
									<templateId root='2.16.840.1.113883.10.20.1.53'/>
									<manufacturedMaterial classCode="MMAT" determinerCode="KIND">
										<templateId root='1.3.6.1.4.1.12559.11.10.1.3.1.3.1'/>
										<!-- Id  dispensed product--> 
										<epsos:id root="222" extension="3213"/>
										<code code="409120009" displayName="Metformin and rosiglitazone" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
											<!-- Optional generic name -->
											<originalText>
												<reference value="reference"/>
											</originalText>
										</code>
										<name>Metformina y rosiglitazona</name>
										<!--Dose form  -->
										<epsos:formCode code="10221000" displayName="Film-coated tablet" codeSystem="1.3.6.1.4.1.12559.11.10.1.3.1.42.2" codeSystemName="epSOS:DoseForm"/>
										
										<epsos:asContent classCode="CONT">
											<!-- Package size-->
											<epsos:quantity>
												<epsos:numerator xsi:type="epsos:PQ" value="112" unit="1" />
												<epsos:denominator xsi:type="epsos:PQ" value="1" unit="1"/>
											</epsos:quantity>
											<!-- Package -->
											<epsos:containerPackagedMedicine classCode="CONT" determinerCode="INSTANCE">
												<epsos:formCode code="30009000" displayName="Box" codeSystem="1.3.6.1.4.1.12559.11.10.1.3.1.42.3" codeSystemName="epSOS:Package"/>
												<!-- A10BD03 Metformin and rosiglitazone -->
												<epsos:name> Metformin and rosiglitazone</epsos:name>
												<!-- random lot number has been assigned-->
												<epsos:lotNumberText>1322231</epsos:lotNumberText>
												<epsos:capacityQuantity value=' 112' unit='1'/>
												
												<!-- child proof-->
												<epsos:capTypeCode code="ChildProof"/>
											</epsos:containerPackagedMedicine>
										</epsos:asContent>
										<epsos:ingredient classCode="ACTI">
											<!--Strength, -->
											<epsos:quantity>
												<epsos:numerator xsi:type="epsos:PQ" value="500+2" unit="mg"/>
												<epsos:denominator xsi:type="epsos:PQ" value="1" unit="1"/>
											</epsos:quantity>
											<epsos:ingredient classCode="MMAT" determinerCode="KIND">
												<!-- ATC-code-->
												<epsos:code code="A10BD03" codeSystem="2.16.840.1.113883.6.73" displayName="Metformin and rosiglitazone"/>
												<epsos:name>Metformin and rosiglitazone</epsos:name>
											</epsos:ingredient>
										</epsos:ingredient>
									</manufacturedMaterial>
								</manufacturedProduct>
							</product>
	 * 
	 * 
	 * 
	 * 
	 * 
	 * @param dom
	 * @param node
	 * @param doctor
	 */
	private void addProductTag(Document dom, Node node, ViewResult dispensedLine, Node prescriptionNode)
	{
		Node productNode = dom.createElement("product");
		Node product = dom.createElement("manufacturedProduct");
		addAttribute(dom, product, "xmlns:epsos", XML_DISPENSATION_PRODUCT_EPSOSNS);
		addAttribute(dom, product, "classCode", XML_DISPENSATION_PRODUCT_CLASSCODE);
		addTemplateId(dom, product, XML_DISPENSATION_PRODUCT_TEMPLATE1);
		addTemplateId(dom, product, XML_DISPENSATION_PRODUCT_TEMPLATE2);
		
		// change after September 29/30-2010 workshop: product tag must be the same as the one in prescription.
		// only changes allowed (if substituting) are the brand name and the package quantity tags
		Node materialNode = null;
		// use identical material info from prescription
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression materialExpr = xpath.compile("substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial");
			Node oldMaterialNode = (Node)materialExpr.evaluate(prescriptionNode, XPathConstants.NODE);
					
			// fix to add epsos:id node
			
			XPathExpression code = xpath.compile("substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/code");
			Node codeNode = (Node)code.evaluate(prescriptionNode, XPathConstants.NODE);
		
			if (codeNode == null)
			{
			code = 	xpath.compile("substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/name");
			codeNode = (Node)code.evaluate(prescriptionNode, XPathConstants.NODE);
			}
			
			Node epsosID = dom.createElement("epsos:id");
			addAttribute(dom, epsosID, "root", XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE3);
			addAttribute(dom, epsosID, "extension", (String)dispensedLine.getField1());
			oldMaterialNode.insertBefore(epsosID, codeNode);	

			materialNode = oldMaterialNode.cloneNode(true);
			
			if (dispensedLine.getField3() != null && ((Boolean)dispensedLine.getField3()).booleanValue())
			{
				// substitute case, change brand name and quantity tags
				XPathExpression brandNameExpr = xpath.compile("name");
				Node nameNode = (Node)brandNameExpr.evaluate(materialNode, XPathConstants.NODE);
				nameNode.setTextContent((String)dispensedLine.getField2());
				
				XPathExpression packContentExpr = xpath.compile("asContent");
				Node contentNode = (Node)packContentExpr.evaluate(materialNode, XPathConstants.NODE);
				XPathExpression packQuantityExpr = xpath.compile("containerPackagedMedicine/capacityQuantity");
				Node oldQuant = (Node)packQuantityExpr.evaluate(contentNode, XPathConstants.NODE);
				NamedNodeMap attributes = oldQuant.getAttributes();
				Node unitNode = node.getOwnerDocument().createAttribute("unit");
				unitNode.setNodeValue((String)dispensedLine.getField12());
				attributes.setNamedItem(unitNode);
				Node attNode = node.getOwnerDocument().createAttribute("value");
				attNode.setNodeValue((String)dispensedLine.getField7());
				attributes.setNamedItem(attNode);
				    
//				Node quant = createEpsosCapacityQuantityNode(dom, (String)dispensedLine.getField7(),(String)dispensedLine.getField12());
//				if (contentNode != null && oldQuant != null)
//					contentNode.replaceChild(quant, oldQuant);
			}
		} catch (Exception e) {
			_log.error("error using identical material info from prescription");
			
		}	
				product.appendChild(materialNode);
				productNode.appendChild(product);
				node.appendChild(productNode);
	}
	
	
	private Node createEpsosCapacityQuantityNode(Document dom, String quantityString,String metrics)
	{
		Node quantity = dom.createElement("epsos:capacityQuantity");
		addAttribute(dom, quantity, "value", quantityString);
		addAttribute(dom, quantity, "unit", metrics);
		return quantity;
	}
	
	private Node createEpsosQuantityNode(Document dom, String quantityString)
	{
		Node quantity = dom.createElement("epsos:capacityQuantity");
		if (quantityString != null && quantityString.length() > 0)
		{
			int slash = quantityString.lastIndexOf('/');
			String numeratorString = quantityString;
			String denominatorString = null;
			if (slash != -1)
			{
				numeratorString = quantityString.substring(0, slash).trim();
				denominatorString = quantityString.substring(slash+1).trim();
			}
			
			Node numerator = createEpsosValueUnitNode(dom, true, numeratorString);
			Node denominator = createEpsosValueUnitNode(dom, false, denominatorString);
			
			quantity.appendChild(numerator);
			quantity.appendChild(denominator);
		}
		 
		
		
		return quantity;
	}
	
	private Node createEpsosValueUnitNode(Document dom, boolean numerator, String valueString)
	{
		Node result = dom.createElement(numerator? "epsos:numerator" : "epsos:denominator");
		addAttribute(dom, result, "xsi:type", "epsos:PQ");
		String value="1", unit="1";
		if (valueString != null &&  !valueString.equals(""))
		{
			String[] values = valueString.split(" ");
			if (values != null && values.length == 2)
			{
				value = values[0];
				unit = values[1];
			}
			else
			{
				value= valueString;
				unit = "1";
			}
		}
			
		addAttribute(dom, result, "value", value);
		addAttribute(dom, result, "unit", unit);
		return result;
	}
	
	/**
	 * Add a tag of the form below, under node
	 *                      <performer typeCode="PRF">
								<time value="20100702"/>
								<assignedEntity>
									<id root="2" extension="12345678"/>
									<code codeSystem="2" code="Speciality" displayName="Speciality"/>
									<assignedPerson>
										<name>
											<family>Jodar de Jodar</family>
											<given>Paco</given>
										</name>
									</assignedPerson>
									<representedOrganization>
										<id root="2.16.840.1.113883.19.5"/>
										<name>Farmacia de La Puerta de la Carne</name>
										<addr>
											<state>Sevilla</state>
											<city>Sevilla</city>
											<precinct>Sevilla</precinct>
											<country>ES</country>
											<postalCode>41003</postalCode>
											<streetAddressLine>Calle Demetrio de los Rios, 3</streetAddressLine>
										</addr>
									</representedOrganization>
								</assignedEntity>
							</performer>
	 * @param dom
	 * @param node
	 * @param doctor
	 */
	private void addPerformerTag(Document dom, Node node, SpiritUserClientDto doctor)
	{
		Node performer = dom.createElement("performer");
		addAttribute(dom, performer, "typeCode", "PRF");

		// time tag
		//String timeString = xmlEncodeDate(new Date());
		String timeString = dateMetaDataFormat.format(new Date());
		Node time = dom.createElement("time");
		addAttribute(dom, time, "value", timeString);
		performer.appendChild(time);
		
		// assignedEntity tag
		Node assignedEntity = dom.createElement("assignedEntity");
		Node id = dom.createElement("id");
		addAttribute(dom, id, "root", XML_DISPENSATION_PERFORMER_ID_ROOT);
		addAttribute(dom, id, "extension", xmlNotNullString(doctor.getUid().get(0)));
		assignedEntity.appendChild(id);
	    // assignedPerson and name tags	                                  
		Node assignedPerson = dom.createElement("assignedPerson");
		Node name = dom.createElement("name");
		Node family = dom.createElement("family");
		family.setTextContent(xmlNotNullString(doctor.getSurname().get(0)));
		name.appendChild(family);
		Node given = dom.createElement("given");
		if (Validator.isNotNull(xmlNotNullString(doctor.getGivenName().get(0))))
			given.setTextContent(xmlNotNullString(doctor.getGivenName().get(0)));
		else
			given.setTextContent(xmlNotNullString(doctor.getSurname().get(0)));
		name.appendChild(given);
		assignedPerson.appendChild(name);
		assignedEntity.appendChild(assignedPerson);
		
		//representedOrganization tag
		SpiritOrganisationClientDto org = doctor.getHomeOrganisation();
		Node representedOrganization = dom.createElement("representedOrganization");
		Node orgid = dom.createElement("id");
		addAttribute(dom, orgid, "root", XML_DISPENSATION_PERFORMER_ID_ROOT);
		addAttribute(dom, orgid, "extension", xmlNotNullString(org.getOrganisationDN()));
		representedOrganization.appendChild(orgid);
		Node orgName = dom.createElement("name");
		orgName.setTextContent(xmlNotNullString(org.getOrganisationName()));
		representedOrganization.appendChild(orgName);
		Node address = dom.createElement("addr");
		Node state = dom.createElement("state");
		state.setTextContent(xmlNotNullString(org.getState()));
		Node city = dom.createElement("city");
		city.setTextContent(xmlNotNullString(org.getLocality()));
		Node country = dom.createElement("country");
		country.setTextContent(xmlNotNullString(org.getLocality()));
		Node zip = dom.createElement("postalCode");
		zip.setTextContent(xmlNotNullString(org.getPostalCode()));
		Node street = dom.createElement("streetAddressLine");
		street.setTextContent(xmlNotNullString(org.getStreet()));
		address.appendChild(street);
		address.appendChild(city);
		address.appendChild(state);
		address.appendChild(zip);
		address.appendChild(country);
		representedOrganization.appendChild(address);
		assignedEntity.appendChild(representedOrganization);
		performer.appendChild(assignedEntity);
		
		node.appendChild(performer);
		
	}
	
	public String patientConsentToXml(PatientConsentObject obj, EhrPatientClientDto patient, SpiritUserClientDto doctor)
	{
		StringBuilder xmlString = new StringBuilder(1000);
		
		xmlString.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n");
		xmlString.append("<consent>\n\t<id>");
		xmlString.append(xmlNotNullString(obj.getConsentid()));
		xmlString.append("</id>\n\n");
		xmlString.append("\t<patient>\n\t<id>");
		xmlString.append(xmlNotNullString(obj.getPatientId())); 
		xmlString.append("</id>\n\t<addr>\n\t\t<country>");
		xmlString.append(xmlNotNullString(patient.getCountry()));
		xmlString.append("</country>\n\t\t<state>");
		xmlString.append(xmlNotNullString(patient.getState())); 
		xmlString.append("</state>\n\t\t<city>");
		xmlString.append(xmlNotNullString(patient.getCity())); 
		xmlString.append("</city>\n\t\t<postalCode>");
		xmlString.append(xmlNotNullString(patient.getZip())); 
		xmlString.append("</postalCode>\n\t\t<streetAddressLine>");
		xmlString.append(xmlNotNullString(patient.getStreetAddress())); 
		xmlString.append("</streeAddressLine>\n\t</addr>\n\t<name>\n\t\t<given>"); 
		xmlString.append(xmlNotNullString(patient.getGivenName())); 
		xmlString.append("</given>\n\t\t<family>"); 
		xmlString.append(xmlNotNullString(patient.getFamilyName())); 
		xmlString.append("</family>\n\t\t<prefix>"); 
		xmlString.append(xmlNotNullString(patient.getNamePrefix())); 
		xmlString.append("</prefix>\n\t\t<suffix>"); 
		xmlString.append(xmlNotNullString(patient.getNameSuffix())); 
		xmlString.append("</suffix>\n\t</name>\n\t<gender value=\""); 
		xmlString.append(xmlNotNullString(patient.getSex())); 
		xmlString.append("\"/>\n\t<birthDate value=\""); 
		xmlString.append(patient.getBirthdate() != null ? patient.getBirthdate().toXMLFormat() : ""); 
		xmlString.append("\"/>\n\t</patient>\n\n\t<doctor>\n\t<id>");
		xmlString.append(xmlNotNullString(doctor.getUid())); 
		xmlString.append("</id>\n\t<addr>\n\t\t<country>");
		xmlString.append(xmlNotNullString(doctor.getLocality()));  // doctor country
		xmlString.append("</country>\n\t\t<state>");
		xmlString.append(xmlNotNullString(doctor.getState())); 
		xmlString.append("</state>\n\t\t<city>");
		xmlString.append(xmlNotNullString(doctor.getLocality())); // doctor city
		xmlString.append("</city>\n\t\t<postalCode>");
		xmlString.append(xmlNotNullString(doctor.getPostalCode())); 
		xmlString.append("</postalCode>\n\t\t<streetAddressLine>");
		xmlString.append(xmlNotNullString(doctor.getStreet())); 
		xmlString.append("</streeAddressLine>\n\t</addr>\n\t<name>\n\t\t<given>"); 
		xmlString.append(xmlNotNullString(doctor.getGivenName()));
		xmlString.append("</given>\n\t\t<family>"); 
		xmlString.append(xmlNotNullString(doctor.getSurname())); 
		xmlString.append("</family>\n\t\t<prefix>"); 
		xmlString.append(xmlNotNullString(doctor.getTitle()));  
		xmlString.append("</prefix>\n\t\t<suffix>"); 
		xmlString.append("");  // doctor suffix
		xmlString.append("</suffix>\n\t</name>\n\t<representedOrganization>\n\t\t<id>");
		
		SpiritOrganisationClientDto org = doctor.getHomeOrganisation();
		xmlString.append(xmlNotNullString(org.getOrganisationDN())); // organization id
		xmlString.append("</id>\n\t\t<name>"); 
		xmlString.append(xmlNotNullString(org.getOrganisationName()));  
		xmlString.append("</name>\n\t\t<addr>\n\t\t\t<country>");
		xmlString.append(xmlNotNullString(org.getLocality())); // organization country
		xmlString.append("</country>\n\t\t\t<state>");
		xmlString.append(xmlNotNullString(org.getState())); 
		xmlString.append("</state>\n\t\t\t<city>");
		xmlString.append(xmlNotNullString(org.getLocality())); // organization city
		xmlString.append("</city>\n\t\t\t<postalCode>");
		xmlString.append(xmlNotNullString(org.getPostalCode())); 
		xmlString.append("</postalCode>\n\t\t\t<streetAddressLine>");
		xmlString.append(xmlNotNullString(org.getStreet())); 
		xmlString.append("</streeAddressLine>\n\t\t</addr>\n\t</representedOrganization>\n\t</doctor>\n\n\t<country code=\""); 
		xmlString.append(obj.getCountry());
		xmlString.append("\"/>\n\n\t<creationTime value=\""); 
		xmlString.append(xmlEncodeDate(obj.getCreationDate())); 
		xmlString.append("\"/>\n\n\t<validityTime>\n\t\t<low value=\""); 
		xmlString.append(xmlEncodeDate(obj.getValidFrom())); 
		xmlString.append("\"/>\n\t\t<high value=\""); 
		xmlString.append(xmlEncodeDate(obj.getValidTo())); 
		xmlString.append("\"/>\n\t</validityTime>\n\n</consent>"); 
		
		return xmlString.toString();
	}
	
	public void writeDispensationDocument(SpiritEhrWsClientInterface webservice, byte[] bytes, byte[] bytesDispPdf,
			EhrPatientClientDto patient,String country,
			SpiritUserClientDto usr,String language, String fullname)  throws EhrException_Exception
	{
		EpsosHelperService.getInstance().createLog("Starting the preparation of the eD doc ....",usr);
		SourceSubmissionClientDto subm = null;
		DocumentClientDto doc = null;
		try
		{
		String fc_nr = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.code"), "60593-1");
		String fc_cs = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.coding.scheme"), "epSOS formatCodes");
		fc_cs="epSOS formatCodes";
		String fc_v = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.epsos.coding.scheme"), "urn:epSOS:ep:dis:2010");
		//String fc_v1 = "urn:uuid:a09d5840-386c-46f2-b5ad-9c3699a4309d";
		
		subm = new SourceSubmissionClientDto();
		SubmissionSetClientDto subSet = new SubmissionSetClientDto();
		subm.setSubmissionSet(subSet);

		doc = new DocumentClientDto();
		
		doc.setMimeType("text/xml"); 
		doc.setBytes(bytes);
		doc.setDocStatus("urn:oasis:names:tc:ebxml-regrep:StatusType:Approved"); 
		doc.setCreationTime(dateMetaDataFormat.format(new Date()));
		doc.setLanguageCode(language);
		String patid = "";
	
		try
		{
		patid = patient.getPid().get(0).getPatientID();
		}
		catch (Exception e)
		{
			doc.setPatientId("N/A");
			_log.error("ERROR GETTING PATIENT ID");
		}
		doc.setPatientId(patid);
		doc.setSourceRecordTargetId(patid);

		IheClassificationClientDto healthcareFacilityCode = new IheClassificationClientDto();
		healthcareFacilityCode.setNodeRepresentation("Not Used");
		healthcareFacilityCode.setValue("Not Used");
		healthcareFacilityCode.getSchema().add("epSOS Healthcare Facility Type Codes-Not Used");
		doc.setHealthcareFacilityCode(healthcareFacilityCode);

		IheClassificationClientDto practiceSettingCode = new IheClassificationClientDto();
		practiceSettingCode.setNodeRepresentation("Not Used");
		practiceSettingCode.setValue("Not Used");
		practiceSettingCode.getSchema().add("epSOS Practice Setting Codes-Not Used");
		doc.setPracticeSettingCode(practiceSettingCode);

		IheClassificationClientDto confidentialityCode = new IheClassificationClientDto();
		confidentialityCode.setNodeRepresentation("N");
		confidentialityCode.setValue("Normal");
		confidentialityCode.getSchema().add("2.16.840.1.113883.5.25");
		doc.setConfidentialityCode(confidentialityCode);
		
		IheClassificationClientDto classCode = new IheClassificationClientDto();
		classCode.setNodeRepresentation("60593-1");
		classCode.setValue("eDispensation");	
		classCode.getSchema().add("2.16.840.1.113883.6.1");	
		doc.setClassCode(classCode);
		
		IheClassificationClientDto formatCode = new IheClassificationClientDto();
		formatCode.setNodeRepresentation("urn:epSOS:ep:dis:2010");
		formatCode.setValue("eDispensation (epSOS pivot coded)");
		formatCode.getSchema().add("epSOS formatCodes");
		doc.setFormatCode(formatCode);

		//doc.setUUID("urn:uuid.........");// will be set from WS endpoint if empty
		//doc.setUniqueId("OID of the CDA document");  

		IheClassificationClientDto contentTypeCode = new IheClassificationClientDto();
		contentTypeCode.setNodeRepresentation("60593-1");
		contentTypeCode.setValue("eDispensation");
		contentTypeCode.getSchema().add("2.16.840.1.113883.6.1");
		subSet.setContentTypeCode(contentTypeCode);

		IheClassificationClientDto typeCode = new IheClassificationClientDto();
//		typeCode.setNodeRepresentation("Dispensation");
//		typeCode.setValue("Dispensation");
//		typeCode.getSchema().add("Connect-a-thon classCodes"); 
		typeCode.setNodeRepresentation("60593-1");
		typeCode.setValue("eDispensation");
		typeCode.getSchema().add("2.16.840.1.113883.6.1"); 
		doc.setTypeCode(typeCode);
		
		
		// Embedded pdf
		
		if (bytesDispPdf!=null)
		{
		DocumentClientDto docPdf = new DocumentClientDto();
		docPdf.setMimeType("application/pdf"); 
		docPdf.setBytes(bytesDispPdf);
		docPdf.setDocStatus("urn:oasis:names:tc:ebxml-regrep:StatusType:Approved"); 
		docPdf.setCreationTime(dateMetaDataFormat.format(new Date()));
		docPdf.setLanguageCode(language);
		docPdf.setPatientId(patid);
		docPdf.setSourceRecordTargetId(patid);
		docPdf.setParentDocumentRelationShip("urn:ihe:iti:2007:AssociationType:XFRM");
		docPdf.setParentDocumentId(doc.getUUID());

		IheClassificationClientDto healthcareFacilityCode_pdf = new IheClassificationClientDto();
		healthcareFacilityCode_pdf.setNodeRepresentation("Not Used");
		healthcareFacilityCode_pdf.setValue("Not Used");
		healthcareFacilityCode_pdf.getSchema().add("");
		docPdf.setHealthcareFacilityCode(healthcareFacilityCode_pdf);

		IheClassificationClientDto practiceSettingCode_pdf = new IheClassificationClientDto();
		practiceSettingCode_pdf.setNodeRepresentation("Not Used");
		practiceSettingCode_pdf.setValue("Not Used");
		practiceSettingCode_pdf.getSchema().add("1.1.11.1.11.1.1.11");
		docPdf.setPracticeSettingCode(practiceSettingCode_pdf);

		IheClassificationClientDto confidentialityCode_pdf = new IheClassificationClientDto();
		confidentialityCode_pdf.setNodeRepresentation("N");
		confidentialityCode_pdf.setValue("Normal");
		confidentialityCode_pdf.getSchema().add("2.16.840.1.113883.5.25");
		docPdf.setConfidentialityCode(confidentialityCode_pdf);
		
		IheClassificationClientDto classCode_pdf = new IheClassificationClientDto();
		classCode_pdf.setNodeRepresentation("60593-1");
		classCode_pdf.setValue("eDispensation");	
		classCode_pdf.getSchema().add("2.16.840.1.113883.6.1");	
		docPdf.setClassCode(classCode_pdf);
		
		IheClassificationClientDto formatCode_pdf = new IheClassificationClientDto();
		formatCode_pdf.setNodeRepresentation("urn:ihe:iti:xds-sd:pdf:2008");
		formatCode_pdf.setValue("PDF/A coded document");
		formatCode_pdf.getSchema().add("epSOS formatCodes");
		docPdf.setFormatCode(formatCode_pdf);
		doc.getChildDocuments().add(docPdf);
		}
		
		String currentUserDisplayName = "";

		if (Validator.isNull(currentUserDisplayName))
			try {
				currentUserDisplayName = usr.getDisplayName();
				//currentUserDisplayName =fullname;
			} catch (Exception e) {
				currentUserDisplayName = "EPSOS PORTAL";
			}
		doc.getAuthorPerson().add(currentUserDisplayName);
		doc.getLegalAuthenticator().add(currentUserDisplayName);
		doc.setDescription("Dispensation Document");
		doc.setName("eDispensation Document");

		subSet.getAuthorPerson().add(currentUserDisplayName);
		subSet.setDescription("eDispensation Document");
		}
		catch (Exception e)
		{
		e.printStackTrace();
		EpsosHelperService.getInstance().createLog("Error creating disp doc",usr);
		}
		String patientName = "";
		try
		{
		patientName = patient.getGivenName();
		}
		catch (Exception e)
		{
			_log.warn("Patient given name is null");
		}
		subm.getDocuments().add(doc);
		EpsosHelperService.getInstance().createLog("UPLOAD DISP DOC REQUEST:" +patientName,usr);			
		boolean submitDispDocument = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.submit.disp.document"), true);

		byte[] docbytes = subm.getDocuments().get(0).getBytes();
		String edcda = new String(docbytes);
		if (submitDispDocument) 
			{
			webservice.submitDocument(subm, patient);
			_log.info("The eD doc will be submitted");
			}
		else
		{
			_log.info("The eD doc will NOT be submitted");
		}
		EpsosHelperService.getInstance().createLog("UPLOAD DISP DOC RESPONSE OK:" + patient.getGivenName(),usr);
	}

	
	public void uploadDispensationDocument(SpiritEhrWsClientInterface webservice, byte[] bytes, EhrPatientClientDto patient, String country,
			SpiritUserClientDto usr, String language, String fullname) throws EhrException_Exception
	{		
		String xmlfile = "";
		String transformedResult="";
		try
		{
		xmlfile = new String(bytes,"UTF-8");
		
		com.gnomon.xslt.EpsosXSLTransformer xlsClass= new com.gnomon.xslt.EpsosXSLTransformer();
		String lang1 = language.replace("_","-");
		PortletURLImpl pURL = null;
		transformedResult= xlsClass.transform(xmlfile,lang1,"");
		}
		catch (Exception e)
		{
			_log.error("Error transforming xml to html");
		}
		
		ByteArrayOutputStream bos = null;
		try
		{
		bos = EpsosHelperService.getInstance().ConvertHTMLtoPDF(transformedResult, epsosWebServiceURL);
		}
		catch (Exception e)
		{
		_log.error("ERROR creating pdf version of ed");
		}
	
		writeDispensationDocument(webservice,bytes,bos.toByteArray(),patient,
				country, usr,language,fullname);		
	}
	
	
	/**
	 * This method only used once to set up a valid prescription document for a patient for the demo
	 * @param webservice
	 * @param bytes
	 * @param patient
	 * @param usr
	 * @param request
	 * @throws EhrException_Exception
	 */
	public void uploadPrescriptionDocument(SpiritEhrWsClientInterface webservice, String filename, EhrPatientClientDto patient, SpiritUserClientDto usr, HttpServletRequest request) throws EhrException_Exception
	{
		byte[] bytes = null;
		try  {
			bytes = FileUploadHelper.getFile(filename);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		SourceSubmissionClientDto subm = new SourceSubmissionClientDto();
		SubmissionSetClientDto subSet = new SubmissionSetClientDto();
		subm.setSubmissionSet(subSet);

		DocumentClientDto doc = new DocumentClientDto();
		
		doc.setMimeType("text/xml"); 
		doc.setBytes(bytes);
		doc.setDocStatus("urn:oasis:names:tc:ebxml-regrep:StatusType:Approved"); 
		doc.setCreationTime(dateMetaDataFormat.format(new Date()));
		doc.setLanguageCode(GeneralUtils.getLocale(request));
		doc.setPatientId(patient.getPid().get(0).getPatientID());
		doc.setSourceRecordTargetId(patient.getPid().get(0).getPatientID());


		IheClassificationClientDto healthcareFacilityCode = new IheClassificationClientDto();
		healthcareFacilityCode.setNodeRepresentation("Not Used");
		healthcareFacilityCode.setValue("Not Used");
		healthcareFacilityCode.getSchema().add("Connect-a-thon healthcareFacilityCodes");
		doc.setHealthcareFacilityCode(healthcareFacilityCode);


		IheClassificationClientDto practiceSettingCode = new IheClassificationClientDto();
		practiceSettingCode.setNodeRepresentation("Not Used");
		practiceSettingCode.setValue("Not Used");
		practiceSettingCode.getSchema().add("Connect-a-thon practiceSettingCodes");
		doc.setPracticeSettingCode(practiceSettingCode);


		IheClassificationClientDto confidentialityCode = new IheClassificationClientDto();
		confidentialityCode.setNodeRepresentation("Not Used");
		confidentialityCode.setValue("Not Used");
		confidentialityCode.getSchema().add("Connect-a-thon confidentialityCodes");
		doc.setConfidentialityCode(confidentialityCode);


		IheClassificationClientDto classCode = new IheClassificationClientDto();
		classCode.setNodeRepresentation("57829-4");
		classCode.setValue("57829-4");
		classCode.getSchema().add("2.16.840.1.113883.6.1");
		doc.setClassCode(classCode);


		IheClassificationClientDto formatCode = new IheClassificationClientDto();
		formatCode.setNodeRepresentation("urn:epSOS:ep:pre:2010");
		formatCode.setValue("urn:epSOS:ep:pre:2010");
		formatCode.getSchema().add("1.3.6.1.4.1.12559.11.10.1.3.1.1.1");
		doc.setFormatCode(formatCode);


		IheClassificationClientDto contentTypeCode = new IheClassificationClientDto();
		contentTypeCode.setNodeRepresentation("Communication");
		contentTypeCode.setValue("Communication");
		contentTypeCode.getSchema().add("Connect-a-thon contentTypeCodes");
		subSet.setContentTypeCode(contentTypeCode);

		IheClassificationClientDto typeCode = new IheClassificationClientDto();
		typeCode.setNodeRepresentation("Prescription");
		typeCode.setValue("Prescription");
		typeCode.getSchema().add("Connect-a-thon classCodes"); 
		doc.setTypeCode(typeCode);
		
		String currentUserDisplayName = usr.getDisplayName();
		if (Validator.isNull(currentUserDisplayName))
			try {
				currentUserDisplayName = PortalUtil.getUser(request).getFullName();
			} catch (Exception e) {
				currentUserDisplayName = "EPSOS PORTAL";
			}
		doc.getAuthorPerson().add(currentUserDisplayName);
		doc.getLegalAuthenticator().add(currentUserDisplayName);
		doc.setDescription("Prescription Document");
		doc.setName("ePrescription Document");

		subSet.getAuthorPerson().add(currentUserDisplayName);
		subSet.setDescription("ePrescription Document");

		webservice.submitDocument(subm, patient);

	}
	
	/**
	 * This method only used once to set up a valid PHR document for a patient for the demo
	 * @param webservice
	 * @param bytes
	 * @param patient
	 * @param usr
	 * @param request
	 * @param xml
	 * @throws EhrException_Exception
	 */
	public void uploadPHRDocument(SpiritEhrWsClientInterface webservice, String filename, 
			EhrPatientClientDto patient, SpiritUserClientDto usr, HttpServletRequest request, boolean xml) throws EhrException_Exception
	{
		
		byte[] bytes = null;
		try  {
			bytes = FileUploadHelper.getFile(filename);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		SourceSubmissionClientDto subm = new SourceSubmissionClientDto();
		SubmissionSetClientDto subSet = new SubmissionSetClientDto();
		subm.setSubmissionSet(subSet);

		DocumentClientDto doc = new DocumentClientDto();
		subm.getDocuments().add(doc);
		if (xml)
			doc.setMimeType("text/xml");
		else
			doc.setMimeType("text/xml");
		doc.setBytes(bytes);
		doc.setDocStatus("urn:oasis:names:tc:ebxml-regrep:StatusType:Approved"); 
		doc.setCreationTime(dateMetaDataFormat.format(new Date()));
		doc.setLanguageCode(GeneralUtils.getLocale(request));
		doc.setPatientId(patient.getPid().get(0).getPatientID());
		doc.setSourceRecordTargetId(patient.getPid().get(0).getPatientID());


		IheClassificationClientDto healthcareFacilityCode = new IheClassificationClientDto();
		healthcareFacilityCode.setNodeRepresentation("Not Used");
		healthcareFacilityCode.setValue("Not Used");
		healthcareFacilityCode.getSchema().add("Connect-a-thon healthcareFacilityCodes");
		doc.setHealthcareFacilityCode(healthcareFacilityCode);


		IheClassificationClientDto practiceSettingCode = new IheClassificationClientDto();
		practiceSettingCode.setNodeRepresentation("Not Used");
		practiceSettingCode.setValue("Not Used");
		practiceSettingCode.getSchema().add("Connect-a-thon practiceSettingCodes");
		doc.setPracticeSettingCode(practiceSettingCode);


		IheClassificationClientDto confidentialityCode = new IheClassificationClientDto();
		confidentialityCode.setNodeRepresentation("Not Used");
		confidentialityCode.setValue("Not Used");
		confidentialityCode.getSchema().add("Connect-a-thon confidentialityCodes");
		doc.setConfidentialityCode(confidentialityCode);


		IheClassificationClientDto classCode = new IheClassificationClientDto();
		classCode.setNodeRepresentation("34133-9");
		classCode.setValue("34133-9");
		classCode.getSchema().add("2.16.840.1.113883.6.1");
		doc.setClassCode(classCode);


		if (xml)
		{
			IheClassificationClientDto formatCode = new IheClassificationClientDto();
			formatCode.setNodeRepresentation("urn:epSOS:ps:ps:2010");
			formatCode.setValue("urn:epSOS:ps:ps:2010");
			formatCode.getSchema().add("1.3.6.1.4.1.12559.11.10.1.3.1.1.3");
			doc.setFormatCode(formatCode);
		}
		else
		{
			IheClassificationClientDto formatCode = new IheClassificationClientDto();
			formatCode.setNodeRepresentation("urn:ihe:iti:xds-sd:pdf:2008");
			formatCode.setValue("urn:ihe:iti:xds-sd:pdf:2008");
			formatCode.getSchema().add("1.3.6.1.4.1.19376.1.2.20");
			doc.setFormatCode(formatCode);
		}
	

		IheClassificationClientDto contentTypeCode = new IheClassificationClientDto();
		contentTypeCode.setNodeRepresentation("Communication");
		contentTypeCode.setValue("Communication");
		contentTypeCode.getSchema().add("Connect-a-thon contentTypeCodes");
		subSet.setContentTypeCode(contentTypeCode);

		IheClassificationClientDto typeCode = new IheClassificationClientDto();
		typeCode.setNodeRepresentation("Patient Summary");
		typeCode.setValue("Patient Summary");
		typeCode.getSchema().add("Connect-a-thon classCodes"); 
		doc.setTypeCode(typeCode);
		
		String currentUserDisplayName = usr.getDisplayName();
		if (Validator.isNull(currentUserDisplayName))
			try {
				currentUserDisplayName = PortalUtil.getUser(request).getFullName();
			} catch (Exception e) {
				currentUserDisplayName = "EPSOS PORTAL";
			}
		doc.getAuthorPerson().add(currentUserDisplayName);
		doc.getLegalAuthenticator().add(currentUserDisplayName);
		doc.setDescription("Patient Summary");
		doc.setName("Patient Summary");

		subSet.getAuthorPerson().add(currentUserDisplayName);
		subSet.setDescription("Patient Summary");

		webservice.submitDocument(subm, patient);

	}
	
	public byte[] extractPdfPartOfPatientSummaryDocument (byte[] bytes)
	{
		byte[] result = bytes;
		
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document dom  = db.parse(new ByteArrayInputStream(bytes));

			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression pdfTag = xpath.compile("//component/nonXMLBody/text[@mediaType='application/pdf']");
			Node pdfNode = (Node) pdfTag.evaluate(dom, XPathConstants.NODE);
			if (pdfNode != null)
			{
				String base64EncodedPdfString = pdfNode.getTextContent().trim();
				result = decode.decode(base64EncodedPdfString.getBytes());
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	public boolean hasCurrentUserPharmacistRole(HttpServletRequest httpReq)
	{
		boolean result = false;
		SpiritUserClientDto usr = (SpiritUserClientDto)httpReq.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr != null)
		{
			if (usr.getLoginRole().equals("Administrator") || 
					usr.getLoginRole().equals("pharmacist"))
				result = true;
		}
		return result;
	}
	
	public boolean hasCurrentUserPhysicianRole(HttpServletRequest httpReq)
	{
		boolean result = false;
		SpiritUserClientDto usr = (SpiritUserClientDto)httpReq.getSession().getAttribute(EPSOS_LOGIN_INFORMATION_ATTRIBUTE);
		if (usr != null)
		{
			if (usr.getLoginRole().equals("Administrator") || 
					usr.getLoginRole().equals("medical doctor"))
				result = true;
		}
		return result;
	}
	
	public String generatePatientIdString (EhrPatientClientDto patient)
	{
		String patids = ""; 
		List <EhrPIDClientDto> pids = patient.getPid();
		for (EhrPIDClientDto id: pids)
		{
		if (Validator.isNull(patids))
			{
			patids=id.getPatientID()+EPSOS_PATID_DEL1+id.getPatientIDType()+
									 EPSOS_PATID_DEL1+id.getDomain().getAuthUniversalID()+
									 EPSOS_PATID_DEL1+id.getDomain().getAuthUniversalIDType()+
									 EPSOS_PATID_DEL1+id.getDomain().getAuthNamespaceID()+
									 EPSOS_PATID_DEL1+id.getEhrPIDType();
			}
		else
			{
			patids=patids + id.getPatientID()+EPSOS_PATID_DEL2+id.getPatientIDType()+
			 EPSOS_PATID_DEL1+id.getDomain().getAuthUniversalID()+
			 EPSOS_PATID_DEL1+id.getDomain().getAuthUniversalIDType()+
			 EPSOS_PATID_DEL1+id.getDomain().getAuthNamespaceID()+
			 EPSOS_PATID_DEL1+id.getEhrPIDType();
			}
		}
		return patids;
	}
	
	private String xmlEncodeDate(Date date)
	{
		if (date == null) return "";
		try {
			GregorianCalendar cal = (GregorianCalendar)GregorianCalendar.getInstance();
			cal.setTime(date);
			XMLGregorianCalendar xmlCal = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
			return xmlCal.toXMLFormat();
		} catch (Exception e)
		{
			return date.toString();
		}
	}
	
	
	private String xmlNotNullString(String s)
	{
		if (Validator.isNull(s))
			return "";
		else
			return s;
	}
	
	private String xmlNotNullString(List<String> s)
	{
		if (s == null || s.size() == 0) 
			return "";
		else
			return xmlNotNullString(s.get(0));
	}

	public static String ObjectToString(Object obj) {
        String out = null;
        if (obj != null) {
                try {
                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        ObjectOutputStream oos = new ObjectOutputStream(baos);
                        oos.writeObject(obj);
                        out = encoder.encode(baos.toByteArray());
                } catch (IOException e) {
                        e.printStackTrace();
                        return null;
                }
        }
        return out;
}

public static Object StringToObject(String str) {
        Object out = null;
        if (str != null) {
                try {
                        ByteArrayInputStream bios = new ByteArrayInputStream(decoder
                                        .decodeBuffer(str));
                        ObjectInputStream ois = new ObjectInputStream(bios);
                        out = ois.readObject();
                } catch (IOException e) {
                        e.printStackTrace();
                        return null;
                } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        return null;
                }
        }
        return out;
}

public static String convertXMLFileToString(String fileName) 
{ 
  try{ 
    DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance(); 
    InputStream inputStream = new FileInputStream(new File(fileName)); 
    org.w3c.dom.Document doc = documentBuilderFactory.newDocumentBuilder().parse(inputStream); 
    StringWriter stw = new StringWriter(); 
    Transformer serializer = TransformerFactory.newInstance().newTransformer(); 
    serializer.transform(new DOMSource(doc), new StreamResult(stw)); 
    return stw.toString(); 
  } 
  catch (Exception e) { 
    e.printStackTrace(); 
  } 
    return null; 
}

public static ByteArrayOutputStream ConvertHTMLtoPDF(String htmlin, String uri)
{
	ByteArrayOutputStream out = new ByteArrayOutputStream(); 
	CYaHPConverter converter = new CYaHPConverter();
	
	try
        {
		List			 headerFooterList = new ArrayList();
		System.out.println("before conversion");
		Map properties = new HashMap();
		headerFooterList.add(new IHtmlToPdfTransformer.CHeaderFooter(
				"<table width=\"100%\"><tbody><tr><td align=\"left\">Generated with Gi9 Portal.</td><td align=\"right\">Page <pagenumber>/<pagecount></td></tr></tbody></table>",
				IHtmlToPdfTransformer.CHeaderFooter.HEADER));
		headerFooterList.add(new IHtmlToPdfTransformer.CHeaderFooter(
				"© 2011 Produced by Gnomon Portal Solution",
				IHtmlToPdfTransformer.CHeaderFooter.FOOTER));
		
		properties.put(IHtmlToPdfTransformer.PDF_RENDERER_CLASS,
				IHtmlToPdfTransformer.FLYINGSAUCER_PDF_RENDERER);
		converter.convertToPdf(htmlin,
			IHtmlToPdfTransformer.A4P, headerFooterList, uri, out,
			properties);
		System.out.println("after conversion");
		out.flush();
		out.close();
        } catch (Exception e)
        {
        	_log.error("Error converting html to pdf");
            e.printStackTrace();
        }
        return out;
}

public static boolean ConvertHTMLtoPDFFile(String htmlin, String uri)
{
	boolean converted = false;
	 
	CYaHPConverter converter = new CYaHPConverter();
	
	try
        {
		FileOutputStream out = new FileOutputStream("c://Apps/ed.pdf");
		List			 headerFooterList = new ArrayList();
		System.out.println("before conversion");
		Map properties = new HashMap();
		headerFooterList.add(new IHtmlToPdfTransformer.CHeaderFooter(
				"<table width=\"100%\"><tbody><tr><td align=\"left\">Generated with Gi9 Portal.</td><td align=\"right\">Page <pagenumber>/<pagecount></td></tr></tbody></table>",
				IHtmlToPdfTransformer.CHeaderFooter.HEADER));
		headerFooterList.add(new IHtmlToPdfTransformer.CHeaderFooter(
				"© 2011 Produced by Gnomon Portal Solution",
				IHtmlToPdfTransformer.CHeaderFooter.FOOTER));
		
		properties.put(IHtmlToPdfTransformer.PDF_RENDERER_CLASS,
				IHtmlToPdfTransformer.FLYINGSAUCER_PDF_RENDERER);
		converter.convertToPdf(htmlin,
			IHtmlToPdfTransformer.A4P, headerFooterList, uri, out,
			properties);
		System.out.println("after conversion");
		converted = true;
		out.flush();
		out.close();
        } catch (Exception e)
        {
        	_log.error("Error converting html to pdf");
            e.printStackTrace();
        }
        return converted;
}


public static String convertXMLtoHTML(byte[] xmlfile, File xslFile)
{
	String transformedResult = "";
	try
	{
	StreamSource xslSource = new StreamSource(new FileInputStream(xslFile));
	
	StreamSource xmlSource = new StreamSource(new ByteArrayInputStream(xmlfile));
	TransformerFactory transformerFactory =
		TransformerFactory.newInstance();

	Transformer transformer =
		transformerFactory.newTransformer(xslSource);
	ByteArrayMaker bam = new ByteArrayMaker();

	transformer.transform(xmlSource, new StreamResult(bam));
	
	transformedResult = bam.toString();
	}
	catch (Exception e)
	{
	_log.error("Error converting xml to html");	
	}
	return transformedResult;
}

public Vector getCountryIdsFromCS(String country)
{
	Vector v = new Vector();
	//String[]  attrs=new String[2];
	String internationalSearchPath = GetterUtil.getString(GnPropsUtil.get("portalb", "international.search.path"));
	String filename = "InternationalSearch_" + country + ".xml";
	try
	{
	File file = new File(internationalSearchPath+filename);
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = dbf.newDocumentBuilder();
	Document doc = db.parse(file);
	doc.getDocumentElement().normalize();
	// ids
	NodeList nodeLst = doc.getElementsByTagName("id");
	String seperator = "";
//	attrs[0]="";
	for (int s = 0; s < nodeLst.getLength(); s++) {
		Node fstNode = nodeLst.item(s);
   
	    	if (s>0) {seperator=",";}
	    	Element link = (Element) nodeLst.item( s );
	    	SearchMask sm = new SearchMask();
	    	sm.setDomain( link.getAttribute( "domain"));
	    	sm.setLabel( link.getAttribute( "label"));
	    	v.add(sm);
//			attrs[0] = attrs[0] + seperator + a1;
		  }
	}
	catch (Exception e)
	{
	Log.error(e.getMessage());
	}
	return v;
}

public String getLanguagesFromCS()
{
	String listOfLangs="";
		try
		{
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        URL url = cl.getResource("content/language/languages.xml");
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		dbf.setValidating(false);
		dbf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(url.getFile());
		doc.getDocumentElement().normalize();
		NodeList nodeLst = doc.getElementsByTagName("entry");
		String seperator = "";
		for (int s = 0; s < nodeLst.getLength(); s++) {
			Node fstNode = nodeLst.item(s);
	    	if (listOfLangs.length()>1) {seperator=",";}
	    	Element link = (Element) nodeLst.item( s );
			String a1 = link.getAttribute("key");
			if (getCountryIdsFromCS(a1).get(0)!=null)
				{
				listOfLangs = listOfLangs + seperator + a1;
				}
		}
		}
	catch (Exception e)
	{
	Log.error(e.getMessage());
	}
	return listOfLangs;
}


public String getCountriesFromCS()
{
	String listOfCountries="";
	String internationalSearchPath = GetterUtil.getString(GnPropsUtil.get("portalb", "international.search.path"));
	String filename = "InternationalSearch.xml";
	try
	{
	File file = new File(internationalSearchPath+filename);
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = dbf.newDocumentBuilder();
	Document doc = db.parse(file);
	doc.getDocumentElement().normalize();
	NodeList nodeLst = doc.getElementsByTagName("country");
	String seperator = "";
	for (int s = 0; s < nodeLst.getLength(); s++) {
		Node fstNode = nodeLst.item(s);
    	//if (s>0) {seperator=",";}
    	if (listOfCountries.length()>1) {seperator=",";}
    	Element link = (Element) nodeLst.item( s );
		String a1 = link.getAttribute( "code");
		if (getCountryIdsFromCS(a1).get(0)!=null)
			{
			listOfCountries = listOfCountries + seperator + a1;
			}
	}
	}
	catch (Exception e)
	{
	Log.error(e.getMessage());
	}
	return listOfCountries;
}

public String getCountriesLabelsFromCS(String language)
{
	String listOfCountries="";
	String internationalSearchPath = GetterUtil.getString(GnPropsUtil.get("portalb", "international.search.path"));
	String filename = "InternationalSearch.xml";
	try
	{
	File file = new File(internationalSearchPath+filename);
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = dbf.newDocumentBuilder();
	Document doc = db.parse(file);
	doc.getDocumentElement().normalize();
	NodeList nodeLst = doc.getElementsByTagName("country");
	String seperator = "";
	for (int s = 0; s < nodeLst.getLength(); s++) {
		Node fstNode = nodeLst.item(s);
    	if (listOfCountries.length()>1) {seperator=",";}
    	Element link = (Element) nodeLst.item( s );
		String a1 = EpsosHelperService.getPortalTranslation(link.getAttribute( "code"),language); 
		Vector v = getCountryIdsFromCS(link.getAttribute( "code"));
		SearchMask sm = (SearchMask) v.get(0);
		if (sm.getDomain() !=null)
			{
			listOfCountries = listOfCountries + seperator + a1;
			}

	}
	
	}
	catch (Exception e)
	{
	Log.error(e.getMessage());
	}
	return listOfCountries;
}

public static String getStringFromDocument(Document doc)
{
    try
    {
       DOMSource domSource = new DOMSource(doc);
       StringWriter writer = new StringWriter();
       StreamResult result = new StreamResult(writer);
       TransformerFactory tf = TransformerFactory.newInstance();
       Transformer transformer = tf.newTransformer();
       transformer.transform(domSource, result);
       return writer.toString();
    }
    catch(TransformerException ex)
    {
       ex.printStackTrace();
       return null;
    }

}

public static void fixNode(Document dom, XPath xpath,String path, String nodeName, String value)
{
	try
	{
	XPathExpression salRO = xpath.compile(path+"/"+nodeName);
	NodeList salRONodes = (NodeList) salRO.evaluate(dom, XPathConstants.NODESET);
	if (salRONodes.getLength()==0)
	{
	XPathExpression salAddr = xpath.compile(path);
	NodeList salAddrNodes = (NodeList) salAddr.evaluate(dom, XPathConstants.NODESET);
	if (salAddrNodes.getLength()>0)
	{
		for (int t=0; t<salAddrNodes.getLength(); t++)
		{		
			Node AddrNode = salAddrNodes.item(t);
			Node city = dom.createElement(nodeName);
			Text cityValue = dom.createTextNode(value);
			city.appendChild(cityValue);
			AddrNode.appendChild(city);
		}
	}
	}
	}
	catch (Exception e)
	{
		_log.error("Error fixing node ...");
	}
}

public static void changeNode(Document dom, XPath xpath,String path, String nodeName, String value)
{
	try
	{
	XPathExpression salRO = xpath.compile(path+"/"+nodeName);
	NodeList salRONodes = (NodeList) salRO.evaluate(dom, XPathConstants.NODESET);
	if (salRONodes.getLength()>0)
	{
		for (int t=0; t<salRONodes.getLength(); t++)
		{		
			Node AddrNode = salRONodes.item(t);
			if (AddrNode.getNodeName().equals("name"))
			{
				AddrNode.setTextContent(value);
			}
		}
	}
	}
	catch (Exception e)
	{
		_log.error("Error fixing node ...");
	}
}

public static String getSafeString(String arg0)
{
	String result="";
	try
	{
	if (Validator.isNull(arg0)) {
		_log.error("Error getting safe string. USING N/A");
		result = "N/A";
	}
	else
	{
	result = arg0;	
	}
	}
	catch (Exception e)
	{
	_log.error("Error getting safe string");	
	}
	return result;
}



public byte[] printReport(String path, String reportName1, Map parameters) {
	byte[] bytes = null;
	try {
		Session session = ConnectionFactory.getInstance().getSession();
		Connection conn = session.connection();
		File reportFile = new File(path);
		JasperPrint jasperPrint= new JasperPrint();
		JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
		jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,conn);
		bytes = JasperExportManager.exportReportToPdf(jasperPrint);
		bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters,conn);
		}
		catch (JRException e) {
			e.printStackTrace();
		}

	return bytes;
}
}
