<%@ include file="/html/portlet/ext/jbpm/init.jsp" %>

<%@ page import="com.liferay.portlet.workflow.service.WorkflowComponentServiceUtil" %>
<%@ page import="com.liferay.portlet.workflow.model.WorkflowTaskFormElement" %>
<%@ page import="com.liferay.portlet.workflow.action.EditTaskAction" %>
<%@ page import="com.liferay.portlet.workflow.jbi.WorkflowXMLUtil" %>
<%@ page import="com.liferay.portlet.workflow.model.WorkflowTask" %>
<%@ page import="com.liferay.portlet.workflow.search.TaskDisplayTerms" %>
<%//@ page import="com.ext.portlet.eproject.Definitions" %>
<%@ page import="com.liferay.portlet.PortletURLImpl" %>
<%@ page import="java.util.GregorianCalendar" %>


<%
Map errors = (Map)SessionErrors.get(renderRequest, EditTaskAction.class.getName());
WorkflowTaskFormElement taskFormElement = (WorkflowTaskFormElement)request.getAttribute("WorkflowTaskFormElement");

String  taskName = ParamUtil.getString(request, "taskName");
String type = taskFormElement.getType();
	String displayName = taskFormElement.getDisplayName();
	String varName = taskFormElement.getVariableName();
	String value = taskFormElement.getValue();
	String inputType = "text";
	String displayName2="";
	%>


	<%
	if(displayName.indexOf(taskName) >=0){

	displayName2=displayName.substring(taskName.length()+1);
}
else {
	displayName2=displayName;
}

	boolean taskElRequeired = taskFormElement.isRequired();
	boolean taskElWritable = taskFormElement.isWritable();
	boolean taskElReadable = taskFormElement.isReadable();

	List valueList = taskFormElement.getValueList();
boolean filefield=false;
	String errorCode = null;

	if (errors != null) {
		errorCode = (String)errors.get(displayName);
	}
	boolean hidden = false;//!taskElReadable && !taskElWritable;

	if (varName.equals("number:mainid")) {
		hidden = true;
	}

	if (varName.equals("text:mainid")) {
		hidden = true;
	}
	if (varName.equals("text:currentActor")) {
		value = value.valueOf(user.getUserId());
	}




%>

