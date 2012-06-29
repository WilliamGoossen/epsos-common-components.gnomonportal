package com.ext.portlet.epsos.gateway;

import java.io.Serializable;
import java.util.List;

import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;

public class SpiritUser implements Serializable { 
	private static final long serialVersionUID = 1L;

	public static List<String> uid;
	public static String surname;
	public static String givenname;
	public static String organisattionDN;
	public static String organisationName;;
	public static String orgState;
	public static String orgLocality;
	public static String postalCode;
	public static String streetAddress;
	
//	public SpiritUser populateSpiritUserFromPortal(SpiritUserClientDto doctor)
//	{
//		SpiritUser su = new SpiritUser();
//		su.setUid(doctor.getUid());
//		su.setSurname(doctor.getSurname())
//		return su;
//	}
	
	public static String getSurname() {
		return surname;
	}
	public static void setSurname(String surname) {
		SpiritUser.surname = surname;
	}
	public static String getGivenname() {
		return givenname;
	}
	public static void setGivenname(String givenname) {
		SpiritUser.givenname = givenname;
	}
	public static String getOrganisattionDN() {
		return organisattionDN;
	}
	public static void setOrganisattionDN(String organisattionDN) {
		SpiritUser.organisattionDN = organisattionDN;
	}
	public static String getOrganisationName() {
		return organisationName;
	}
	public static void setOrganisationName(String organisationName) {
		SpiritUser.organisationName = organisationName;
	}
	public static String getOrgState() {
		return orgState;
	}
	public static void setOrgState(String orgState) {
		SpiritUser.orgState = orgState;
	}
	public static String getOrgLocality() {
		return orgLocality;
	}
	public static void setOrgLocality(String orgLocality) {
		SpiritUser.orgLocality = orgLocality;
	}
	public static String getPostalCode() {
		return postalCode;
	}
	public static void setPostalCode(String postalCode) {
		SpiritUser.postalCode = postalCode;
	}
	public static String getStreetAddress() {
		return streetAddress;
	}
	public static void setStreetAddress(String streetAddress) {
		SpiritUser.streetAddress = streetAddress;
	}

	public static List<String> getUid() {
		return uid;
	}

	public static void setUid(List<String> uid) {
		SpiritUser.uid = uid;
	}
	
}
