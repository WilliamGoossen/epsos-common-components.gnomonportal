<%
/**
Created by Soumelidis Nikolaos, 11:00 @ 3/11/2006, gnomon informatics
 */
%>

<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.documents.*" %>
<%@ page import="gnomon.business.ViewResultUtil" %>
<%@ page import="gnomon.business.FileUploadHelper" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");

long companyId = PortalUtil.getCompanyId(request);
String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
boolean useThumbnails = GetterUtil.getBoolean(PropsUtil.get(companyId, "bs.documents.video.create.thumbnail"), false);
boolean embedMultimedia = instanceEmbedMedia.equals("yes");
String mmsurl = GetterUtil.getString(PropsUtil.get(companyId, "bs.documents.media.server.url"));
if (mmsurl.endsWith("/")) 
    mmsurl = mmsurl.substring(0, mmsurl.length()-1);
%>