<%if (!hidden){%>

	<c:if test="<%= Validator.isNotNull(errorCode) %>">
		<tr>

			<td colspan="3">
				<span class="portlet-msg-error" style="font-size: xx-small;">

				<c:choose>
					<c:when test='<%= errorCode.equals("required-value") %>'>
						<%= LanguageUtil.get(pageContext, "please-enter-a-value") %>
					</c:when>
					<c:when test='<%= errorCode.equals("invalid-date") %>'>
						<%= LanguageUtil.get(pageContext, "please-enter-a-valid-date") %>
					</c:when>
					<c:when test='<%= errorCode.equals("invalid-email") %>'>
						<%= LanguageUtil.get(pageContext, "please-enter-a-valid-email-address") %>
					</c:when>
					<c:when test='<%= errorCode.equals("invalid-number") %>'>
						<%= LanguageUtil.get(pageContext, "please-enter-a-valid-number") %>
					</c:when>
					<c:when test='<%= errorCode.equals("invalid-phone") %>'>
						<%= LanguageUtil.get(pageContext, "please-enter-a-valid-phone-number") %>
					</c:when>
				</c:choose>

				</span>
			</td>
		</tr>
	</c:if>

	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, displayName2) %>

			<c:if test="<%= taskFormElement.isRequired() %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				*
				</span>
			</c:if>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<c:choose>

					<c:when test="<%= filefield%>">
						<% if (taskFormElement.isWritable()) {%>
					 		<input type="file" name="<%= displayName %>" >
					 	<%} else if (!value.equals("")) {%>
					 			<a target="_blank" href="<%=value%>"> <%= LanguageUtil.get(pageContext,displayName) %> </a>
					 	<%}%>

					</c:when>



				<c:when test="<%= taskFormElement.isWritable() %>">
					<c:choose>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_CHECKBOX) %>">
							<liferay-ui:input-checkbox
								param="<%= displayName %>"
								defaultValue="<%= Validator.isNotNull(value) %>"
							/>
						</c:when>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_DATE) %>">

							<%
							displayName = JS.getSafeName(displayName);

							Calendar cal = null;

							if (Validator.isNotNull(value)) {
								cal = new GregorianCalendar();

								cal.setTime(WorkflowXMLUtil.parseDate(value));
							}

							else {
								cal = new GregorianCalendar();
		//cal.setTime(WorkflowXMLUtil.parseDate(value));
							}

							%>

							<liferay-ui:input-field
								model="<%= WorkflowTask.class %>"
								field="<%= TaskDisplayTerms.CREATE_DATE_GT %>"
								fieldParam="<%= displayName %>"
								defaultValue="<%= cal %>"
							/>

							<input name="<portlet:namespace /><%= displayName %>" type="hidden" value="">
						</c:when>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_EMAIL) || type.equals(WorkflowTaskFormElement.TYPE_NUMBER) || type.equals(WorkflowTaskFormElement.TYPE_PHONE) || type.equals(WorkflowTaskFormElement.TYPE_TEXT) %>">
							<input class="form-text" name="<portlet:namespace /><%= displayName %>" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= value %>">
						</c:when>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_PASSWORD) %>">
							<input class="form-text" name="<portlet:namespace /><%= displayName %>" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="password" value="<%= value %>">
						</c:when>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_RADIO) %>">

							<%
							for (int j = 0; j < valueList.size(); j++) {
								String curValue = (String)valueList.get(j);

								if(taskName.equals("finalepileximotita") && displayName.equals("finalepileximotita_apliccable") && curValue.equals("no")) {

							%>
								<input <%= value.equals(curValue) ? "checked" : "" %> name="<portlet:namespace /><%= displayName %>" type="radio" value="<%= curValue %>"> <%= LanguageUtil.get(pageContext, "no_applicable") %><br>
						<%} else {%>

								<input <%= value.equals(curValue) ? "checked" : "" %> name="<portlet:namespace /><%= displayName %>" type="radio" value="<%= curValue %>"> <%= LanguageUtil.get(pageContext, curValue) %><br>

							<%
						}
							}
							%>

						</c:when>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_SELECT) %>">
							<select name="<portlet:namespace /><%= displayName %>">

								<%
								for (int j = 0; j < valueList.size(); j++) {
									String curValue = (String)valueList.get(j);
								%>

									<option <%= value.equals(curValue) ? "selected" : "" %> value="<%= curValue %>"><%= LanguageUtil.get(pageContext, curValue) %></option>

								<%
								}
								%>

							</select>
						</c:when>
						<c:when test="<%= type.equals(WorkflowTaskFormElement.TYPE_TEXTAREA) %>">
							<textarea class="form-text" name="<portlet:namespace /><%= displayName %>" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;" wrap="soft"><%= value %></textarea>
						</c:when>
					</c:choose>
				</c:when>
				<c:when test="<%= taskFormElement.isReadable() %>">

					<%
					value = taskFormElement.getValue();

					if (type.equals(WorkflowTaskFormElement.TYPE_DATE)) {
					}
					else if (type.equals(WorkflowTaskFormElement.TYPE_CHECKBOX)) {
						if (GetterUtil.getBoolean(value)) {
							value = LanguageUtil.get(pageContext, (String)taskFormElement.getValueList().get(0));
						}
					}
					else if (type.equals(WorkflowTaskFormElement.TYPE_RADIO) || type.equals(WorkflowTaskFormElement.TYPE_SELECT)) {
						value = LanguageUtil.get(pageContext, value);
					}

					if (Validator.isNull(value)) {
						value = LanguageUtil.get(pageContext, "not-available");
					}
					%>

					<%= value %>
				</c:when>
			</c:choose>
		</td>
	</tr>

<%} else{// hidden %>

		<input class="form-text" name="<portlet:namespace /><%= displayName %>" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="hidden" value="<%= value %>">

<%} // hidden%>

