<%@ include file="/html/portlet/ext/menu_layout/init.jsp" %>


<%
Vector  items =(Vector) request.getAttribute("menu_items");





Hashtable item=null;
String url="";
String type="";
String name="";
String portletid="";
String courseid="";
String image="";
String mytopicid="";

if(items!=null && items.size()>0) {%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">

<%	for(int i=0; i<items.size(); i++) {
		item = (Hashtable)items.get(i);
			if(item!=null) {
				name = (String)item.get("NAME");
				type = (String)item.get("TYPE");
				url = (String)item.get("URL");
				portletid = (String)item.get("PORTLET_ID");												
				courseid = (String)item.get("COURSE_ID");															
				image=(String)item.get("M_IMAGE");	
				mytopicid=(String)item.get("TOPICID");	
				if(image!=null && !image.equals("")) {
					image ="/FILESYSTEM/menus/"+image;
				}
				if(type.equals("1")) {%>
		<tr>
<td>		
	<div id="menu">
	
				<ul>
					<li>
					<a href="<%=url%>"><%if(image!=null && !image.equals("")) {%><img src="<%=image%>" border=0 align="absmiddle">
					<%}%><%=name%></a>
					</li>
				</ul>
	</div>
</td>
</tr>
<%				}
				
				else if(type.equals("2")) {%>
				<tr>
<td>
			<div id="menu">		
				
				<ul>
					<li>
					<a href="<liferay:actionURL portletName ="<%=portletid%>" windowState="maximized"><%if (mytopicid!=null && !mytopicid.equals("")) {%> <liferay:param name="vtopicid" value="<%=mytopicid%>"/><liferay:param name="start_topic" value="<%=mytopicid%>"/><%}%> </liferay:actionURL>">
					<%if(image!=null && !image.equals("")) {%><img src="<%=image%>" border=0 align="absmiddle">
					<%}%><%=name%></a>
					</li>
				</ul>
</div>
</td>
</tr>

						

<%				}
				
				
				else if(type.equals("3")) {%>
			<tr>
			<td>
			<div id="menu">		
				<ul>
					<li>
					<a href="<liferay:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" portletName ="GN_CHAPTERS"><liferay:param name="struts_action" value="/ext/chapters/view_chapters" /><liferay:param name="course_id" value="<%=courseid%>" />
					</liferay:actionURL>"><%if(image!=null && !image.equals("")) {%><img src="<%=image%>" border=0 align="absmiddle">
					<%}%><%= name %></a>
					</li>
				</ul>
</div>
</td>
</tr>
								
								
								

<%				} 
				
				
				
			}
	}%>
</table>
<%}





%>









