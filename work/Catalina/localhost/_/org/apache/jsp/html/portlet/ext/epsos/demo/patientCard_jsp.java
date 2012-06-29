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

public final class patientCard_jsp extends org.apache.jasper.runtime.HttpJspBase
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
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid_005fexport;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid_005fexport = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid_005fexport.release();
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.release();
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
 EhrPatientClientDto patient = (EhrPatientClientDto) request.getAttribute("patient"); 

      out.write("\n");
      out.write("\n");
      out.write("<div class=\"uni-form\">\r\n");
      out.write("<fieldset class=\"inline-labels\">\n");
      out.write("<legend>\n");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.patientCard") );
      out.write("\n");
      out.write("</legend>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.surName") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getFamilyName() != null ? patient.getFamilyName() : "");
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.givenName") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getGivenName() != null? patient.getGivenName(): "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.middleName") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getMiddleName() != null ? patient.getMiddleName() : "");
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.title") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getNamePrefix() != null ? patient.getNamePrefix() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.sex") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getSex() != null ? LanguageUtil.get(pageContext, "epsos.demo.search.sex."+patient.getSex()) : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.birthDate") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getBirthdate() != null? 
    EpsosHelperService.dateFormat.format(patient.getBirthdate().toGregorianCalendar().getTime()) : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.street") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getStreetAddress() != null? patient.getStreetAddress() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.city") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getCity() != null? patient.getCity() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.country") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getCountry() != null? patient.getCountry() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.zipCode") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getZip() != null? patient.getZip() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.state") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getState() != null? patient.getState() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.phone_home") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getHomePhone() != null? patient.getHomePhone() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.phone_business") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getBusinessPhone() != null? patient.getBusinessPhone() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.mail_home") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getEmailHome() != null? patient.getEmailHome() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.mail_business") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getEmailBusiness() != null? patient.getEmailBusiness() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.placeOfBirth") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getBirthPlace() != null? patient.getBirthPlace() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.citizenship") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getCitizenship() != null? patient.getCitizenship() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.nationality") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getNationality() != null? patient.getNationality() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.accountData") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getAccountNumber() != null? patient.getAccountNumber() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.ssnNumber") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getSsnNumber() != null? patient.getSsnNumber() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.driversLicenceNumber") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getDrivingLicense() != null? patient.getDrivingLicense() : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.dateOfDeath") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getDeathdate() != null? EpsosHelperService.dateFormat.format(patient.getDeathdate().toGregorianCalendar().getTime()) : "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"ctrl-holder\">\n");
      out.write("<label>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.lastUpdate") );
      out.write("</label>\n");
      out.write("<span>\n");
      out.print( patient.getLastUpdtateTime() != null?  EpsosHelperService.dateFormat.format(patient.getLastUpdtateTime().toGregorianCalendar().getTime()): "" );
      out.write("\n");
      out.write("</span>\n");
      out.write("</div>\n");
      out.write("</fieldset>\n");
      out.write("\n");
      out.write("\n");
      out.write("<br />\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!--<fieldset class=\"inline-labels\">\n");
      out.write("<legend>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.patientIds") );
      out.write("</legend>\n");
      out.write("-->\n");
      out.write("<h3>");
      out.print( LanguageUtil.get(pageContext, "epsos.demo.search.patiendIds") );
      out.write("</h3>\n");
      out.write("\n");
      out.write("\n");
 if (patient.getPid() != null && patient.getPid().size() > 0) { 
	request.setAttribute("patientIds", patient.getPid());

      out.write('\n');
      out.write('\n');
      //  display:table
      org.displaytag.tags.TableTag _jspx_th_display_005ftable_005f0 = (org.displaytag.tags.TableTag) _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid_005fexport.get(org.displaytag.tags.TableTag.class);
      _jspx_th_display_005ftable_005f0.setPageContext(_jspx_page_context);
      _jspx_th_display_005ftable_005f0.setParent(null);
      _jspx_th_display_005ftable_005f0.setUid("pid");
      _jspx_th_display_005ftable_005f0.setName(new String("patientIds"));
      _jspx_th_display_005ftable_005f0.setRequestURI("//ext/epsos/demo/viewPatientCard?actionURL=true");
      _jspx_th_display_005ftable_005f0.setPagesize(25);
      _jspx_th_display_005ftable_005f0.setSort("list");
      _jspx_th_display_005ftable_005f0.setExport(true);
      _jspx_th_display_005ftable_005f0.setStyle("width: 100%;");
      int _jspx_eval_display_005ftable_005f0 = _jspx_th_display_005ftable_005f0.doStartTag();
      if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        java.lang.Object pid = null;
        java.lang.Integer pid_rowNum = null;
        if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_display_005ftable_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_display_005ftable_005f0.doInitBody();
        }
        pid = (java.lang.Object) _jspx_page_context.findAttribute("pid");
        pid_rowNum = (java.lang.Integer) _jspx_page_context.findAttribute("pid_rowNum");
        do {
          out.write('\n');
          out.write('\n');
 EhrPIDClientDto pidItem = (EhrPIDClientDto)pid; 
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
          if (_jspx_meth_display_005fcolumn_005f0(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          if (_jspx_meth_display_005fcolumn_005f1(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f2 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f2.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f2.setTitleKey("epsos.demo.pid.domain");
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
              out.print(  pidItem.getDomain().getAuthUniversalID() );
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
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.reuse(_jspx_th_display_005fcolumn_005f2);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.reuse(_jspx_th_display_005fcolumn_005f2);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f3 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f3.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f3.setTitleKey("epsos.demo.pid.domainType");
          _jspx_th_display_005fcolumn_005f3.setSortable(true);
          int _jspx_eval_display_005fcolumn_005f3 = _jspx_th_display_005fcolumn_005f3.doStartTag();
          if (_jspx_eval_display_005fcolumn_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_display_005fcolumn_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_display_005fcolumn_005f3.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_display_005fcolumn_005f3.doInitBody();
            }
            do {
              out.write('\n');
              out.print(  pidItem.getDomain().getAuthUniversalIDType() );
              out.write('\n');
              int evalDoAfterBody = _jspx_th_display_005fcolumn_005f3.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_display_005fcolumn_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_display_005fcolumn_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.reuse(_jspx_th_display_005fcolumn_005f3);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.reuse(_jspx_th_display_005fcolumn_005f3);
          out.write('\n');
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f4 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f4.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f4.setTitleKey("epsos.demo.pid.namespace");
          _jspx_th_display_005fcolumn_005f4.setSortable(true);
          int _jspx_eval_display_005fcolumn_005f4 = _jspx_th_display_005fcolumn_005f4.doStartTag();
          if (_jspx_eval_display_005fcolumn_005f4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_display_005fcolumn_005f4 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_display_005fcolumn_005f4.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_display_005fcolumn_005f4.doInitBody();
            }
            do {
              out.write('\n');
              out.print(  pidItem.getDomain().getAuthNamespaceID() );
              out.write('\n');
              int evalDoAfterBody = _jspx_th_display_005fcolumn_005f4.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_display_005fcolumn_005f4 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_display_005fcolumn_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.reuse(_jspx_th_display_005fcolumn_005f4);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable.reuse(_jspx_th_display_005fcolumn_005f4);
          out.write('\n');
          if (_jspx_meth_display_005fcolumn_005f5(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write('\n');
          out.write('\n');
          int evalDoAfterBody = _jspx_th_display_005ftable_005f0.doAfterBody();
          pid = (java.lang.Object) _jspx_page_context.findAttribute("pid");
          pid_rowNum = (java.lang.Integer) _jspx_page_context.findAttribute("pid_rowNum");
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_display_005ftable_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid_005fexport.reuse(_jspx_th_display_005ftable_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005frequestURI_005fpagesize_005fname_005fid_005fexport.reuse(_jspx_th_display_005ftable_005f0);
      out.write('\n');
      out.write('\n');
 }  
      out.write("\n");
      out.write("<!--</fieldset>-->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\n");
      out.write("<br>\n");
      out.write("\n");
      out.write("<a href=\"");
      out.print( redirect );
      out.write("\">\n");
      out.write("<img src=\"");
      out.print( themeDisplay.getPathThemeImage() );
      out.write("/common/back.png\" alt=\"back\">");
      out.print( LanguageUtil.get(pageContext, "back") );
      out.write("</a>\n");
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
    _jspx_th_display_005fsetProperty_005f1.setValue("PatientIds.xls");
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
    _jspx_th_display_005fsetProperty_005f3.setValue("PatientIds.pdf");
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
    _jspx_th_display_005fsetProperty_005f5.setValue("PatientIds.csv");
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
    _jspx_th_display_005fsetProperty_005f7.setValue("PatientIds.xml");
    int _jspx_eval_display_005fsetProperty_005f7 = _jspx_th_display_005fsetProperty_005f7.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f7);
    return false;
  }

  private boolean _jspx_meth_display_005fcolumn_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:column
    org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f0 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
    _jspx_th_display_005fcolumn_005f0.setPageContext(_jspx_page_context);
    _jspx_th_display_005fcolumn_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fcolumn_005f0.setProperty("patientID");
    _jspx_th_display_005fcolumn_005f0.setTitleKey("epsos.demo.pid.id");
    _jspx_th_display_005fcolumn_005f0.setSortable(true);
    int _jspx_eval_display_005fcolumn_005f0 = _jspx_th_display_005fcolumn_005f0.doStartTag();
    if (_jspx_th_display_005fcolumn_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f0);
    return false;
  }

  private boolean _jspx_meth_display_005fcolumn_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:column
    org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f1 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
    _jspx_th_display_005fcolumn_005f1.setPageContext(_jspx_page_context);
    _jspx_th_display_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fcolumn_005f1.setProperty("patientIDType");
    _jspx_th_display_005fcolumn_005f1.setTitleKey("epsos.demo.pid.type");
    _jspx_th_display_005fcolumn_005f1.setSortable(true);
    int _jspx_eval_display_005fcolumn_005f1 = _jspx_th_display_005fcolumn_005f1.doStartTag();
    if (_jspx_th_display_005fcolumn_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f1);
    return false;
  }

  private boolean _jspx_meth_display_005fcolumn_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_display_005ftable_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  display:column
    org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f5 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.get(org.displaytag.tags.ColumnTag.class);
    _jspx_th_display_005fcolumn_005f5.setPageContext(_jspx_page_context);
    _jspx_th_display_005fcolumn_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
    _jspx_th_display_005fcolumn_005f5.setProperty("ehrPIDType");
    _jspx_th_display_005fcolumn_005f5.setTitleKey("epsos.demo.pid.ehrType");
    _jspx_th_display_005fcolumn_005f5.setSortable(true);
    int _jspx_eval_display_005fcolumn_005f5 = _jspx_th_display_005fcolumn_005f5.doStartTag();
    if (_jspx_th_display_005fcolumn_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005ftitleKey_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_display_005fcolumn_005f5);
    return false;
  }
}
