package org.apache.jsp.html.common.themes;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.germinus.easyconf.Filter;
import com.liferay.lock.DuplicateLockException;
import com.liferay.lock.model.Lock;
import com.liferay.lock.service.LockServiceUtil;
import com.liferay.portal.NoSuchUserException;
import com.liferay.portal.captcha.CaptchaTextException;
import com.liferay.portal.kernel.cal.Recurrence;
import com.liferay.portal.kernel.dao.DAOParamUtil;
import com.liferay.portal.kernel.dao.search.ResultRow;
import com.liferay.portal.kernel.dao.search.RowChecker;
import com.liferay.portal.kernel.dao.search.SearchContainer;
import com.liferay.portal.kernel.dao.search.SearchEntry;
import com.liferay.portal.kernel.dao.search.TextSearchEntry;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.language.LanguageWrapper;
import com.liferay.portal.kernel.language.UnicodeLanguageUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.log.LogUtil;
import com.liferay.portal.kernel.portlet.LiferayPortletMode;
import com.liferay.portal.kernel.portlet.LiferayWindowState;
import com.liferay.portal.kernel.security.permission.ActionKeys;
import com.liferay.portal.kernel.security.permission.PermissionChecker;
import com.liferay.portal.kernel.servlet.BrowserSniffer;
import com.liferay.portal.kernel.util.ArrayUtil;
import com.liferay.portal.kernel.util.BooleanWrapper;
import com.liferay.portal.kernel.util.CalendarFactoryUtil;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.ContentTypes;
import com.liferay.portal.kernel.util.DateUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.IntegerWrapper;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.KeyValuePair;
import com.liferay.portal.kernel.util.KeyValuePairComparator;
import com.liferay.portal.kernel.util.ObjectValuePair;
import com.liferay.portal.kernel.util.ObjectValuePairComparator;
import com.liferay.portal.kernel.util.OrderByComparator;
import com.liferay.portal.kernel.util.OrderedProperties;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PrefsParamUtil;
import com.liferay.portal.kernel.util.PropertiesUtil;
import com.liferay.portal.kernel.util.Randomizer;
import com.liferay.portal.kernel.util.ServerDetector;
import com.liferay.portal.kernel.util.SortedProperties;
import com.liferay.portal.kernel.util.StackTraceUtil;
import com.liferay.portal.kernel.util.StringComparator;
import com.liferay.portal.kernel.util.StringMaker;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.UnicodeFormatter;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.language.LanguageImpl;
import com.liferay.portal.lucene.LuceneFields;
import com.liferay.portal.model.*;
import com.liferay.portal.model.impl.*;
import com.liferay.portal.security.auth.PrincipalException;
import com.liferay.portal.service.*;
import com.liferay.portal.service.impl.LayoutTemplateLocalUtil;
import com.liferay.portal.service.permission.LayoutPermissionUtil;
import com.liferay.portal.service.permission.PortletPermissionUtil;
import com.liferay.portal.struts.StrutsUtil;
import com.liferay.portal.theme.PortletDisplay;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.ContentUtil;
import com.liferay.portal.util.CookieKeys;
import com.liferay.portal.util.DateFormats;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.PortletKeys;
import com.liferay.portal.util.PrefsPropsUtil;
import com.liferay.portal.util.PropsUtil;
import com.liferay.portal.util.Recipient;
import com.liferay.portal.util.ReleaseInfo;
import com.liferay.portal.util.SessionClicks;
import com.liferay.portal.util.SessionTreeJSClicks;
import com.liferay.portal.util.ShutdownUtil;
import com.liferay.portal.util.WebAppPool;
import com.liferay.portal.util.WebKeys;
import com.liferay.portal.util.comparator.RecipientComparator;
import com.liferay.portal.util.comparator.PortletCategoryComparator;
import com.liferay.portal.util.comparator.PortletTitleComparator;
import com.liferay.portlet.CachePortlet;
import com.liferay.portlet.PortalPreferences;
import com.liferay.portlet.PortletConfigFactory;
import com.liferay.portlet.PortletConfigImpl;
import com.liferay.portlet.PortletInstanceFactory;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.liferay.portlet.PortletSetupUtil;
import com.liferay.portlet.PortletURLImpl;
import com.liferay.portlet.PortletURLUtil;
import com.liferay.portlet.RenderParametersPool;
import com.liferay.portlet.RenderRequestFactory;
import com.liferay.portlet.RenderRequestImpl;
import com.liferay.portlet.RenderResponseFactory;
import com.liferay.portlet.RenderResponseImpl;
import com.liferay.portlet.UserAttributes;
import com.liferay.portlet.messaging.util.MessagingUtil;
import com.liferay.portlet.portletconfiguration.util.PortletConfigurationUtil;
import com.liferay.util.BeanParamUtil;
import com.liferay.util.BeanUtil;
import com.liferay.util.CollectionFactory;
import com.liferay.util.CookieUtil;
import com.liferay.util.CreditCard;
import com.liferay.util.FileUtil;
import com.liferay.util.Html;
import com.liferay.util.Http;
import com.liferay.util.HttpUtil;
import com.liferay.util.JS;
import com.liferay.util.ListUtil;
import com.liferay.util.LocaleUtil;
import com.liferay.util.MathUtil;
import com.liferay.util.PKParser;
import com.liferay.util.PwdGenerator;
import com.liferay.util.SetUtil;
import com.liferay.util.State;
import com.liferay.util.StateUtil;
import com.liferay.util.TextFormatter;
import com.liferay.util.Time;
import com.liferay.util.cal.CalendarUtil;
import com.liferay.util.dao.hibernate.QueryUtil;
import com.liferay.util.format.PhoneNumberUtil;
import com.liferay.util.log4j.Levels;
import com.liferay.util.mail.InternetAddressUtil;
import com.liferay.util.portlet.DynamicRenderRequest;
import com.liferay.util.servlet.DynamicServletRequest;
import com.liferay.util.servlet.SessionErrors;
import com.liferay.util.servlet.SessionMessages;
import com.liferay.util.servlet.SessionParameters;
import com.liferay.util.servlet.StringServletResponse;
import com.liferay.util.servlet.UploadException;
import com.liferay.util.xml.XMLFormatter;
import java.io.ByteArrayInputStream;
import java.io.StringReader;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Currency;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.Stack;
import java.util.TimeZone;
import java.util.TreeMap;
import java.util.TreeSet;
import javax.portlet.PortletConfig;
import javax.portlet.PortletContext;
import javax.portlet.PortletException;
import javax.portlet.PortletMode;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletSession;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.UnavailableException;
import javax.portlet.ValidatorException;
import javax.portlet.WindowState;
import org.apache.struts.Globals;
import org.json.JSONObject;
import com.ext.util.*;
import gnomon.business.StringUtils;
import gnomon.hibernate.model.views.ViewResult;
import com.liferay.portal.kernel.security.permission.ActionExtKeys;
import com.liferay.portlet.journal.NoSuchTemplateException;
import com.liferay.portlet.journal.model.JournalTemplate;
import com.liferay.portlet.journal.service.JournalTemplateLocalServiceUtil;

public final class top_005fhead_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


private static final String _BOTTOM_KEY = "bottom";

private static final String _LEFT_KEY = "left";

private static final String _RIGHT_KEY = "right";

private static final String _SAME_FOR_ALL_KEY = "sameForAll";

private static final String _TOP_KEY = "top";

private static final String _UNIT_KEY = "unit";

private static final String _VALUE_KEY = "value";

private static final Set _unitSet = new HashSet();

static {
	_unitSet.add("px");
	_unitSet.add("em");
	_unitSet.add("%");
}


