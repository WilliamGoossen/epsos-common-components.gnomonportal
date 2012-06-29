package com.ext.portlet.epsos;

import java.io.Serializable;

public class SearchMask implements Serializable{

	private static final long serialVersionUID = 1L;
	
	public String label;
	public String domain;
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	
}
