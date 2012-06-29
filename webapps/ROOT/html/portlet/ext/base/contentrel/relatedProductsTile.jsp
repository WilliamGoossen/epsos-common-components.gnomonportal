<%@ include file="/html/portlet/ext/base/contentrel/init.jsp" %>

<%@ page import="com.ext.portlet.base.search.GnSearchResultRow" %>
<%@ page import="com.ext.portlet.base.contentrel.ContentRelUtil" %>
<%@ page import="com.ext.portlet.cms.generic.lucene.LuceneUtilities" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="java.util.Vector" %>

<tiles:useAttribute id="rel_className" name="className" classname="java.lang.String"/>
<tiles:useAttribute id="rel_primaryKey" name="primaryKey" classname="java.lang.String"/>
<tiles:useAttribute id="rel_style" name="style" classname="java.lang.String" ignore="true"/>

<%

List<String> classNamesList1 = Arrays.asList(classNames);
ArrayList<String> classNamesList = new ArrayList<String>();
classNamesList.addAll(classNamesList1);
classNamesList.add(ContentRelUtil.JOURNAL_CLASSNAME);
classNames = classNamesList.toArray(new String[0]);

 String filePath = GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH); 
 String instanceProductListType=GetterUtil.getString(prefs.getValue("productListType", StringPool.BLANK));	

//	PortletConfigImpl portletConfig = (PortletConfigImpl)request.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);


String myportletName =((PortletConfigImpl)portletConfig).getPortletId();

// make certain our className is one of the content rel allowed classnames, otherwise do nothing

if (classNamesList.contains(rel_className)) {
	
	// reorder classNames based on configuration orderIndices if present
	Vector<String> orderVector = new Vector<String>();
	orderVector.setSize(classNames.length);
	for (String pClassName: classNames) {
		String orderIndex = prefs.getValue("showRelContentOrderIndex_"+pClassName, StringPool.BLANK);
		int order = -1;
		try { order = Integer.parseInt(orderIndex); 
		} catch (Exception numE) {}
		if (order >=0 && order<orderVector.size()) 
		{
			if (orderVector.get(order) == null)
				orderVector.remove(order);
			orderVector.add(order, pClassName);
		}
		else
		{
			orderVector.add(pClassName);
		}
	}
	int arrayIndex = 0;
	for (int v=0; v<orderVector.size(); v++) 
	{
		String orderedName = orderVector.get(v);
		if (Validator.isNotNull(orderedName))
		{
			classNames[arrayIndex] = orderedName;
			arrayIndex++;
		}
	}

%>

<script language="JavaScript" src="/html/js/editor/modalwindow.js" type="text/javascript"></script><noscript></noscript>


<div style="<%= rel_style %>">

<!--  here list all related content items -->

<form name="BS_RELATED_CONTENT_LISTS_FORM" action="<liferay-portlet:actionURL portletName="bs_content_rels" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/contentrel/deleteRelatedItems"/></liferay-portlet:actionURL>" method="post">
<input type="hidden" name="rel_className" value="<%= rel_className %>">
<input type="hidden" name="rel_primaryKey" value="<%= rel_primaryKey %>">
<input type="hidden" name="redirect" value="<%= currentURL %>">
<%
String lang = GeneralUtils.getLocale(request);
boolean foundAtLeastOneItem = false;
boolean usedHeader = false;
List results=null;
for (String className: classNames) {
	 results=null;
	
	if (Validator.isNull(instancePortletShowRelContent) || 
			instancePortletShowRelContent.indexOf(className) != -1) 
	{
		boolean isProduct = className.equals(gnomon.hibernate.model.ecommerce.product.PrProduct.class.getName());
		if (isProduct) {
			results = LuceneUtilities.searchForRelatedContent(request, lang, "*", new String[]{className}, rel_className, rel_primaryKey);
		}
		if (results != null && results.size() > 0) {
			foundAtLeastOneItem = true;
			String relatedPortletName = relUtil.getPortletNameForClassName(className);
			String resultIds="";
			
			for(int i=0; i<results.size();i++) {
				GnSearchResultRow prItem = (GnSearchResultRow) results.get(i);
				if(i>0)
					resultIds+=",";
					resultIds+=prItem.getId();
			}
			
			
			List products = com.ext.portlet.ecommerce.product.service.ProductBrowserService.getInstance().listProductsWithCriteria(resultIds, lang, PortalUtil.getCompanyId(request));
			
			
				
			request.setAttribute("products", products);
			if (!usedHeader) {
				usedHeader = true;
				%>
				<h3><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_content_rels") %></h3>
				
				<%
			} %>
		
		
		<tiles:insert page="/html/portlet/ext/ecommerce/product/browser/featuredList.jsp" flush="true">
	<tiles:put name="filePath" value="<%=filePath%>"/>
	<tiles:put name="myportletName" value="<%=myportletName%>"/>
</tiles:insert>
		
		<%}
		
	}
}
%>




<% if (hasAdd) { %>
<a href="javascript:openDialog('<liferay-portlet:actionURL portletName="bs_content_rels" windowState="pop_up">
		<liferay-portlet:param name="struts_action" value="/ext/contentrel/search"/>
		<liferay-portlet:param name="rel_className" value="<%= rel_className %>"/>
		<liferay-portlet:param name="rel_primaryKey" value="<%= rel_primaryKey %>"/>
		</liferay-portlet:actionURL>', 650, 450);">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/links.png" alt="link icon">		
<%= LanguageUtil.get(pageContext, "bs.related.content.add") %> ...
</a>	
<% } %>	

</div>

<% } %>