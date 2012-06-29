<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<h3><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.lines.list") %></h3>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

          
<% 
String patID = request.getParameter("patID");
String docID = request.getParameter("docID");

List<ViewResult> prescriptionLines = (List<ViewResult>)request.getAttribute("prescriptionLines");

//line.setField1(name);
//line.setField2(ingredient);
//line.setField3(strength);
//line.setField4(packsString);
//line.setField5(doseString);
//line.setField6(freqString);
//line.setField7(routeString);
//line.setField8(nrOfPacks);
//line.setField9(lowString);
//line.setField10(highString);
//line.setField11(patientString);
//line.setField12(fillerString);
//line.setField13(prescriber);
//line.setField14(prescriptionID);
//line.setField15(performer);
//line.setField16(profession);
//line.setField17(facility);
//line.setField18(address);
//line.setField19(materialID);
//line.setField20(substitutionPermitted);

%>
<script language="JavaScript">
function toggleDispensationRow(checkbox)
{
	Liferay.Util.toggle('dispensed_'+checkbox.value);
}


function toggleSubstituteFields(id)
{
	Liferay.Util.toggle('name_'+id);
	//Liferay.Util.toggle('ingredient_'+id);
	//Liferay.Util.toggle('strength_'+id);
	//Liferay.Util.toggle('packaging1_'+id);
	//Liferay.Util.toggle('packaging2_'+id);
	Liferay.Util.toggle('packaging3_'+id);
}
</script>


<form name="DISPENSE_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/epsos/demo/dispensePrescriptionLines"/></portlet:actionURL>" method="post" class="uni-form">
<input type="hidden" name="patID" value="<%= patID %>">
<input type="hidden" name="country" value="<%= request.getParameter("country") %>">
<input type="hidden" name="patIDType" value="<%= request.getParameter("patIDType") %>">
<input type="hidden" name="docID" value="<%= docID %>">
<input type="hidden" name="redirect" value="<%= redirect %>">

<html:errors/>

<fieldset class="inline-labels">
<table class="liferay-table" style="width: 100%">
             
<tr>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.id") %> </th> 
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.prescriber") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.name") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.ingredient") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.strength") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.package") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.nrOfPacks") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.dosage") %> / 
<%= LanguageUtil.get(pageContext, "epsos.demo.prescription.frequency") %> / 
<%= LanguageUtil.get(pageContext, "epsos.demo.prescription.route") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.instruction.patient") %> / <%= LanguageUtil.get(pageContext, "epsos.demo.prescription.instruction.filler") %></th>
<th><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.start") %> / <%= LanguageUtil.get(pageContext, "epsos.demo.prescription.end") %> </th>
<th></th>
</tr>

<%if (prescriptionLines != null) {
	for (ViewResult line: prescriptionLines) { 

String packsString = (String)line.getField4();
String[] packs1 = null;
if (packsString != null)
{
 packs1 = packsString.split("#");
}
String[] packs = new String[] {"N/A", "N/A", "N/A"}; 
if (packs1 != null)
{
	int p = 0;
	for (String p1: packs1)
	{
		if (p<3)
			packs[p] = p1;
		p++;
	}
}
 
%>

<tr id="prescribed_<%= line.getMainid().toString() %>">
<td>
<%//= line.getField14() + "&nbsp;/&nbsp;" + line.getField19()+""%>
<%= line.getField19()+""%>
</td>
<td>
<%= line.getField13() %>
</td>
<td>
<%= line.getField1() %>
</td>
<td>
<%= line.getField2() %>
</td>
<td>
<%= line.getField3() %>
</td>
<td>
<%= packs != null? packs[0] + " (" + packs[1]+" x "+ packs[2]+")" : line.getField4() %>
</td>
<td>
<%= line.getField8() %>
</td>
<td>
<%= line.getField5() %> /
<%= line.getField6() %> /
<%= line.getField7() %>
</td>
<td>
<%= line.getField11() %> /
<%= line.getField12() %> 
</td>
<td>
<%= line.getField9() %> /
<%= line.getField10() %>
</td>

<% if (com.ext.portlet.epsos.EpsosHelperService.getInstance().hasCurrentUserPharmacistRole(request) || true) { %>
<td>
<input type="checkbox" name="dispense" value="<%= line.getMainid().toString() %>" 
    onChange="toggleDispensationRow(this);" title="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation") %>">
</td>
<% } %>
</tr>

<tr id="dispensed_<%= line.getMainid().toString() %>" style="background-color:#e0e1e1; display:none;">

<td valign="top">
<input type="text" name="dispensationid_<%= line.getMainid().toString() %>" size= "4" title="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.id") %>" value="<%= line.getField19().toString() %>">
</td>

<td valign="top">
<% if (line.getField20() != null && ((Boolean)line.getField20()).booleanValue()) { %>
<input type="checkbox" name="substitute_<%= line.getMainid().toString() %>" value="true" title="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.substitute") %>" onChange="toggleSubstituteFields('<%= line.getMainid().toString() %>');">
<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.substitute") %>
<% } else { %>
<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.substitute-not-permitted") %>
<% } %>
</td>

