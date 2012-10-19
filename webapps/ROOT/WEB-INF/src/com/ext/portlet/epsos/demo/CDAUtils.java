package com.ext.portlet.epsos.demo;

import epsos.ccd.gnomon.configmanager.ConfigurationManagerService;
import gnomon.util.GnPropsUtil;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.Vector;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.stream.FactoryConfigurationError;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import com.ext.portlet.epsos.EpsosHelperService;
import com.liferay.portal.kernel.util.GetterUtil;


public class CDAUtils {
	private static Logger _log = Logger.getLogger("CDAUtils");

	public final static String XML_LOINC_SYSTEM = "LOINC",
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
            XML_DISPENSATION_PRODUCT_MATERIAL_CONTAINER_FORMCODE_SYSTEM = "1.3.6.1.4.1.12559.11.10.1.3.1.42.3";
	
	public static void main(String[] args) {
		try {
//			
//			String dateString = "2010-03-01T00:00:00-08:00";
//			String pattern = "yyyy-MM-dd'T'HH:mm:ssZ";
//			DateTimeFormatter dtf = DateTimeFormat.forPattern(pattern);
//			DateTime dateTime = dtf.parseDateTime(dateString);
//			System.out.println(dateTime); // 2010-03-01T04:00:00.000-04:00
//			
//			long now = System.currentTimeMillis();
//			createPrescription();
//			long end = System.currentTimeMillis();
//			long time1=(end-now);
//			System.out.println(end-now);
			CDAHeader cda = createEdSample();
			Document epDoc = readEpXML();
			String a1 = Utils.nodeToString(epDoc);
//			String ed = createDispensation(a1,cda);
//			System.out.println(ed);
		} catch (Exception exc) {
			exc.printStackTrace();
		}
	}


	
	public static String createDispensation(Document epDoc,CDAHeader cda) throws ParserConfigurationException, SAXException, IOException
	{		
		String ed = CDAModelToEDXML(epDoc,cda);
		return ed;
	}
	
	private static NodeList readXML(String xml) throws ParserConfigurationException, SAXException, IOException
	{
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(new ByteArrayInputStream(xml.getBytes()));
			
		doc.getDocumentElement().normalize();
		NodeList nList = doc.getElementsByTagName("Table");
		return nList;
	}	 	
	
	private static NodeList readXML() throws ParserConfigurationException, SAXException, IOException
	{
		File fXmlFile = new File("/home/karkaletsis/workspace/brokerapp/src/samples/idika1.xml");
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(fXmlFile);
		doc.getDocumentElement().normalize();
		NodeList nList = doc.getElementsByTagName("Table");
		return nList;
	}
	
	private static CDAHeader createEdSample()
	{
		CDAHeader cda = new CDAHeader();
		cda.setEffectiveTime("201205311010");
		cda.setLanguageCode("el_GR");
		cda.setPharmacistAMKA("AMKA PHARM");
		cda.setPharmacistAddress("PH ADDRESS");
		cda.setPharmacistCity("PH CITY");
		cda.setPharmacistPostalCode("PH TK");
		cda.setPharmacistCountry("PH Country");
		cda.setPharmacistTelephone("003400044");
		cda.setPharmacistEmail("mail@kdd.gr");
		cda.setPharmacistFamilyName("PH name");
		cda.setPharmacistGivenName("PH given name");
		cda.setPharmacistOrgName("PHARMACY 1");
		cda.setPharmacistOrgAddress("ORG PH ADDRESS");
		cda.setPharmacistOrgCity("ORG PH CITY");
		cda.setPharmacistOrgPostalCode("ORG PH TK");
		cda.setPharmacistOrgCountry("ORG PH Country");
		cda.setDispensationId("DISP ID");
		cda.setPrescriptionBarcode("1205144406307");
		
		
		ArrayList<EDDetail> medicines = new ArrayList<EDDetail>(); 
		EDDetail detail = new EDDetail();
		detail.setRelativePrescriptionLineId("0");
		detail.setDispensedQuantity("1");
		detail.setMedicineBarcode("2802383802022");
		detail.setMedicineTainiaGnisiotitas("010101010101");
		detail.setMedicineExecutionCase("1");
		detail.setMedicinePrice("19");
		detail.setMedicineRefPrice("16");
		detail.setPatientParticipation("25");
		detail.setMedicineExecutionCase("1");
		
		medicines.add(detail);
		cda.setEDDetail(medicines);
		return cda;
	}
	
	private static Document readInventoryXML() throws ParserConfigurationException, SAXException, IOException 
	{
		File fXmlFile = new File("/home/karkaletsis/workspace/brokerapp/src/samples/inventory.xml");
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		//dbFactory.setNamespaceAware(true); 
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(fXmlFile);
		return doc;
	}
	
