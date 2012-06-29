<%@ include file="/html/common/init.jsp" %>

<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="type" name="type" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="vtopicid" name="vtopicid" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="start_topic1" name="start_topic1" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="p_p_text" name="p_p_text" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="month" name="month" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="year" name="year" classname="java.lang.String" ignore="true"/>



<%
Enumeration e = request.getParameterNames();
for (; e.hasMoreElements();) {
	String name = (String)e.nextElement();
	String value = request.getParameter(name);
	System.out.println("name : "+name+"\tvalue : "+value);
}
%>

<form enctype="multipart/form-data" action="
<portlet:actionURL>
<portlet:param name="struts_action" value="<%=struts_action%>" />
<portlet:param name="type" value="<%=type %>"/>
<portlet:param name="vtopicid" value="<%=vtopicid %>"/>
<portlet:param name="start_topic" value="<%=start_topic1 %>"/>
<portlet:param name="p_p_text" value="<%=p_p_text %>"/>
<%
Enumeration en = request.getParameterNames();
for (; en.hasMoreElements();) {
	String name = (String)en.nextElement();
	String value = request.getParameter(name); %>
<portlet:param name="<%=name%>" value="<%=value%>"/>
<%}%>
</portlet:actionURL>" method="post" name="<portlet:namespace />fm">

<fieldset>
	<legend><%= LanguageUtil.get(pageContext, "search") %></legend>
	<table width="100%" border="0" cellpadding="0" cellspacing="1">
	<tr valign="top">
		<td colspan="3">
			<div align="left"><%= LanguageUtil.get(pageContext, "keyword_search") %></div>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="2">
			<div align="left">
				<input name="textSearch" class="gamma1-FormArea" value="" size="24">
			</div>
	    </td>
		<td>
			<input type="image" src="/html/themes/portlet/gnomon_theme/img/search_icon.gif" alt="<%= LanguageUtil.get(pageContext, "search") %>" border="0">
		</td>
	</tr>
	<tr>
	    <td valign="top">
	    	<div align="center">
	    		<select class="gamma1-FormArea"  name="month">
					<option value="-"><%= LanguageUtil.get(pageContext, "all_months") %></option>
					<%
					String monthText="";
					for (int mIndex=0; mIndex<12; mIndex++) {
						monthText = monthText.valueOf(mIndex+1);
						if ( monthText.equals(month)) { %>
							<option selected  value="<%=mIndex+1%>" ><%= LanguageUtil.get(pageContext, "month"+(mIndex+1)) %></option>
						<% } else {%>
							<option value="<%=mIndex+1%>"><%= LanguageUtil.get(pageContext, "month"+(mIndex+1)) %></option>
						<% }
						}%>
				</select>
			</div>
		</td>
		<td valign="top">
			<div align="center">
				<select class="gamma1-FormArea"  name="year">
					<option value="-"><%= LanguageUtil.get(pageContext, "all_years") %></option>
					<%
					String[] years= (String[])request.getAttribute("years");
					if(years!=null && years.length >0 ) {
						for (int y1=0; y1<years.length; y1++) {
							if ( years[y1].equals(year)) { %>
								<option selected value="<%=years[y1]%>"><%=years[y1]%></option>
							<% } else {%>
								<option value="<%=years[y1]%>"><%=years[y1]%></option>
							<% }
						}
					}%>
				</select>
				&nbsp;

			</div>
		</td>
		<td valign="top">
			<input type="image" src="/html/themes/portlet/gnomon_theme/img/search_icon.gif" alt="<%= LanguageUtil.get(pageContext, "search") %>" border="0">
		</td>
	</tr>
</table>
</form>
</fieldset>

<br/>