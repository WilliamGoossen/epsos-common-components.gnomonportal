<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="com.liferay.portal.kernel.util.JavaConstants" %>

<%@ page import="com.ext.util.FieldsMetaData" %>
<%@ page import="com.ext.util.FieldsData" %>
<%@ page import="com.ext.portlet.cms.kms.MetaDataUtil" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<tiles:useAttribute id="curFormNameAttribute" name="formName" classname="java.lang.String" />
<tiles:useAttribute id="classNameAttribute" name="className" classname="java.lang.String" />
<tiles:useAttribute id="primaryKeyAttribute" name="primaryKey" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="organizationAttribute" name="organizationId" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="noTableAttribute" name="noTable" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="readOnlyAttribute" name="readOnly" classname="java.lang.String" ignore="true"/>


<%
String lang = request.getParameter("lang");
if (Validator.isNull(lang)) lang = GeneralUtils.getLocale(request);
Long companyId = PortalUtil.getCompanyId(request);
Integer organizationId = null;
try { organizationId = Integer.valueOf(organizationAttribute); } catch (Exception orgE) {}
FieldsMetaData mdata = MetaDataUtil.generateMetaData(companyId, organizationId, lang, classNameAttribute);
if (readOnlyAttribute != null && readOnlyAttribute.equals("true"))
	mdata.setAllFieldsReadOnly();
FieldsData fdata = MetaDataUtil.readMetaData(companyId, organizationId, classNameAttribute, primaryKeyAttribute, lang);
mdata.generateFormView(fdata, (PortletRequest)request.getAttribute(JavaConstants.JAVAX_PORTLET_REQUEST));

%>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_dynamic_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormNameAttribute %></tiles:put>
	<%if (noTableAttribute != null) { %>
	<tiles:put name="noTable"><%= noTableAttribute %></tiles:put>
	<% } %>
</tiles:insert>