	private static Document readEpXML() throws ParserConfigurationException, SAXException, IOException 
	{
		
		File fXmlFile = new File("/home/karkaletsis/workspace/brokerapp/src/samples/ep1203280000770.xml");
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setNamespaceAware(true); 
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(fXmlFile);
		return doc;
	}
	
	
	public static Document readEpXML(String xml) throws ParserConfigurationException, SAXException, IOException 
	{
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		dbFactory.setNamespaceAware(true); 
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(new ByteArrayInputStream(xml.getBytes()));
		return doc;
	}
	
	
	public static String getRelativePrescriptionRoot(Document doc)
	{
		NodeList nl=null;
		String refBarcode="";
		try
			{
			XPathFactory xPathfactory = XPathFactory.newInstance();
			XPath xpath = xPathfactory.newXPath();
			xpath.setNamespaceContext(new CDANameSpaceContext());
			///ClinicalDocument/component/structuredBody/component/section/id
			XPathExpression epExpr = xpath.compile("//component/structuredBody/component/section//id/@root");
			nl = (NodeList) epExpr.evaluate(doc, XPathConstants.NODESET);
			if (nl.item(0) !=null)
				refBarcode = nl.item(0).getNodeValue();
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return refBarcode;		
	}

	public static String getRelativePrescriptionBarcode(Document doc)
	{
		NodeList nl=null;
		String refBarcode="";
		try
			{
			XPathFactory xPathfactory = XPathFactory.newInstance();
			XPath xpath = xPathfactory.newXPath();
			xpath.setNamespaceContext(new CDANameSpaceContext());
			///ClinicalDocument/component/structuredBody/component/section/id
			XPathExpression epExpr = xpath.compile("//component/structuredBody/component/section//id/@extension");
			nl = (NodeList) epExpr.evaluate(doc, XPathConstants.NODESET);
			if (nl.item(0) !=null)
				refBarcode = nl.item(0).getNodeValue();
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return refBarcode;		
	}
	
	public static String getRelativePrescriptionBarcode(String xml)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			Document doc = readEpXML(xml);
			nodeString = getRelativePrescriptionBarcode(doc);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}

	private static String getRelativePrescriptionLineFromEP(Document epDoc, String id)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			Document doc = epDoc;
			XPathFactory xPathfactory = XPathFactory.newInstance();
			XPath xpath = xPathfactory.newXPath();
			xpath.setNamespaceContext(new CDANameSpaceContext());
			XPathExpression epExpr = xpath.compile("//substanceAdministration[id/@extension='" + id + "']");
			nl = (Node) epExpr.evaluate(doc, XPathConstants.NODE);
			nodeString=Utils.nodeToString(nl);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}
	
	private static String getRelativeProductLineFromEP(Document epDoc, String id, String commercialName)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			Document doc = epDoc;
			XPathFactory xPathfactory = XPathFactory.newInstance();
			XPath xpath = xPathfactory.newXPath();
			xpath.setNamespaceContext(new CDANameSpaceContext());
			XPathExpression epExpr = xpath.compile("//substanceAdministration[id/@extension='" + id + "']//consumable//manufacturedProduct");
			nl = (Node) epExpr.evaluate(doc, XPathConstants.NODE);
			// change commercial name
			EpsosHelperService.changeNode(epDoc,xpath,
					"//substanceAdministration[id/@extension='" + id + "']//consumable//manufacturedProduct/manufacturedMaterial",
					"name",commercialName);
			// after manufactured material <epsos:id root="470575" extension="470575" xmlns:epsos="urn:epsos-org:ep:medication" />
			XPathExpression materialExpr = xpath.compile("//substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial");

			Node oldMaterialNode = (Node)materialExpr.evaluate(epDoc, XPathConstants.NODE);
					
			XPathExpression code = xpath.compile("//substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/code");
			Node codeNode = (Node)code.evaluate(epDoc, XPathConstants.NODE);
			
			if (codeNode == null)
			{
			code = 	xpath.compile("//substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/name");
			codeNode = (Node)code.evaluate(epDoc, XPathConstants.NODE);
			}
			
			Node epsosID = epDoc.createElement("epsos:id");
			EpsosHelperService.getInstance().addAttribute(epDoc, epsosID, "root", XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE3);
			EpsosHelperService.getInstance().addAttribute(epDoc, epsosID, "extension", id);
			oldMaterialNode.insertBefore(epsosID, codeNode);	


