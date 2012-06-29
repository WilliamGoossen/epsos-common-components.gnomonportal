<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<portlet:defineObjects />


<% if(instancePortletBrowseType.equals("topics")) {%>
<div class="ViewContentBrowser">
    <tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
        <tiles:put name="struts_action" value="/ext/yellowpages/list"/>
        <tiles:put name="contentClass" value="gnomon.hibernate.model.base.yellowpages.BsYellowPage"/>
        <tiles:put name="commandSpace" value="/html/portlet/ext/base/yellowpages/menu/list_menu.jsp"/>
    </tiles:insert>
</div>
<% } else if(instancePortletBrowseType.equals("metadata")) { %>

<% String searchItem = (String)request.getAttribute("searchItem");
   if (Validator.isNull(searchItem)) { searchItem = ""; } 
   List categories = (List)request.getAttribute("categories");
   List subcategories = (List)request.getAttribute("subcategories");
   String categoryid = (String)request.getAttribute("categoryid");
   if (categoryid == null) categoryid = request.getParameter("categoryid");
   if (categoryid == null) categoryid = "*";
   String subcategoryid = (String)request.getAttribute("subcategoryid");
   if (subcategoryid == null) subcategoryid = request.getParameter("subcategoryid");
   if (subcategoryid == null) subcategoryid = "*";
%>

<script language="JavaScript"  type="text/javascript">
var  preSelectedCategoryid = "<%= categoryid %>";
var  preSelectedSubCategoryid = "<%= subcategoryid %>";

function SubCategory(id, name, parentid, allParents)
{
	this.id = id;
	this.name = name;
	this.parentid = parentid;
	this.allParents = allParents;
}

var subCategories = new Array(
  <% for (int p=0; p<subcategories.size(); p++) { ViewResult pref = (ViewResult)subcategories.get(p); %>
  new SubCategory("<%= pref.getMainid().toString() %>", "<%= pref.getField1().toString() %>", "<%= pref.getField2().toString() %>", "<%= pref.getField3().toString() %>")
  <% if (p<subcategories.size()-1) { %> , <% } %>
  <% } %>
);

function chooseCategory(catId) {
	var listObj = document.BS_YELLOW_PAGES_SEARCH_FORM.elements["subcategoryid"];
	var oldOptions = listObj.options;
	while(oldOptions.length) { listObj.remove(0);}
	oldOptions.add(new Option("<%= LanguageUtil.get(pageContext, "all") %>", "*"));
	var i=0;
	var j=0;
	var selectedIndex = 0;
	for (i=0; i<subCategories.length; i++)
	{
		if (subCategories[i].allParents.indexOf(","+catId+",") >= 0)
		{
			j++;
			var optionToAdd = new Option(subCategories[i].name, subCategories[i].id);
			oldOptions.add(optionToAdd);
			if (subCategories[i].id == preSelectedSubCategoryid)
				selectedIndex = j;
		}
	}
	listObj.selectedIndex = selectedIndex;
	if (catId != "*")
		document.BS_YELLOW_PAGES_SEARCH_FORM.elements["topicid"].value = catId+"*";
	else
		document.BS_YELLOW_PAGES_SEARCH_FORM.elements["topicid"].value = "*";
}

function chooseSubCategory(catId) {
	if (catId != "*")
		document.BS_YELLOW_PAGES_SEARCH_FORM.elements["topicid"].value = catId;
}

</script>

<h3><%= LanguageUtil.get(pageContext, "gn.button.search") %></h3>
<form name="BS_YELLOW_PAGES_SEARCH_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/yellowpages/list"/></portlet:actionURL>" method="post" >
<input type="hidden" name="topicid" id="topicid" value="*">
<table>
<tr>
<td valign="top"><%= LanguageUtil.get(pageContext, "bs.yellowpages.search.category") %></td>
<td>&nbsp;</td>
<td valign="top">
<select name="<portlet:namespace />categoryid" id="categoryid" onChange="chooseCategory(this.options[this.selectedIndex].value);" >
<option name="all" value="*"><%= LanguageUtil.get(pageContext, "all") %></option>
<% for (int c=0; c<categories.size(); c++) { 
	ViewResult item = (ViewResult)categories.get(c); %>
	<option name="<%= item.getMainid().toString() %>" value="<%= item.getMainid().toString() %>"
		<% if (item.getMainid().toString().equals(categoryid)) { out.print("selected"); }  %>
	><%= item.getField1() %></option>
<% } %>
</select>
</td>
</tr>
<tr>
<td valign="top"><%= LanguageUtil.get(pageContext, "bs.yellowpages.search.subcategory") %></td>
<td>&nbsp;</td>
<td valign="top">
<select name="<portlet:namespace />subcategoryid" id="subcategoryid" onChange="chooseSubCategory(this.options[this.selectedIndex].value);" >
<option name="all" value="*"><%= LanguageUtil.get(pageContext, "all") %></option>
</select>
</td>
</tr>
<tr>
<td valign="top"><%= LanguageUtil.get(pageContext, "bs.yellowpages.search.keyword") %></td>
<td>&nbsp;</td>
<td valign="top">
<input type="text" name="<portlet:namespace />searchItem" value="<%= searchItem %>">
<br><%= LanguageUtil.get(pageContext, "bs.yellowpages.search.text") %></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td valign="top">
<input type="hidden" name="<portlet:namespace />loadaction" value="search" >
<input type="submit" value="<%= LanguageUtil.get(pageContext, "gn.button.search") %>"></td>
</tr>

</table>
</form>

<script language="JavaScript"  type="text/javascript">
chooseCategory(preSelectedCategoryid);
chooseSubCategory(preSelectedSubCategoryid);
</script>

<% } else  if(instancePortletBrowseType.equals("none")) { %>

<% } %>