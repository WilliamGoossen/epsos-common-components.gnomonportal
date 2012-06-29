<logic:equal name="NewPersonWizardForm" property="wizardPageNumber" value="<%=""+NewPersonWizardForm.WIZ_PG_COMPLETE_INFO%>">

<tr><td>
<BR>
<h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.organizations.optionalInfo")%>
</h3>
<BR>
</td></tr>
<tr><td>


	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewPersonWizardForm" />
			<tiles:put name="attributeName" value="PERSON_COMP_DEP_FIELDS"/>
		</tiles:insert>
		
<BR>
</td></tr>

</logic:equal>