private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.common.themes.top_head.jsp");

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(28);
    _jspx_dependants.add("/html/common/init.jsp");
    _jspx_dependants.add("/WEB-INF/tld/displaytag.tld");
    _jspx_dependants.add("/WEB-INF/tld/easyconf.tld");
    _jspx_dependants.add("/WEB-INF/tld/c-rt.tld");
    _jspx_dependants.add("/WEB-INF/tld/fmt-rt.tld");
    _jspx_dependants.add("/WEB-INF/tld/sql-rt.tld");
    _jspx_dependants.add("/WEB-INF/tld/x-rt.tld");
    _jspx_dependants.add("/WEB-INF/tld/liferay-portlet.tld");
    _jspx_dependants.add("/WEB-INF/tld/liferay-portlet-ext.tld");
    _jspx_dependants.add("/WEB-INF/tld/liferay-security.tld");
    _jspx_dependants.add("/WEB-INF/tld/liferay-theme.tld");
    _jspx_dependants.add("/WEB-INF/tld/liferay-ui.tld");
    _jspx_dependants.add("/WEB-INF/tld/liferay-util.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-bean.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-bean-el.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-html.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-html-el.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-logic.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-logic-el.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-nested.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-tiles.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-tiles-el.tld");
    _jspx_dependants.add("/html/common/init-ext.jsp");
    _jspx_dependants.add("/html/common/themes/top_meta.jspf");
    _jspx_dependants.add("/html/common/themes/top_meta-ext.jsp");
    _jspx_dependants.add("/html/common/themes/portlet_css.jspf");
    _jspx_dependants.add("/html/common/themes/top_js.jspf");
    _jspx_dependants.add("/html/common/themes/top_js-ext.jsp");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fmeta_002dtags_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fchoose;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fwhen_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fotherwise;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fmeta_002dtags_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fchoose = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fwhen_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fotherwise = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fif_005ftest.release();
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fmeta_002dtags_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fchoose.release();
    _005fjspx_005ftagPool_005fc_005fwhen_005ftest.release();
    _005fjspx_005ftagPool_005fc_005fotherwise.release();
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;


/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\r\n");
      out.write("\r\n");

