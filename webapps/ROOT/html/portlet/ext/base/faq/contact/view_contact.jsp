<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="gnomon.business.StringUtils" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
BsFaqContact contactDetails = (BsFaqContact)request.getAttribute("contactDetails");
%>

<c:if test="<%=(contactDetails!=null)%>">
<br/>
<table width="100%" class="bglines">
	<tr>
		<td>
			<b>
			<%= StringUtils.check_null(contactDetails.getContactTitle(),"") %>
			</b>
			<br/>
		</td>
	</tr>
	<tr>
		<td>
			<%= StringUtils.check_null(contactDetails.getContactDescription(),"") %>
		</td>
	</tr>
	
	<c:if test="<%=((contactDetails.getReplied()!=null) && contactDetails.getReplied()==true)%>">
	<tr>
		<td>
			<%= (contactDetails.getReplyDate()==null? "" : contactDetails.getReplyDate().toString()) %>
			&nbsp;(
			<%= StringUtils.check_null(contactDetails.getRepliedVia(),"") %>
			)
		</td>
	</tr>
	</c:if>
		
</table>


<br/>
<form name="BsFaqContactForm" action="/ext/faq/loadContact" method="post">

<c:choose>
	<c:when test="<%=(contactDetails.getReplied()==null) || (!contactDetails.getReplied())%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
			<tiles:put name="action"  value="/ext/faq/loadContactReply" />
			<tiles:put name="buttonName" value="replyButton" />
			<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "bs.faq.contact.link.reply") %>" />
			<tiles:put name="formName"   value="BsFaqContactForm" />
			<tiles:putList name="actionParamList">
			  	<tiles:add value="loadaction"/>
			  	<tiles:add value="mainid"/>
			  	<tiles:add value="redirect"/>
			</tiles:putList>
		  	<tiles:putList name="actionParamValueList">
			  	<tiles:add value="edit"/>
			  	<tiles:add><%=contactDetails.getMainid().toString()%></tiles:add>
			  	<tiles:add><%=currentURL%></tiles:add>
		  	</tiles:putList>
				<%--tiles:put name="actionParam" value="loadaction"/>
			<tiles:put name="actionParamValue" value="add"/--%>
			<tiles:put name="actionPermission" value="reply"/>
			<tiles:put name="portletId" value="<%=portletID%>"/>
		</tiles:insert>
	</c:when>
	<c:otherwise>
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
			<tiles:put name="action"  value="/ext/faq/load" />
			<tiles:put name="buttonName" value="addButton" />
			<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "bs.faq.contact.link.add-to-faq") %>" />
			<tiles:put name="formName"   value="BsFaqContactForm" />
			<tiles:putList name="actionParamList">
			  	<tiles:add value="loadaction"/>
			  	<tiles:add value="contactid"/>
			  	<tiles:add value="redirect"/>
			</tiles:putList>
		  	<tiles:putList name="actionParamValueList">
			  	<tiles:add value="add"/>
			  	<tiles:add><%=contactDetails.getMainid().toString()%></tiles:add>
			  	<tiles:add><%=currentURL%></tiles:add>
		  	</tiles:putList>
				<%--tiles:put name="actionParam" value="loadaction"/>
			<tiles:put name="actionParamValue" value="add"/--%>
			<tiles:put name="actionPermission" value="add"/>
			<tiles:put name="portletId" value="<%=portletID%>"/>
		</tiles:insert>
	</c:otherwise>
</c:choose>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/faq/loadContact" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsFaqContactForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="edit"/>
	  	<tiles:add><%=contactDetails.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="edit"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/faq/loadContact" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsFaqContactForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="delete"/>
	  	<tiles:add><%=contactDetails.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="delete"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

</form>
</c:if>

<br/>
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<a <%=Validator.isNull(redirect)? "onClick=\"history.go(-1);\"":"href=\"" + redirect + "\"" %>> 
		<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="middle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
		</a>
	</td>
</tr>
</table>