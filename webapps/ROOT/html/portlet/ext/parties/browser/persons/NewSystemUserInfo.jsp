
<logic:equal name="NewPersonWizardForm" property="wizardPageNumber" value="<%=""+NewPersonWizardForm.WIZ_PG_SYSTEM_USER_INFO%>">

<script>
	function changeEnableStatusOfFields(formName, thisEl){
		try{
			var formEl = document.getElementsByName(formName)[0];
			
			var userIdEl = formEl.elements['screenName'];
			var passwordEl = formEl.elements['password'];
			var retypePasswordEl = formEl.elements['retypePassword'];
			var userEmailEl = formEl.elements['userEmail'];
			var existingUserIdSelectEl = formEl.elements['existingUserId'];
			
			var checkedFlag =  (thisEl.checked) ;
			
			if (checkedFlag) {
				userIdEl.className="gamma1-FormArea";				
				userIdEl.readOnly = false;
				
				passwordEl.className="gamma1-FormArea";				
				passwordEl.readOnly = false;
				
				retypePasswordEl.className="gamma1-FormArea";				
				retypePasswordEl.readOnly = false;
				
				userEmailEl.className="gamma1-FormArea";				
				userEmailEl.readOnly = false;
				
				
				existingUserIdSelectEl.className="gamma1-FormAreaDisable";				
				existingUserIdSelectEl.disabled = true;
			}else{
				userIdEl.value = '';
				userIdEl.className="gamma1-FormAreaDisable";
				userIdEl.readOnly = true;
				
				passwordEl.value = '';
				passwordEl.className="gamma1-FormAreaDisable";
				passwordEl.readOnly = true;
				
				retypePasswordEl.value = '';
				retypePasswordEl.className="gamma1-FormAreaDisable";
				retypePasswordEl.readOnly = true;
				
				userEmailEl.value = '';
				userEmailEl.className="gamma1-FormAreaDisable";
				userEmailEl.readOnly = true;
				
				existingUserIdSelectEl.className="gamma1-FormArea";				
				existingUserIdSelectEl.disabled = false;

			}
		}catch(ex){
			alert("EXCEPTION \n"+ex.message);
		}
	}
</script>

<tr><td>

<BR>
<h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.organizations.systemUserInfo")%>
</h3>
<BR>

</td></tr>

<tr><td>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewPersonWizardForm" />
			<tiles:put name="attributeName" value="SYSTEM_USER_INFO"/>
		</tiles:insert>
</td></tr>

</logic:equal>

