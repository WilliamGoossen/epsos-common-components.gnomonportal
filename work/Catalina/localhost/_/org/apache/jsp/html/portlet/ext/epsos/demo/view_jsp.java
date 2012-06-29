package org.apache.jsp.html.portlet.ext.epsos.demo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Vector;
import java.util.Hashtable;
import java.util.Arrays;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.servlet.*;
import com.ext.portlet.topics.service.permission.*;
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
import gnomon.hibernate.model.gn.GnPortletSetting;
import com.liferay.portal.kernel.util.ParamUtil;
import java.util.Vector;
import java.util.Hashtable;
import gnomon.business.StringUtils;
import com.ext.portlet.permissions.service.PermissionsService;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import com.liferay.portlet.ActionRequestImpl;
import com.liferay.portlet.RenderRequestImpl;
import com.spirit.ehr.ws.client.generated.*;
import com.ext.portlet.epsos.*;
import com.ext.portlet.epsos.demo.PatientSearchForm;

public final class view_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(26);
    _jspx_dependants.add("/html/portlet/ext/epsos/demo/init.jsp");
    _jspx_dependants.add("/html/portlet/init.jsp");
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
    _jspx_dependants.add("/html/portlet/init-ext.jsp");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleClass_005fmethod_005fenctype_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fdefine_005fproperty_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005finsert_005fpage_005fflush;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fsortable;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fmedia;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005factionURL;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleClass_005fmethod_005fenctype_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fdefine_005fproperty_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005finsert_005fpage_005fflush = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fsortable = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fmedia = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005factionURL = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleClass_005fmethod_005fenctype_005faction.release();
    _005fjspx_005ftagPool_005fbean_005fdefine_005fproperty_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005ftiles_005finsert_005fpage_005fflush.release();
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid.release();
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fsortable.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fmedia.release();
    _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.release();
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005factionURL.release();
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

