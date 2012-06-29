
<%@ include file="/html/portlet/rss/init.jsp" %>

<%
String url = ParamUtil.getString(request, "url");
String title = StringPool.BLANK;
boolean hide = false;

WindowState windowState = renderRequest.getWindowState();
%>

<c:choose>
	<c:when test="<%= Validator.isNotNull(url) %>">

		<%
		int i = 0;
		entriesPerFeed = 20;
		%>

		<%@ include file="/html/portlet/rss/feed.jspf" %>
	</c:when>
	<c:otherwise>

		<%
		for (int i = 0; i < urls.length; i++) {
			url = urls[i];

			if (i < titles.length) {
				title = titles[i];
			}
			else {
				title = StringPool.BLANK;
			}

			if (i == 0) {
				hide = false;
			}
			else {
				hide = true;
			}
		%>

			<%@ include file="/html/portlet/rss/feed.jspf" %>

		<%
		}
		%>

		<script type="text/javascript">
			jQuery(
				function() {
					var currentPortlet = jQuery('#p_p_id<portlet:namespace />');

					currentPortlet.Accordion({
						headerSelector: '.portlet-rss-header',
						panelSelector: '.portlet-rss-content',
						panelHeight: _$J("#p_p_id<portlet:namespace /> .portlet-rss-content:first").height(),
						speed: 300
					});

					if (!jQuery.browser.msie) {
						currentPortlet.css('overflow', 'visible');
					}
				}
			);
		</script>
        <noscript>
        
        </noscript>
	</c:otherwise>
</c:choose>