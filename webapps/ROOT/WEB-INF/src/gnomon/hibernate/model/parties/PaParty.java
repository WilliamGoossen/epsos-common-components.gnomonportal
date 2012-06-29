package gnomon.hibernate.model.parties;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class PaParty implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** identifier field */
    private Integer mainid;

    /** nullable persistent field */
    private Long companyId;
    
    private Boolean active;
    
    private boolean privateContact = false;
    private Date creationDate;
    private Date modifiedDate;
    private PaParty ownerParty;
    private Set ownedParties;
    
    private String relatedImage;
    private String relatedFile;
    
    /** persistent field */
    private Set paGeographicAddresses;

    /** persistent field */
    private Set paPartyLanguages;

    /** persistent field */
    private Set paTelecomAddresses;

    /** persistent field */
    private Set psPartyRoles;

    /** persistent field */
    private Set paEmailAddresses;

    /** persistent field */
    private Set paWebpageAddresses;

    /** persistent field */
    private Set paEvents;

    /** persistent field */
    private Set paRegisteredIdentifiers;
    
    private Set paGroupMemberships;
    
    private Set paPartyTopics;
    
    private Set paPartyHighRoles;
    
    private Set paPartyHighRolesByOtherParty;
    
    /** full constructor */
    public PaParty(Set paGeographicAddresses, Set paPartyLanguages, Set paTelecomAddresses, Set psPartyRoles, Set paEmailAddresses, Set paWebpageAddresses, Set paEvents, Set paRegisteredIdentifiers) {
        this.paGeographicAddresses = paGeographicAddresses;
        this.paPartyLanguages = paPartyLanguages;
        this.paTelecomAddresses = paTelecomAddresses;
        this.psPartyRoles = psPartyRoles;
        this.paEmailAddresses = paEmailAddresses;
        this.paWebpageAddresses = paWebpageAddresses;
        this.paEvents = paEvents;
        this.paRegisteredIdentifiers = paRegisteredIdentifiers;
        active = new Boolean(true);
    }

    /** default constructor */
    public PaParty() {
    	active = new Boolean(true);
    }

    public Integer getMainid() {
        return this.mainid;
    }

    public void setMainid(Integer mainid) {
        this.mainid = mainid;
    }
    
    public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public Set getPaGeographicAddresses() {
        return this.paGeographicAddresses;
    }

    public void setPaGeographicAddresses(Set paGeographicAddresses) {
        this.paGeographicAddresses = paGeographicAddresses;
    }

    public Set getPaPartyLanguages() {
        return this.paPartyLanguages;
    }

    public void setPaPartyLanguages(Set paPartyLanguages) {
        this.paPartyLanguages = paPartyLanguages;
    }

    public Set getPaTelecomAddresses() {
        return this.paTelecomAddresses;
    }

    public void setPaTelecomAddresses(Set paTelecomAddresses) {
        this.paTelecomAddresses = paTelecomAddresses;
    }

    public Set getPsPartyRoles() {
        return this.psPartyRoles;
    }

    public void setPsPartyRoles(Set psPartyRoles) {
        this.psPartyRoles = psPartyRoles;
    }

    public Set getPaEmailAddresses() {
        return this.paEmailAddresses;
    }

    public void setPaEmailAddresses(Set paEmailAddresses) {
        this.paEmailAddresses = paEmailAddresses;
    }

    public Set getPaWebpageAddresses() {
        return this.paWebpageAddresses;
    }

    public void setPaWebpageAddresses(Set paWebpageAddresses) {
        this.paWebpageAddresses = paWebpageAddresses;
    }

    public Set getPaEvents() {
        return this.paEvents;
    }

    public void setPaEvents(Set paEvents) {
        this.paEvents = paEvents;
    }

    public Set getPaRegisteredIdentifiers() {
        return this.paRegisteredIdentifiers;
    }

    public void setPaRegisteredIdentifiers(Set paRegisteredIdentifiers) {
        this.paRegisteredIdentifiers = paRegisteredIdentifiers;
    }

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String toString() {
        return new ToStringBuilder(this)
            .append("mainid", getMainid())
            .toString();
    }

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

	public boolean isPrivateContact() {
		return privateContact;
	}

	public void setPrivateContact(boolean privateContact) {
		this.privateContact = privateContact;
	}

	public PaParty getOwnerParty() {
		return ownerParty;
	}

	public void setOwnerParty(PaParty ownerParty) {
		this.ownerParty = ownerParty;
	}

	public Set getOwnedParties() {
		return ownedParties;
	}

	public void setOwnedParties(Set ownedParties) {
		this.ownedParties = ownedParties;
	}

	public Set getPaGroupMemberships() {
		return paGroupMemberships;
	}

	public void setPaGroupMemberships(Set paGroupMemberships) {
		this.paGroupMemberships = paGroupMemberships;
	}

	public Set getPaPartyTopics() {
		return paPartyTopics;
	}

	public void setPaPartyTopics(Set paPartyTopics) {
		this.paPartyTopics = paPartyTopics;
	}

	public Set getPaPartyHighRoles() {
		return paPartyHighRoles;
	}

	public void setPaPartyHighRoles(Set paPartyHighRoles) {
		this.paPartyHighRoles = paPartyHighRoles;
	}

	public Set getPaPartyHighRolesByOtherParty() {
		return paPartyHighRolesByOtherParty;
	}

	public void setPaPartyHighRolesByOtherParty(Set paPartyHighRolesByOtherParty) {
		this.paPartyHighRolesByOtherParty = paPartyHighRolesByOtherParty;
	}

	public String getRelatedImage() {
		return relatedImage;
	}

	public void setRelatedImage(String relatedImage) {
		this.relatedImage = relatedImage;
	}

	public String getRelatedFile() {
		return relatedFile;
	}

	public void setRelatedFile(String relatedFile) {
		this.relatedFile = relatedFile;
	}

	
	
}