/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      //  liferay-theme:defineObjects
      com.liferay.taglib.theme.DefineObjectsTag _jspx_th_liferay_002dtheme_005fdefineObjects_005f0 = (com.liferay.taglib.theme.DefineObjectsTag) _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.get(com.liferay.taglib.theme.DefineObjectsTag.class);
      _jspx_th_liferay_002dtheme_005fdefineObjects_005f0.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dtheme_005fdefineObjects_005f0.setParent(null);
      int _jspx_eval_liferay_002dtheme_005fdefineObjects_005f0 = _jspx_th_liferay_002dtheme_005fdefineObjects_005f0.doStartTag();
      if (_jspx_th_liferay_002dtheme_005fdefineObjects_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.reuse(_jspx_th_liferay_002dtheme_005fdefineObjects_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.reuse(_jspx_th_liferay_002dtheme_005fdefineObjects_005f0);
      com.liferay.portal.theme.ThemeDisplay themeDisplay = null;
      com.liferay.portal.model.Company company = null;
      com.liferay.portal.model.Account account = null;
      com.liferay.portal.model.User user = null;
      com.liferay.portal.model.User realUser = null;
      com.liferay.portal.model.Contact contact = null;
      com.liferay.portal.model.Layout layout = null;
      java.util.List layouts = null;
      java.lang.Long plid = null;
      com.liferay.portal.model.LayoutTypePortlet layoutTypePortlet = null;
      java.lang.Long portletGroupId = null;
      com.liferay.portal.kernel.security.permission.PermissionChecker permissionChecker = null;
      java.util.Locale locale = null;
      java.util.TimeZone timeZone = null;
      com.liferay.portal.model.Theme theme = null;
      com.liferay.portal.model.ColorScheme colorScheme = null;
      com.liferay.portal.theme.PortletDisplay portletDisplay = null;
      themeDisplay = (com.liferay.portal.theme.ThemeDisplay) _jspx_page_context.findAttribute("themeDisplay");
      company = (com.liferay.portal.model.Company) _jspx_page_context.findAttribute("company");
      account = (com.liferay.portal.model.Account) _jspx_page_context.findAttribute("account");
      user = (com.liferay.portal.model.User) _jspx_page_context.findAttribute("user");
      realUser = (com.liferay.portal.model.User) _jspx_page_context.findAttribute("realUser");
      contact = (com.liferay.portal.model.Contact) _jspx_page_context.findAttribute("contact");
      layout = (com.liferay.portal.model.Layout) _jspx_page_context.findAttribute("layout");
      layouts = (java.util.List) _jspx_page_context.findAttribute("layouts");
      plid = (java.lang.Long) _jspx_page_context.findAttribute("plid");
      layoutTypePortlet = (com.liferay.portal.model.LayoutTypePortlet) _jspx_page_context.findAttribute("layoutTypePortlet");
      portletGroupId = (java.lang.Long) _jspx_page_context.findAttribute("portletGroupId");
      permissionChecker = (com.liferay.portal.kernel.security.permission.PermissionChecker) _jspx_page_context.findAttribute("permissionChecker");
      locale = (java.util.Locale) _jspx_page_context.findAttribute("locale");
      timeZone = (java.util.TimeZone) _jspx_page_context.findAttribute("timeZone");
      theme = (com.liferay.portal.model.Theme) _jspx_page_context.findAttribute("theme");
      colorScheme = (com.liferay.portal.model.ColorScheme) _jspx_page_context.findAttribute("colorScheme");
      portletDisplay = (com.liferay.portal.theme.PortletDisplay) _jspx_page_context.findAttribute("portletDisplay");
      out.write("\r\n");
      out.write("\r\n");

/**
 * Copyright (c) 2000-2006 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
//@ page import="com.liferay.portal.kernel.util.PortletExtKeys" 
      out.write("\r\n");
      out.write("\r\n");




String contextPath = PropsUtil.get(PropsUtil.PORTAL_CTX);
if (contextPath.equals("/")) {
	contextPath = "";
}

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\n");
      out.write("\n");
      out.write("<meta content=\"");
      out.print( ContentTypes.TEXT_HTML_UTF8 );
      out.write("\" http-equiv=\"content-type\" />\n");
      out.write("\n");

String refreshRate = request.getParameter("refresh_rate");

      out.write('\n');
      out.write('\n');
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(null);
      _jspx_th_c_005fif_005f0.setTest( (refreshRate != null) && (!refreshRate.equals("0")) );
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t<meta content=\"");
          out.print( refreshRate );
          out.write(";\" http-equiv=\"Refresh\" />\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f0);
      out.write('\n');
      out.write('\n');

String cacheControl = request.getParameter("cache_control");

      out.write('\n');
      out.write('\n');
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f1.setParent(null);
      _jspx_th_c_005fif_005f1.setTest( (cacheControl != null) && (cacheControl.equals("0")) );
      int _jspx_eval_c_005fif_005f1 = _jspx_th_c_005fif_005f1.doStartTag();
      if (_jspx_eval_c_005fif_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t<meta content=\"no-cache\" http-equiv=\"Cache-Control\" />\n");
          out.write("\t<meta content=\"no-cache\" http-equiv=\"Pragma\" />\n");
          out.write("\t<meta content=\"0\" http-equiv=\"Expires\" />\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f1.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f1);
      out.write('\n');
      out.write('\n');
      if (_jspx_meth_liferay_002dtheme_005fmeta_002dtags_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');

/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<link rel=\"Shortcut Icon\" href=\"");
      out.print( themeDisplay.getPathThemeImages() );
      out.write("/gi9-socket.ico\" />\r\n");
      out.write("\r\n");
      out.write("<link href=\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/css_cached?themeId=");
      out.print( themeDisplay.getTheme().getThemeId() );
      out.write("&amp;colorSchemeId=");
      out.print( themeDisplay.getColorScheme().getColorSchemeId() );
      out.write("\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
      out.write("<link href=\"");
      out.print( themeDisplay.getPathJavaScript() );
      out.write("/calendar/skins/aqua/theme.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("\r\n");

List portlets = null;

if ((layout != null) && layout.getType().equals(LayoutImpl.TYPE_PORTLET)) {
	portlets = layoutTypePortlet.getPortlets();
}

      out.write("\r\n");
      out.write("\r\n");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f2.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f2.setParent(null);
      _jspx_th_c_005fif_005f2.setTest( portlets != null );
      int _jspx_eval_c_005fif_005f2 = _jspx_th_c_005fif_005f2.doStartTag();
      if (_jspx_eval_c_005fif_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t");

	Set headerCssPortlets = CollectionFactory.getHashSet();
	Set headerCssPaths = CollectionFactory.getHashSet();

	for (int i = 0; i < portlets.size(); i++) {
		Portlet portlet = (Portlet)portlets.get(i);

		if (!headerCssPortlets.contains(portlet.getRootPortletId())) {
			headerCssPortlets.add(portlet.getRootPortletId());

			List headerCssList = portlet.getHeaderCss();

			for (int j = 0; j < headerCssList.size(); j++) {
				String headerCss = (String)headerCssList.get(j);

				String headerCssPath = portlet.getContextPath() + headerCss;

				if (!headerCssPaths.contains(headerCssPath)) {
					headerCssPaths.add(headerCssPath);
	
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<link href=\"");
          out.print( headerCssPath );
          out.write("\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
          out.write("\r\n");
          out.write("\t");

				}
			}
		}
	}
	
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t<style type=\"text/css\">\r\n");
          out.write("\r\n");
          out.write("\t\t");

		for (int i = 0; i < portlets.size(); i++) {
			Portlet portlet = (Portlet)portlets.get(i);

			PortletPreferences portletSetup = PortletPreferencesFactoryUtil.getPortletSetup(request, portlet.getPortletId(), true, true);

			String portletSetupCss = portletSetup.getValue("portlet-setup-css", StringPool.BLANK);
		
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t\t");
          //  c:if
          org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f3 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
          _jspx_th_c_005fif_005f3.setPageContext(_jspx_page_context);
          _jspx_th_c_005fif_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
          _jspx_th_c_005fif_005f3.setTest( Validator.isNotNull(portletSetupCss) );
          int _jspx_eval_c_005fif_005f3 = _jspx_th_c_005fif_005f3.doStartTag();
          if (_jspx_eval_c_005fif_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t\t");

				try {
				
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t\t\t");

/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

              out.write('\n');
              out.write('\n');

JSONObject jsonObj = PortletSetupUtil.cssToJSON(portletSetup, portletSetupCss);

List finalCSS = new ArrayList();

// Background data

JSONObject bgData = jsonObj.getJSONObject("bgData");

String bgColor = bgData.getString("backgroundColor");
String bgImage = bgData.getString("backgroundImage");

JSONObject bgPos = bgData.getJSONObject("backgroundPosition");
JSONObject bgPosLeft = bgPos.getJSONObject(_LEFT_KEY);
JSONObject bgPosTop = bgPos.getJSONObject(_TOP_KEY);

String bgPosLeftValue = bgPosLeft.getString(_VALUE_KEY) + bgPosLeft.getString(_UNIT_KEY);
String bgPosTopValue = bgPosTop.getString(_VALUE_KEY) + bgPosTop.getString(_UNIT_KEY);
String bgPosValue = bgPosLeftValue + " " + bgPosTopValue;

boolean useBgImage = bgData.getBoolean("useBgImage");

if (Validator.isNotNull(bgColor)) {
	finalCSS.add("background-color: " + bgColor);
}

if (Validator.isNotNull(bgImage)) {
	finalCSS.add("background-image: url(" + bgImage + ")");
}

if (useBgImage) {
	finalCSS.add("background-position: " + bgPosValue);
}

// Border data

JSONObject borderData = jsonObj.getJSONObject("borderData");
JSONObject borderWidth = borderData.getJSONObject("borderWidth");
JSONObject borderStyle = borderData.getJSONObject("borderStyle");
JSONObject borderColor = borderData.getJSONObject("borderColor");

boolean ufaBorderWidth = borderWidth.getBoolean(_SAME_FOR_ALL_KEY);
boolean ufaBorderStyle = borderStyle.getBoolean(_SAME_FOR_ALL_KEY);
boolean ufaBorderColor = borderColor.getBoolean(_SAME_FOR_ALL_KEY);

// Width

JSONObject borderWidthTop = borderWidth.getJSONObject(_TOP_KEY);
JSONObject borderWidthRight = borderWidth.getJSONObject(_RIGHT_KEY);
JSONObject borderWidthBottom = borderWidth.getJSONObject(_BOTTOM_KEY);
JSONObject borderWidthLeft = borderWidth.getJSONObject(_LEFT_KEY);

String borderTopWidthValue = borderWidthTop.getString(_VALUE_KEY) + borderWidthTop.getString(_UNIT_KEY);
String borderRightWidthValue = borderWidthRight.getString(_VALUE_KEY) + borderWidthRight.getString(_UNIT_KEY);
String borderBottomWidthValue = borderWidthBottom.getString(_VALUE_KEY) + borderWidthBottom.getString(_UNIT_KEY);
String borderLeftWidthValue = borderWidthLeft.getString(_VALUE_KEY) + borderWidthLeft.getString(_UNIT_KEY);

// Style

String borderTopStyleValue = borderStyle.getString(_TOP_KEY);
String borderRightStyleValue = borderStyle.getString(_RIGHT_KEY);
String borderBottomStyleValue = borderStyle.getString(_BOTTOM_KEY);
String borderLeftStyleValue = borderStyle.getString(_LEFT_KEY);

// Color

String borderTopColorValue = borderColor.getString(_TOP_KEY);
String borderRightColorValue = borderColor.getString(_RIGHT_KEY);
String borderBottomColorValue = borderColor.getString(_BOTTOM_KEY);
String borderLeftColorValue = borderColor.getString(_LEFT_KEY);

if (ufaBorderWidth) {
	if (!_unitSet.contains(borderTopWidthValue)) {
		finalCSS.add("border-width: " + borderTopWidthValue);
	}
}
else {
	if (!_unitSet.contains(borderTopWidthValue)) {
		finalCSS.add("border-top-width: " + borderTopWidthValue);
	}

	if (!_unitSet.contains(borderRightWidthValue)) {
		finalCSS.add("border-right-width: " + borderRightWidthValue);
	}

	if (!_unitSet.contains(borderBottomWidthValue)) {
		finalCSS.add("border-bottom-width: " + borderBottomWidthValue);
	}

	if (!_unitSet.contains(borderLeftWidthValue)) {
		finalCSS.add("border-left-width: " + borderLeftWidthValue);
	}
}

if (ufaBorderStyle && !_unitSet.contains(borderTopWidthValue)) {
	finalCSS.add("border-style: " + borderTopStyleValue);
}
else {
	if (Validator.isNotNull(borderTopStyleValue)) {
		finalCSS.add("border-top-style: " + borderTopStyleValue);
	}

	if (Validator.isNotNull(borderRightStyleValue)) {
		finalCSS.add("border-right-style: " + borderRightStyleValue);
	}

	if (Validator.isNotNull(borderBottomStyleValue)) {
		finalCSS.add("border-bottom-style: " + borderBottomStyleValue);
	}

	if (Validator.isNotNull(borderLeftStyleValue)) {
		finalCSS.add("border-left-style: " + borderLeftStyleValue);
	}
}

if (ufaBorderColor) {
	if (Validator.isNotNull(borderTopColorValue)) {
		finalCSS.add("border-color: " + borderTopColorValue);
	}
}
else {
	if (Validator.isNotNull(borderTopColorValue)) {
		finalCSS.add("border-top-color: " + borderTopColorValue);
	}

	if (Validator.isNotNull(borderRightColorValue)) {
		finalCSS.add("border-right-color: " + borderRightColorValue);
	}

	if (Validator.isNotNull(borderBottomColorValue)) {
		finalCSS.add("border-bottom-color: " + borderBottomColorValue);
	}

	if (Validator.isNotNull(borderLeftColorValue)) {
		finalCSS.add("border-left-color: " + borderLeftColorValue);
	}
}

// Spacing data

JSONObject spacingData = jsonObj.getJSONObject("spacingData");
JSONObject margin = spacingData.getJSONObject("margin");
JSONObject padding = spacingData.getJSONObject("padding");

boolean ufaMargin = margin.getBoolean(_SAME_FOR_ALL_KEY);
boolean ufaPadding = padding.getBoolean(_SAME_FOR_ALL_KEY);

// Margin

JSONObject marginTop = margin.getJSONObject(_TOP_KEY);
JSONObject marginRight = margin.getJSONObject(_RIGHT_KEY);
JSONObject marginBottom = margin.getJSONObject(_BOTTOM_KEY);
JSONObject marginLeft = margin.getJSONObject(_LEFT_KEY);

String marginTopValue = marginTop.getString(_VALUE_KEY) + marginTop.getString(_UNIT_KEY);
String marginRightValue = marginRight.getString(_VALUE_KEY) + marginRight.getString(_UNIT_KEY);
String marginBottomValue = marginBottom.getString(_VALUE_KEY) + marginBottom.getString(_UNIT_KEY);
String marginLeftValue = marginLeft.getString(_VALUE_KEY) + marginLeft.getString(_UNIT_KEY);

if (ufaMargin) {
	if (!_unitSet.contains(marginTopValue)) {
		finalCSS.add("margin: " + marginTopValue);
	}
}
else {
	if (!_unitSet.contains(marginTopValue)) {
		finalCSS.add("margin-top: " + marginTopValue);
	}

	if (!_unitSet.contains(marginRightValue)) {
		finalCSS.add("margin-right: " + marginRightValue);
	}

	if (!_unitSet.contains(marginBottomValue)) {
		finalCSS.add("margin-bottom: " + marginBottomValue);
	}

	if (!_unitSet.contains(marginLeftValue)) {
		finalCSS.add("margin-left: " + marginLeftValue);
	}
}

// Padding

JSONObject paddingTop = padding.getJSONObject(_TOP_KEY);
JSONObject paddingRight = padding.getJSONObject(_RIGHT_KEY);
JSONObject paddingBottom = padding.getJSONObject(_BOTTOM_KEY);
JSONObject paddingLeft = padding.getJSONObject(_LEFT_KEY);

String paddingTopValue = paddingTop.getString(_VALUE_KEY) + paddingTop.getString(_UNIT_KEY);
String paddingRightValue = paddingRight.getString(_VALUE_KEY) + paddingRight.getString(_UNIT_KEY);
String paddingBottomValue = paddingBottom.getString(_VALUE_KEY) + paddingBottom.getString(_UNIT_KEY);
String paddingLeftValue = paddingLeft.getString(_VALUE_KEY) + paddingLeft.getString(_UNIT_KEY);

if (ufaPadding) {
	if (!_unitSet.contains(paddingTopValue)) {
		finalCSS.add("padding: " + paddingTopValue);
	}
}
else {
	if (!_unitSet.contains(paddingTopValue)) {
		finalCSS.add("padding-top: " + paddingTopValue);
	}

	if (!_unitSet.contains(paddingRightValue)) {
		finalCSS.add("padding-right: " + paddingRightValue);
	}

	if (!_unitSet.contains(paddingBottomValue)) {
		finalCSS.add("padding-bottom: " + paddingBottomValue);
	}

	if (!_unitSet.contains(paddingLeftValue)) {
		finalCSS.add("padding-left: " + paddingLeftValue);
	}
}

// Text data

JSONObject textData = jsonObj.getJSONObject("textData");

String color = textData.getString("color");
String fontFamily = textData.getString("fontFamily");
String fontSize = textData.getString("fontSize");
String fontStyle = textData.getString("fontStyle");
String fontWeight = textData.getString("fontWeight");
String letterSpacing = textData.getString("letterSpacing");
String lineHeight = textData.getString("lineHeight");
String textAlign = textData.getString("textAlign");
String textDecoration = textData.getString("textDecoration");
String wordSpacing = textData.getString("wordSpacing");

if (Validator.isNotNull(color)) {
	finalCSS.add("color: " + color);
}

if (Validator.isNotNull(fontFamily)) {
	finalCSS.add("font-family: '" + fontFamily + "'");
}

if (Validator.isNotNull(fontSize)) {
	finalCSS.add("font-size: " + fontSize);
}

if (Validator.isNotNull(fontStyle)) {
	finalCSS.add("font-style: " + fontStyle);
}

if (Validator.isNotNull(fontWeight)) {
	finalCSS.add("font-weight: " + fontWeight);
}

if (Validator.isNotNull(letterSpacing)) {
	finalCSS.add("letter-spacing: " + letterSpacing);
}

if (Validator.isNotNull(lineHeight)) {
	finalCSS.add("line-height: " + lineHeight);
}

if (Validator.isNotNull(textAlign)) {
	finalCSS.add("text-align: " + textAlign);
}

if (Validator.isNotNull(textDecoration)) {
	finalCSS.add("text-decoration: " + textDecoration);
}

if (Validator.isNotNull(wordSpacing)) {
	finalCSS.add("word-spacing: " + wordSpacing);
}

// Advanced styling

JSONObject advancedData = jsonObj.getJSONObject("advancedData");

String customCSS = advancedData.getString("customCSS");

// Portlet data

JSONObject portletData = jsonObj.getJSONObject("portletData");

boolean showBorders = portletData.getBoolean("showBorders");

// Generated CSS

out.print("#p_p_id_" + portlet.getPortletId() + "_");

if (showBorders) {
	out.print(" .portlet");
}

out.print(" {\n");

String[] finalCSSArray = (String[])finalCSS.toArray(new String[0]);

String finalCSSString = StringUtil.merge(finalCSSArray, ";\n");

out.print(finalCSSString);

out.print("\n}\n");

// Advanced CSS

if (Validator.isNotNull(customCSS)) {
	out.print(customCSS);
}

              out.write('\n');
              out.write('\n');
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t\t");

				}
				catch (Exception e) {
					if (_log.isWarnEnabled()) {
						_log.warn(e.getMessage());
					}
				}
				
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t");
              int evalDoAfterBody = _jspx_th_c_005fif_005f3.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fif_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f3);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f3);
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t");

		}
		
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t</style>\r\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f2.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f2);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f2);
      out.write("\r\n");
      out.write("\r\n");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f4 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f4.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f4.setParent(null);
      _jspx_th_c_005fif_005f4.setTest( (layout != null) && Validator.isNotNull(layout.getCssText()) );
      int _jspx_eval_c_005fif_005f4 = _jspx_th_c_005fif_005f4.doStartTag();
      if (_jspx_eval_c_005fif_005f4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t<style type=\"text/css\">\r\n");
          out.write("\t\t");
          out.print( layout.getCssText() );
          out.write("\r\n");
          out.write("\t</style>\r\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f4.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f4);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f4);
      out.write("\r\n");
      out.write("\r\n");

/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("\tvar themeDisplay = {\n");
      out.write("\t\tgetCompanyId: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getCompanyId() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetDoAsUserIdEncoded: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getDoAsUserId() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetPlid: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getPlid() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetGroupId: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getPortletGroupId() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetUserId: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getUserId() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\n");
      out.write("\t\t");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f5 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f5.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f5.setParent(null);
      _jspx_th_c_005fif_005f5.setTest( layout != null );
      int _jspx_eval_c_005fif_005f5 = _jspx_th_c_005fif_005f5.doStartTag();
      if (_jspx_eval_c_005fif_005f5 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t\t\tgetLayoutId: function() {\n");
          out.write("\t\t\t\treturn \"");
          out.print( layout.getLayoutId() );
          out.write("\";\n");
          out.write("\t\t\t},\n");
          out.write("\t\t\tisPrivateLayout: function() {\n");
          out.write("\t\t\t\treturn \"");
          out.print( layout.isPrivateLayout() );
          out.write("\";\n");
          out.write("\t\t\t},\n");
          out.write("\t\t\tgetParentLayoutId: function() {\n");
          out.write("\t\t\t\treturn \"");
          out.print( layout.getParentLayoutId() );
          out.write("\";\n");
          out.write("\t\t\t},\n");
          out.write("\t\t");
          int evalDoAfterBody = _jspx_th_c_005fif_005f5.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f5);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f5);
      out.write("\n");
      out.write("\n");
      out.write("\t\tgetLanguageId: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( LanguageUtil.getLanguageId(request) );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tisFreeformLayout: function() {\n");
      out.write("\t\t\treturn ");
      out.print( themeDisplay.isFreeformLayout() );
      out.write(";\n");
      out.write("\t\t},\n");
      out.write("\t\tisSignedIn: function() {\n");
      out.write("\t\t\treturn ");
      out.print( themeDisplay.isSignedIn() );
      out.write(";\n");
      out.write("\t\t},\n");
      out.write("\t\tisStateExclusive: function() {\n");
      out.write("\t\t\treturn ");
      out.print( themeDisplay.isStateExclusive() );
      out.write(";\n");
      out.write("\t\t},\n");
      out.write("\t\tisStateMaximized: function() {\n");
      out.write("\t\t\treturn ");
      out.print( themeDisplay.isStateMaximized() );
      out.write(";\n");
      out.write("\t\t},\n");
      out.write("\t\tisStatePopUp: function() {\n");
      out.write("\t\t\treturn ");
      out.print( themeDisplay.isStatePopUp() );
      out.write(";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetPathContext: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getPathContext() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetPathMain: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getPathMain() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetPathThemeImages: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getPathThemeImages() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetPathThemeRoot: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getPathThemeRoot() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetURLHome: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( themeDisplay.getURLHome() );
      out.write("\";\n");
      out.write("\t\t},\n");
      out.write("\t\tgetSessionId: function() {\n");
      out.write("\t\t\treturn \"");
      out.print( session.getId() );
      out.write("\";\n");
      out.write("\t\t}\n");
      out.write("\t};\n");
      out.write("\n");
      out.write("\tvar mainPath = themeDisplay.getPathMain();\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("\n");
      //  c:choose
      org.apache.taglibs.standard.tag.common.core.ChooseTag _jspx_th_c_005fchoose_005f0 = (org.apache.taglibs.standard.tag.common.core.ChooseTag) _005fjspx_005ftagPool_005fc_005fchoose.get(org.apache.taglibs.standard.tag.common.core.ChooseTag.class);
      _jspx_th_c_005fchoose_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fchoose_005f0.setParent(null);
      int _jspx_eval_c_005fchoose_005f0 = _jspx_th_c_005fchoose_005f0.doStartTag();
      if (_jspx_eval_c_005fchoose_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write('\n');
          out.write('	');
          //  c:when
          org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_005fwhen_005f0 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _005fjspx_005ftagPool_005fc_005fwhen_005ftest.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
          _jspx_th_c_005fwhen_005f0.setPageContext(_jspx_page_context);
          _jspx_th_c_005fwhen_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f0);
          _jspx_th_c_005fwhen_005f0.setTest( ParamUtil.getBoolean(request, "js_fast_load", GetterUtil.getBoolean(PropsUtil.get(PropsUtil.JAVASCRIPT_FAST_LOAD))) );
          int _jspx_eval_c_005fwhen_005f0 = _jspx_th_c_005fwhen_005f0.doStartTag();
          if (_jspx_eval_c_005fwhen_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              out.write("\n");
              out.write("\t\t<script src=\"");
              out.print( themeDisplay.getPathJavaScript() );
              out.write("/everything_super_packed.js\" type=\"text/javascript\"></script>\n");
              out.write("\t");
              int evalDoAfterBody = _jspx_th_c_005fwhen_005f0.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fwhen_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f0);
          out.write('\n');
          out.write('	');
          //  c:otherwise
          org.apache.taglibs.standard.tag.common.core.OtherwiseTag _jspx_th_c_005fotherwise_005f0 = (org.apache.taglibs.standard.tag.common.core.OtherwiseTag) _005fjspx_005ftagPool_005fc_005fotherwise.get(org.apache.taglibs.standard.tag.common.core.OtherwiseTag.class);
          _jspx_th_c_005fotherwise_005f0.setPageContext(_jspx_page_context);
          _jspx_th_c_005fotherwise_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f0);
          int _jspx_eval_c_005fotherwise_005f0 = _jspx_th_c_005fotherwise_005f0.doStartTag();
          if (_jspx_eval_c_005fotherwise_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\n");
              out.write("\t\t");

		String[] javaScriptFiles = PropsUtil.getArray(PropsUtil.JAVASCRIPT_FILES);

		for (int i = 0; i < javaScriptFiles.length; i++) {
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t<script src=\"");
              out.print( themeDisplay.getPathJavaScript() );
              out.write('/');
              out.print( javaScriptFiles[i] );
              out.write("\" type=\"text/javascript\"></script>\n");
              out.write("\n");
              out.write("\t\t");

		}
		
              out.write('\n');
              out.write('\n');
              out.write('	');
              int evalDoAfterBody = _jspx_th_c_005fotherwise_005f0.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fotherwise_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fotherwise.reuse(_jspx_th_c_005fotherwise_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fotherwise.reuse(_jspx_th_c_005fotherwise_005f0);
          out.write('\n');
          int evalDoAfterBody = _jspx_th_c_005fchoose_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fchoose_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fchoose.reuse(_jspx_th_c_005fchoose_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fchoose.reuse(_jspx_th_c_005fchoose_005f0);
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f6 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f6.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f6.setParent(null);
      _jspx_th_c_005fif_005f6.setTest( GetterUtil.getBoolean(PropsUtil.get(PropsUtil.JAVASCRIPT_LOG_ENABLED)) );
      int _jspx_eval_c_005fif_005f6 = _jspx_th_c_005fif_005f6.doStartTag();
      if (_jspx_eval_c_005fif_005f6 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t<script src=\"");
          out.print( themeDisplay.getPathJavaScript() );
          out.write("/firebug/firebug.js\" type=\"text/javascript\"></script>\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f6.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f6);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f6);
      out.write("\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/javascript_cached?languageId=");
      out.print( themeDisplay.getLocale().toString() );
      out.write("&themeId=");
      out.print( themeDisplay.getThemeId() );
      out.write("&colorSchemeId=");
      out.print( themeDisplay.getColorSchemeId() );
      out.write("\"></script>\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("\n");
      out.write("\t");

	String currentURL = PortalUtil.getCurrentURL(request);
	
      out.write("\n");
      out.write("\n");
      out.write("\tfunction addPortlet(plid, portletId, doAsUserId) {\n");
      out.write("\t\tvar refreshPortletList = getRefreshPortletList();\n");
      out.write("\n");
      out.write("\t\tif (refreshPortletList[\"_\" + portletId]) {\n");
      out.write("\t\t\tself.location = \"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout?p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write('=');
      out.print( Constants.ADD );
      out.write("&referer=");
      out.print( HttpUtil.encodeURL(currentURL) );
      out.write("&refresh=1\";\n");
      out.write("\t\t}\n");
      out.write("\t\telse {\n");
      out.write("\t\t\tvar loadingDiv = document.createElement(\"div\");\n");
      out.write("\t\t\tvar container = document.getElementById(\"layout-column_column-1\");\n");
      out.write("\n");
      out.write("\t\t\tif (container == null) {\n");
      out.write("\t\t\t\treturn;\n");
      out.write("\t\t\t}\n");
      out.write("\n");
      out.write("\t\t\tloadingDiv.className = \"loading-animation\";\n");
      out.write("\n");
      out.write("\t\t\tcontainer.appendChild(loadingDiv);\n");
      out.write("\n");
      out.write("\t\t\tvar queryString = \"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout?p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write('=');
      out.print( Constants.ADD );
      out.write("&currentURL=");
      out.print( HttpUtil.encodeURL(currentURL) );
      out.write("\";\n");
      out.write("\n");
      out.write("\t\t\taddPortletHTML(queryString, loadingDiv);\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\tfunction showLayoutTemplates() {\n");
      out.write("\t\tvar message = Liferay.Popup(\n");
      out.write("\t\t\t{\n");
      out.write("\t\t\t\twidth: 700,\n");
      out.write("\t\t\t\tmodal: true,\n");
      out.write("\t\t\t\ttitle: \"");
      out.print( UnicodeLanguageUtil.get(pageContext, "layout") );
      out.write("\"\n");
      out.write("\t\t\t});\n");
      out.write("\n");
      out.write("\t\turl = \"");
      out.print( themeDisplay.getPathMain() );
      out.write("/layout_configuration/templates?p_l_id=");
      out.print( plid );
      out.write("&doAsUserId=");
      out.print( themeDisplay.getDoAsUserId() );
      out.write("\";\n");
      out.write("\n");
      out.write("\t\tAjaxUtil.update(url, message, {onComplete: function(){Liferay.Popup.center()}});\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\t_$J(document).ready(\n");
      out.write("\t\tfunction() {\n");
      out.write("\t\t\tLiferay.Util.addInputType();\n");
      out.write("\t\t\tLiferay.Util.addInputFocus();\n");
      out.write("\t\t}\n");
      out.write("\t);\n");
      out.write("\n");
      out.write("\tLiferay.Portlet.ready(\n");
      out.write("\t\tfunction(portletId, jQueryObj) {\n");
      out.write("\t\t\tLiferay.Util.addInputType(portletId, jQueryObj);\n");
      out.write("\t\t}\n");
      out.write("\t);\n");
      out.write("\n");
      out.write("\t");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f7 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f7.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f7.setParent(null);
      _jspx_th_c_005fif_005f7.setTest( !themeDisplay.isStatePopUp() );
      int _jspx_eval_c_005fif_005f7 = _jspx_th_c_005fif_005f7.doStartTag();
      if (_jspx_eval_c_005fif_005f7 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write('\n');
          out.write('	');
          out.write('	');
          //  c:if
          org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f8 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
          _jspx_th_c_005fif_005f8.setPageContext(_jspx_page_context);
          _jspx_th_c_005fif_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f7);
          _jspx_th_c_005fif_005f8.setTest( MessagingUtil.isJabberEnabled() && themeDisplay.isSignedIn() );
          int _jspx_eval_c_005fif_005f8 = _jspx_th_c_005fif_005f8.doStartTag();
          if (_jspx_eval_c_005fif_005f8 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t\t_$J(document).ready(\n");
              out.write("\t\t\t\tfunction() {\n");
              out.write("\t\t\t\t\tMessaging.init(\"");
              out.print( request.getRemoteUser() );
              out.write("\");\n");
              out.write("\t\t\t\t}\n");
              out.write("\t\t\t);\n");
              out.write("\t\t");
              int evalDoAfterBody = _jspx_th_c_005fif_005f8.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fif_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f8);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f8);
          out.write("\n");
          out.write("\n");
          out.write("\t\t");
          //  c:if
          org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f9 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
          _jspx_th_c_005fif_005f9.setPageContext(_jspx_page_context);
          _jspx_th_c_005fif_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f7);
          _jspx_th_c_005fif_005f9.setTest( GetterUtil.getBoolean(PropsUtil.get(PropsUtil.REVERSE_AJAX_ENABLED)) && themeDisplay.isSignedIn());
          int _jspx_eval_c_005fif_005f9 = _jspx_th_c_005fif_005f9.doStartTag();
          if (_jspx_eval_c_005fif_005f9 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t\tif (!Liferay.Browser.is_safari) {\n");
              out.write("\t\t\t\t_$J(document).last(\n");
              out.write("\t\t\t\t\tfunction() {\n");
              out.write("\t\t\t\t\t\tReverseAjax.initialize();\n");
              out.write("\t\t\t\t\t}\n");
              out.write("\t\t\t\t);\n");
              out.write("\t\t\t}\n");
              out.write("\t\t");
              int evalDoAfterBody = _jspx_th_c_005fif_005f9.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fif_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f9);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f9);
          out.write("\n");
          out.write("\n");
          out.write("\t\t");

		String scroll = ParamUtil.getString(request, "scroll");
		
          out.write("\n");
          out.write("\n");
          out.write("\t\t");
          //  c:if
          org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f10 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
          _jspx_th_c_005fif_005f10.setPageContext(_jspx_page_context);
          _jspx_th_c_005fif_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f7);
          _jspx_th_c_005fif_005f10.setTest( Validator.isNotNull(scroll) );
          int _jspx_eval_c_005fif_005f10 = _jspx_th_c_005fif_005f10.doStartTag();
          if (_jspx_eval_c_005fif_005f10 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t\t_$J(document).last(\n");
              out.write("\t\t\t\tfunction() {\n");
              out.write("\t\t\t\t\tdocument.getElementById(\"");
              out.print( scroll );
              out.write("\").scrollIntoView();\n");
              out.write("\t\t\t\t}\n");
              out.write("\t\t\t);\n");
              out.write("\t\t");
              int evalDoAfterBody = _jspx_th_c_005fif_005f10.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fif_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f10);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f10);
          out.write('\n');
          out.write('	');
          int evalDoAfterBody = _jspx_th_c_005fif_005f7.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f7);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f7);
      out.write("\n");
      out.write("\n");
      out.write("    ");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f11 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f11.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f11.setParent(null);
      _jspx_th_c_005fif_005f11.setTest( (layoutTypePortlet != null) );
      int _jspx_eval_c_005fif_005f11 = _jspx_th_c_005fif_005f11.doStartTag();
      if (_jspx_eval_c_005fif_005f11 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\n");
          out.write("\t\t");

        List portletIds = layoutTypePortlet.getPortletIds();
        
          out.write("\n");
          out.write("\n");
          out.write("        ");
          //  c:choose
          org.apache.taglibs.standard.tag.common.core.ChooseTag _jspx_th_c_005fchoose_005f1 = (org.apache.taglibs.standard.tag.common.core.ChooseTag) _005fjspx_005ftagPool_005fc_005fchoose.get(org.apache.taglibs.standard.tag.common.core.ChooseTag.class);
          _jspx_th_c_005fchoose_005f1.setPageContext(_jspx_page_context);
          _jspx_th_c_005fchoose_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f11);
          int _jspx_eval_c_005fchoose_005f1 = _jspx_th_c_005fchoose_005f1.doStartTag();
          if (_jspx_eval_c_005fchoose_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("            ");
              //  c:when
              org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_005fwhen_005f1 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _005fjspx_005ftagPool_005fc_005fwhen_005ftest.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
              _jspx_th_c_005fwhen_005f1.setPageContext(_jspx_page_context);
              _jspx_th_c_005fwhen_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f1);
              _jspx_th_c_005fwhen_005f1.setTest( portletIds.size() > 0 && !layoutTypePortlet.hasStateMax() );
              int _jspx_eval_c_005fwhen_005f1 = _jspx_th_c_005fwhen_005f1.doStartTag();
              if (_jspx_eval_c_005fwhen_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("                Liferay.Portlet.list = {");

                    for (int i = 0; i < portletIds.size(); i++) {
                        out.print("\"" + portletIds.get(i) + "\":1");

                        if (i < portletIds.size() - 1) {
                            out.print(",");
                        }
                    }
                
                  out.write("};\n");
                  out.write("            ");
                  int evalDoAfterBody = _jspx_th_c_005fwhen_005f1.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
              }
              if (_jspx_th_c_005fwhen_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f1);
              out.write("\n");
              out.write("            ");
              if (_jspx_meth_c_005fotherwise_005f1(_jspx_th_c_005fchoose_005f1, _jspx_page_context))
                return;
              out.write("\n");
              out.write("        ");
              int evalDoAfterBody = _jspx_th_c_005fchoose_005f1.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fchoose_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fchoose.reuse(_jspx_th_c_005fchoose_005f1);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fchoose.reuse(_jspx_th_c_005fchoose_005f1);
          out.write('\n');
          out.write('	');
          int evalDoAfterBody = _jspx_th_c_005fif_005f11.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f11);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f11);
      out.write('\n');
      out.write('\n');
      out.write('	');
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f12 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f12.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f12.setParent(null);
      _jspx_th_c_005fif_005f12.setTest( (layout != null) && (LayoutPermissionUtil.contains(permissionChecker, layout, ActionKeys.UPDATE)) );
      int _jspx_eval_c_005fif_005f12 = _jspx_th_c_005fif_005f12.doStartTag();
      if (_jspx_eval_c_005fif_005f12 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t\tjQuery(document).ready(\n");
          out.write("\t\t\tfunction() {\n");
          out.write("\t\t\t\tif (themeDisplay.isFreeformLayout()) {\n");
          out.write("\t\t\t\t\tLiferay.Freeform({\n");
          out.write("\t\t\t\t\t\tcolumnSelector: \"div[id^=layout-column_]\",\n");
          out.write("\t\t\t\t\t\tboxSelector: \".portlet-boundary\"\n");
          out.write("\t\t\t\t\t});\n");
          out.write("\t\t\t\t}\n");
          out.write("\t\t\t\telse {\n");
          out.write("\t\t\t\t\tLiferay.Columns({\n");
          out.write("\t\t\t\t\t\tcolumnSelector: \"div[id^=layout-column_]\",\n");
          out.write("\t\t\t\t\t\thandleSelector: \".portlet-title:first, .portlet-title-default:first\",\n");
          out.write("\t\t\t\t\t\tboxSelector: \".portlet-boundary\" ,\n");
          out.write("\t\t\t\t\t\tpositionClass: \"drop-position\",\n");
          out.write("\t\t\t\t\t\tareaClass: \"drop-area\",\n");
          out.write("\t\t\t\t\t\tonComplete: function(d) {\n");
          out.write("\t\t\t\t\t\t\tLiferay.Portlet.move(d);\n");
          out.write("\t\t\t\t\t\t}\n");
          out.write("\t\t\t\t\t});\n");
          out.write("\t\t\t\t}\n");
          out.write("\n");
          out.write("\t\t\t\tnew Liferay.Navigation(\n");
          out.write("\t\t\t\t\t{\n");
          out.write("\t\t\t\t\t\tlayoutIds: [");
          out.print( ListUtil.toString(layouts, "layoutId") );
          out.write("],\n");
          out.write("\t\t\t\t\t\tnavBlock: '#navigation'\n");
          out.write("\t\t\t\t\t}\n");
          out.write("\t\t\t\t);\n");
          out.write("\n");
          out.write("\t\t\t\t/*jQuery(\".journal-content-eip-text\").leditable(\n");
          out.write("\t\t\t\t\t\"");
          out.print( themeDisplay.getPathMain() );
          out.write("/journal_content/update_article_field\",\n");
          out.write("\t\t\t\t\t{\n");
          out.write("\t\t\t\t\t\tcancel: Liferay.Language.get('cancel'),\n");
          out.write("\t\t\t\t\t\tevent: 'click',\n");
          out.write("\t\t\t\t\t\tid: 'fieldName',\n");
          out.write("\t\t\t\t\t\tname: 'fieldData',\n");
          out.write("\t\t\t\t\t\tsubmit: Liferay.Language.get('ok'),\n");
          out.write("\t\t\t\t\t\ttype: 'textarea',\n");
          out.write("\t\t\t\t\t\twidth: '100%'\n");
          out.write("\t\t\t\t\t}\n");
          out.write("\t\t\t\t);\n");
          out.write("\n");
          out.write("\t\t\t\tjQuery(\".journal-content-eip-text_box\").leditable(\n");
          out.write("\t\t\t\t\t\"");
          out.print( themeDisplay.getPathMain() );
          out.write("/journal_content/update_article_field\",\n");
          out.write("\t\t\t\t\t{\n");
          out.write("\t\t\t\t\t\tcancel: Liferay.Language.get('cancel'),\n");
          out.write("\t\t\t\t\t\tevent: 'click',\n");
          out.write("\t\t\t\t\t\tid: 'fieldName',\n");
          out.write("\t\t\t\t\t\tname: 'fieldData',\n");
          out.write("\t\t\t\t\t\tsubmit: Liferay.Language.get('ok'),\n");
          out.write("\t\t\t\t\t\ttype: 'textarea',\n");
          out.write("\t\t\t\t\t\twidth: '100%'\n");
          out.write("\t\t\t\t\t}\n");
          out.write("\t\t\t\t);\n");
          out.write("\n");
          out.write("\t\t\t\tjQuery(\".journal-content-eip-text_area\").leditable(\n");
          out.write("\t\t\t\t\t\"");
          out.print( themeDisplay.getPathMain() );
          out.write("/journal_content/update_article_field\",\n");
          out.write("\t\t\t\t\t{\n");
          out.write("\t\t\t\t\t\tcancel: Liferay.Language.get('cancel'),\n");
          out.write("\t\t\t\t\t\tevent: 'click',\n");
          out.write("\t\t\t\t\t\tid: 'fieldName',\n");
          out.write("\t\t\t\t\t\tname: 'fieldData',\n");
          out.write("\t\t\t\t\t\tsubmit: Liferay.Language.get('ok'),\n");
          out.write("\t\t\t\t\t\ttype: 'fcktextarea',\n");
          out.write("\t\t\t\t\t\twidth: '100%'\n");
          out.write("\t\t\t\t\t}\n");
          out.write("\t\t\t\t);*/\n");
          out.write("\t\t\t}\n");
          out.write("\t\t);\n");
          out.write("\t");
          int evalDoAfterBody = _jspx_th_c_005fif_005f12.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f12);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f12);
      out.write("\n");
      out.write("\n");
      out.write("\tjQuery(document).ready(\n");
      out.write("\t\tfunction() {\n");
      out.write("\t\t\tLiferay.Dock.init();\n");
      out.write("\t\t}\n");
      out.write("\t);\n");
      out.write("</script>");
      out.write('\r');
      out.write('\n');

