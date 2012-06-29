<%@ include file="/html/portlet/ext/favorites/init.jsp" %>

<%
String url=themeDisplay.getPathMain() + "/ext/favorites/save";
//getPathImage()
%>

<div id="gi9-favorities">

<%-- here list user favorites --%>
	
<div id="<portlet:namespace/>favorites">

</div>

<div id="<portlet:namespace/>myFavorite" style="padding-top:10px;">
	<img style="vertical-align:middle" src="<%=themeDisplay.getPathThemeImages()%>/custom/favorities_heart.gif" alt="add to favorities" /><a href="javascript:<portlet:namespace/>addToFavorites()"><%=LanguageUtil.get(pageContext, "add.to.favorites") %></a>
</div>

<liferay-util:include page="/html/portlet/ext/favorites/sendToFriendForm.jsp">
	<liferay-util:param name="urlParam" value="<%=PortalUtil.getPortalURL(request)+currentURL%>"/>
</liferay-util:include>


<script type="text/javascript")>
	_$J(document).ready(function(){
		<portlet:namespace />getFavorites();
	});
	
	function <portlet:namespace />addToFavorites() {
		var mytitle = document.title;
		var myurl = document.URL;
		var callurl = '<%= themeDisplay.getPathMain() %>/ext/favorites/save';
		/*callurl = '<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/favorites/save"/>
			</portlet:actionURL>';*/

		jQuery.ajax(
				{
					url: callurl,
					data: {
						title: mytitle,
						url: myurl
					},
					type: 'POST',
					dataType: 'json',
					success: function(data, textStatus) {
						<portlet:namespace />populateFavoritesList("#<portlet:namespace />favorites", data);
						//eval("var myFavorites1={"+data +"}");
						//alert(data.entries);
						//alert(data.entries[0].url);
						//alert(data.entries[0].title);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						<portlet:namespace />handleJSONError('update', XMLHttpRequest, textStatus, errorThrown)
					}
				}
			);
		//alert('111');
	}
	
	function <portlet:namespace />deleteFromFavorites(favurl,favtitle) {
		var callurl = '<%= themeDisplay.getPathMain() %>/ext/favorites/delete';

		jQuery.ajax(
				{
					url: callurl,
					data: {
						title: favtitle,
						url: favurl
					},
					type: 'POST',
					dataType: 'json',
					success: function(data, textStatus) {
						<portlet:namespace />populateFavoritesList("#<portlet:namespace />favorites", data);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						<portlet:namespace />handleJSONError('delete', XMLHttpRequest, textStatus, errorThrown);
					}
				}
			);	
	}
	
	function <portlet:namespace />getFavorites() {
		var callurl = '<%= themeDisplay.getPathMain() %>/ext/favorites/get';

		jQuery.ajax(
				{
					url: callurl,
					type: 'POST',
					dataType: 'json',
					success: function(data, textStatus) {
						<portlet:namespace />populateFavoritesList("#<portlet:namespace />favorites", data);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						<portlet:namespace />handleJSONError('retrieve', XMLHttpRequest, textStatus, errorThrown)
					}
				}
			);	
	}
	
	function <portlet:namespace />populateFavoritesList(elementid, data) {
		_$J("#<portlet:namespace />favorites").empty();
		for (var i=0; i<data.length; i++) {
			var fav = "<img src=\"<%=themeDisplay.getPathThemeImages()%>/custom/bullet1.gif\" title=\"go\" style=\"vertical-align:middle;padding-right:7px;\" /><a href=\"" + data[i].url + "\">" + decodeURI(data[i].title) + "</a>";
			var favdel = "<a href=\"javascript:<portlet:namespace/>deleteFromFavorites('" + data[i].url + "', '" + data[i].title + "')\"><img src=\"<%=themeDisplay.getPathThemeImages()%>/common/delete.png\" title=\"<%=LanguageUtil.get(pageContext, "delete.from.favorites") %>\" style=\"vertical-align:middle;padding-left:7px;\" /></a>";
			//alert(favdel);
			_$J("#<portlet:namespace />favorites").append(fav);
			_$J("#<portlet:namespace />favorites").append(favdel);
			_$J("#<portlet:namespace />favorites").append("<br/>");
		}
		//_$J("#<portlet:namespace />howto").empty();
	}
	
	function <portlet:namespace />handleJSONError(action, XMLHttpRequest, textStatus, errorThrown) {
		//alert('Oups! An error accured while trying to perform "' + action + '" to your favorites');
	}
</script>
<noscript></noscript>

</div>