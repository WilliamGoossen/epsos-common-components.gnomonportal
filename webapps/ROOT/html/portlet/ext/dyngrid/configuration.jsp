<%@ include file="/html/common/init.jsp" %>

<%
String title = (String)request.getAttribute("title");
String sqlquery =(String) request.getAttribute("sqlquery");
String categories = (String)request.getAttribute("categories");
String valuesstring = (String)request.getAttribute("valuesstring");
String seriesstring = (String)request.getAttribute("seriesstring");
String charttype = (String)request.getAttribute("charttype");
String width = (String)request.getAttribute("width");
String height = (String)request.getAttribute("height");


if(width.equals("")) width="400";
if(height.equals("")) height="400";

String showData = (String)request.getAttribute("showData");

String charttypes[]={"piechart","areaChart","horizontalBarChart3D","lineChart",
											"stackedHorizontalBar","stackedVerticalBar","stackedVerticalBar3D",
										"VerticalBarChart","verticalBar3D","stackedArea"};
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

<table class="liferay-table">
<tr>
	<td>
		<liferay-ui:message key="title" />
	</td>
	<td>
	<input type="text" name="title" value="<%=title %>" size="80">
	</td>
</tr>

<tr>
	<td>
		<liferay-ui:message key="sqlquery" />
	</td>
	<td>
	<textarea name="sqlquery" rows="6" cols="80"><%=sqlquery %></textarea>
	</td>
</tr>

<tr>

<td>
		<liferay-ui:message key="x-axis" />
	</td>
<td>
<input type="text"  size="80" name="categories" value="<%=categories%>">
	</td>
</tr>

<tr>
<td>
		<liferay-ui:message key="single-y-axis" />
	</td>
<td>

 <input type="text" size="80"  name="valuesstring" value="<%=valuesstring%>"> 
	</td>
</tr>

<tr>
<td>
		<liferay-ui:message key="multiple -y-axis" />
	</td>
<td>

 <input type="text" size="80"  name="seriesstring" value="<%=seriesstring%>"> 
	</td>
</tr>




<tr>
<td>
		<liferay-ui:message key="charttype" />
	</td>
<td>

 <select  name="charttype" >
 <%for(int i=0; i<charttypes.length;i++) {%>
 	
 	<option value="<%=charttypes[i]%>"  <%if(charttypes[i].equals(charttype)){%> selected <%}%>> <%=charttypes[i]%></option>
<%}%>
 
 </select>
	</td>
</tr>


<tr>
<td>
		<liferay-ui:message key="width" />
	</td>
<td>

 <input type="text" size="80"  name="width" value="<%=width%>"> 
	</td>
</tr>


<tr>
<td>
		<liferay-ui:message key="height" />
	</td>
<td>

 <input type="text" size="80"  name="height" value="<%=height%>"> 
	</td>
</tr>


<tr>
<td>
		<liferay-ui:message key="showData" />
	</td>
<td>

 <input type="radio"  name="showData" value="yes" <%if(showData.equals("yes")){%> checked <%}%>> <liferay-ui:message key="yes" />
<input type="radio"  name="showData" value="no" <%if(showData.equals("no")){%> checked <%}%>> <liferay-ui:message key="no" />
	</td>
</tr>


</table>

<br />

<input type="button" value="<liferay-ui:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);" />

</form>