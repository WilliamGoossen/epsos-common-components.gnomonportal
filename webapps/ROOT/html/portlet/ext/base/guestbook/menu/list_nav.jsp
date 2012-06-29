<%@ include file="/html/portlet/ext/base/guestbook/init.jsp" %>

<portlet:defineObjects />

<%
String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/guestbook/list"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.guestbook.BsGuestbook"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/guestbook/menu/list_menu.jsp"/>
</tiles:insert>


<%--
<table width="100%" border="0">
  <tr>
    <th colspan="3" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="50">
		<tiles:insert page="/html/portlet/ext/includes/date_search.jsp" flush="true">
		<tiles:put name="struts_action" value="/ext/guestbook/list"/>
		<tiles:put name="contentClass" value="gnomon.hibernate.model.base.guestbook.BsGuestbook"/>
		</tiles:insert>
	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
</table>
--%>