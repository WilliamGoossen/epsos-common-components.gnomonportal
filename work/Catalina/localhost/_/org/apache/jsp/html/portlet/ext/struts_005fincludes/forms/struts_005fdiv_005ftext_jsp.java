package org.apache.jsp.html.portlet.ext.struts_005fincludes.forms;

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
import javax.portlet.RenderResponse;

public final class struts_005fdiv_005ftext_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(23);
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
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fsize_005freadonly_005fproperty_005fonchange_005falt_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fpassword_005fsize_005freadonly_005fproperty_005falt_005fnobody;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fsize_005freadonly_005fproperty_005fonchange_005falt_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fpassword_005fsize_005freadonly_005fproperty_005falt_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fsize_005freadonly_005fproperty_005fonchange_005falt_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fpassword_005fsize_005freadonly_005fproperty_005falt_005fnobody.release();
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
 try {
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();

	String formFieldName;
	String formFieldKey;
	boolean required;
	String formFieldType;
	String value = null;
	String fieldDateFormat="";
	boolean hidden;
	boolean readonly;
	String collectionName;
	String collectionAttrName;
	String collectionProperty;
	String collectionLabel;
	int field_size;
	int textAreaCols;
	int textAreaRows;
	int popupWidth;
	int popupHeight;
	String helpMessage = null;
	com.ext.sql.StrutsFormFields form_field;

	boolean textAreaHtmlFlag = false;
	String onChange = "";
	String lookupAction = "";
	boolean previous_fieldset = false;
	boolean secretField = false;
	String colour = null;
	String bgcolour = null;

	form_field = (com.ext.sql.StrutsFormFields) request.getAttribute(namespace+"_STRUTS_DIV_FIELD");
	String curFormName = (String)request.getAttribute(namespace+"_STRUTS_DIV_curFormName");
	
	formFieldName = form_field.getFormFieldName();
	formFieldKey = form_field.getFormFieldKey();
	formFieldType = form_field.getFormFieldType();
	fieldDateFormat = form_field.getDateFormat();
	if (fieldDateFormat == null || fieldDateFormat.equals(""))
		fieldDateFormat = CommonDefs.DATE_FORMAT_JSCRIPT;
	hidden = form_field.isHidden();
	readonly = form_field.isReadonly();
	required = form_field.isRequired();
	collectionName=form_field.getCollectionName();
	collectionAttrName = form_field.getCollectionAttrName();
	collectionProperty=form_field.getCollectionProperty();
	collectionLabel=form_field.getCollectionLabel();
	field_size = form_field.getField_size();
	textAreaCols = form_field.getTextAreaCols();
	textAreaRows = form_field.getTextAreaRows();
	popupWidth = form_field.getPopupWidth();
	popupHeight = form_field.getPopupHeight();
	secretField = form_field.isSecretTextField();
	helpMessage = form_field.getHelpMessage();
	value = form_field.getValue();
	if (Validator.isNull(value) && Validator.isNotNull(request.getParameter(formFieldName))) 
		value = request.getParameter(formFieldName);
	colour = form_field.getColour();
	bgcolour = colour;
	if (colour != null && colour.equals("inherit"))
		bgcolour = null;
	// force span colour to always be the default
	colour = "inherit";

  if (formFieldType.equals("text"))
 	{
 		 if (form_field.isDynamicField()) {
 		 	if (hidden)
	     	{ 
      out.write("\r\n");
      out.write("    \t \t<input type=\"hidden\" id=\"");
      out.print(formFieldName);
      out.write("\" name=\"");
      out.print(formFieldName);
      out.write("\" value=\"");
      out.print( (value!= null? value : "") );
      out.write("\">\r\n");
      out.write("     \t\t");

	     	}
        else if (readonly)
     		{ 
      out.write("\r\n");
      out.write("     \t\t\t<div class=\"ctrl-holder\">\r\n");
      out.write("\t\t\t\t     \t<label for=\"");
      out.print(formFieldName);
      out.write('"');
      out.write('>');
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write("</label>\r\n");
      out.write("\t\t\t\t     \t<input alt=\"");
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write("\" type=\"hidden\" id=\"");
      out.print(formFieldName);
      out.write("\" name=\"");
      out.print(formFieldName);
      out.write("\" value=\"");
      out.print( (value!= null? value : "") );
      out.write("\">\r\n");
      out.write("\t\t\t\t     \t");
      out.print( (value!= null? value : "") );
      out.write("\r\n");
      out.write("\t\t\t\t     \t");
 if (helpMessage != null) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t");
      //  liferay-ui:icon-help
      com.liferay.taglib.ui.IconHelpTag _jspx_th_liferay_002dui_005ficon_002dhelp_005f0 = (com.liferay.taglib.ui.IconHelpTag) _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.get(com.liferay.taglib.ui.IconHelpTag.class);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f0.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f0.setParent(null);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f0.setMessage( helpMessage );
      int _jspx_eval_liferay_002dui_005ficon_002dhelp_005f0 = _jspx_th_liferay_002dui_005ficon_002dhelp_005f0.doStartTag();
      if (_jspx_th_liferay_002dui_005ficon_002dhelp_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f0);
      out.write("\r\n");
      out.write("\t\t\t\t\t    ");
 } 
      out.write("\r\n");
      out.write("\t\t\t    \t \t");
      //  html:errors
      org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_005ferrors_005f0 = (org.apache.struts.taglib.html.ErrorsTag) _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
      _jspx_th_html_005ferrors_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005ferrors_005f0.setParent(null);
      _jspx_th_html_005ferrors_005f0.setProperty(formFieldName);
      int _jspx_eval_html_005ferrors_005f0 = _jspx_th_html_005ferrors_005f0.doStartTag();
      if (_jspx_th_html_005ferrors_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f0);
      out.write("\r\n");
      out.write("\t\t\t     \t</div>\r\n");
      out.write("\t\t\t     \t");

				} else { 
      out.write("\r\n");
      out.write("\t\t\t\t\t<div class=\"ctrl-holder\">\r\n");
      out.write("\t\t\t\t\t     \t<label for=\"");
      out.print(formFieldName);
      out.write('"');
      out.write('>');
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write("</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input alt=\"");
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write('"');
      out.write(' ');
 if (bgcolour != null) { 
      out.write(" style=\"background-color:");
      out.print( bgcolour );
      out.write('"');
      out.write(' ');
 } 
      out.write(" id=\"");
      out.print(formFieldName);
      out.write("\" type=\"text\" size=\"");
      out.print( ""+field_size );
      out.write("\" name=\"");
      out.print(formFieldName);
      out.write("\" value=\"");
      out.print( (value!= null? value : "") );
      out.write('"');
      out.write('>');
 if (required) { 
      out.write("<em>*</em>");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t\t     \t");
 if (helpMessage != null) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      //  liferay-ui:icon-help
      com.liferay.taglib.ui.IconHelpTag _jspx_th_liferay_002dui_005ficon_002dhelp_005f1 = (com.liferay.taglib.ui.IconHelpTag) _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.get(com.liferay.taglib.ui.IconHelpTag.class);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f1.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f1.setParent(null);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f1.setMessage( helpMessage );
      int _jspx_eval_liferay_002dui_005ficon_002dhelp_005f1 = _jspx_th_liferay_002dui_005ficon_002dhelp_005f1.doStartTag();
      if (_jspx_th_liferay_002dui_005ficon_002dhelp_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f1);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t    ");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t    \t \t");
      //  html:errors
      org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_005ferrors_005f1 = (org.apache.struts.taglib.html.ErrorsTag) _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
      _jspx_th_html_005ferrors_005f1.setPageContext(_jspx_page_context);
      _jspx_th_html_005ferrors_005f1.setParent(null);
      _jspx_th_html_005ferrors_005f1.setProperty(formFieldName);
      int _jspx_eval_html_005ferrors_005f1 = _jspx_th_html_005ferrors_005f1.doStartTag();
      if (_jspx_th_html_005ferrors_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f1);
      out.write("\r\n");
      out.write("\t\t\t\t   </div>\r\n");
      out.write("\t\t\t\t   ");
  	
				}
		}
		
		
		else {
    	onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";
     	if (hidden)
	     	{ 
      out.write("\r\n");
      out.write("    \t \t");
      //  html:hidden
      org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
      _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fhidden_005f0.setParent(null);
      _jspx_th_html_005fhidden_005f0.setProperty(formFieldName);
      int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
      if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      out.write("\r\n");
      out.write("     \t\t");

	     	}
        else if (readonly && !secretField) 
        { 
      out.write("\r\n");
      out.write("         \t\t<div class=\"ctrl-holder\">\r\n");
      out.write("\t\t\t\t     \t<label for=\"");
      out.print(formFieldName);
      out.write('"');
      out.write('>');
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write("</label>\r\n");
      out.write("\t\t\t\t     \t");
      //  html:hidden
      org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f1 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
      _jspx_th_html_005fhidden_005f1.setPageContext(_jspx_page_context);
      _jspx_th_html_005fhidden_005f1.setParent(null);
      _jspx_th_html_005fhidden_005f1.setProperty(formFieldName);
      int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
      if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      out.write("\r\n");
      out.write("\t\t\t\t     \t");
      //  bean:write
      org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f0 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
      _jspx_th_bean_005fwrite_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bean_005fwrite_005f0.setParent(null);
      _jspx_th_bean_005fwrite_005f0.setName(curFormName);
      _jspx_th_bean_005fwrite_005f0.setProperty(formFieldName);
      int _jspx_eval_bean_005fwrite_005f0 = _jspx_th_bean_005fwrite_005f0.doStartTag();
      if (_jspx_th_bean_005fwrite_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
      out.write("\r\n");
      out.write("\t\t\t\t     \t");
 if (helpMessage != null) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t");
      //  liferay-ui:icon-help
      com.liferay.taglib.ui.IconHelpTag _jspx_th_liferay_002dui_005ficon_002dhelp_005f2 = (com.liferay.taglib.ui.IconHelpTag) _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.get(com.liferay.taglib.ui.IconHelpTag.class);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f2.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f2.setParent(null);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f2.setMessage( helpMessage );
      int _jspx_eval_liferay_002dui_005ficon_002dhelp_005f2 = _jspx_th_liferay_002dui_005ficon_002dhelp_005f2.doStartTag();
      if (_jspx_th_liferay_002dui_005ficon_002dhelp_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f2);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f2);
      out.write("\r\n");
      out.write("\t\t\t\t\t    ");
 } 
      out.write("\r\n");
      out.write("\t\t\t    \t \t");
      //  html:errors
      org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_005ferrors_005f2 = (org.apache.struts.taglib.html.ErrorsTag) _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
      _jspx_th_html_005ferrors_005f2.setPageContext(_jspx_page_context);
      _jspx_th_html_005ferrors_005f2.setParent(null);
      _jspx_th_html_005ferrors_005f2.setProperty(formFieldName);
      int _jspx_eval_html_005ferrors_005f2 = _jspx_th_html_005ferrors_005f2.doStartTag();
      if (_jspx_th_html_005ferrors_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f2);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f2);
      out.write("\r\n");
      out.write("\t\t\t     \t</div>\r\n");
      out.write("\t\t\t     \t");

        }
        else
     		{
	     		if (!secretField) {
	     		
      out.write("\r\n");
      out.write("\t\t\t     \t\t<div class=\"ctrl-holder\">\r\n");
      out.write("\t\t\t\t\t     \t<label for=\"");
      out.print(formFieldName);
      out.write('"');
      out.write('>');
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write("</label>\r\n");
      out.write("\t\t\t\t\t     \t");
      //  html:text
      org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f0 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fsize_005freadonly_005fproperty_005fonchange_005falt_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
      _jspx_th_html_005ftext_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005ftext_005f0.setParent(null);
      _jspx_th_html_005ftext_005f0.setAlt( LanguageUtil.get(pageContext, formFieldKey) );
      _jspx_th_html_005ftext_005f0.setProperty(formFieldName);
      _jspx_th_html_005ftext_005f0.setSize( ""+field_size );
      _jspx_th_html_005ftext_005f0.setOnchange( onChange );
      _jspx_th_html_005ftext_005f0.setReadonly(readonly);
      int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
      if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005ftext_005fsize_005freadonly_005fproperty_005fonchange_005falt_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005ftext_005fsize_005freadonly_005fproperty_005fonchange_005falt_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
 if (required) { 
      out.write("<em>*</em>");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t\t     \t");
 if (helpMessage != null) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t");
      //  liferay-ui:icon-help
      com.liferay.taglib.ui.IconHelpTag _jspx_th_liferay_002dui_005ficon_002dhelp_005f3 = (com.liferay.taglib.ui.IconHelpTag) _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.get(com.liferay.taglib.ui.IconHelpTag.class);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f3.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f3.setParent(null);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f3.setMessage( helpMessage );
      int _jspx_eval_liferay_002dui_005ficon_002dhelp_005f3 = _jspx_th_liferay_002dui_005ficon_002dhelp_005f3.doStartTag();
      if (_jspx_th_liferay_002dui_005ficon_002dhelp_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f3);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f3);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t    ");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t    \t \t");
      //  html:errors
      org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_005ferrors_005f3 = (org.apache.struts.taglib.html.ErrorsTag) _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
      _jspx_th_html_005ferrors_005f3.setPageContext(_jspx_page_context);
      _jspx_th_html_005ferrors_005f3.setParent(null);
      _jspx_th_html_005ferrors_005f3.setProperty(formFieldName);
      int _jspx_eval_html_005ferrors_005f3 = _jspx_th_html_005ferrors_005f3.doStartTag();
      if (_jspx_th_html_005ferrors_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f3);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f3);
      out.write("\r\n");
      out.write("\t\t\t\t     \t</div>\r\n");
      out.write("\t\t\t\t");
 } else { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<div class=\"ctrl-holder\">\r\n");
      out.write("\t\t\t\t     \t<label for=\"");
      out.print(formFieldName);
      out.write('"');
      out.write('>');
      out.print( LanguageUtil.get(pageContext, formFieldKey) );
      out.write("</label>\r\n");
      out.write("\t\t\t\t     \t");
      //  html:password
      org.apache.struts.taglib.html.PasswordTag _jspx_th_html_005fpassword_005f0 = (org.apache.struts.taglib.html.PasswordTag) _005fjspx_005ftagPool_005fhtml_005fpassword_005fsize_005freadonly_005fproperty_005falt_005fnobody.get(org.apache.struts.taglib.html.PasswordTag.class);
      _jspx_th_html_005fpassword_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fpassword_005f0.setParent(null);
      _jspx_th_html_005fpassword_005f0.setAlt( LanguageUtil.get(pageContext, formFieldKey) );
      _jspx_th_html_005fpassword_005f0.setProperty(formFieldName);
      _jspx_th_html_005fpassword_005f0.setSize( ""+field_size );
      _jspx_th_html_005fpassword_005f0.setReadonly(readonly);
      int _jspx_eval_html_005fpassword_005f0 = _jspx_th_html_005fpassword_005f0.doStartTag();
      if (_jspx_th_html_005fpassword_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fpassword_005fsize_005freadonly_005fproperty_005falt_005fnobody.reuse(_jspx_th_html_005fpassword_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fpassword_005fsize_005freadonly_005fproperty_005falt_005fnobody.reuse(_jspx_th_html_005fpassword_005f0);
 if (required) { 
      out.write("<em>*</em>");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t     \t");
 if (helpMessage != null) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t");
      //  liferay-ui:icon-help
      com.liferay.taglib.ui.IconHelpTag _jspx_th_liferay_002dui_005ficon_002dhelp_005f4 = (com.liferay.taglib.ui.IconHelpTag) _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.get(com.liferay.taglib.ui.IconHelpTag.class);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f4.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f4.setParent(null);
      _jspx_th_liferay_002dui_005ficon_002dhelp_005f4.setMessage( helpMessage );
      int _jspx_eval_liferay_002dui_005ficon_002dhelp_005f4 = _jspx_th_liferay_002dui_005ficon_002dhelp_005f4.doStartTag();
      if (_jspx_th_liferay_002dui_005ficon_002dhelp_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f4);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dui_005ficon_002dhelp_005fmessage_005fnobody.reuse(_jspx_th_liferay_002dui_005ficon_002dhelp_005f4);
      out.write("\r\n");
      out.write("\t\t\t\t\t    ");
 } 
      out.write("\r\n");
      out.write("\t\t\t    \t \t");
      //  html:errors
      org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_005ferrors_005f4 = (org.apache.struts.taglib.html.ErrorsTag) _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
      _jspx_th_html_005ferrors_005f4.setPageContext(_jspx_page_context);
      _jspx_th_html_005ferrors_005f4.setParent(null);
      _jspx_th_html_005ferrors_005f4.setProperty(formFieldName);
      int _jspx_eval_html_005ferrors_005f4 = _jspx_th_html_005ferrors_005f4.doStartTag();
      if (_jspx_th_html_005ferrors_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f4);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005ferrors_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f4);
      out.write("\r\n");
      out.write("\t\t\t\t    </div>\r\n");
      out.write("\t\t\t\t");
 }
			}
		}
	}
	
} catch (Exception e) { e.printStackTrace(); } 
      out.write('\r');
      out.write('\n');
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
}
