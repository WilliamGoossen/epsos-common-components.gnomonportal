<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.parties.PaCountry" %>
<%@ page import="gnomon.business.GeneralUtils" %>


<% String filePath = GetterUtil.getString(PropsUtil.get("base.yellowpages.store"), CommonDefs.DEFAULT_STORE_PATH); %>
<% ViewResult view = (ViewResult) request.getAttribute("yellowpageItem"); %>
<%-- edw tha mpei to view tou new --%>
<%-- 
  		 String[] fields = new String[] {"table1.published",1
					   "table1.publishDateStart",			2
					   "table1.entryDate",					3
					   "langs.title",						4
					   "langs.description",					5
					   "langs.image",						6
					   "langs.address",						7
						"langs.phone",						8
						"langs.fax",						9
						"langs.email",						10
						"langs.url",						11
						"langs.address2",					12
						"langs.phone2",						13
						"langs.fax2",						14
						"langs.email2",						15
						"langs.url2",						16
						"langs.responsible",				17
						"langs.responsibleRole",			18	
						"langs.interestedIn",				19
						"table1.paCountry.mainid"			20
--%>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>
<table>

<% if (Validator.isNotNull(view.getField6())) { %>
<tr>
<td colspan="2">
<a href="javascript:openDialog('<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + view.getField6() %>', '500', '400');">
<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)view.getField6())%>" alt="<%= view.getField4().toString() %>" align="left" />
</a>
&nbsp;&nbsp;
</td>
</tr>
<% } %>

<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.title")%></strong>
</td>
<td>
<%= (Validator.isNotNull(view.getField4()) ? view.getField4().toString() : "") %>
</td>
</tr>

<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.productsServices")%></strong>
</td>
<td>
<%= (Validator.isNotNull(view.getField5())? view.getField5().toString() : "") %>
</td>
</tr>
<%-- 
<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.interestedIn")%></strong>
</td>
<td>
<%= (Validator.isNotNull(view.getField19())? view.getField19().toString() : "") %>
</td>
</tr>
--%>

<% if (Validator.isNotNull(view.getField17())) { %>
<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.responsible")%></strong>
</td>
<td>
<%= (Validator.isNotNull(view.getField18())? view.getField18().toString()+" : " : "") %>
<%= view.getField17().toString() %>
</td>
</tr>
<% } %>

<% if (Validator.isNotNull(view.getField19())) { %>
<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.interestedIn")%></strong>
</td>
<td>
<%= view.getField19().toString() %>
</td>
</tr>
<% } %>

<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.contact")%></strong>
</td>
<td>
<%= (Validator.isNotNull(view.getField7()) ? view.getField7().toString() : "") %>
<% if (Validator.isNotNull(view.getField20())) { 
	ViewResult countryView = GnPersistenceService.getInstance(null).getObjectWithLanguage(PaCountry.class, (Integer)view.getField20(), GeneralUtils.getLocale(request), new String[]{"langs.name"});
	if (countryView != null)
		out.print(", "+countryView.getField1());
%>
<% }  %>
<%= (Validator.isNotNull(view.getField8()) ? ", "+view.getField8().toString() : "") %>
<%= (Validator.isNotNull(view.getField9()) ? ", Fax:"+view.getField9().toString() : "") %>
<%= (Validator.isNotNull(view.getField10()) ? ", "+view.getField10().toString() : "") %>
<%= (Validator.isNotNull(view.getField11()) ? ", <a target=\"_new\" href=\"http://"+view.getField11().toString()+"\">"+view.getField11().toString()+"</a>" : "") %>

</td>
</tr>

<% if (Validator.isNotNull(view.getField12())) { %>
<tr>
<td>
<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.contact2")%></strong>
</td>
<td>
<%= (Validator.isNotNull(view.getField12()) ? view.getField12().toString() : "") %>
<%= (Validator.isNotNull(view.getField13()) ? ", "+view.getField13().toString() : "") %>
<%= (Validator.isNotNull(view.getField14()) ? ", Fax:"+view.getField14().toString() : "") %>
<%= (Validator.isNotNull(view.getField15()) ? ", "+view.getField15().toString() : "") %>
<%= (Validator.isNotNull(view.getField16()) ? ", <a target=\"_new\" href=\"http://"+view.getField16().toString()+"\">"+view.getField16().toString()+"</a>" : "") %>
</td>
</tr>
<% } %>
</table>