/**
 * Copyright (c) 2000-2006 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

      out.write("\r\n");
      out.write("\r\n");
      out.write("<script src=\"");
      out.print( themeDisplay.getPathJavaScript() );
      out.write("/cms_menu.js\" type=\"text/javascript\"></script>\r\n");
      out.write("<script src=\"");
      out.print( themeDisplay.getPathJavaScript() );
      out.write("/ui_utils.js\" type=\"text/javascript\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print( themeDisplay.getPathJavaScript() );
      out.write("/thickbox/thickbox.css\" type=\"text/css\" media=\"screen\" />\r\n");
      out.write("\r\n");
      out.write("\r\n");
 if ("print".equals(request.getParameter("p_p_mode"))) {
      out.write("\r\n");
      out.write("<div class=\"button-holder\" id=\"buttonDiv\" style=\"text-align:right\">\r\n");
      out.write("<a title=\"");
      out.print( LanguageUtil.get(pageContext, "print") );
      out.write("\" href=\"#\" onClick=\"document.getElementById('buttonDiv').style.display='none'; window.print();\">\r\n");
      out.write("<img alt=\"");
      out.print( LanguageUtil.get(pageContext, "print") );
      out.write("\" src=\"");
      out.print( themeDisplay.getPathThemeImage() );
      out.write("/common/print.png\">&nbsp;");
      out.print( LanguageUtil.get(pageContext, "print") );
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("\t");

}

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script language=\"JavaScript\">\r\n");
      out.write("//global variable to hold dynamic form fields mutual filtering information\r\n");
      out.write("var _top_filterTable = new Array();\r\n");
      out.write("// global variable to hold dynamic form fields original options settings\r\n");
      out.write("var _top_allFieldsOptions = new Array();\r\n");
      out.write("\r\n");
      out.write("// an object to hold information about the filtered values of a given form field\r\n");
      out.write("function _top_filterTableEntry(feature2, valuesArray)\r\n");
      out.write("{\r\n");
      out.write("   this.f2 = feature2;\r\n");
      out.write("   this.values = valuesArray;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("// the event callback function to filter out options of form fields based on a \r\n");
      out.write("// currently selected value for the given form element and the information stored\r\n");
      out.write("// in the filter table array, in the formatof filter table entry objects\r\n");
      out.write("function _top_updateOptionsFor(formName, formElement, selectedValue) \r\n");
      out.write(" {\r\n");
      out.write("     if (_top_filterTable[formName+\"_\"+formElement]) \r\n");
      out.write("    {\r\n");
      out.write("       var f;\r\n");
      out.write("       for (f=0; f<_top_filterTable[formName+\"_\"+formElement].length; f++)\r\n");
      out.write("       {\r\n");
      out.write("           var tableEntry = _top_filterTable[formName+\"_\"+formElement][f];\r\n");
      out.write("           var originalOptions = _top_allFieldsOptions[formName+\"_\"+tableEntry.f2];\r\n");
      out.write("           if (originalOptions != null) {\r\n");
      out.write("\t           var optionsToReduce = new Array();\r\n");
      out.write("\t           var o;\r\n");
      out.write("\t           for(o=0; o<originalOptions.length; o++) {\r\n");
      out.write("\t           \t\toptionsToReduce[o] = originalOptions[o];\r\n");
      out.write("\t           }\r\n");
      out.write("\t           // only do something if there is a filter defined for the given value\r\n");
      out.write("\t           if (tableEntry.values[selectedValue])\r\n");
      out.write("\t           {\r\n");
      out.write("\t\t           \t // make certain that the affected fields are set to the empty selection (value:0)\r\n");
      out.write("\t\t           \t // document.forms[formName].elements[tableEntry.f2].selectedIndex = 0;\r\n");
      out.write("\t\t           \t // in case this field had some filters of its own, recursively call the update function\r\n");
      out.write("\t\t           \t // updateOptionsFor(formName, tableEntry.f2, \"\");\r\n");
      out.write("\t\t           \t // then filter the options for the given selection\r\n");
      out.write("\t\t             var i;\r\n");
      out.write("\t\t             for (i=0; i < optionsToReduce.length; i++ ) {\r\n");
      out.write("\t\t                var option = optionsToReduce[i];\r\n");
      out.write("\t\t                var found = false;\r\n");
      out.write("\t\t                if (optionsToReduce[i].value == \"\") found = true;\r\n");
      out.write("\t\t                var j=0;\r\n");
      out.write("\t\t                while (!found && j<tableEntry.values[selectedValue].length)\r\n");
      out.write("\t\t                {\r\n");
      out.write("\t\t                      if (option.value == tableEntry.values[selectedValue][j])\r\n");
      out.write("\t\t                         found=true;\r\n");
      out.write("\t\t                      j++;\r\n");
      out.write("\t\t                }\r\n");
      out.write("\t\t                if (!found)\r\n");
      out.write("\t\t                {\r\n");
      out.write("\t\t                   optionsToReduce[i] = null;\r\n");
      out.write("\t\t                   //if (i == document.forms[formName].elements[tableEntry.f2].selectedIndex)\r\n");
      out.write("\t\t                   //\t\tdocument.forms[formName].elements[tableEntry.f2].selectedIndex = 0;\r\n");
      out.write("\t\t                }\r\n");
      out.write("\t\t             }\r\n");
      out.write("\t           }\r\n");
      out.write("\t           \r\n");
      out.write("\t           var filteredListBoxName = tableEntry.f2;\r\n");
      out.write("\t\t       var listObj = document.forms[formName].elements[filteredListBoxName];\r\n");
      out.write("\t\t       if (listObj.options == null && listObj.selectedIndex == null)\r\n");
      out.write("\t\t       {\r\n");
      out.write("\t\t       \t\t// this is the case if the filtered listbox is disabled, then its actual name has an extra underscore\r\n");
      out.write("\t\t       \t\tfilteredListBoxName = tableEntry.f2+\"_\";\r\n");
      out.write("\t\t       \t\tlistObj = document.forms[formName].elements[filteredListBoxName];\r\n");
      out.write("\t\t       }\r\n");
      out.write("\t\t       var oldOptions = document.forms[formName].elements[filteredListBoxName].options ;\r\n");
      out.write("\t\t       var selectedOption = \"\";\r\n");
      out.write("\t\t       if (listObj != null &&\r\n");
      out.write("\t\t           listObj.selectedIndex != null &&\r\n");
      out.write("\t\t           listObj.selectedIndex != 0)\r\n");
      out.write("\t\t       \t\tselectedOption = \"\"+listObj.options[listObj.selectedIndex].value;\r\n");
      out.write("\t\t       // remove all old entries\r\n");
      out.write("\t\t       while(oldOptions.length) { listObj.remove(0);}\r\n");
      out.write("\t\t       // copy over reduced entries\r\n");
      out.write("\t\t       var n, newSelectedIndex = 0, currentIndex = 0;\r\n");
      out.write("\t\t       for(n=0; n<optionsToReduce.length; n++)\r\n");
      out.write("\t\t       {\r\n");
      out.write("\t\t       \t\tif (optionsToReduce[n] != null)\r\n");
      out.write("\t\t       \t\t{\r\n");
      out.write("\t\t       \t\t\toldOptions.add(optionsToReduce[n]);\r\n");
      out.write("\t\t       \t\t\tif (optionsToReduce[n].value == selectedOption)\r\n");
      out.write("\t\t       \t\t\t{\r\n");
      out.write("\t\t       \t\t\t\tnewSelectedIndex = currentIndex;\r\n");
      out.write("\t\t       \t\t\t}\r\n");
      out.write("\t\t       \t\t\tcurrentIndex ++;\r\n");
      out.write("\t\t       \t\t}\r\n");
      out.write("\t\t       }\r\n");
      out.write("\t\t       listObj.selectedIndex = newSelectedIndex;\r\n");
      out.write("\t\t     }\r\n");
      out.write("\t     }\r\n");
      out.write("    }\r\n");
      out.write("    return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f13 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f13.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f13.setParent(null);
      _jspx_th_c_005fif_005f13.setTest( portlets != null );
      int _jspx_eval_c_005fif_005f13 = _jspx_th_c_005fif_005f13.doStartTag();
      if (_jspx_eval_c_005fif_005f13 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t");

	Set headerJavaScriptPortlets = CollectionFactory.getHashSet();
	Set headerJavaScriptPaths = CollectionFactory.getHashSet();

	for (int i = 0; i < portlets.size(); i++) {
		Portlet portlet = (Portlet)portlets.get(i);

		if (!headerJavaScriptPortlets.contains(portlet.getRootPortletId())) {
			headerJavaScriptPortlets.add(portlet.getRootPortletId());

			List headerJavaScriptList = portlet.getHeaderJavaScript();

			for (int j = 0; j < headerJavaScriptList.size(); j++) {
				String headerJavaScript = (String)headerJavaScriptList.get(j);

				String headerJavaScriptPath = portlet.getContextPath() + headerJavaScript;

				if (!headerJavaScriptPaths.contains(headerJavaScriptPath)) {
					headerJavaScriptPaths.add(headerJavaScriptPath);
	
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<script src=\"");
          out.print( headerJavaScriptPath );
          out.write("\" type=\"text/javascript\"></script>\r\n");
          out.write("\r\n");
          out.write("\t");

				}
			}
		}
	}
	
          out.write("\r\n");
          out.write("\r\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f13.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f13);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fif_005ftest.reuse(_jspx_th_c_005fif_005f13);
      out.write("\r\n");
      out.write("\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_liferay_002dtheme_005fmeta_002dtags_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-theme:meta-tags
    com.liferay.taglib.theme.MetaTagsTag _jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0 = (com.liferay.taglib.theme.MetaTagsTag) _005fjspx_005ftagPool_005fliferay_002dtheme_005fmeta_002dtags_005fnobody.get(com.liferay.taglib.theme.MetaTagsTag.class);
    _jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0.setParent(null);
    int _jspx_eval_liferay_002dtheme_005fmeta_002dtags_005f0 = _jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0.doStartTag();
    if (_jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dtheme_005fmeta_002dtags_005fnobody.reuse(_jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fmeta_002dtags_005fnobody.reuse(_jspx_th_liferay_002dtheme_005fmeta_002dtags_005f0);
    return false;
  }

  private boolean _jspx_meth_c_005fotherwise_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fchoose_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:otherwise
    org.apache.taglibs.standard.tag.common.core.OtherwiseTag _jspx_th_c_005fotherwise_005f1 = (org.apache.taglibs.standard.tag.common.core.OtherwiseTag) _005fjspx_005ftagPool_005fc_005fotherwise.get(org.apache.taglibs.standard.tag.common.core.OtherwiseTag.class);
    _jspx_th_c_005fotherwise_005f1.setPageContext(_jspx_page_context);
    _jspx_th_c_005fotherwise_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f1);
    int _jspx_eval_c_005fotherwise_005f1 = _jspx_th_c_005fotherwise_005f1.doStartTag();
    if (_jspx_eval_c_005fotherwise_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                _$J(document).ready(\n");
        out.write("                    function() {\n");
        out.write("                            Liferay.Portlet.processLast();\n");
        out.write("                    }\n");
        out.write("                );\n");
        out.write("            ");
        int evalDoAfterBody = _jspx_th_c_005fotherwise_005f1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_005fotherwise_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fc_005fotherwise.reuse(_jspx_th_c_005fotherwise_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fc_005fotherwise.reuse(_jspx_th_c_005fotherwise_005f1);
    return false;
  }
}
