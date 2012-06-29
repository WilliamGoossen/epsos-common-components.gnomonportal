<%@ include file="/html/portlet/init.jsp" %>

<%//@ taglib uri="http://java.sun.com/portlet" prefix="portlet" %>
<%//@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%//@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%//@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%//@ taglib uri="/WEB-INF/tld/struts-nested.tld" prefix="nested" %>
<%//@ taglib uri="/WEB-INF/tld/struts-template.tld" prefix="template" %>
<%//@ taglib uri="/WEB-INF/tld/struts-tiles.tld" prefix="tiles" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Hashtable" %>

<%@ page import="gnomon.business.StringUtils" %>
<%@ page import="gnomon.business.FileUtils" %>


<%@ page import="com.liferay.portal.model.Layout" %>
<%@ page import="com.liferay.portlet.PortletURLImpl" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="javax.portlet.WindowState" %>
<%@ page import="javax.portlet.PortletMode" %>
<%@ page import="Coalesys.WebMenu.*" %>
<%@ page import="Coalesys.WebMenu.Group" %>
<%@ page import="Coalesys.PanelBar.*" %>

<%//thisPortletId="MENU_LAYOUT";%>
<portlet:defineObjects />