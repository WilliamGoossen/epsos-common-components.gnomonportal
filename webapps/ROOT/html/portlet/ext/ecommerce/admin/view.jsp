<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%String propertiesNamespace=GetterUtil.getString(prefs.getValue("propertiesNamespace", "eshop")); %>

<form action="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/ecommerce/admin/save"/>
		</portlet:actionURL>"  method="post" enctype="multipart/form-data" >
<table>		
	<%
				

				List headerNames = new ArrayList();

				headerNames.add("property");
				headerNames.add("value");

				

				Map portalProps = new TreeMap();

				portalProps.putAll(GnPropsUtil.getProperties(propertiesNamespace));

				List results = ListUtil.fromCollection(portalProps.entrySet());

				

				for (int i = 0; i < results.size(); i++) {
					Map.Entry entry = (Map.Entry)results.get(i);

					String property = (String)entry.getKey();
					String value = (String)entry.getValue();
					if(!property.equals("include-and-override")) {
	%>
			<tr><td><%=LanguageUtil.get(pageContext, property)%> : </td><td>
			<input name="<%=property%>" value="<%=value%>" type="text" size="50"></td></tr>
	<%
}
				}
				%>
			<tr><td>	
				<input type="hidden" name="submitted" value="1">
				<input type="submit" value="<%= LanguageUtil.get(pageContext, "save") %>">
				</td>
			</tr>
</table>
</form>

<%--
<br><br>

<a href="<portlet:renderURL>
		<portlet:param name="struts_action" value="/ext/ecommerce/admin/importalios"/>
	</portlet:renderURL>"> Import my clients </a>
--%>