<%@ include file="/html/common/init.jsp" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<%

TitleData titleData = null;
if (tileAttribute != null)
	titleData = (TitleData)request.getAttribute(tileAttribute);
else
	titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE);

if (titleData != null)
{
	%>
	<table width="100%" class="bglines">
	<%
	for (int i=0; i<titleData.displaySize(); i++)
	{
	    %>
            <tr>
			<td class="title_left" ><%= LanguageUtil.get(pageContext, titleData.getDisplayKey(i).toString()) %> : </td>
			<td class="title_right" >
			<% if (titleData.getDisplayValue(i) != null &&  titleData.getDisplayValue(i) instanceof String)
				out.print(LanguageUtil.get(pageContext, titleData.getDisplayValue(i).toString()));
			else
	            out.print(titleData.getDisplayValue(i).toString());
            %>
            </td></tr>
            <%
	}
	%>
	</table>
	<%
}
%>