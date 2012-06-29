<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.events.BsEvent" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="gnomon.hibernate.model.base.events.EvTicketType" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="org.apache.struts.Globals" %>
<%@ page import="org.apache.struts.action.ActionErrors" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ext.portlet.base.events.wizard.WizardService" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
//ActionErrors errors  = (ActionErrors)session.getAttribute("BS_EVENT_WIZARD_ERROR");
ActionErrors errors = (ActionErrors)request.getAttribute(Globals.ERROR_KEY);
if (errors != null && errors.size() > 0) {
	//session.setAttribute("BS_EVENT_WIZARD_ERROR", new ActionErrors());
	//request.setAttribute(Globals.ERROR_KEY, errors); 
	%>
	<div class="portlet-msg-error">
		<html:errors/>
	</div>
<% 
}

   String eventid = (String)request.getAttribute("eventid");
   if (Validator.isNull(eventid)) eventid = request.getParameter("eventid");
   String step = (String)request.getAttribute("step");
   if (Validator.isNull(step)) step = request.getParameter("step");
   
   BsEvent event = (BsEvent)request.getAttribute("event");
   if (event == null)
	   event = (BsEvent)GnPersistenceService.getInstance(null).getObject(BsEvent.class, Integer.valueOf(eventid));
 %>

	