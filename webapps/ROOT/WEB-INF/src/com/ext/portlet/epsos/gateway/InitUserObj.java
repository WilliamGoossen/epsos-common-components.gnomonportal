package com.ext.portlet.epsos.gateway;

import java.io.Serializable;
import java.util.List;

import org.opensaml.saml2.core.Assertion;

import com.spirit.ehr.ws.client.generated.SpiritUserClientDto;

public class InitUserObj implements Serializable { 
	private static final long serialVersionUID = 1L;

	SpiritUserClientDto usr;
	Assertion assertion;
	
	public SpiritUserClientDto getUsr() {
		return usr;
	}
	public void setUsr(SpiritUserClientDto usr) {
		this.usr = usr;
	}
	public Assertion getAssertion() {
		return assertion;
	}
	public void setAssertion(Assertion assertion) {
		this.assertion = assertion;
	}
	
	
}