<td valign="top">
<% if (line.getField20() == null || !((Boolean)line.getField20()).booleanValue()) { %>
<input type="hidden" name="name_<%= line.getMainid().toString() %>" value="<%= line.getField1() %>">
<%= line.getField1() %>
<% } else { %>
<input type="text" id="name_<%= line.getMainid().toString() %>" size="8" style="display:none" name="name_<%= line.getMainid().toString() %>" title="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.name") %>" value="<%= line.getField1() %>">
<% } %>
</td>

<td valign="top">
<%= line.getField2() %>
<input type="hidden" name="ingredient_<%= line.getMainid().toString() %>" value="<%= line.getField2() %>">
</td>

<td valign="top">
<%= line.getField3() %>
<input type="hidden" name="strength_<%= line.getMainid().toString() %>" value="<%= line.getField3() %>">
</td>

<td valign="top">
<% if (line.getField20() == null || !((Boolean)line.getField20()).booleanValue()) { %>
<input type="hidden" name="packaging1_<%= line.getMainid().toString() %>" value="<%= packs != null ? packs[0] : "" %>">
<input type="hidden" name="packaging2_<%= line.getMainid().toString() %>" value="<%= packs != null ? packs[1] : "" %>">
<input type="hidden" name="packaging3_<%= line.getMainid().toString() %>" value="<%= packs != null ? packs[2] : "" %>">

<%= packs != null ? packs[0] : "" %><br><%= packs != null ? packs[1] : "" %><br><%= packs != null ? packs[2] : "" %>

<% } else { %>
<%= packs != null ? packs[0] : "" %><br>
<%= packs != null ? packs[1] : "" %><br>
<input type="hidden" name="packaging1_<%= line.getMainid().toString() %>" value="<%= packs != null ? packs[0] : "" %>">
<input type="hidden" name="packaging2_<%= line.getMainid().toString() %>" value="<%= packs != null ? packs[1] : "" %>">
<input type="text" id="packaging3_<%= line.getMainid().toString() %>" style="display:none" name="packaging3_<%= line.getMainid().toString() %>" size= "4" title="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.packaging") %>" value="<%= packs != null ? packs[2] : "" %>">
<% } %>
</td>

<td valign="top">
<input type="text" name="nrOfPacks_<%= line.getMainid().toString() %>" size= "4" title="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation.nrOfPacks") %>" value="<%= line.getField8() %>">
</td>

<td valign="top">
</td>

<td valign="top">
</td>

<td valign="top">
</td>

<td valign="top">
</td>

</tr>

<% }
}%>
   
</table>

</fieldset>

<% if (com.ext.portlet.epsos.EpsosHelperService.getInstance().hasCurrentUserPharmacistRole(request) || true) { %> 
<div id="button_holder_div" class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "epsos.demo.dispensation") %>">
</div>
<% } %>
</form>


<br>



<% List<ViewResult> dispensedLines = (List<ViewResult>) request.getAttribute("dispensedLines");
   if (dispensedLines != null && dispensedLines.size() > 0) { %>
<fieldset><legend><%= LanguageUtil.get(pageContext, "epsos.demo.dispensation") %></legend>

<display:table id="dline" name="dispensedLines" requestURI="//ext/epsos/demo/viewPrescriptionLines?actionURL=true" sort="list" style="width: 100%;">
<display:setProperty name="export.excel" value="true" />
<display:setProperty name="export.excel.filename" value="DispensedLines.xls" />
<display:setProperty name="export.pdf" value="true" />
<display:setProperty name="export.pdf.filename" value="DispensedLines.pdf" />
<display:setProperty name="export.csv" value="true" />
<display:setProperty name="export.csv.filename" value="DispensedLines.csv" />
<display:setProperty name="export.xml" value="true" />
<display:setProperty name="export.xml.filename" value="DispensedLines.xml" />

<% ViewResult d_line = (ViewResult)dline; %>

<display:column property="field1" titleKey="epsos.demo.dispensation.id" sortable="true"/>
<display:column titleKey="epsos.demo.dispensation.name" sortable="true">
<%= d_line.getField2() + (d_line.getField3() != null && ((Boolean)d_line.getField3()).booleanValue() ? "("+LanguageUtil.get(pageContext, "epsos.demo.dispensation.substitute")+")" : "") %>
</display:column>
<display:column property="field11" titleKey="epsos.demo.prescription.ingredient" sortable="true"/>
<display:column property="field4" titleKey="epsos.demo.dispensation.strength" sortable="true"/>
<display:column property="field5" titleKey="epsos.demo.dispensation.packaging-form" sortable="true"/>
<display:column property="field6" titleKey="epsos.demo.dispensation.packaging-pack" sortable="true"/>
<display:column property="field7" titleKey="epsos.demo.dispensation.packaging-quantity" sortable="true"/>
<display:column property="field8" titleKey="epsos.demo.dispensation.nrOfPacks" sortable="true"/>

</display:table>

</fieldset>
   
<% } %>

<br>

<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back"><%= LanguageUtil.get(pageContext, "back") %></a>