/**
 * Copyright (c) 2000-2006 Liferay, Inc. All rights reserved.
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
      out.write('\n');
      out.write('\n');
      //  portlet:defineObjects
      com.liferay.taglib.portlet.DefineObjectsTag _jspx_th_portlet_005fdefineObjects_005f0 = (com.liferay.taglib.portlet.DefineObjectsTag) _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.get(com.liferay.taglib.portlet.DefineObjectsTag.class);
      _jspx_th_portlet_005fdefineObjects_005f0.setPageContext(_jspx_page_context);
      _jspx_th_portlet_005fdefineObjects_005f0.setParent(null);
      int _jspx_eval_portlet_005fdefineObjects_005f0 = _jspx_th_portlet_005fdefineObjects_005f0.doStartTag();
      if (_jspx_th_portlet_005fdefineObjects_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.reuse(_jspx_th_portlet_005fdefineObjects_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.reuse(_jspx_th_portlet_005fdefineObjects_005f0);
      javax.portlet.PortletConfig portletConfig = null;
      java.lang.String portletName = null;
      javax.portlet.PortletPreferences portletPreferences = null;
      javax.portlet.PortletSession portletSession = null;
      javax.portlet.RenderRequest renderRequest = null;
      javax.portlet.RenderResponse renderResponse = null;
      portletConfig = (javax.portlet.PortletConfig) _jspx_page_context.findAttribute("portletConfig");
      portletName = (java.lang.String) _jspx_page_context.findAttribute("portletName");
      portletPreferences = (javax.portlet.PortletPreferences) _jspx_page_context.findAttribute("portletPreferences");
      portletSession = (javax.portlet.PortletSession) _jspx_page_context.findAttribute("portletSession");
      renderRequest = (javax.portlet.RenderRequest) _jspx_page_context.findAttribute("renderRequest");
      renderResponse = (javax.portlet.RenderResponse) _jspx_page_context.findAttribute("renderResponse");
      out.write('\n');
      out.write('\n');

PortletURL currentURLObj = PortletURLUtil.getCurrent(renderRequest, renderResponse);

//String currentURL = currentURLObj.toString();
String currentURL = PortalUtil.getCurrentURL(request);

      out.write('\n');
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

String defLang = com.liferay.portal.util.PropsUtil.get("locale.default");
//String redirect = (String)request.getParameter("redirect");
PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
String portletID = null;
if (portletRequest instanceof RenderRequest) {
	RenderRequestImpl req = (RenderRequestImpl)portletRequest;
	portletID = req.getPortletName();
} else {
	ActionRequestImpl req = (ActionRequestImpl)portletRequest;
	portletID = req.getPortletName();
}


boolean managetopic=true;

Boolean managetopics=(Boolean)request.getAttribute("managetopics");

if(managetopics!=null) {
	managetopic=managetopics.booleanValue();
}
else {
	String isTopicPermissions = GetterUtil.getString(PropsUtil.get("gn.topics.permissions"),"off");
int isTopics =0;
if(request.getAttribute("isTopics")!=null)
	isTopics= ((Integer) request.getAttribute("isTopics")).intValue();
String topicid = (String)request.getParameter("topicid");

	if(isTopicPermissions.equals("on") && isTopics!=GnPortletSetting.TOPICS_ENABLED_FALSE) {
	
	 if(topicid!=null && !topicid.equals("") && !com.ext.portlet.topics.service.permission.GnTopicPermission.contains(permissionChecker, new Integer(topicid), com.liferay.portal.kernel.security.permission.ActionExtKeys.MANAGECONTENT))
			managetopic=false;
			
	}
	}


      out.write('\n');
      out.write('\n');

	boolean hasAdmin = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADMINISTRATE) && managetopic;
	boolean hasPublish = PermissionsService.getInstance().isPortletPublishingEnabled(PortalUtil.getCompanyId(request),portletID) 
			&& PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.PUBLISH) && managetopic;
	boolean hasViewUnPublished = hasPublish; //PermissionsService.getInstance().isPortletPublishingEnabled(portletID) && PortletPermission.contains(permissionChecker, plid, portletID, ActionExtKeys.VIEW_UNPUBLISHED) && managetopic;
	boolean hasAdd = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADD) && managetopic;
	boolean hasEdit = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT) && managetopic;
	boolean hasDelete = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.DELETE) && managetopic;

      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      //  portlet:defineObjects
      com.liferay.taglib.portlet.DefineObjectsTag _jspx_th_portlet_005fdefineObjects_005f1 = (com.liferay.taglib.portlet.DefineObjectsTag) _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.get(com.liferay.taglib.portlet.DefineObjectsTag.class);
      _jspx_th_portlet_005fdefineObjects_005f1.setPageContext(_jspx_page_context);
      _jspx_th_portlet_005fdefineObjects_005f1.setParent(null);
      int _jspx_eval_portlet_005fdefineObjects_005f1 = _jspx_th_portlet_005fdefineObjects_005f1.doStartTag();
      if (_jspx_th_portlet_005fdefineObjects_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.reuse(_jspx_th_portlet_005fdefineObjects_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.reuse(_jspx_th_portlet_005fdefineObjects_005f1);
      portletConfig = (javax.portlet.PortletConfig) _jspx_page_context.findAttribute("portletConfig");
      portletName = (java.lang.String) _jspx_page_context.findAttribute("portletName");
      portletPreferences = (javax.portlet.PortletPreferences) _jspx_page_context.findAttribute("portletPreferences");
      portletSession = (javax.portlet.PortletSession) _jspx_page_context.findAttribute("portletSession");
      renderRequest = (javax.portlet.RenderRequest) _jspx_page_context.findAttribute("renderRequest");
      renderResponse = (javax.portlet.RenderResponse) _jspx_page_context.findAttribute("renderResponse");
      out.write("\n");
      out.write("\n");
      out.write("<script language=\"JavaScript\" src=\"/html/js/editor/modalwindow.js\"></script><noscript></noscript>\n");
      out.write("\n");

String redirect = (String)request.getParameter("redirect");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write(" <style type=\"text/css\">\n");
      out.write("\n");
      out.write("#left {\n");
      out.write("\tfloat: left;\n");
      out.write("\twidth: 270px;\n");
      out.write("}\n");
      out.write("\n");
      out.write("#right {\n");
      out.write("\tfloat: right;\n");
      out.write("\twidth: 270px;\n");
      out.write("}\n");
      out.write("\n");
      out.write("#middle { \n");
      out.write("\tfloat: left;\n");
      out.write("\twidth: 270px;\n");
      out.write("}\n");
      out.write(" </style>\n");
      out.write("\n");

String currentURL2 = currentURL;
String extraParams = "";
java.util.Enumeration params = request.getParameterNames();
while(params.hasMoreElements())
{
	String paramName = (String)params.nextElement();
	if (paramName.equals("struts_action") || paramName.startsWith("p_p_")) 
		continue;
	String paramValue = request.getParameter(paramName);
	if (Validator.isNull(paramValue)) paramValue= "";
	extraParams += "&"+paramName+"="+paramValue;
}

currentURL2 = currentURL +extraParams;

currentURL = currentURL2;

      out.write("\n");
      out.write("\n");
      out.write("<script language=\"JavaScript\">\n");
      out.write("\n");
      out.write("function countrySelectionChanged()\n");
      out.write("{\n");
      out.write("\tdocument.EpsosPatientSearchForm.elements['search'].value = false;\n");
      out.write("\tdocument.EpsosPatientSearchForm.elements['submitButton'].disabled=true;\n");
      out.write("\tdocument.EpsosPatientSearchForm.submit();\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\r\n");
      //  html:form
      org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleClass_005fmethod_005fenctype_005faction.get(org.apache.struts.taglib.html.FormTag.class);
      _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fform_005f0.setParent(null);
      _jspx_th_html_005fform_005f0.setAction("/ext/epsos/demo/view?actionURL=true");
      _jspx_th_html_005fform_005f0.setMethod("post");
      _jspx_th_html_005fform_005f0.setEnctype("multipart/form-data");
      _jspx_th_html_005fform_005f0.setStyleClass("uni-form");
      int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
      if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\n");
          out.write("<input type=\"hidden\" name=\"choiceMade\" value=\"true\">\n");
          out.write("\n");

String choiceMade = request.getParameter("choiceMade");
if (choiceMade == null || choiceMade.equals("false"))
{
	PatientSearchForm formBean = (PatientSearchForm) request.getAttribute("PatientSearchForm");
	
          out.write("<fieldset><legend>");
          out.print( LanguageUtil.get(pageContext, "epsos.demo.search.country") );
          out.write("</legend>\n");
          out.write("\t");

	for (int c=0 ; c< formBean.getCountryIds().length; c++ ) { 
		String countryid = formBean.getCountryIds()[c];
		String countryName = formBean.getCountryNames()[c];
		String divClass="";
		if (((c+1) % 3) ==0) divClass="left"; 
		if (((c+1) % 3) ==1) divClass="middle";
		if (((c+1) % 3) ==2) divClass="right";
		
          out.write("\n");
          out.write("\t\t\n");
          out.write("\t\t<div id=\"");
          out.print( divClass );
          out.write("\">\n");
          out.write("\t\t<input  type=\"radio\" name=\"country\" value=\"");
          out.print( countryid );
          out.write("\" onClick=\"countrySelectionChanged()\">\n");
          out.write("\t\t&nbsp;<img style=\"padding-top:20px;\" src=\"");
          out.print( themeDisplay.getPathThemeImage() );
          out.write("/language/");
          out.print( countryid );
          out.write("_flag.gif\" width=\"47\" height=\"26\" title=\"");
          out.print( countryName );
          out.write("\" alt=\"");
          out.print( countryName );
          out.write("\">\n");
          out.write("\t\t&nbsp;&nbsp;\n");
          out.write("\t\t</div>");

	 }
	
          out.write("\n");
          out.write("\t</fieldset>\n");
          out.write("\t<input type=\"hidden\" name=\"submitButton\" value=\"\">\n");
          out.write("\t<input type=\"hidden\" name=\"search\" value=\"false\">\n");
          out.write("\t");

}	
else {

          out.write('\n');
          out.write('\n');
          //  bean:define
          org.apache.struts.taglib.bean.DefineTag _jspx_th_bean_005fdefine_005f0 = (org.apache.struts.taglib.bean.DefineTag) _005fjspx_005ftagPool_005fbean_005fdefine_005fproperty_005fname_005fid_005fnobody.get(org.apache.struts.taglib.bean.DefineTag.class);
          _jspx_th_bean_005fdefine_005f0.setPageContext(_jspx_page_context);
          _jspx_th_bean_005fdefine_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
          _jspx_th_bean_005fdefine_005f0.setId("labels1");
          _jspx_th_bean_005fdefine_005f0.setName("EpsosPatientSearchForm");
          _jspx_th_bean_005fdefine_005f0.setProperty("sexNames");
          int _jspx_eval_bean_005fdefine_005f0 = _jspx_th_bean_005fdefine_005f0.doStartTag();
          if (_jspx_th_bean_005fdefine_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fbean_005fdefine_005fproperty_005fname_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fbean_005fdefine_005fproperty_005fname_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f0);
          java.lang.Object labels1 = null;
          labels1 = (java.lang.Object) _jspx_page_context.findAttribute("labels1");
          out.write('\n');

// correct the list of keys for translations to be shown properly
String[] labelsList1 = (String[])labels1;
for (int i=0; i<labelsList1.length; i++)
{
 	labelsList1[i] = LanguageUtil.get(pageContext, labelsList1[i]);
}

          out.write("\n");
          out.write("\n");
          out.write("<input type=\"hidden\" name=\"search\" value=\"true\">\n");
          out.write("\n");
          if (_jspx_meth_tiles_005finsert_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\n");
          out.write("\n");
          out.write("\n");
          out.write("<div class=\"block-labels\" style=\"text-align:right;\">\r\n");
          out.write("\t<div class=\"buttonHolder\">\r\n");
          out.write("<input type=\"submit\" name=\"submitButton\" value=\"");
          out.print( LanguageUtil.get(pageContext, "search") );
          out.write("\">\n");
          out.write("</div>\n");
          out.write("</div>\r\n");
          out.write("\n");
 } 
          out.write('\n');
          out.write('\n');
          int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fform_005fstyleClass_005fmethod_005fenctype_005faction.reuse(_jspx_th_html_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fform_005fstyleClass_005fmethod_005fenctype_005faction.reuse(_jspx_th_html_005fform_005f0);
      out.write('\n');
      out.write('\n');

String search = request.getParameter("search");
if (Validator.isNotNull(search) && search.equals("true")) {
List<EhrPatientClientDto> patientsList = (List<EhrPatientClientDto>)request.getAttribute("patientsList");
session.setAttribute("patients",patientsList);
if (patientsList != null && patientsList.size() > 0) { 
      out.write('\n');
      out.write('\n');
      //  display:table
      org.displaytag.tags.TableTag _jspx_th_display_005ftable_005f0 = (org.displaytag.tags.TableTag) _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid.get(org.displaytag.tags.TableTag.class);
      _jspx_th_display_005ftable_005f0.setPageContext(_jspx_page_context);
      _jspx_th_display_005ftable_005f0.setParent(null);
      _jspx_th_display_005ftable_005f0.setUid("patient");
      _jspx_th_display_005ftable_005f0.setName(new String("patientsList"));
      _jspx_th_display_005ftable_005f0.setRequestURI("//ext/epsos/demo/view?actionURL=true");
      _jspx_th_display_005ftable_005f0.setPagesize(25);
      _jspx_th_display_005ftable_005f0.setSort("list");
      _jspx_th_display_005ftable_005f0.setStyle("width: 100%;");
      int _jspx_eval_display_005ftable_005f0 = _jspx_th_display_005ftable_005f0.doStartTag();
      if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        java.lang.Object patient = null;
        java.lang.Integer patient_rowNum = null;
        if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_display_005ftable_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_display_005ftable_005f0.doInitBody();
        }
        patient = (java.lang.Object) _jspx_page_context.findAttribute("patient");
        patient_rowNum = (java.lang.Integer) _jspx_page_context.findAttribute("patient_rowNum");
        do {
          out.write('\n');
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f0(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f1(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f2(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f3(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f4(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f5(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f6(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fsetProperty_005f7(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          out.write('\n');
          out.write('\n');
  EhrPatientClientDto pat = (EhrPatientClientDto) pageContext.getAttribute("patient"); 
//session.setAttribute(request.getParameter("country") + "_" + "patient_" + pat.getPid().get(0).getPatientID() + "_" + pat.getPid().get(0).getPatientIDType(),pat);

          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f0 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f0.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f0.setProperty("givenName");
          _jspx_th_display_005fcolumn_005f0.setTitle( EpsosHelperService.getPortalTranslation("patient.data.givenname",user.getLanguageId()) );
          int _jspx_eval_display_005fcolumn_005f0 = _jspx_th_display_005fcolumn_005f0.doStartTag();
          if (_jspx_th_display_005fcolumn_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f0);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f1 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f1.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f1.setProperty("familyName");
          _jspx_th_display_005fcolumn_005f1.setTitle( EpsosHelperService.getPortalTranslation("patient.data.surname",user.getLanguageId()) );
          int _jspx_eval_display_005fcolumn_005f1 = _jspx_th_display_005fcolumn_005f1.doStartTag();
          if (_jspx_th_display_005fcolumn_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f1);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f1);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f2 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fsortable.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f2.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f2.setTitle( EpsosHelperService.getPortalTranslation("patient.data.birth.date",user.getLanguageId()) );
          _jspx_th_display_005fcolumn_005f2.setSortable(true);
          int _jspx_eval_display_005fcolumn_005f2 = _jspx_th_display_005fcolumn_005f2.doStartTag();
          if (_jspx_eval_display_005fcolumn_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_display_005fcolumn_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_display_005fcolumn_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_display_005fcolumn_005f2.doInitBody();
            }
            do {
              out.write('\n');
 if (pat.getBirthdate() != null ) {
	java.util.Date bday = pat.getBirthdate().toGregorianCalendar().getTime();
	 out.print(EpsosHelperService.dateFormat.format(bday));
}

              out.write('\n');
              int evalDoAfterBody = _jspx_th_display_005fcolumn_005f2.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_display_005fcolumn_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_display_005fcolumn_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fsortable.reuse(_jspx_th_display_005fcolumn_005f2);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fsortable.reuse(_jspx_th_display_005fcolumn_005f2);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f3 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f3.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f3.setProperty("streetAddress");
          _jspx_th_display_005fcolumn_005f3.setTitle( EpsosHelperService.getPortalTranslation("patient.data.street.address",user.getLanguageId()) );
          int _jspx_eval_display_005fcolumn_005f3 = _jspx_th_display_005fcolumn_005f3.doStartTag();
          if (_jspx_th_display_005fcolumn_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f3);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f3);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f4 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f4.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f4.setProperty("zip");
          _jspx_th_display_005fcolumn_005f4.setTitle( EpsosHelperService.getPortalTranslation("patient.data.code",user.getLanguageId()) );
          int _jspx_eval_display_005fcolumn_005f4 = _jspx_th_display_005fcolumn_005f4.doStartTag();
          if (_jspx_th_display_005fcolumn_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f4);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f4);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f5 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f5.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f5.setProperty("city");
          _jspx_th_display_005fcolumn_005f5.setTitle( EpsosHelperService.getPortalTranslation("patient.data.city",user.getLanguageId()) );
          int _jspx_eval_display_005fcolumn_005f5 = _jspx_th_display_005fcolumn_005f5.doStartTag();
          if (_jspx_th_display_005fcolumn_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f5);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f5);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f6 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f6.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f6.setProperty("country");
          _jspx_th_display_005fcolumn_005f6.setTitle( EpsosHelperService.getPortalTranslation("patient.data.country",user.getLanguageId()) );
          int _jspx_eval_display_005fcolumn_005f6 = _jspx_th_display_005fcolumn_005f6.doStartTag();
          if (_jspx_th_display_005fcolumn_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f6);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f6);
          out.write('\n');
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f7 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fmedia.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f7.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f7.setMedia("html");
          _jspx_th_display_005fcolumn_005f7.setStyle("white-space:nowrap;");
          int _jspx_eval_display_005fcolumn_005f7 = _jspx_th_display_005fcolumn_005f7.doStartTag();
          if (_jspx_eval_display_005fcolumn_005f7 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_display_005fcolumn_005f7 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_display_005fcolumn_005f7.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_display_005fcolumn_005f7.doInitBody();
            }
            do {
              out.write("\n");
              out.write("\n");
              out.write("<a target=\"new\" title=\"");
              out.print( EpsosHelperService.getPortalTranslation("navi.info.patient.agreement",user.getLanguageId()) );
              out.write("\" href=\"");
              //  portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f0 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_portlet_005factionURL_005f0.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005factionURL_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f7);
              _jspx_th_portlet_005factionURL_005f0.setWindowState( LiferayWindowState.EXCLUSIVE.toString() );
              int _jspx_eval_portlet_005factionURL_005f0 = _jspx_th_portlet_005factionURL_005f0.doStartTag();
              if (_jspx_eval_portlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005factionURL_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005factionURL_005f0.doInitBody();
                }
                do {
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f0(_jspx_th_portlet_005factionURL_005f0, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f1 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f1.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f0);
                  _jspx_th_portlet_005fparam_005f1.setName("patID");
                  _jspx_th_portlet_005fparam_005f1.setValue( patientsList.indexOf(pat)+""  );
                  int _jspx_eval_portlet_005fparam_005f1 = _jspx_th_portlet_005fparam_005f1.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f1);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f1);
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f2 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f2.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f0);
                  _jspx_th_portlet_005fparam_005f2.setName("country");
                  _jspx_th_portlet_005fparam_005f2.setValue( request.getParameter("country") );
                  int _jspx_eval_portlet_005fparam_005f2 = _jspx_th_portlet_005fparam_005f2.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f2);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f2);
                  out.write('\n');
                  int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f0.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005factionURL_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f0);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f0);
              out.write("\">\n");
              out.write("<img src=\"");
              out.print( themeDisplay.getPathThemeImage() );
              out.write("/common/print.png\" alt=\"consent\">\n");
              out.write("</a>\n");
              out.write("&nbsp;\n");
 	boolean allowCreateConsent = GetterUtil.getBoolean(gnomon.util.GnPropsUtil.get("portalb", "epsos.consent.allow.create"), false); 
              out.write('\n');
 if  (allowCreateConsent) {
              out.write("\n");
              out.write("<a title=\"");
              out.print( EpsosHelperService.getPortalTranslation("navi.info.patient.agreement",user.getLanguageId()) );
              out.write("\" href=\"javascript:openDialog('");
              //  portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f1 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_portlet_005factionURL_005f1.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005factionURL_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f7);
              _jspx_th_portlet_005factionURL_005f1.setWindowState( LiferayWindowState.POP_UP.toString() );
              int _jspx_eval_portlet_005factionURL_005f1 = _jspx_th_portlet_005factionURL_005f1.doStartTag();
              if (_jspx_eval_portlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005factionURL_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005factionURL_005f1.doInitBody();
                }
                do {
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f3(_jspx_th_portlet_005factionURL_005f1, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f4(_jspx_th_portlet_005factionURL_005f1, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f5(_jspx_th_portlet_005factionURL_005f1, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f6 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f6.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
                  _jspx_th_portlet_005fparam_005f6.setName("patID");
                  _jspx_th_portlet_005fparam_005f6.setValue( patientsList.indexOf(pat)+"" );
                  int _jspx_eval_portlet_005fparam_005f6 = _jspx_th_portlet_005fparam_005f6.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f6);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f6);
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f7(_jspx_th_portlet_005factionURL_005f1, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f8 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f8.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
                  _jspx_th_portlet_005fparam_005f8.setName("country");
                  _jspx_th_portlet_005fparam_005f8.setValue( request.getParameter("country") );
                  int _jspx_eval_portlet_005fparam_005f8 = _jspx_th_portlet_005fparam_005f8.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f8);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f8);
                  out.write('\n');
                  int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f1.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005factionURL_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f1);
              out.write("', 600,800);\">\n");
              out.write("<img src=\"");
              out.print( themeDisplay.getPathThemeImage() );
              out.write("/common/assign_user_permissions.png\" alt=\"consent\">\n");
              out.write("</a>\n");
              out.write("&nbsp;\n");
 } 
              out.write("\n");
              out.write("<a title=\"");
              out.print( LanguageUtil.get(pageContext, "epsos.patient.card.view") );
              out.write("\" href=\"");
              //  portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f2 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_portlet_005factionURL_005f2.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005factionURL_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f7);
              int _jspx_eval_portlet_005factionURL_005f2 = _jspx_th_portlet_005factionURL_005f2.doStartTag();
              if (_jspx_eval_portlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005factionURL_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005factionURL_005f2.doInitBody();
                }
                do {
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f9(_jspx_th_portlet_005factionURL_005f2, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f10(_jspx_th_portlet_005factionURL_005f2, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f11(_jspx_th_portlet_005factionURL_005f2, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f12 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f12.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
                  _jspx_th_portlet_005fparam_005f12.setName("patID");
                  _jspx_th_portlet_005fparam_005f12.setValue( patientsList.indexOf(pat)+"" );
                  int _jspx_eval_portlet_005fparam_005f12 = _jspx_th_portlet_005fparam_005f12.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f12);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f12);
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f13(_jspx_th_portlet_005factionURL_005f2, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f14 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f14.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
                  _jspx_th_portlet_005fparam_005f14.setName("country");
                  _jspx_th_portlet_005fparam_005f14.setValue( request.getParameter("country") );
                  int _jspx_eval_portlet_005fparam_005f14 = _jspx_th_portlet_005fparam_005f14.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f14);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f14);
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f15 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f15.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f15.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
                  _jspx_th_portlet_005fparam_005f15.setName("redirect");
                  _jspx_th_portlet_005fparam_005f15.setValue( currentURL );
                  int _jspx_eval_portlet_005fparam_005f15 = _jspx_th_portlet_005fparam_005f15.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f15);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f15);
                  out.write('\n');
                  int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f2.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005factionURL_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005factionURL.reuse(_jspx_th_portlet_005factionURL_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005factionURL.reuse(_jspx_th_portlet_005factionURL_005f2);
              out.write("\"><img src=\"");
              out.print( themeDisplay.getPathThemeImage() );
              out.write("/common/view.png\" alt=\"view\"></a>\n");
              out.write("&nbsp;\n");
 if (true || EpsosHelperService.getInstance().hasCurrentUserPhysicianRole(request)) { 
              out.write("\n");
              out.write("<a title=\"");
              out.print( EpsosHelperService.getPortalTranslation("navi.report.summary",user.getLanguageId()) );
              out.write("\" href=\"");
              //  portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f3 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_portlet_005factionURL_005f3.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005factionURL_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f7);
              int _jspx_eval_portlet_005factionURL_005f3 = _jspx_th_portlet_005factionURL_005f3.doStartTag();
              if (_jspx_eval_portlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005factionURL_005f3.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005factionURL_005f3.doInitBody();
                }
                do {
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f16(_jspx_th_portlet_005factionURL_005f3, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f17(_jspx_th_portlet_005factionURL_005f3, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f18(_jspx_th_portlet_005factionURL_005f3, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f19 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f19.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f19.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
                  _jspx_th_portlet_005fparam_005f19.setName("patID");
                  _jspx_th_portlet_005fparam_005f19.setValue( patientsList.indexOf(pat)+"" );
                  int _jspx_eval_portlet_005fparam_005f19 = _jspx_th_portlet_005fparam_005f19.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f19);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f19);
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f20(_jspx_th_portlet_005factionURL_005f3, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f21 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f21.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f21.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
                  _jspx_th_portlet_005fparam_005f21.setName("country");
                  _jspx_th_portlet_005fparam_005f21.setValue( request.getParameter("country") );
                  int _jspx_eval_portlet_005fparam_005f21 = _jspx_th_portlet_005fparam_005f21.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f21.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f21);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f21);
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f22 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f22.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f22.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
                  _jspx_th_portlet_005fparam_005f22.setName("redirect");
                  _jspx_th_portlet_005fparam_005f22.setValue( currentURL );
                  int _jspx_eval_portlet_005fparam_005f22 = _jspx_th_portlet_005fparam_005f22.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f22.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f22);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f22);
                  out.write('\n');
                  int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f3.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005factionURL_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005factionURL.reuse(_jspx_th_portlet_005factionURL_005f3);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005factionURL.reuse(_jspx_th_portlet_005factionURL_005f3);
              out.write("\"><img src=\"");
              out.print( themeDisplay.getPathThemeImage() );
              out.write("/common/all_pages.png\" alt=\"documents\"></a>\n");
 } 
              out.write('\n');
// if (EpsosHelperService.getInstance().hasCurrentUserPharmacistRole(request)) { 
              out.write('\n');
 if (true) { 
              out.write("\n");
              out.write("&nbsp;\n");
              out.write("<a title=\"");
              out.print( EpsosHelperService.getPortalTranslation("navi.report.prescription",user.getLanguageId()) );
              out.write("\" href=\"");
              //  portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f4 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_portlet_005factionURL_005f4.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005factionURL_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f7);
              int _jspx_eval_portlet_005factionURL_005f4 = _jspx_th_portlet_005factionURL_005f4.doStartTag();
              if (_jspx_eval_portlet_005factionURL_005f4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005factionURL_005f4 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005factionURL_005f4.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005factionURL_005f4.doInitBody();
                }
                do {
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f23(_jspx_th_portlet_005factionURL_005f4, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f24(_jspx_th_portlet_005factionURL_005f4, _jspx_page_context))
                    return;
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f25(_jspx_th_portlet_005factionURL_005f4, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f26 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f26.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f26.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
                  _jspx_th_portlet_005fparam_005f26.setName("country");
                  _jspx_th_portlet_005fparam_005f26.setValue( request.getParameter("country") );
                  int _jspx_eval_portlet_005fparam_005f26 = _jspx_th_portlet_005fparam_005f26.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f26.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f26);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f26);
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f27 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f27.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f27.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
                  _jspx_th_portlet_005fparam_005f27.setName("patID");
                  _jspx_th_portlet_005fparam_005f27.setValue( patientsList.indexOf(pat)+"" );
                  int _jspx_eval_portlet_005fparam_005f27 = _jspx_th_portlet_005fparam_005f27.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f27.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f27);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f27);
                  out.write('\n');
                  if (_jspx_meth_portlet_005fparam_005f28(_jspx_th_portlet_005factionURL_005f4, _jspx_page_context))
                    return;
                  out.write('\n');
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f29 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f29.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f29.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
                  _jspx_th_portlet_005fparam_005f29.setName("redirect");
                  _jspx_th_portlet_005fparam_005f29.setValue( currentURL );
                  int _jspx_eval_portlet_005fparam_005f29 = _jspx_th_portlet_005fparam_005f29.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f29.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f29);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f29);
                  out.write('\n');
                  int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f4.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005factionURL_005f4 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005factionURL_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005factionURL.reuse(_jspx_th_portlet_005factionURL_005f4);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005factionURL.reuse(_jspx_th_portlet_005factionURL_005f4);
              out.write("\"><img src=\"");
              out.print( themeDisplay.getPathThemeImage() );
              out.write("/common/manage_task.png\" alt=\"epsos.demo.prescription.list\"></a>\n");
 } 
              out.write('\n');
              out.write('\n');
              int evalDoAfterBody = _jspx_th_display_005fcolumn_005f7.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_display_005fcolumn_005f7 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_display_005fcolumn_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fmedia.reuse(_jspx_th_display_005fcolumn_005f7);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fmedia.reuse(_jspx_th_display_005fcolumn_005f7);
          out.write('\n');
          out.write('\n');
          out.write('\n');
          int evalDoAfterBody = _jspx_th_display_005ftable_005f0.doAfterBody();
          patient = (java.lang.Object) _jspx_page_context.findAttribute("patient");
          patient_rowNum = (java.lang.Integer) _jspx_page_context.findAttribute("patient_rowNum");
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_display_005ftable_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid.reuse(_jspx_th_display_005ftable_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid.reuse(_jspx_th_display_005ftable_005f0);
      out.write('\n');
      out.write('\n');
} else {
      out.write("\n");
      out.write("\t   <span class=\"portlet-msg-alert\">\n");
      out.print( EpsosHelperService.getInstance().getPortalTranslation("patient.list.no.patient",themeDisplay.getLanguageId()) );
      out.write("\n");
      out.write("</span>\n");
 }} 
      out.write('\n');
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

  private boolean _jspx_meth_tiles_005finsert_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:insert
    org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f0 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_005fpage_005fflush.get(org.apache.struts.taglib.tiles.InsertTag.class);
    _jspx_th_tiles_005finsert_005f0.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005finsert_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    _jspx_th_tiles_005finsert_005f0.setPage("/html/portlet/ext/struts_includes/struts_div_fields.jsp");
    _jspx_th_tiles_005finsert_005f0.setFlush(true);
    int _jspx_eval_tiles_005finsert_005f0 = _jspx_th_tiles_005finsert_005f0.doStartTag();
    if (_jspx_eval_tiles_005finsert_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write('\n');
        out.write('	');
        if (_jspx_meth_tiles_005fput_005f0(_jspx_th_tiles_005finsert_005f0, _jspx_page_context))
          return true;
        out.write('\n');
        out.write('	');
        if (_jspx_meth_tiles_005fput_005f1(_jspx_th_tiles_005finsert_005f0, _jspx_page_context))
          return true;
        out.write('\n');
        int evalDoAfterBody = _jspx_th_tiles_005finsert_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_tiles_005finsert_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005finsert_005fpage_005fflush.reuse(_jspx_th_tiles_005finsert_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005finsert_005fpage_005fflush.reuse(_jspx_th_tiles_005finsert_005f0);
    return false;
  }

  private boolean _jspx_meth_tiles_005fput_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_tiles_005finsert_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:put
    org.apache.struts.taglib.tiles.PutTag _jspx_th_tiles_005fput_005f0 = (org.apache.struts.taglib.tiles.PutTag) _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.get(org.apache.struts.taglib.tiles.PutTag.class);
    _jspx_th_tiles_005fput_005f0.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005fput_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_tiles_005finsert_005f0);
    _jspx_th_tiles_005fput_005f0.setName("formName");
    _jspx_th_tiles_005fput_005f0.setValue("EpsosPatientSearchForm");
    int _jspx_eval_tiles_005fput_005f0 = _jspx_th_tiles_005fput_005f0.doStartTag();
    if (_jspx_th_tiles_005fput_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f0);
    return false;
  }

  private boolean _jspx_meth_tiles_005fput_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_tiles_005finsert_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:put
    org.apache.struts.taglib.tiles.PutTag _jspx_th_tiles_005fput_005f1 = (org.apache.struts.taglib.tiles.PutTag) _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.get(org.apache.struts.taglib.tiles.PutTag.class);
    _jspx_th_tiles_005fput_005f1.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005fput_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_tiles_005finsert_005f0);
    _jspx_th_tiles_005fput_005f1.setName("useTabs");
    _jspx_th_tiles_005fput_005f1.setValue("false");
    int _jspx_eval_tiles_005fput_005f1 = _jspx_th_tiles_005fput_005f1.doStartTag();
    if (_jspx_th_tiles_005fput_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f1);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f0 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f0.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f0.setName("export.excel");
    _jspx_th_display_005fsetProperty_005f0.setValue("true");
    int _jspx_eval_display_005fsetProperty_005f0 = _jspx_th_display_005fsetProperty_005f0.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f0);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f1 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f1.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f1.setName("export.excel.filename");
    _jspx_th_display_005fsetProperty_005f1.setValue("Patients.xls");
    int _jspx_eval_display_005fsetProperty_005f1 = _jspx_th_display_005fsetProperty_005f1.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f1);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f2 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f2.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f2.setName("export.pdf");
    _jspx_th_display_005fsetProperty_005f2.setValue("true");
    int _jspx_eval_display_005fsetProperty_005f2 = _jspx_th_display_005fsetProperty_005f2.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f2);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f3 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f3.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f3.setName("export.pdf.filename");
    _jspx_th_display_005fsetProperty_005f3.setValue("Patients.pdf");
    int _jspx_eval_display_005fsetProperty_005f3 = _jspx_th_display_005fsetProperty_005f3.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f3);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f4 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f4.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f4.setName("export.csv");
    _jspx_th_display_005fsetProperty_005f4.setValue("true");
    int _jspx_eval_display_005fsetProperty_005f4 = _jspx_th_display_005fsetProperty_005f4.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f4);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f5 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f5.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f5.setName("export.csv.filename");
    _jspx_th_display_005fsetProperty_005f5.setValue("Patients.csv");
    int _jspx_eval_display_005fsetProperty_005f5 = _jspx_th_display_005fsetProperty_005f5.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f5);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f6 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f6.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f6.setName("export.xml");
    _jspx_th_display_005fsetProperty_005f6.setValue("true");
    int _jspx_eval_display_005fsetProperty_005f6 = _jspx_th_display_005fsetProperty_005f6.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f6);
    return false;
  }

  private boolean _jspx_meth_display_005fsetProperty_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:setProperty
    org.displaytag.tags.SetPropertyTag _jspx_th_display_005fsetProperty_005f7 = (org.displaytag.tags.SetPropertyTag) _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.get(org.displaytag.tags.SetPropertyTag.class);
    _jspx_th_display_005fsetProperty_005f7.setPageContext(_jspx_page_context);
    _jspx_th_display_005fsetProperty_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fsetProperty_005f7.setName("export.xml.filename");
    _jspx_th_display_005fsetProperty_005f7.setValue("Patients.xml");
    int _jspx_eval_display_005fsetProperty_005f7 = _jspx_th_display_005fsetProperty_005f7.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f7);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f0 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f0.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f0);
    _jspx_th_portlet_005fparam_005f0.setName("struts_action");
    _jspx_th_portlet_005fparam_005f0.setValue("/ext/epsos/demo/getConsentPDF");
    int _jspx_eval_portlet_005fparam_005f0 = _jspx_th_portlet_005fparam_005f0.doStartTag();
    if (_jspx_th_portlet_005fparam_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f0);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f3 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f3.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
    _jspx_th_portlet_005fparam_005f3.setName("struts_action");
    _jspx_th_portlet_005fparam_005f3.setValue("/ext/epsos/demo/viewPatientConsent");
    int _jspx_eval_portlet_005fparam_005f3 = _jspx_th_portlet_005fparam_005f3.doStartTag();
    if (_jspx_th_portlet_005fparam_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f3);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f4 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f4.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
    _jspx_th_portlet_005fparam_005f4.setName("accessAction");
    _jspx_th_portlet_005fparam_005f4.setValue("checkConsent");
    int _jspx_eval_portlet_005fparam_005f4 = _jspx_th_portlet_005fparam_005f4.doStartTag();
    if (_jspx_th_portlet_005fparam_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f4);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f5 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f5.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
    _jspx_th_portlet_005fparam_005f5.setName("reason");
    _jspx_th_portlet_005fparam_005f5.setValue("consent");
    int _jspx_eval_portlet_005fparam_005f5 = _jspx_th_portlet_005fparam_005f5.doStartTag();
    if (_jspx_th_portlet_005fparam_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f5);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f7 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f7.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
    _jspx_th_portlet_005fparam_005f7.setName("docType");
    _jspx_th_portlet_005fparam_005f7.setValue("consent");
    int _jspx_eval_portlet_005fparam_005f7 = _jspx_th_portlet_005fparam_005f7.doStartTag();
    if (_jspx_th_portlet_005fparam_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f7);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f9 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f9.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
    _jspx_th_portlet_005fparam_005f9.setName("struts_action");
    _jspx_th_portlet_005fparam_005f9.setValue("/ext/epsos/demo/checkPatientAccess");
    int _jspx_eval_portlet_005fparam_005f9 = _jspx_th_portlet_005fparam_005f9.doStartTag();
    if (_jspx_th_portlet_005fparam_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f9);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f10(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f10 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f10.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
    _jspx_th_portlet_005fparam_005f10.setName("accessAction");
    _jspx_th_portlet_005fparam_005f10.setValue("checkConfirmation");
    int _jspx_eval_portlet_005fparam_005f10 = _jspx_th_portlet_005fparam_005f10.doStartTag();
    if (_jspx_th_portlet_005fparam_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f10);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f10);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f11(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f11 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f11.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
    _jspx_th_portlet_005fparam_005f11.setName("forwardAction");
    _jspx_th_portlet_005fparam_005f11.setValue("/ext/epsos/demo/viewPatientCard");
    int _jspx_eval_portlet_005fparam_005f11 = _jspx_th_portlet_005fparam_005f11.doStartTag();
    if (_jspx_th_portlet_005fparam_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f11);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f11);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f13(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f13 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f13.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
    _jspx_th_portlet_005fparam_005f13.setName("docType");
    _jspx_th_portlet_005fparam_005f13.setValue("ps");
    int _jspx_eval_portlet_005fparam_005f13 = _jspx_th_portlet_005fparam_005f13.doStartTag();
    if (_jspx_th_portlet_005fparam_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f13);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f13);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f16(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f16 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f16.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f16.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
    _jspx_th_portlet_005fparam_005f16.setName("struts_action");
    _jspx_th_portlet_005fparam_005f16.setValue("/ext/epsos/demo/viewPatientDocuments");
    int _jspx_eval_portlet_005fparam_005f16 = _jspx_th_portlet_005fparam_005f16.doStartTag();
    if (_jspx_th_portlet_005fparam_005f16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f16);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f16);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f17(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f17 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f17.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f17.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
    _jspx_th_portlet_005fparam_005f17.setName("accessAction");
    _jspx_th_portlet_005fparam_005f17.setValue("checkConfirmation");
    int _jspx_eval_portlet_005fparam_005f17 = _jspx_th_portlet_005fparam_005f17.doStartTag();
    if (_jspx_th_portlet_005fparam_005f17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f17);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f17);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f18(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f18 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f18.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f18.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
    _jspx_th_portlet_005fparam_005f18.setName("forwardAction");
    _jspx_th_portlet_005fparam_005f18.setValue("/ext/epsos/demo/viewPatientDocuments");
    int _jspx_eval_portlet_005fparam_005f18 = _jspx_th_portlet_005fparam_005f18.doStartTag();
    if (_jspx_th_portlet_005fparam_005f18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f18);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f18);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f20(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f20 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f20.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f20.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
    _jspx_th_portlet_005fparam_005f20.setName("docType");
    _jspx_th_portlet_005fparam_005f20.setValue("ps");
    int _jspx_eval_portlet_005fparam_005f20 = _jspx_th_portlet_005fparam_005f20.doStartTag();
    if (_jspx_th_portlet_005fparam_005f20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f20);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f20);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f23(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f23 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f23.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f23.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
    _jspx_th_portlet_005fparam_005f23.setName("struts_action");
    _jspx_th_portlet_005fparam_005f23.setValue("/ext/epsos/demo/viewPatientPrescriptions");
    int _jspx_eval_portlet_005fparam_005f23 = _jspx_th_portlet_005fparam_005f23.doStartTag();
    if (_jspx_th_portlet_005fparam_005f23.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f23);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f23);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f24(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f24 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f24.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f24.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
    _jspx_th_portlet_005fparam_005f24.setName("accessAction");
    _jspx_th_portlet_005fparam_005f24.setValue("checkConfirmation");
    int _jspx_eval_portlet_005fparam_005f24 = _jspx_th_portlet_005fparam_005f24.doStartTag();
    if (_jspx_th_portlet_005fparam_005f24.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f24);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f24);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f25(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f25 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f25.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f25.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
    _jspx_th_portlet_005fparam_005f25.setName("forwardAction");
    _jspx_th_portlet_005fparam_005f25.setValue("/ext/epsos/demo/viewPatientPrescriptions");
    int _jspx_eval_portlet_005fparam_005f25 = _jspx_th_portlet_005fparam_005f25.doStartTag();
    if (_jspx_th_portlet_005fparam_005f25.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f25);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f25);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f28(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f28 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f28.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f28.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f4);
    _jspx_th_portlet_005fparam_005f28.setName("docType");
    _jspx_th_portlet_005fparam_005f28.setValue("ep");
    int _jspx_eval_portlet_005fparam_005f28 = _jspx_th_portlet_005fparam_005f28.doStartTag();
    if (_jspx_th_portlet_005fparam_005f28.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f28);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f28);
    return false;
  }
}
