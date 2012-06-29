<%@ include file="/html/common/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>

<html>
<head>
	<title><%= LanguageUtil.get(pageContext, "gn.topics.browser.delete") %></title>
	<link href="/html/themes/brochure/css/main.css" type="text/css" rel="stylesheet" />
</head>
<body>

<%
String openerFormName = request.getParameter("openerFormName");
String openerFormFieldName = request.getParameter("openerFormFieldName");
String topicIds = request.getParameter("topicIds");

String[] topics = topicIds.split(",");
String[] topicNames = new String[topics.length];
String[] topicNameField = {"langs.name"};
String lang = gnomon.business.GeneralUtils.getLocale(request);
GnPersistenceService serv = GnPersistenceService.getInstance(null);

for (int v=0; v<topics.length; v++)
{
	if (!topics[v].equals(""))
	{
		Integer topicId = Integer.valueOf(topics[v]);
		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		topicNames[v] =  (String)topicView.getField1();
	}
}
%>

<form action="/some/url" name="topic_deletion_choice_form" method="post" class="uni-form">
<fieldset class="inline-labels">
<legend> <%= LanguageUtil.get(pageContext, "gn.topics.browser.delete") %> </legend>
<% for (int v=0; v<topics.length; v++) { %>

<div class="ctrl-holder">
<label for="topicId"><%= topicNames[v] %></label>

<input type="radio" name="topicId" value="<%=topics[v]+","+topicNames[v]%>"></td>
</div>
<% } %>

<script language="JavaScript">
function deleteSelectedTopic()
{
	var buttonList = document.topic_deletion_choice_form.elements['topicId'];
	var topicid_topicName;
	if (!buttonList.length)
		topicid_topicName = buttonList.value;
	else
	{
		for(var i=0; i<buttonList.length; i++)
		{
			if (buttonList[i].checked)
			{
				topicid_topicName = buttonList[i].value;
				break;
			}
		}
	}

	var strArr = topicid_topicName.split(",");
	var topicid = strArr[0];
	var topicName = strArr[1];

	var openerField = opener.document.<%= openerFormName%>.elements["<%= openerFormFieldName %>"];
	var openerField_Names = opener.document.<%= openerFormName%>.elements["<%= openerFormFieldName +"_Names"%>"];

	var topicIdIndex = openerField.value.indexOf(topicid);
	if (topicIdIndex >= 0 && topicIdIndex != openerField.value.length - topicid.length)
	{
		openerField.value = openerField.value.replace(topicid+",","");
	}
	else if (topicIdIndex != 0 && topicIdIndex == openerField.value.length - topicid.length)
	{
		openerField.value = openerField.value.replace(","+topicid,"");
	}
	else
	{
		openerField.value = openerField.value.replace(topicid,"");
	}

	var topicNameIndex = openerField_Names.value.indexOf(topicName);
	if (topicNameIndex >= 0 && topicNameIndex != openerField_Names.value.length - topicName.length)
	{
		openerField_Names.value = openerField_Names.value.replace(topicName+", ","");
	}
	else if (topicIdIndex != 0 && topicNameIndex == openerField_Names.value.length - topicName.length)
	{
		openerField_Names.value = openerField_Names.value.replace(", "+topicName,"");
	}
	else
	{
		openerField_Names.value = openerField_Names.value.replace(topicName,"");
	}

	self.close();
}
</script>

</fieldset>

<div class="button-holder">
<input type="button" onClick="deleteSelectedTopic();" value="<%= LanguageUtil.get(pageContext, "gn.button.delete") %>">
</div>

</form>

</body>
</html>