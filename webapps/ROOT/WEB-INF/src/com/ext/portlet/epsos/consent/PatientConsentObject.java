package com.ext.portlet.epsos.consent;

import java.io.Serializable;
import java.util.Date;

import com.ext.portlet.epsos.EpsosHelperService;
import com.spirit.ehr.ws.client.generated.EhrPatientClientDto;
import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;

public class PatientConsentObject implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String consentid;
	private String patientId;
	private String doctorName;
	private String doctorAddress;
	private String country;
	private Date creationDate;
	private Date validFrom;
	private Date validTo;
	
	
	public PatientConsentObject() {
		super();
	}
	
	
	public PatientConsentObject(String consentid, String patientId,
			String doctorName, String doctorAddress, String country,
			Date creationDate, Date validFrom, Date validTo) {
		super();
		this.consentid = consentid;
		this.patientId = patientId;
		this.doctorName = doctorName;
		this.doctorAddress = doctorAddress;
		this.country = country;
		this.creationDate = creationDate;
		this.validFrom = validFrom;
		this.validTo = validTo;
	}


	public String getConsentid() {
		return consentid;
	}
	
	public void setConsentid(String consentid) {
		this.consentid = consentid;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getDoctorAddress() {
		return doctorAddress;
	}
	public void setDoctorAddress(String doctorAddress) {
		this.doctorAddress = doctorAddress;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public Date getValidFrom() {
		return validFrom;
	}
	public void setValidFrom(Date validFrom) {
		this.validFrom = validFrom;
	}
	public Date getValidTo() {
		return validTo;
	}
	public void setValidTo(Date validTo) {
		this.validTo = validTo;
	}
	
	
	public String toXML(EhrPatientClientDto patient, SpiritUserClientDto doctor)
	{
		return EpsosHelperService.getInstance().patientConsentToXml(this, patient, doctor);
	}
}
