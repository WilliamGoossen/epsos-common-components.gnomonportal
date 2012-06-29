<%@ include file="/html/portlet/init.jsp" %>

<portlet:defineObjects />

<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String"/>
<tiles:useAttribute id="searchStyle" name="searchStyle" classname="java.lang.String" ignore="true"/>

<%
String lucene_searchItem = (String)request.getAttribute("lucene_searchItem");
if (lucene_searchItem == null) lucene_searchItem = "";
String lucene_month = (String)request.getAttribute("lucene_month");
if (lucene_month == null) lucene_month = "";
String lucene_year = (String)request.getAttribute("lucene_year");
if (lucene_year == null) lucene_year = "";

Integer listFilter = (Integer)request.getAttribute("listFilter");
if (listFilter == null) 
	listFilter = GnPortletSetting.LIST_PUBLISH_TRUE;

String monthParam = request.getParameter("sel_month");
String dayParam = request.getParameter("sel_day");
String yearParam = request.getParameter("sel_year");
String monthAttr = (String)request.getAttribute("sel_month");
String dayAttr = (String)request.getAttribute("sel_day");
String yearAttr = (String)request.getAttribute("sel_year");
dayParam = (dayAttr != null) ? dayAttr :  dayParam;
monthParam = (monthAttr != null) ? monthAttr :  monthParam;
yearParam = (yearAttr != null) ? yearAttr :  yearParam;
//System.err.println("### "+dayParam+" "+monthParam+" "+yearParam);
%>

<c:if test="<%=Validator.isNotNull(searchStyle)%>">
	<c:choose>
	<c:when test="<%=searchStyle.equals("calendar")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/calendar.jsp" flush="true">
			<tiles:put name="struts_action" value="<%=struts_action%>" />
			<tiles:put name="monthParam"><%= monthParam %></tiles:put>
			<tiles:put name="dayParam"><%= dayParam %></tiles:put>
			<tiles:put name="yearParam"><%= yearParam %></tiles:put>
		</tiles:insert>
	</c:when>
	<c:when test="<%=searchStyle.equals("month-year")%>">
		<form name="<portlet:namespace/>LUCENE_SEARCH" method="post"
		      action="<portlet:renderURL windowState="<%= WindowState.NORMAL.toString() %>" >
						<portlet:param name="struts_action" value="<%= struts_action %>" />
						<portlet:param name="topicid" value="<%= ParamUtil.getString(request,"topicid", "") %>" />
						</portlet:renderURL>">
			<fieldset><legend><span class="form-text"><%= LanguageUtil.get(pageContext, "gn.lucene.search") %></span></legend>
			<table style="width:100%">
				<tr>
					<td><span class="form-text"><%= LanguageUtil.get(pageContext, "gn.lucene.contains-text") %></span></td>
					<td><input type="text" class="FormArea" size="10" name="lucene_searchItem" value="<%= lucene_searchItem %>"></td>
					<td rowspan="3">
						<input type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" value="<%= LanguageUtil.get(pageContext, "gn.lucene.search") %>">
					</td>
				</tr>
				<tr>
					<td><span class="form-text"><%= LanguageUtil.get(pageContext, "gn.lucene.contains-month") %></span></td>
					<td>
						<select class="FormArea" name="lucene_month">
							<option class="form-text" name="" value=""></option>
							<option class="form-text" name="01" value="01" <% if(lucene_month.equals("01")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.1") %></option>
							<option class="form-text" name="02" value="02" <% if(lucene_month.equals("02")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.2") %></option>
							<option class="form-text" name="03" value="03" <% if(lucene_month.equals("03")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.3") %></option>
							<option class="form-text" name="04" value="04" <% if(lucene_month.equals("04")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.4") %></option>
							<option class="form-text" name="05" value="05" <% if(lucene_month.equals("05")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.5") %></option>
							<option class="form-text" name="06" value="06" <% if(lucene_month.equals("06")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.6") %></option>
							<option class="form-text" name="07" value="07" <% if(lucene_month.equals("07")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.7") %></option>
							<option class="form-text" name="08" value="08" <% if(lucene_month.equals("08")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.8") %></option>
							<option class="form-text" name="09" value="09" <% if(lucene_month.equals("09")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.9") %></option>
							<option class="form-text" name="10" value="10" <% if(lucene_month.equals("10")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.10") %></option>
							<option class="form-text" name="11" value="11" <% if(lucene_month.equals("11")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.11") %></option>
							<option class="form-text" name="12" value="12" <% if(lucene_month.equals("12")) { %> selected <% } %> ><%= LanguageUtil.get(pageContext, "gn.lucene.month.12") %></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><span class="form-text"><%= LanguageUtil.get(pageContext, "gn.lucene.contains-year") %></span></td>
					<td><input type="text" class="FormArea" size="10" name="lucene_year" value="<%= lucene_year %>"></td>
				</tr>
				<c:if test="<%= hasViewUnPublished %>">
				<tr>
					<td colspan="2">
						<input type="radio" name="listFilter" value="<%=GnPortletSetting.LIST_PUBLISH_TRUE+""%>" <% if (listFilter.equals(GnPortletSetting.LIST_PUBLISH_TRUE)) { %> checked <% } %>   ><%= LanguageUtil.get(pageContext, "gn.link.view-published") %><br>
						<input type="radio" name="listFilter" value="<%=GnPortletSetting.LIST_PUBLISH_FALSE+""%>" <% if (listFilter.equals(GnPortletSetting.LIST_PUBLISH_FALSE)) { %> checked <% } %>   ><%= LanguageUtil.get(pageContext, "gn.link.view-unpublished") %><br>
						<input type="radio" name="listFilter" value="<%=GnPortletSetting.LIST_PUBLISH_ALL+""%>" <% if (listFilter.equals(GnPortletSetting.LIST_PUBLISH_ALL)) { %> checked <% } %>   ><%= LanguageUtil.get(pageContext, "gn.link.view-all") %><br>
					</td>
				</tr>
				</c:if>
			</table>
			</fieldset>
		</form>
	</c:when>
	<c:otherwise>
	</c:otherwise>
	</c:choose>
</c:if>