			nodeString=Utils.nodeToString(nl);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}
	
	private static String getRecordTargetFromEP(Document epDoc)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			nl = epDoc.getElementsByTagName("recordTarget").item(0);
			nodeString=Utils.nodeToString(nl);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}
	
	private static String getCustodianFromEP(Document epDoc)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			nl = epDoc.getElementsByTagName("custodian").item(0);
			nodeString=Utils.nodeToString(nl);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}
	
	private static String getLegalAuthFromEP(Document epDoc)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			nl = epDoc.getElementsByTagName("legalAuthenticator").item(0);
			nodeString=Utils.nodeToString(nl);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}
	
	private static String getAuthorFromEP(Document epDoc)
	{
		Node nl=null;
		String nodeString = "";
		try
			{
			nl = epDoc.getElementsByTagName("author").item(0);
			nodeString=Utils.nodeToString(nl);
			}
		catch (Exception e)
			{
			_log.error(e.getMessage());
			}		
		return nodeString;		
	}
	
	private static String CDAModelToEDXML(Document epDoc, CDAHeader cda)
	{
		String edCountry = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.country"), "");
		String edOid = GetterUtil.getString(GnPropsUtil.get("portalb", "ed.oid"), "");
		String entryOid = GetterUtil.getString(GnPropsUtil.get("portalb", "entry.oid"), "");
		String orderOid = GetterUtil.getString(GnPropsUtil.get("portalb", "order.oid"), "");
		String pharmacistsOid = GetterUtil.getString(GnPropsUtil.get("portalb", "pharmacists.oid"), "");
		String pharmaciesOid = GetterUtil.getString(GnPropsUtil.get("portalb", "pharmacies.oid"), "");
		String custodianOid = GetterUtil.getString(GnPropsUtil.get("portalb", "custodian.oid"), "");
		String custodianName = GetterUtil.getString(GnPropsUtil.get("portalb", "custodian.name"), "");
		String legalPersonOid = GetterUtil.getString(GnPropsUtil.get("portalb", "legalauth.person.oid"), "");
		String legalOrgOid = GetterUtil.getString(GnPropsUtil.get("portalb", "legalauth.org.oid"), "");
		
		String legalauthenticatorfirstname = GetterUtil.getString(GnPropsUtil.get("portalb", "legal.authenticator.firstname"), "");
		String legalauthenticatorlastname = GetterUtil.getString(GnPropsUtil.get("portalb", "legal.authenticator.lastname"), "");
		String legalauthenticatorcity = GetterUtil.getString(GnPropsUtil.get("portalb", "legal.authenticator.city"), "");
		String legalauthenticatorpostalcode = GetterUtil.getString(GnPropsUtil.get("portalb", "legal.authenticator.postalcode"), "");				
		
		StringBuilder sb = new StringBuilder();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("\r\n");
		sb.append("<ClinicalDocument xmlns:epsos=\"urn:epsos-org:ep:medication\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"urn:hl7-org:v3\" " +
				"xsi:schemaLocation=\"urn:hl7-org:v3\">");
		sb.append("\r\n");
		sb.append("<typeId root=\"2.16.840.1.113883.1.3\" extension=\"POCD_MT000040\"/>");sb.append("\r\n");
		sb.append("<templateId root=\"1.3.6.1.4.1.12559.11.10.1.3.1.1.2\"/>");
		sb.append("\r\n");	
		sb.append("<id root=\"" + edOid + "\"/>");
		sb.append("\r\n");
		sb.append("<code codeSystemName=\"LOINC\" codeSystem=\"2.16.840.1.113883.6.1\" code=\"60593-1\" displayName=\"eDispensation\"/>");
		sb.append("\r\n");
		sb.append("<title>" + XML_DISPENSATION_TITLE +"</title>");
		sb.append("\r\n");
		sb.append("<effectiveTime value=\"" + cda.getEffectiveTime() + "\" />");
		sb.append("\r\n");
		sb.append("<confidentialityCode code=\"N\" codeSystem=\"2.16.840.1.113883.5.25\"/>");
		sb.append("\r\n");
		sb.append("<languageCode code=\"" + cda.getLanguageCode() + "\"/>");
		sb.append("\r\n");
		sb.append(getRecordTargetFromEP(epDoc));sb.append("\r\n");
		// dispenser information
		sb.append("<author typeCode=\"AUT\">");sb.append("\r\n");
		sb.append("<functionCode code=\"" + "2262" +  "\" displayName=\"Pharmacists\" codeSystem=\"2.16.840.1.113883.2.9.6.2.7\" codeSystemName=\"epSOSHealthcareProfessionalRoles\"/>");sb.append("\r\n");
		sb.append("<time value=\"" + cda.getEffectiveTime() + "\"/>");sb.append("\r\n");
		sb.append("<assignedAuthor classCode=\"ASSIGNED\">");sb.append("\r\n");
		sb.append("<id extension=\"" + cda.getPharmacistOrgId() + "\" root=\"" + pharmacistsOid + "\"/>");sb.append("\r\n");
		sb.append(addAddress(cda.getPharmacistAddress(),cda.getPharmacistCity(),cda.getPharmacistPostalCode(),
				cda.getPharmacistCountry(),cda.getPharmacistTelephone(),cda.getPharmacistEmail()));
		sb.append("<assignedPerson classCode=\"PSN\" determinerCode=\"INSTANCE\">");sb.append("\r\n");
		sb.append(addName(cda.getPharmacistFamilyName(),cda.getPharmacistPrefix(),cda.getPharmacistGivenName()));sb.append("\r\n");
		sb.append("</assignedPerson>");sb.append("\r\n");
		sb.append("</assignedAuthor>");sb.append("\r\n");
		sb.append("</author>");sb.append("\r\n");
		
		sb.append("<custodian typeCode=\"CST\">" + "\r\n" +
				"<assignedCustodian classCode=\"ASSIGNED\">" + "\r\n" +
				"<representedCustodianOrganization classCode=\"ORG\" determinerCode=\"INSTANCE\">" + "\r\n" +
				"<id root=\"" + custodianOid + "\"/>" + "\r\n" +
				"<name>" + custodianName + "</name>" + "\r\n" +
				"<telecom nullFlavor=\"NI\"/>" + "\r\n" +
				"<addr>" + "\r\n" +
				"<country>" + edCountry + "</country>" +"\r\n" + 
				"</addr>" +"\r\n" +
				"</representedCustodianOrganization>" +"\r\n" +
				"</assignedCustodian></custodian>" + "\r\n");

		sb.append("<legalAuthenticator contextControlCode=\"OP\" typeCode=\"LA\">" +"\r\n" + 
	    "<time value=\"20120927112208\"/>" +"\r\n" +
	    "<signatureCode code=\"S\"/>" +"\r\n" +
	    "<assignedEntity classCode=\"ASSIGNED\">" +"\r\n" +
	    "<id root=\"" + legalOrgOid + "\"/>" +"\r\n" +
	     "<telecom nullFlavor=\"NI\"/>" +"\r\n" +
	      "<assignedPerson>" +"\r\n" +
	        "<name>" +"\r\n" +
	          "<family>" + legalauthenticatorfirstname + "</family>" +"\r\n" +
	          "<given>"+ legalauthenticatorlastname + "</given>" +"\r\n" +
	        "</name>" +"\r\n" +
	      "</assignedPerson>" +"\r\n" +
	      "<representedOrganization classCode=\"ORG\" determinerCode=\"INSTANCE\">" +"\r\n" +
	        "<id root=\"" + legalOrgOid + "\"/>" +"\r\n" +
	        "<name>Kansaneläkelaitos</name>" +"\r\n" +
	        "<addr use=\"PST\">" +"\r\n" +
	          "<city>" + legalauthenticatorcity + "</city>" +"\r\n" +
	          "<postalCode>" + legalauthenticatorpostalcode + "</postalCode>" +"\r\n" +
	          "<state nullFlavor=\"UNK\"/>" +"\r\n" +
	          "<country>" + edCountry + "</country>" +"\r\n" +
	        "</addr>" +"\r\n" +
	      "</representedOrganization>" +"\r\n" +
	    "</assignedEntity>" +"\r\n" +
	  "</legalAuthenticator>" + "\r\n");
	
		String relRoot = getRelativePrescriptionRoot(epDoc);
		// Add relative prescription
		sb.append("<inFulfillmentOf>");sb.append("\r\n");
		sb.append("<order>");sb.append("\r\n");
		sb.append(" <id extension=\"" + cda.getPrescriptionBarcode() + "\" root=\"" + relRoot + "\" />");sb.append("\r\n");
		sb.append("</order>");sb.append("\r\n");
		sb.append("</inFulfillmentOf>");sb.append("\r\n");
		//prescription header
		sb.append("<component>");sb.append("\r\n");
			sb.append("<structuredBody>");sb.append("\r\n");
				sb.append("<component>");sb.append("\r\n");
					sb.append("<section>");sb.append("\r\n");
						// Required templateIds
						sb.append("<templateId root=\"2.16.840.1.113883.10.20.1.8\"/>");sb.append("\r\n");
						sb.append("<templateId root=\"1.3.6.1.4.1.12559.11.10.1.3.1.2.2\"/>");sb.append("\r\n");
						// Κωδικός εκτελεσμένης συνταγής
						sb.append(addIDRoot(edOid,cda.getDispensationId()));sb.append("\r\n");
						sb.append("<code code=\"60590-7\" codeSystem=\"2.16.840.1.113883.6.1\" codeSystemName=\"LOINC\" displayName=\"Medication dispensed\"/>");sb.append("\r\n");
						sb.append("<title>" + "Dispensation: " + cda.getDispensationId() + "</title>");sb.append("\r\n");
						
						for (int i=0; i<cda.getEDDetail().size();i++)
						{			
						EDDetail detail = (EDDetail) cda.getEDDetail().get(i);
						// prescription details
						sb.append("<entry>");sb.append("\r\n");
						sb.append("<supply classCode=\"SPLY\" moodCode=\"EVN\">");sb.append("\r\n");
						
							sb.append("<templateId root=\"" + XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE1 + "\"/>");sb.append("\r\n");
							sb.append("<templateId root=\"" + XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE2 + "\"/>");sb.append("\r\n"); 
							sb.append("<templateId root=\"" + XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE3 + "\"/>");sb.append("\r\n"); 
							// Related prescription line
							sb.append(addIDRoot(entryOid,detail.getRelativePrescriptionLineId()));sb.append("\r\n");									
							sb.append("<quantity value=\"" + detail.getDispensedQuantity() + "\" unit=\"1\" />"); 
							
							// Medicine
							sb.append("<product>");sb.append("\r\n");					
							sb.append(getRelativeProductLineFromEP(epDoc,detail.getRelativePrescriptionLineId(),detail.getMedicineCommercialName()));sb.append("\r\n");
							
							// TODO fix containerPackageMedicine code 
							/*
							 * 
							 *                       <epsos:containerPackagedMedicine classCode="CONT" determinerCode="INSTANCE">
								                        <epsos:name>DIGOXIN</epsos:name>
								                        <epsos:formCode codeSystem="1.3.6.1.4.1.12559.11.10.1.3.1.44.1" codeSystemName="EDQM" code="N/A"/>
								                        <epsos:capacityQuantity unit="1" value="100"/>
								                      </epsos:containerPackagedMedicine>
							 */
							sb.append("</product>");sb.append("\r\n");
							

							
//							sb.append("<manufacturedProduct xmlns:epsos=\"urn:epsos-org:ep:medication\" classCode=\"MANU\">");sb.append("\r\n");
//							sb.append("<templateId root=\"" + XML_DISPENSATION_PRODUCT_TEMPLATE1 +"\"/>");sb.append("\r\n");
//							sb.append("<templateId root=\"" + XML_DISPENSATION_PRODUCT_TEMPLATE2 +"\"/>");sb.append("\r\n");
//								sb.append("<manufacturedMaterial classCode=\"MMAT\" determinerCode=\"KIND\">");sb.append("\r\n");
//								sb.append("<templateId root=\"1.3.6.1.4.1.12559.11.10.1.3.1.3.1\"/>");sb.append("\r\n");
//								// Medicine Unique Barcode
//								sb.append("<epsos:id root=\"" + XML_DISPENSATION_ENTRY_SUPPLY_TEMPLATE3 + "\" extension=\"" + detail.getRelativePrescriptionLineId() +"\" />");				
//								// Product Code
//								String codeSystemName="";
//								sb.append("<code code=\"" + detail.getMedicineBarcode() + "\" codeSystem=\"1.2.246.537.6.55\" codeSystemName=\"" + codeSystemName + "\" />");
//								sb.append("\r\n");
//								sb.append("<name>" + detail.getMedicineCommercialName() +"</name>");sb.append("\r\n");
//								// 
//								sb.append("<epsos:formCode code=\"" + detail.getMedicineFormCode() +"\" displayName=\"" + 
//										detail.getMedicineFormCodeDescription() + "\" codeSystem=\"1.3.6.1.4.1.12559.11.10.1.3.1.44.1\" codeSystemName=\"EDQM\" />");sb.append("\r\n");
//									sb.append("<epsos:asContent classCode=\"CONT\" xmlns:epsos=\"urn:epsos-org:ep:medication\">");sb.append("\r\n");
////									sb.append("<epsos:containerPackagedMedicine classCode=\"CONT\" determinerCode=\"INSTANCE\">");sb.append("\r\n");
////											sb.append("<epsos:formCode code=\"" + detail.getMedicinePackageFormCode() +"\" displayName=\"" + 
////											detail.getMedicinePackageFormCodeDescription() + "\" codeSystem=\"1.3.6.1.4.1.12559.11.10.1.3.1.44.1\" codeSystemName=\"EDQM\" />");sb.append("\r\n");
//										sb.append("<epsos:capacityQuantity value=\"" + detail.getMedicineCapacityQuantity() +"\" unit=\"1\" />");sb.append("\r\n");
//									sb.append("</epsos:containerPackagedMedicine>");sb.append("\r\n");
//								sb.append("</epsos:asContent>");sb.append("\r\n");
//								// Active Ingredient
//								// I think it must be removed as it can't be changed otherwise must be copied from ep.
////								sb.append("<epsos:ingredient classCode=\"ACTI\">");	sb.append("\r\n");							
////								sb.append("<epsos:ingredient classCode=\"MMAT\" determinerCode=\"KIND\">");sb.append("\r\n");
////								//sb.append("<epsos:code code=\"" + detail.getDrastikiATCCode() + "\" codeSystem=\"2.16.840.1.113883.6.73\" displayName=\"" + detail.getDrastikiName() +"\"/>");sb.append("\r\n");
////								sb.append("<epsos:code code=\"" + detail.getMedicineDrastikiATCCode() + "\" displayName=\"" + detail.getMedicineDrastikiName() +"\"/>");sb.append("\r\n");
////								sb.append("<epsos:name>" + detail.getMedicineDrastikiName() + "</epsos:name>");sb.append("\r\n");
////								sb.append("</epsos:ingredient>");sb.append("\r\n");
////								sb.append("</epsos:ingredient>");sb.append("\r\n");
//								sb.append("</manufacturedMaterial>");sb.append("\r\n");
//							sb.append("</manufacturedProduct>");sb.append("\r\n");
//						sb.append("</product>");sb.append("\r\n");
						
						// Στοιχεία φαρμακοποιού
						
						sb.append("<performer typeCode=\"PRF\">");sb.append("\r\n");
						sb.append("<time value=\"" + cda.getEffectiveTime() + "\" />");sb.append("\r\n");
						sb.append("<assignedEntity>");sb.append("\r\n");
						sb.append("<id root=\"" + pharmacistsOid + "\" extension=\"" + cda.getPharmacistOrgId()  + "\"/>");sb.append("\r\n");
						sb.append(addAddress(cda.getPharmacistAddress(),cda.getPharmacistCity(),cda.getPharmacistPostalCode(),
								cda.getPharmacistCountry(),cda.getPharmacistTelephone(),cda.getPharmacistEmail()));sb.append("\r\n");
						sb.append("<assignedPerson>");sb.append("\r\n");
						sb.append(addName(cda.getPharmacistFamilyName(),cda.getPharmacistPrefix(),cda.getPharmacistGivenName()));sb.append("\r\n");
						sb.append("</assignedPerson>");sb.append("\r\n");
						sb.append("<representedOrganization>");sb.append("\r\n");
						sb.append("<id root=\"" + pharmaciesOid + "\" extension=\"" + cda.getPharmacistOrgId() +"\"/>");sb.append("\r\n");
						sb.append("<name>" + cda.getPharmacistOrgName() + "</name>");sb.append("\r\n");
						sb.append(addAddress(cda.getPharmacistOrgAddress(),cda.getPharmacistOrgCity(),cda.getPharmacistOrgPostalCode(),
								cda.getPharmacistOrgCountry(),cda.getPharmacistOrgTelephone(),cda.getPharmacistOrgEmail()));sb.append("\r\n");
						sb.append("</representedOrganization>");sb.append("\r\n");
						sb.append("</assignedEntity>");sb.append("\r\n");
						sb.append("</performer>");sb.append("\r\n");
																		
						// get relative prescription line
						sb.append("<entryRelationship typeCode=\"REFR\">");
						sb.append(getRelativePrescriptionLineFromEP(epDoc,detail.getRelativePrescriptionLineId()));sb.append("\r\n");
						sb.append("</entryRelationship>");
											
						sb.append("</supply>");sb.append("\r\n");
						sb.append("</entry>");sb.append("\r\n");
						}
						sb.append("</section>");sb.append("\r\n");
					sb.append("</component>");sb.append("\r\n");
				sb.append("</structuredBody>");sb.append("\r\n");
			sb.append("</component>");sb.append("\r\n");
		sb.append("</ClinicalDocument>");sb.append("\r\n");
						
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	private static String addDoctorAuthor(CDAHeader cda)
	{
	StringBuffer sb = new StringBuffer();
	sb.append("<author typeCode=\"AUT\">");sb.append("\r\n");
	sb.append("<functionCode code=\"" + "221" +  "\" displayName=\"Medical doctors\" codeSystem=\"2.16.840.1.113883.2.9.6.2.7\" codeSystemName=\"epSOSHealthcareProfessionalRoles\"/>");sb.append("\r\n");
	sb.append("<time value=\"" + cda.getEffectiveTime() + "\"/>");sb.append("\r\n");
	sb.append("<assignedAuthor classCode=\"ASSIGNED\">");sb.append("\r\n");
	sb.append(addIDRoot("1.19", cda.getDoctorAMKA()));sb.append("\r\n");
	sb.append(addIDRoot("1.20", cda.getDoctorETAA()));sb.append("\r\n");
	sb.append(addAddress(cda.getDoctorAddress(),cda.getDoctorCity(),cda.getDoctorPostalCode(),
			cda.getDoctorCountry(),cda.getDoctorTelephone(),cda.getDoctorEmail()));
	sb.append("<assignedPerson classCode=\"PSN\" determinerCode=\"INSTANCE\">");sb.append("\r\n");
	sb.append(addName(cda.getDoctorFamilyName(),cda.getDoctorPrefix(),cda.getDoctorGivenName()));sb.append("\r\n");
	sb.append("</assignedPerson>");sb.append("\r\n");
	
	if (cda.getDoctorUnit()!=null)
	{
		sb.append("<representedOrganization>");sb.append("\r\n");
		sb.append("<id nullFlavor=\"NA\" />");sb.append("\r\n");
		sb.append("<name>" + cda.getDoctorUnit() + "</name>");sb.append("\r\n");
		sb.append(addAddress("","","",cda.getDoctorCountry(),"",""));
		sb.append("</representedOrganization>");sb.append("\r\n");
	}
	sb.append("</assignedAuthor>");sb.append("\r\n");
	sb.append("</author>");sb.append("\r\n");	
	
	return sb.toString();
	}
	
	
	private static String addEntryRelationship(String code1, String value1)
	{
		StringBuilder sb = new StringBuilder();
		sb.append("<entryRelationship inversionInd=\"true\" typeCode=\"RSON\">");sb.append("\r\n");
		sb.append("<act classCode=\"ACT\" moodCode=\"EVN\">"); sb.append("\r\n");
			sb.append("<templateId root=\"1.3.6.1.4.1.19376.1.5.3.1.4.4.1\" />"); sb.append("\r\n");
			sb.append("<templateId root=\"2.16.840.1.113883.10.20.1.27\" />");sb.append("\r\n");
			if (value1==null) value1="";
			if (value1.equals(""))
			{
			sb.append("<id nullFlavor=\"NI\" root=\"" + code1 + "\" />");sb.append("\r\n");
			}
			else
			{
			sb.append("<id extension=\"" + value1 + "\" root=\"" + code1 + "\" />");sb.append("\r\n");
			}
			sb.append("<code></code>"); sb.append("\r\n");
		sb.append("</act>");sb.append("\r\n");
		sb.append("</entryRelationship>");sb.append("\r\n");
		return sb.toString();
		
	}
	
	private static String addQuantity(String lowValue, String lowUnit, String highValue, String highUnit)
	{
		StringBuilder et = new StringBuilder();
		et.append("<epsos:quantity>");et.append("\r\n");
		et.append("<epsos:numerator xsi:type=\"epsos:PQ\" value=\"" + lowValue + "\" unit=\"" + lowUnit + "\"/>");et.append("\r\n");
		et.append("<epsos:denominator xsi:type=\"epsos:PQ\" value=\"" + lowValue + "\" unit=\"" + lowUnit + "\"/>");et.append("\r\n");
		et.append("</epsos:quantity>");et.append("\r\n");
		return et.toString();
	}


	
	private static String addDoseQuantity(String lowValue, String lowUnit, String highValue, String highUnit)
	{
		StringBuilder et = new StringBuilder();
		et.append("<doseQuantity>");et.append("\r\n");
		et.append("<low value=\"" + lowValue + "\" unit=\"" + lowUnit + "\"/>");et.append("\r\n");
		et.append("<high value=\"" + highValue + "\" unit=\"" + highUnit + "\"/>");et.append("\r\n");
		et.append("</doseQuantity>");et.append("\r\n");
		return et.toString();
	}

	/*
	 * <effectiveTime xsi:type='PIVL_TS' institutionSpecified='false' operator='A'> <period value='8' unit='h' /></effectiveTime> 
	 */
	private static String addDoseFrequency(String freq)
	{
		String eff="";
		if (freq.equals("5"))  // Μια φορά την εβδομάδα
			{
			eff="<effectiveTime xsi:type=\"PIVL_TS\">" +
					"<period value=\"1\" unit=\"wk\" /></effectiveTime>";
			}
		if (freq.equals("1"))  // Μια φορά την ημέρα
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"1\" unit=\"d\" /></effectiveTime>";
		}
		if (freq.equals("6"))  // Δύο φορές την εβδομάδα
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"4\" unit=\"d\" /></effectiveTime>";
		}
		if (freq.equals("2"))  // Δύο φορές την ημέρα
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"12\" unit=\"h\" /></effectiveTime>";
		}
		if (freq.equals("7"))  // Τρεις φορές την εβδομάδα
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"3\" unit=\"d\" /></effectiveTime>";
		}
		if (freq.equals("3"))  // Τρεις φορές την ημέρα
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"8\" unit=\"h\" /></effectiveTime>";
		}
		if (freq.equals("4"))  // Τέσσερις φορές την ημέρα
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"6\" unit=\"h\" /></effectiveTime>";
		}
		if (freq.equals("10"))  // Κάθε 2 εβδομάδες
		{
		eff="<effectiveTime xsi:type=\"PIVL_TS\" institutionSpecified=\"false\" operator=\"A\">" +
				"<period value=\"2\" unit=\"wk\" /></effectiveTime>";
		}
		if (freq.equals("0"))  // Ανευ
		{
		eff="<effectiveTime nullFlavor=\"NI\" />";
		}
		if (freq.equals("9"))  // Επί πόνου
		{
			eff="<effectiveTime xsi:type=\"EIVL_TS\" operator=\"A\">" +
					"<event code=\"PAIN\" />" +
					"</effectiveTime>";  
		}
		if (freq.equals("8"))  // Εφάπαξ
		{
			eff="<effectiveTime xsi:type=\"EIVL_TS\" operator=\"A\">" +
					"<event code=\"ONCE\" />" +
				"</effectiveTime>";  
		}
		return eff;
		
	}
	
	private static String addEffectiveTime(String low, String high)
	{
		StringBuilder et = new StringBuilder();
		et.append("<effectiveTime xsi:type=\"IVL_TS\">");et.append("\r\n");
		et.append("<low value=\"" + low + "\" />");et.append("\r\n");
		et.append("<high value=\"" + high + "\" />");et.append("\r\n");
		et.append("</effectiveTime>");
		return et.toString();
	}
	
	private static String addTextTag(String tagName, String value)
	{
		if (value==null) value="";
		StringBuilder sb = new StringBuilder();
		sb.append("<" + tagName);
		String ext="";
		if (value.equals("")) 
			ext=" nullFlavor=\"NI\">"; 
		else
			ext=">" + value;
		sb.append(ext);
		sb.append("</" + tagName + ">");
		return sb.toString();
	}
	
	private static String addTag(String tagName, String value)
	{
		if (value==null) value="";
		StringBuilder sb = new StringBuilder();
		sb.append("<" + tagName);
		String ext="";
		if (value.equals("")) 
			ext=" nullFlavor=\"NI\""; 
		else
			ext=" value=\"" + value + "\"";
		sb.append(ext);
		sb.append(" />");
		return sb.toString();
	}
	
	private static String addName(String family, String prefix, String given)
	{
		StringBuilder sb = new StringBuilder();
		sb.append("<name>");sb.append("\r\n");
		sb.append(addTextTag("family",family));sb.append("\r\n");
		sb.append(addTextTag("given",given));sb.append("\r\n");
		sb.append("</name>");
		return sb.toString();
	}
	
	private static String addAddress(String streetAddress, String city, String postalCode, String country, String tel, String email)
	{
		StringBuilder sb = new StringBuilder();
		sb.append("<addr>");sb.append("\r\n");
		sb.append(addTextTag("streetAddressLine",streetAddress));sb.append("\r\n");
		sb.append(addTextTag("city",city));sb.append("\r\n");
		sb.append(addTextTag("state","N/A"));sb.append("\r\n");
		sb.append(addTextTag("postalCode",postalCode));sb.append("\r\n");
		sb.append(addTextTag("country",country));sb.append("\r\n");
		sb.append("</addr>");sb.append("\r\n");
		if (tel==null) tel="";
		if (email==null) email="";
		if (!tel.equals(""))
			{
			sb.append("<telecom use=\"WP\" value=\"tel:+" + tel + "\" />");
			}
		if (!email.equals(""))
			{
			sb.append("<telecom use=\"WP\" value=\"mailto:" + email + "\"/>");
			}
		return sb.toString();
	}
	
	private static String addIDRoot(String id, String extension)
	{
		if (extension==null) extension="";
		String ret="";
		String ext ="";
		if (extension.equals("")) ext = "nullFlavor=\"NI\"";else 
			ext="extension=\"" + extension +"\"";
		ret ="<id root=\"" + id + "\" " + ext + " />";
		return ret;
	}
	
	private static String addTemplateIDRoot(String id, String extension)
	{
		if (extension==null) extension="";
		String ret="";
		String ext ="";
		if (extension.equals("")) ext = "nullFlavor=\"NI\"";else 
			ext="extension=\"" + extension +"\"";
		ret ="<templateId root=\"" + id + "\" " + ext + " />";
		return ret;
	}
	

	private static String getTagValue(String sTag, Element eElement) {
		String ret="";
		try
		{
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    ret = nValue.getNodeValue();
		}
		catch (Exception e)
		{
		_log.error("Error getting value " + e.getMessage());
		}
		return ret;
	  }
	 
	

	public static boolean checkPrescriptionBarcode(String dispensexml, String barcode)
	{
	boolean sameBarcode = false;
	try {
		Document doc = CDAUtils.readEpXML(dispensexml);
		XPathFactory xPathfactory = XPathFactory.newInstance();
		XPath xpath = xPathfactory.newXPath();
		xpath.setNamespaceContext(new CDANameSpaceContext());
		
		XPathExpression execExpr = xpath.compile("//xsi:inFulfillmentOf/xsi:order/xsi:id[@root='2.16.724.4.8.10.200.20']/@extension");
		NodeList nl = (NodeList) execExpr.evaluate(doc, XPathConstants.NODESET);
					
		String refBarcode="";
		if (nl.item(0) !=null)
			refBarcode = nl.item(0).getNodeValue();
		sameBarcode = barcode.equals(refBarcode);
		_log.debug("The reference prescription barcode is : " + refBarcode + " and the requested is : " + barcode + ".Comparison: " + sameBarcode);
		}  
		catch (Exception e) {
		_log.error(e.getMessage());
	}
	return sameBarcode;
	
	}
	
}
