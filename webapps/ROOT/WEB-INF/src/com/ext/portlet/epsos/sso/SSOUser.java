package com.ext.portlet.epsos.sso;

import java.io.Serializable;

public class SSOUser implements Serializable { 
	private static final long serialVersionUID = 1L;
	
	public String login;
	public String emailAddress;
	public String firstName;
	public String lastName;
	public String organisationName;
	public String language;

/*
 * Role: 0 for nurse
 * Role 1 for pharmacist
 * Role medical doctors for doctor
 * Role 3 for administrator
 */
	public String role;
	
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getOrganisationName() {
		return organisationName;
	}
	public void setOrganisationName(String organisationName) {
		this.organisationName = organisationName;
	}
	public String getRole() {
		return role;
	}
	
	public void setRole(String role) {
		this.role = role;
	}
	public String getLogin() {
			return login;
	}
	public void setLogin(String login) {
			this.login = login;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}

	
	
}
