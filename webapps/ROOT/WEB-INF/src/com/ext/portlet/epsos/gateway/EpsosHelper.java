	package com.ext.portlet.epsos.gateway;
	
	import gnomon.hibernate.model.views.ViewResult;
	
	import java.util.ArrayList;
	import java.util.List;
	import java.util.Vector;
	
	import javax.jws.WebMethod;
	import javax.jws.WebService;
	import javax.servlet.http.HttpServletRequest;
	
	import com.ext.portlet.epsos.demo.PatientSearchForm;
import com.ext.sql.StrutsFormFields;
	import com.ext.sql.StrutsFormFields2;
import com.liferay.portal.model.User;
	import com.spirit.ehr.ws.client.generated.DocumentClientDto;
	import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.PolicySetGroup;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
	
	@WebService
	public interface EpsosHelper {
		 
		
		 /**
		 * @param username
		 * @return the SpiritUserClientDto. This id will be used in createConfirmation as the refAssertionId
		 * @throws CustomException 
		 */
		 @WebMethod SpiritUserClientDto initUser(String username,String password) throws CustomException;
		 
		 /**
		 * @param country
		 * @returns the list of the field required in seatch form for the specific country
		 *       <return>
	     *       <clearDate>true</clearDate>
	     *       <collectionLabel>countryNames</collectionLabel>
	     *       <collectionProperty>countryIds</collectionProperty>
	     *       <colour>inherit</colour>
	     *       <dateFormat/>
	     *       <dynamicField>false</dynamicField>
	     *       <field_size>20</field_size>
	     *       <formFieldKey>epsos.demo.search.country</formFieldKey>
	     *       <formFieldName>country</formFieldName>
	     *       <formFieldType>select</formFieldType>
	     *       <hidden>false</hidden>
	     *       <imgHeight>32</imgHeight>
	     *       <imgWidth>32</imgWidth>
	     *       <multipleSelection>0</multipleSelection>
	     *       <onChange>countrySelectionChanged()</onChange>
	     *       <popupHeight>350</popupHeight>
	     *       <popupWidth>450</popupWidth>
	     *       <readonly>false</readonly>
	     *       <required>false</required>
	     *       <secretTextField>false</secretTextField>
	     *       <selectOnlyLeaves>false</selectOnlyLeaves>
	     *       <textAreaCols>45</textAreaCols>
	     *       <textAreaRows>6</textAreaRows>
	     *       <textAreaToolBar>gnomon</textAreaToolBar>
	     *    </return>
		 */
		 @WebMethod Vector<StrutsFormFields> getFieldsForCountryFromNCP(String country,String language);	 
		 /**
		 * @param field
		 * @return the greek translation of the form field
		 */
		@WebMethod String getTranslation(String field);
		 /**
		 * @param xml
		 * Example input is the following <![CDATA[<form><field><name>country</name><value>SE</value></field><field><name>pid</name><value>192405038569</value></field></form>]]>
		 * @throws CustomException 
		 * @returns ths list of patients
		 *     <return>
	     *       <birthdate>1924-05-02T23:00:00Z</birthdate>
	     *       <familyName>Ordinationslista</familyName>
	     *       <givenName>Ofelia</givenName>
	     *       <homeCommunityId>2.16.17.710.807.1000.990.1</homeCommunityId>
	     *       <pid>
	     *          <domain>
	     *             <authUniversalID>2.16.17.710.807.1000.990.1</authUniversalID>
	     *             <authUniversalIDType>ISO</authUniversalIDType>
	     *          </domain>
	     *          <ehrPIDType>778</ehrPIDType>
	     *          <patientID>192405038569</patientID>
	     *          <patientIDType>RRI</patientIDType>
	     *       </pid>
	     *       <sex>F</sex>
	     *    </return>
	     *
		 */
		@WebMethod List<EhrPatientClientDto> searchPatients(String xml) throws CustomException;
		 /**
		 * @return the list of available countries in comma seperated list
		 */
		@WebMethod String ListCountries();

		
		/**
		 * @param docID is the unique ID of the requested document
		 * @param EhrPatientClientDto
		 * @return the cda document in a bytearray
		 * @throws CustomException 
		 */
		@WebMethod byte[] getCDADocument(String docID, EhrPatientClientDto patient) throws CustomException;

		@WebMethod byte[] getPDFDocument(DocumentClientDto doc, EhrPatientClientDto patient) throws CustomException;


	

		

		
		@WebMethod String getTranslationLang(String field, String language, String country);

		/**
		 * @param EhrPatientClientDto
		 * @return the list of eprescription documents for a specific patient
		 * @throws CustomException 
		 */
		@WebMethod List<DocumentClientDto> queryPatientEPDocs(EhrPatientClientDto patient) throws CustomException;

		 /**
		 * @param EhrPatientClientDto
		 * @param country
		 * @param purposeOfUse (TREATEMENT,EMERGENCY)
		 * @param username
		 * @return true if the confirmation created successfully
		 * @throws CustomException 
		 */
		@WebMethod boolean CreatePatientConfirmation(EhrPatientClientDto patient, String country,
				String purposeOfUse, String username) throws CustomException;

		@WebMethod boolean writeCDADocument(byte[] bytes, EhrPatientClientDto patient,
				String country, String language, String fullname)
				throws CustomException;

		/**
		 * @param docID is the unique ID of the requested document
		 * @param patID
		 * @param patIDType
		 * @param country
		 * @return the List of View Results of prescription lines
		 * 
		 * line.setField1(name);   			key=epsos.demo.prescription.name
		 * line.setField2(ingredient);		key=epsos.demo.prescription.ingredient
		 * line.setField3(strength);		key=epsos.demo.prescription.strength
		 * line.setField4(packsString);		key=epsos.demo.prescription.package
		 * line.setField5(doseString);		key=epsos.demo.prescription.dosage
		 * line.setField6(freqString);		key=epsos.demo.prescription.frequency
		 * line.setField7(routeString);		key=epsos.demo.prescription.route
		 * line.setField8(nrOfPacks);		key=epsos.demo.prescription.nrOfPacks
		 * line.setField9(lowString);		key=epsos.demo.prescription.start
		 * line.setField10(highString);		key=epsos.demo.prescription.end
		 * line.setField11(patientString); 	key=epsos.demo.prescription.instruction.patient
		 * line.setField12(fillerString);	key=epsos.demo.prescription.instruction.filler
		 * line.setField13(prescriber);  	key=epsos.demo.prescription.prescriber
		 * // entry header information
		 * line.setField14(prescriptionID);	
		 * // prescription header information
		 * line.setField15(performer);
		 * line.setField16(profession);
		 * line.setField17(facility);
		 * line.setField18(address);
		 * line.setField19(dispenseID);  key=epsos.demo.prescription.id
		 * line.setField20(substitutionPermitted);
		 * line.setMainid(lines.size());
		 * 
		 * @throws CustomException 
		 */
		@WebMethod List<ViewResult> getCDAPrescriptionLines(String docID,
				EhrPatientClientDto patient)
				throws CustomException;

		/**
		 * @param EhrPatientClientDto
		 * @return the empty policy set group for patient
		 * @throws CustomException
		 */

		@WebMethod List<PolicySetGroup> queryPolicySets(
				EhrPatientClientDto patient)
				throws CustomException;

		/**
		 * @param EhrPatientClientDto
		 * @param country
		 * @param language
		 * @param policies
		 * @param fromdate
		 * @param todate
		 * @return T/F 
		 * @throws CustomException
		 */

		@WebMethod boolean WriteConsentPolicy(EhrPatientClientDto patient, String country,
				String language, String policies, String fromdate, String todate)
				throws CustomException;

		@WebMethod int Authenticate(long companyid, String username, String password)
				throws CustomException;

		@WebMethod int epsosAuthenticate(String username, String password)
				throws CustomException;

		@WebMethod public boolean writeDispensationDocument(String prescriptionID, SpiritUserClientDto usr, EhrPatientClientDto patient, 
				ViewResult prescribedLine, String dispensedId, String dispensedProduct, boolean isSubstitute, String dispensedQuantity, String country, String language, boolean sent)
				throws CustomException;

		@WebMethod List<ViewResult> getCDAPrescriptionLinesFromEP(byte[] bytes,
				EhrPatientClientDto patient) throws CustomException;

		@WebMethod String transformCDA(byte[] prescription, String language)
				throws CustomException;

		@WebMethod String getLanguageTranslation(String field, String language,
				String country);

		@WebMethod boolean writeDispensationDocumentFromEP(byte[] prescription,
				SpiritUserClientDto usr, EhrPatientClientDto patient,
				ViewResult prescribedLine, String dispensedId,
				String dispensedProduct, boolean isSubstitute,
				String dispensedQuantity, String country, String language,
				boolean sent) throws CustomException;

		boolean sendAuditLocal(EhrPatientClientDto patient, String remoteHost,
				String screenName, boolean pin) throws CustomException;

		@WebMethod boolean sendAudit(EhrPatientClientDto patient, String screenName,
				boolean pin) throws CustomException;

		byte[] getConsentReport(String lang2, String fullname,
				EhrPatientClientDto patient) throws CustomException;
	
	}
	
	
