<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.business.GeneralUtils" %>

<% 
   //String lang = GeneralUtils.getLocale(request);
   int begin = 0;
   int end = 26;
   char beginChar = 'A';
   char skipChar = '\u03a2';
   // if (lang.equals("el_GR"))
   //{
   //   end=25;
   //   beginChar = '\u0391';
   //}
   String selectedName = request.getParameter("name");
   if (selectedName != null && selectedName.length() == 2 && selectedName.endsWith("*"))
	   selectedName = selectedName.substring(0,1);
   else
	   selectedName = "";
  
%>

<fieldset style="text-align:center;">


<span class="pagelinks" style="padding:1; background:none;">
	<% for (int i=begin; i<end; i++){ 
             if (beginChar == skipChar) {
                 beginChar++;
                 continue;
             }
             String c = ""+beginChar;
             beginChar++;
             boolean selected = false;
             if (c.equals(selectedName))
            	 selected = true;
        %>
        <a id="link_<%= c %>" 
         <% if (selected) { %> style="border-width:3px; border-style:solid;" <% } %>
        href="<portlet:actionURL>
        <portlet:param name="struts_action" value="/ext/parties/contacts/search"/>
        <portlet:param name="alphabet" value="true"/>
        <portlet:param name="search" value="true"/>
        <portlet:param name="name" value="<%= c +"*"%>"/>
        </portlet:actionURL>">
        <% if (selected) { %> <b> <% } %>
        <%= c %>
        <% if (selected) { %> </b> <% } %>
        </a>
    
    <% } %>
</span>


<span class="pagelinks" style="padding:1; background:none;">
        
        <% beginChar = '\u0391';
               end=25;
               for (int i=begin; i<end; i++){ 
                 if (beginChar == skipChar) {
                     beginChar++;
                     continue;
                 }
                 String c = ""+beginChar;
                 beginChar++;
                 boolean selected = false;
                 if (c.equals(selectedName))
                	 selected = true;
            %>
            <a id="link_<%= c %>" 
            <% if (selected) { %> style="border-width:3px; border-style:solid;" <% } %>
            href="<portlet:actionURL>
            <portlet:param name="struts_action" value="/ext/parties/contacts/search"/>
            <portlet:param name="alphabet" value="true"/>
            <portlet:param name="search" value="true"/>
            <portlet:param name="name" value="<%= c +"*"%>"/>
            </portlet:actionURL>">
            <% if (selected) { %> <b> <% } %>
            <%= c %>
            <% if (selected) { %> </b> <% } %>
            </a>
            
        <% } %>

</span>

<span class="pagelinks" style="padding:1; background:none;">

	<% for (int i=0; i<10; i++){ 
             String c = ""+i;
             boolean selected = false;
             if (c.equals(selectedName))
            	 selected = true;
        %>
        <a id="link_<%= c %>" 
        <% if (selected) { %> style="border-width:3px; border-style:solid;" <% } %>
        href="<portlet:actionURL>
        <portlet:param name="struts_action" value="/ext/parties/contacts/search"/>
        <portlet:param name="alphabet" value="true"/>
        <portlet:param name="search" value="true"/>
        <portlet:param name="name" value="<%= c  +"*"%>"/>
        </portlet:actionURL>">
        <% if (selected) { %> <b> <% } %>
        <%= c %>
        <% if (selected) { %> </b> <% } %>
        </a>
       
    <% } %>


</span>

</fieldset>

