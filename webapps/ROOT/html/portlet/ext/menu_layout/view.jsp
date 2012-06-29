	<%
	String p_p_state=(String) request.getAttribute("p_p_state");
if (!p_p_state.equals("popup")) { %>

<table width="200" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td>
<%
String menutype=(request.getAttribute("menutype")==null? "-1": (String) request.getAttribute("menutype"));

if (menutype.equals("0")) { %>
<jsp:include page="/html/portlet/ext/menu_layout/view_webmenu.jsp" />
<% }
else if (menutype.equals("1")) { %>
<jsp:include page ="/html/portlet/ext/menu_layout/view_panelmenu.jsp" />
<% }
else if (menutype.equals("2")) { %>
<jsp:include page ="/html/portlet/ext/menu_layout/view_xpmenu.jsp" />
<% }
	else { %>
<jsp:include page ="/html/portlet/ext/menu_layout/view_webmenu.jsp" />
<% } %>

</td>
  </tr>
</table>
<% } %><br />
