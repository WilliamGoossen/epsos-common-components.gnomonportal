<%
String currentURL2 = currentURL;
String extraParams = "";
java.util.Enumeration params = request.getParameterNames();
while(params.hasMoreElements())
{
	String paramName = (String)params.nextElement();
	if (paramName.equals("struts_action") || paramName.startsWith("p_p_")) 
		continue;
	String paramValue = request.getParameter(paramName);
	if (Validator.isNull(paramValue)) paramValue= "";
	extraParams += "&"+paramName+"="+paramValue;
}

currentURL2 = currentURL +extraParams;
%>