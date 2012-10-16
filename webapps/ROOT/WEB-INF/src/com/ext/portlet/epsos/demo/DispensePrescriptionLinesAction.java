package com.ext.portlet.epsos.demo;

import gnomon.business.FileUploadHelper;
import gnomon.business.GeneralUtils;
import gnomon.hibernate.model.views.ViewResult;
import gnomon.util.GnPropsUtil;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.compass.core.util.backport.java.util.Arrays;

import com.ext.portlet.epsos.EpsosHelperService;
import com.ext.portlet.epsos.gateway.EpsosHelperImpl;
import com.ext.util.CommonUtil;
import com.ext.util.TitleData;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.PortalUtil;
import com.spirit.ehr.ws.client.generated.DocumentClientDto;
import com.spirit.ehr.ws.client.generated.EhrPIDClientDto;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.IheClassificationClientDto;
import com.spirit.ehr.ws.client.generated.PatientContentClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;
import com.spirit.ehr.ws.client.generated.XdsQArgsDocument;
import com.spirit.ehr.ws.interfaces.SpiritEhrWsClientInterface;

public class DispensePrescriptionLinesAction extends PortletAction {

	public void processAction(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			ActionRequest request, ActionResponse response)
	throws Exception
	{

		EpsosHelperService epsos = null;
		SpiritUserClientDto usr = null;
		User portaluser = PortalUtil.getUser(request);
		try {

			epsos = EpsosHelperService.getInstance(); 
			usr = epsos.getEpsosUserInformation(request);

			SpiritEhrWsClientInterface webservice = epsos.getWebService(request);

			String docID = request.getParameter("docID");
			
			List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)CommonUtil.getHttpServletRequest(request).getSession().getAttribute("patientDocuments");
			DocumentClientDto doc = patientDocuments.get(Integer.parseInt(docID));		

			EhrPatientClientDto patient = null;
			patient = EpsosHelperService.getInstance().getPatientFromRequest(request);

			if (patient!=null)
			{
				TitleData titleData = epsos.generatePatientTitleData(request, patient);

				XdsQArgsDocument argDoc = new XdsQArgsDocument();
				XdsQArgsDocument qArgs = new XdsQArgsDocument();
				qArgs=EpsosHelperService.getInstance().getArgsForEP();
				DocumentClientDto prescription = null;
				prescription = doc;
						
				if (prescription != null)
				{
//					// FOR TESTING PURPOSES 
//					boolean useLocalDocument = GetterUtil.getBoolean(GnPropsUtil.get("portalb", "epsos.use.default.local.document.example"), false);
//					if (useLocalDocument) EpsosHelperService.getInstance().createLog("USING LOCAL DOCUMENT FOR EP DOC",null);
					
					byte[] bytes = null;
					List<ViewResult> lines=null;
					bytes = (byte[])CommonUtil.getHttpServletRequest(request).getSession().getAttribute("bytes");
					if (bytes==null)
					{
					bytes = webservice.retrieveDocument(prescription);
					lines = epsos.parsePrescriptionDocumentForPrescriptionLines(bytes);
					}
					if (lines != null && lines.size() > 0)
					{
						// fill in title data with prescription header info
						ViewResult line = lines.get(0);
						if (Validator.isNotNull(line.getField15()))
						{
							titleData.put("epsos.demo.prescription.performer", line.getField15());
						}
						if (Validator.isNotNull(line.getField16()))
						{
							titleData.put("epsos.demo.prescription.profession", line.getField16());
						}
						if (Validator.isNotNull(line.getField17()))
						{
							titleData.put("epsos.demo.prescription.facility", line.getField17());
						}
						if (Validator.isNotNull(line.getField18()))
						{
							titleData.put("epsos.demo.prescription.address", line.getField18());
						}
					}

					String[] dispensedIds = new String[lines.size()];
					for (int i=0;i<lines.size();i++)
					{
						dispensedIds[i]=request.getParameter("dispensationid_" + i);
					}
					
					String language = GeneralUtils.getLocale(request);
					String fullname = "EPSOS PORTAL";
					try {
						fullname = PortalUtil.getUser(request).getFullName();
					} catch (Exception e1) {
					
					} 
					
					
					if (dispensedIds.length==0) 
					{
						//epsos.uploadDispensationDocument(webservice, bytes, patient,request.getParameter("country"),usr, language,fullname);
						request.setAttribute("prescriptionLines", lines);
						setForward(request, "common.validation");
						return;
					}

					if (dispensedIds != null)
					{
						List<String> dispensedIdsList = Arrays.asList(dispensedIds);
						// find out which ones of these are dispensed by the user, and generate the dispensation document
						ArrayList<ViewResult> dispensedLines = new ArrayList<ViewResult>();
						for (ViewResult line: lines)
						{
							int id = line.getMainid();
						//	if (!dispensedIdsList.contains(String.valueOf(id)))
						//		continue;  // skip non-dispensed items
							EpsosHelperImpl eh = new EpsosHelperImpl();
							String measures_id = request.getParameter("measures_"+id); 
							String dispensed_id = request.getParameter("dispensationid_"+id); //field1
							String dispensedProduct = request.getParameter("dispensedProductValue_"+id);
							if (Validator.isNull(dispensedProduct)) dispensedProduct=line.getField1()+"";
							String dispensed_substitute = request.getParameter("dispense_"+id); // field3
							boolean substitute = GetterUtil.getBoolean(dispensed_substitute, false);
							String dispensed_quantity = request.getParameter("dispensedPackageSize_"+id); // field7 //lathos
							if (Validator.isNull(dispensed_quantity)) dispensed_quantity=line.getField21()+"";
							String dispensed_name = dispensedProduct;
							String dispensed_strength = line.getField3()+"";
							String dispensed_form =  line.getField4()+"";
							String dispensed_package =  line.getField4()+""; //request.getParameter("packaging2_"+id); // field6
							String dispensed_nrOfPacks =  line.getField8().toString();
							String prescriptionid = line.getField14()+""; // field9 //lathos
							String materialid = line.getField19()+""; // field10
							String activeIngredient = line.getField2().toString();
							
//							eh.writeDispensationDocument(prescriptionid, usr, patient, line, dispensed_id, dispensedProduct, substitute, dispensed_quantity, request.getParameter("country"), language);
	
							ViewResult d_line = new ViewResult(
									id, 
									dispensed_id, 
									dispensed_name, 
									substitute,
									dispensed_strength, 
									dispensed_form, 
									dispensed_package, 
									dispensed_quantity, 
									dispensed_nrOfPacks, 
									prescriptionid, 
									materialid, 
									activeIngredient,
									measures_id);

							dispensedLines.add(d_line);
						}

						if (dispensedLines.size() > 0)
						{
							ActionErrors errors = validateLines(lines, dispensedLines);
							if (errors != null && !errors.isEmpty())
							{
								request.setAttribute(Globals.ERROR_KEY, errors);
								request.setAttribute("prescriptionLines", lines);
								setForward(request, "common.validation");
								return;
							}
							else
							{
								/*
								 * field7: quantity
								 * field2: dispensed name
								 * field12: measure
								 * field3: substitution
								 * field4: strength
								 */
//								
								bytes = epsos.generateDispensationDocumentFromPrescription2(bytes, lines, dispensedLines, usr, portaluser);
								//bytes = epsos.generateDispensationDocumentFromPrescription(bytes, lines, dispensedLines, usr,portaluser);
								if (Validator.isNotNull(bytes))
									epsos.uploadDispensationDocument(webservice, bytes, patient,request.getParameter("country"),usr, language,fullname);
								else
								{
									EpsosHelperService.getInstance().createLog("UPLOAD DISP DOC RESPONSE ERROR",null);
									request.setAttribute("exception", "UPLOAD DISP DOC RESPONSE ERROR");
									setForward(request, "common.failure");
									return;
								}
							}
						}
						request.setAttribute("dispensedLines", dispensedLines);
					}
					request.setAttribute("prescriptionLines", lines);


				}
			}

			setForward(request, "common.success");
		} catch (Exception e) {
			
			if (e.getMessage().contains("LOGIN_REQUIRED"))
			{
			User user = PortalUtil.getUser(request);
			EpsosHelperService.getInstance().createLog("DISPENSE, RESPONSE ERROR: " + e.getMessage(),usr);
			String errMsg = EpsosHelperService.getPortalTranslation("session.timeout.relogin",user.getLanguageId());
			String loginMsg = EpsosHelperService.getPortalTranslation("login.login",user.getLanguageId());
			request.setAttribute("exception", errMsg + " <a href='/c/portal/logout'>" + loginMsg + "</a>");
			setForward(request, "common.failure");
			}
			
			
			e.printStackTrace();
			EpsosHelperService.getInstance().createLog("UPLOAD DISP DOC RESPONSE ERROR:" + e.getMessage(),null);
			request.setAttribute("exception", e.getMessage());
			setForward(request, "common.failure");
		}
	}

	
	private ActionErrors validateLines(List<ViewResult> lines, List<ViewResult> dispensedLines)
	{
		ActionErrors result = null;

		if (dispensedLines != null)
		{
			for (int l=0; l<dispensedLines.size(); l++)
			{
				ViewResult d_line = dispensedLines.get(l);
				//id mandatory
				if (Validator.isNull(d_line.getField1()))
				{
					ActionMessage mesg = new ActionMessage("epsos.dispensation.error.id.required");
					if (result == null) result = new ActionErrors();
					result.add("dispensationid_"+ d_line.getMainid().toString(), mesg);
				}
				
				// nr of packages mandatory
				if (Validator.isNull(d_line.getField8()) || 
						!Validator.isNumber((String)d_line.getField8()) ||
						d_line.getField8().equals("0"))
				{
					ActionMessage mesg = new ActionMessage("epsos.dispensation.error.nrOfPacks.required");
					if (result == null) result = new ActionErrors();
					result.add("nrOfPacks_"+ d_line.getMainid().toString(), mesg);
				}
				else
				{
					// nr of packages must be less than that of the prescribed line
					try {
						int nrOfPacksEntered = Integer.valueOf((String)d_line.getField8());
						int nrOfPacksPrescribed = Integer.valueOf((String)lines.get(l).getField8());
						if (nrOfPacksEntered > nrOfPacksPrescribed)
						{
							ActionMessage mesg = new ActionMessage("epsos.dispensation.error.nrOfPacks.too-large");
							if (result == null) result = new ActionErrors();
							result.add("nrOfPacks_"+ d_line.getMainid().toString(), mesg);
						}
					} catch (Exception e1) {}
				}

				if (d_line.getField3() != null && ((Boolean)d_line.getField3()).booleanValue())
				{
					// if substituting, brand name and package quantity mandatory
					if (Validator.isNull(d_line.getField2()))
					{
						ActionMessage mesg = new ActionMessage("epsos.dispensation.error.name.required");
						if (result == null) result = new ActionErrors();
						result.add("name_"+ d_line.getMainid().toString(), mesg);
					}
					
					if (Validator.isNull(d_line.getField7()))
					{
						ActionMessage mesg = new ActionMessage("epsos.dispensation.error.packaging.required");
						if (result == null) result = new ActionErrors();
						result.add("packaging3_"+ d_line.getMainid().toString(), mesg);
					}
				}
			}
		}
		return result;
	}
	
}
