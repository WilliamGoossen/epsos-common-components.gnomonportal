<%@ include file="/html/portlet/init.jsp" %>

<%
String titleParam = ParamUtil.getString(request,"titleParam"); 
String urlParam = ParamUtil.getString(request,"urlParam");
String idParam = ParamUtil.getString(request,"idParam");
if (Validator.isNull(titleParam))
	titleParam = "document.title";
else
	titleParam = "'" + titleParam + "'";

if (Validator.isNull(urlParam))
	urlParam = "document.URL";
else
	urlParam = "'" + urlParam + "'";
%>

<div id="<portlet:namespace/>mySendToFriend<%=idParam%>" style="padding-top:1px;">
	<img style="vertical-align:middle; padding-right:4px;" src="<%=themeDisplay.getPathThemeImages()%>/base/email_users.gif" alt="<%=LanguageUtil.get(pageContext, "send.to.a.friend") %>" /><a href="javascript: <portlet:namespace/>prepareProposal<%=idParam%>();"><%=LanguageUtil.get(pageContext, "send.to.a.friend") %></a>
</div>

<div id="<portlet:namespace />mySendFormArea<%=idParam%>" style="padding-top:1px; display: none; width:90%;">
	<form name="<portlet:namespace />fm<%=idParam%>">

		<input type="hidden" id="<portlet:namespace />subject<%=idParam%>"/>
		
		<div class="ctrl-holder">
			<label for="<portlet:namespace />message<%=idParam%>"><%= LanguageUtil.get(pageContext, "message") %></label>
			<textarea style="width:100%" rows="7" id="<portlet:namespace />message<%=idParam%>"></textarea>
		</div>
		
		<div class="ctrl-holder">
			<label for="<portlet:namespace />emailto<%=idParam%>"><%= LanguageUtil.get(pageContext, "email-to") %></label>
			<input type="text" id="<portlet:namespace />emailto<%=idParam%>" style="width:100%" size="5"/>
		</div>
		
		<div class="btn-holder">
			<input class="portlet-form-button" type="button" value="<bean:message key="send" />" onClick="<portlet:namespace />sendToFriend<%=idParam%>();">
		</div>
	</form>
</div>

<div id="<portlet:namespace />mySendSuccess<%=idParam%>" style="padding-top:10px; display: none;">
	<%= LanguageUtil.get(pageContext, "the-email-was-sent-successfuly") %>
</div>
<div id="<portlet:namespace />mySendFailure<%=idParam%>" style="padding-top:10px; display: none;">
	<%= LanguageUtil.get(pageContext, "the-email-could-not-be-sent") %>
</div>


<script type="text/javascript")>
	/*
	function <portlet:namespace />sendToFriend() {
		var mytitle = document.title;
		var myurl = document.URL;
		//alert('mailto:?subject=' + mytitle + '&body=' + myurl);
		document.location = 'mailto:?subject=Check this page out!' + '&body=' + myurl;
	}
	*/

	function <portlet:namespace />prepareProposal<%=idParam%>() {
		<portlet:namespace />populateSendForm<%=idParam%>();
		Liferay.Util.toggleByIdSpan(document, '<portlet:namespace />mySendFormArea<%=idParam%>');
		document.getElementById("<portlet:namespace />mySendSuccess<%=idParam%>").style.display = "none";
		document.getElementById("<portlet:namespace />mySendFailure<%=idParam%>").style.display = "none";
	}

	function <portlet:namespace />populateSendForm<%=idParam%>() {
		var mytitle = <%=titleParam%>;
		var myurl = <%=urlParam%>;
		var myhref = "<a href=\"" + myurl + "\">" + mytitle + "</a>";
		var subjectObj = document.getElementById("<portlet:namespace />subject<%=idParam%>");
		var messageObj = document.getElementById("<portlet:namespace />message<%=idParam%>");
		var emailToObj = document.getElementById("<portlet:namespace />emailto<%=idParam%>");

		if ((subjectObj.value==null || subjectObj.value=="")) {
			subjectObj.value = mytitle;
			messageObj.value = mytitle + ": " + myurl + "\n\n";
		}
		emailToObj.focus();
	}


	function <portlet:namespace />onSendSuccess<%=idParam%>() {
		document.getElementById("<portlet:namespace />mySendSuccess<%=idParam%>").style.display = "block";
		document.getElementById("<portlet:namespace />mySendFailure<%=idParam%>").style.display = "none";
		Liferay.Util.toggleByIdSpan(document, "<portlet:namespace />mySendFormArea<%=idParam%>");
	}

	function <portlet:namespace />onSendFailure<%=idParam%>() {
		document.getElementById("<portlet:namespace />mySendFailure<%=idParam%>").style.display = "block";
		document.getElementById("<portlet:namespace />mySendSuccess<%=idParam%>").style.display = "none";
		//Liferay.Util.toggleByIdSpan(document, "<portlet:namespace />mySendFormArea<%=idParam%>");
	}
	
	function <portlet:namespace />sendToFriend<%=idParam%>() {
		var callurl = '<%= themeDisplay.getPathMain() %>/ext/products/browser/send';

		var subjectObj = document.getElementById("<portlet:namespace />subject<%=idParam%>");
		var messageObj = document.getElementById("<portlet:namespace />message<%=idParam%>");
		var emailToObj = document.getElementById("<portlet:namespace />emailto<%=idParam%>");

		var mysubject = subjectObj.value;
		var mymessage = messageObj.value;
		var myemailto = emailToObj.value;
		jQuery.ajax(
				{
					url: callurl,
					data: {
						subject: mysubject,
						message: mymessage,
						emailto: myemailto
					},
					type: 'POST',
					dataType: 'json',
					success: function(data, textStatus) {
						<portlet:namespace />onSendSuccess<%=idParam%>();
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						<portlet:namespace />onSendFailure<%=idParam%>();
					}
				}
			);
	}
	
	function <portlet:namespace />handleJSONError<%=idParam%>(action, XMLHttpRequest, textStatus, errorThrown) {
		//alert('Oups! An error accured while trying to perform "' + action + '"');
	}
</script>
<noscript></noscript>

