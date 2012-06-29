<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
    <tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_BULKIMPORT %></tiles:put>
</tiles:insert>

<%
List fieldNamesList = (List)session.getAttribute("fieldNamesList"); //List<String>
List<ViewResult> excelViewResults = (List<ViewResult>)session.getAttribute("excelViewResults"); //List<ViewResult>
request.setAttribute("excelViewResults", excelViewResults);
%>

<portlet:actionURL var="bulkImportURL">
    <portlet:param name="struts_action" value="/ext/products/admin/bulkImport"/>
    <portlet:param name="type" value="products"/>
</portlet:actionURL>

<script type="text/javascript">
    function <portlet:namespace />preview() {
        document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "preview";
        submitForm(document.<portlet:namespace />fm);
    }
    function <portlet:namespace />commit() {
        document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "commit";
        submitForm(document.<portlet:namespace />fm);
    }
    function <portlet:namespace />back() {
        document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "";
        submitForm(document.<portlet:namespace />fm);
    }
</script>

<form class="uni-form" action="<%=bulkImportURL%>" method="post" name="<portlet:namespace />fm" enctype="multipart/form-data">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="" type="hidden" />
<%--<input type="hidden" name="<portlet:namespace/>redirect" id="<portlet:namespace/>redirect" value="<%=viewProductsURL %>"/>--%>
<div class="block-labels">

	<div class="ctrl-holder">
	    <label for="<portlet:namespace/>fileContent"><liferay-ui:message key="file" /></label>
	    <input name="<portlet:namespace/>fileContent" id="<portlet:namespace/>fileContent" size="50" type="file" class="liferay-input-text" />
	    
        <div class="buttonHolder1" style="float:right;">
	    <input type="button" class="primaryAction" value="<liferay-ui:message key="preview" />" onClick="<portlet:namespace />preview();"/>
        </div>
	</div>

</div>

<c:choose>
<c:when test="<%=excelViewResults!=null && excelViewResults.size()>0%>">

	<link rel="stylesheet" type="text/css" media="screen" href="<%=themeDisplay.getPathThemeRoot() %>/jqgrid/redmond/jquery-ui-1.7.1.custom.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=themeDisplay.getPathThemeRoot() %>/jqgrid/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=themeDisplay.getPathThemeRoot() %>/jqgrid/ui.multiselect.css" />
	
	<script src="/html/js/jqgrid/i18n/grid.locale-el.js" type="text/javascript"></script>
	<script src="/html/js/jqgrid/jquery.jqGrid.min.js" type="text/javascript"></script>
	
	<table id="<portlet:namespace />previewGrid"></table> 
	<script type="text/javascript">

	jQuery("#<portlet:namespace />previewGrid").jqGrid({
		shrinkToFit: false,
	    datatype: "local",
	    width: 700,
	    height: 240,
	    colNames:[
            <%for (int i=0; fieldNamesList!=null && i<fieldNamesList.size(); i++) {
                String fieldName = (String)fieldNamesList.get(i);
            %>
            '<%=LanguageUtil.get(pageContext, fieldName)%>'<%=(i==fieldNamesList.size()-1? "": ",")%>
            <%}%>
	      	],
	    colModel:[
	      	<%for (int i=0; fieldNamesList!=null && i<fieldNamesList.size(); i++) {
	      		String fieldName = (String)fieldNamesList.get(i);
	      	%>
	      	{name:'<%=LanguageUtil.get(pageContext, fieldName)%>',index:'<%=LanguageUtil.get(pageContext, fieldName)%>', width:60, align:"right", sortable:false}<%=(i==fieldNamesList.size()-1? "": ",")%>
	      	<%}%>    
	    ],
	    caption: '<%=LanguageUtil.get(pageContext, "preview")%>'
	});
	var mydata = [
			<%for (int j=0; excelViewResults!=null && j<excelViewResults.size() && j<10; j++) {
				ViewResult view = excelViewResults.get(j);
			%>
			{
			<%	for (int i=0; fieldNamesList!=null && i<fieldNamesList.size(); i++) {
	                String fieldName = (String)fieldNamesList.get(i); 
	                String value = gnomon.business.ViewResultUtil.getString(view, "field" + (i+1));
	                %>

	                "<%=LanguageUtil.get(pageContext, fieldName)%>":"<%=value%>"<%=(i==fieldNamesList.size()-1? "": ",")%>

	        <%}%>
			}
			<%=(j==excelViewResults.size()-1? "": ",")%>
			<%}%>
	        ];
	for(var i=0;i<=mydata.length;i++)
	    jQuery("#<portlet:namespace />previewGrid").jqGrid('addRowData',i+1,mydata[i]);
	</script>
	
	

	<div class="block-labels">
	
	    <div class="buttonHolder1">
	        <%--<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />back();"/>--%>
	        <input type="button" class="primaryAction" value="<liferay-ui:message key="import" />" onClick="<portlet:namespace />commit();"/>
	    </div>
	
	</div>
</c:when>
<c:otherwise>
    <img align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/xls.gif"%>"/>
    <a target="_blank" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
                    <portlet:param name="struts_action" value="/ext/products/admin/get_bulk_template"/>
                    <portlet:param name="type" value="products"/>
                    </portlet:actionURL>"><%= LanguageUtil.get(pageContext, "download-bulk-import-products-template") %></a>
    
</c:otherwise>
</c:choose>
</form>