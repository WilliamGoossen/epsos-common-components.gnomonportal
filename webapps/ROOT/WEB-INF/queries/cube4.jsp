<%@ page session="true" contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/jpivot/jpivot-tags.tld" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://jakarta.apache.org/taglibs/i18n-1.0" prefix="i18n" %>
<i18n:bundle baseName="locale"
             localeRef="userLocale"
             scope="session"
             changeResponseLocale="true"/>

<% 
String lang = null;
if (lang == null) lang="el_GR";
%>

<jp:mondrianQuery id="query01" jdbcDriver="net.sourceforge.jtds.jdbc.Driver" jdbcUrl="jdbc:jtds:sqlserver://194.219.31.206:1433/gi9_obsind;tds=8.0;lastupdatecount=true" jdbcUser="sa" jdbcPassword="olimpos" 
dynLocale="<%=lang %>" dynResolver="mondrian.i18n.LocalizingDynamicSchemaProcessor" 
catalogUri="/WEB-INF/queries/cube4.xml">
select {([mondian_Table4.Etos].[All mondian_table4.etos],[mondian_Table4.nomos])} on rows,
 {[Measures].[SUM of mondian_Table4.timi]} on columns
  from cube4
</jp:mondrianQuery>



<c:set var="title01" scope="session"><i18n:message key="mondrian.stat3" /></c:set>
