<%@ page session="true" contentType="text/html; charset=UTF-8" %>


<%@ taglib uri="/WEB-INF/jpivot/jpivot-tags.tld" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://jakarta.apache.org/taglibs/i18n-1.0" prefix="i18n" %>
<%@ taglib uri="/WEB-INF/mdxtable.tld" prefix="mdx" %>

<i18n:bundle baseName="locale"
             localeRef="userLocale"
             scope="session"
             changeResponseLocale="true"/>


<% 
String lang = null;

if(session.getAttribute("lang")!=null)
lang =session.getAttribute("lang").toString();

if (lang == null) lang="el_GR";
%>
<jp:mondrianQuery id="query01" jdbcDriver="net.sourceforge.jtds.jdbc.Driver"
jdbcUrl="jdbc:jtds:sqlserver://194.219.31.206:1433/gi9_obsind;tds=8.0;lastupdatecount=true" jdbcUser="sa" jdbcPassword="olimpos"
dynLocale="<%=lang %>" dynResolver="mondrian.i18n.LocalizingDynamicSchemaProcessor"
catalogUri="/WEB-INF/queries/cube8.xml">

select {([mondian_Table5.group_deiktis])} on rows,

{[Measures].[SUM of mondian_Table5.timi]} on columns
  from cube8
</jp:mondrianQuery>


<c:set var="title01" scope="session"><i18n:message key="mondrian.group2" /></c:set>



