
 

	

<SCRIPT>
	function onChange(formName, thisEl){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		    var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/load" /><liferay-portlet:param name="loadaction" value ="subscribe" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}
	
	
	function submitFormForLoadSubscribe(formName){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		   	var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/load" /><liferay-portlet:param name="loadaction" value ="subscribe" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}
	function submitFormForSubscribe(formName){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		   	var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/subscribe" /><liferay-portlet:param name="loadaction" value ="subscribe" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}
	function submitFormForActivate(formName){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		   	var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/subscribe" /><liferay-portlet:param name="loadaction" value ="activate" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}
	function submitFormForRequestActivationCode(formName){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		   	var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/subscribe" /><liferay-portlet:param name="loadaction" value ="requestActivationCode" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}
	function submitFormForLoadUnsubscribe(formName){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		   	var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/load" /><liferay-portlet:param name="loadaction" value ="unsubscribe" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}
	
	function submitFormForUnsubscribe(formName){
		try {
			var formEl = document.getElementsByName(formName)[0];		    
		   	var loadFormUrl = '<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value ="/ext/smslists_display/unsubscribe" /><liferay-portlet:param name="loadaction" value ="unsubscribe" /></liferay-portlet:actionURL>';

   			formEl.action = loadFormUrl;
		    submitForm(formEl);
		} catch (e) { 	
			alert(e.message);
		}
	}

</SCRIPT>
