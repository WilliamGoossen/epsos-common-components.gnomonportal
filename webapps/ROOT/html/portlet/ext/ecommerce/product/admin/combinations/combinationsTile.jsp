<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<tiles:useAttribute id="readonly" name="readOnly" classname="java.lang.String" ignore="true"/>
<%
boolean readOnly = false;
if (readonly != null && readonly.equals("true")) readOnly = true;

List<Integer> instanceChosenValues = (List<Integer>)request.getAttribute("instanceChosenValues");
if (instanceChosenValues == null) instanceChosenValues = new java.util.ArrayList<Integer>();

List<ViewResult> allFeaturesAndValues = (List<ViewResult>)request.getAttribute("allFeaturesAndValues");
if (allFeaturesAndValues != null && allFeaturesAndValues.size() > 0) {
%>

<div class="inline-labels">
<% 
if (readOnly) {
	for (Integer chosen: instanceChosenValues) {
	%>
	<input type="hidden" name="featureChoice" value="<%= ""+chosen %>">
	<%
	}
}

Integer currentFeatureId = null;
for (int i=0; i<allFeaturesAndValues.size(); i++) { 
	ViewResult entry = allFeaturesAndValues.get(i);
	if (currentFeatureId == null || !currentFeatureId.equals(entry.getMainid()))
	{
		if (currentFeatureId != null) { %> 
			</select>
			<%if (entry.getField7() != null && ((Boolean)entry.getField7()).booleanValue()) { %>
			<em>*</em>
			<% } %>
			</div>  
		<% }	
		currentFeatureId = entry.getMainid();
		%>
		<div class="ctrl-holder">
		<label for="featureChoice"><%=  entry.getField1() %></label>
		<select name="featureChoice" <% if (readOnly) { out.print("disabled"); } %>>
		<%
	}
%>
	<option value="<%= entry.getField3().toString() %>"
	<% if (instanceChosenValues.contains(entry.getField3())) { out.print("selected"); } %>
	><%= entry.getField2() %></option>
	
	<% if ( i == allFeaturesAndValues.size()-1 ) { %>
		</select>
		<%if (entry.getField7() != null && ((Boolean)entry.getField7()).booleanValue()) { %>
		<em>*</em>
		<% } %>
		</div>
	<% } %> 
<% } %>
 
 </div>
 
<% } %>
