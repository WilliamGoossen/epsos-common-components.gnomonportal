<logic:equal name="NewPersonWizardForm" property="wizardPageNumber" value="<%=""+NewPersonWizardForm.WIZ_PG_COMPLETE_INFO%>">

<tr><td>

<BR>
<h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.organizations.optionalInfo")%>
</h3>
</td></tr>
<tr><td>

<TABLE width="100%">
<TR>
<TD colspan="2" align="left">
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewPersonWizardForm" />
			<tiles:put name="attributeName" value="PERSON_AFM_FIELDS"/>
		</tiles:insert>
</TD>
</TR>

<TR>
<TD><h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.browser.tab.geographicAddress")%>
</h3></TD>
<TD><h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.browser.tab.telecomAddresses")%>
</h3></TD>
</TR>

<TR>
<TD align="left" valign="top" >
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewPersonWizardForm" />
			<tiles:put name="attributeName" value="PERSON_GEOGRAPHIC_ADDRESS_FIELDS"/>
		</tiles:insert>
		
</TD>
<TD align="left" valign="top" >
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewPersonWizardForm" />
			<tiles:put name="attributeName" value="PERSON_TELECOM_ADDRESS_FIELDS"/>
		</tiles:insert>
</TD>
</TR>
</TABLE>

<BR>

</td></tr>

</logic:equal>
