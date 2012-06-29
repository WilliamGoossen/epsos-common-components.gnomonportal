package org.apache.jsp.html.portlet.portlet_005fcss;

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
import com.liferay.portal.util.LayoutLister;
import com.liferay.portal.util.LayoutView;

public final class view_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(26);
    _jspx_dependants.add("/html/portlet/portlet_css/init.jsp");
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
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.release();
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

      out.write('\n');
      out.write('\n');

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
      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("<div id=\"lfr-look-and-feel\">\n");
      out.write("\t<div id=\"portlet-set-properties\">\n");
      out.write("\t\t<ul class=\"tabs\">\n");
      out.write("\t\t\t<li>\n");
      out.write("\t\t\t\t<a href=\"#portlet-config\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f0(_jspx_page_context))
        return;
      out.write("</a>\n");
      out.write("\t\t\t</li>\n");
      out.write("\t\t\t<li>\n");
      out.write("\t\t\t\t<a href=\"#text-styles\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f1(_jspx_page_context))
        return;
      out.write("</a>\n");
      out.write("\t\t\t</li>\n");
      out.write("\t\t\t<li>\n");
      out.write("\t\t\t\t<a href=\"#background-styles\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f2(_jspx_page_context))
        return;
      out.write("</a>\n");
      out.write("\t\t\t</li>\n");
      out.write("\t\t\t<li>\n");
      out.write("\t\t\t\t<a href=\"#border-styles\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f3(_jspx_page_context))
        return;
      out.write("</a>\n");
      out.write("\t\t\t</li>\n");
      out.write("\t\t\t<li>\n");
      out.write("\t\t\t\t<a href=\"#spacing-styles\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f4(_jspx_page_context))
        return;
      out.write("</a>\n");
      out.write("\t\t\t</li>\n");
      out.write("\t\t\t<li>\n");
      out.write("\t\t\t\t<a href=\"#css-styling\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f5(_jspx_page_context))
        return;
      out.write("</a>\n");
      out.write("\t\t\t</li>\n");
      out.write("\t\t</ul>\n");
      out.write("\n");
      out.write("\t\t<form class=\"uni-form\" method=\"post\">\n");
      out.write("\t\t<input type=\"hidden\" name=\"portlet-area\" id=\"portlet-area\" />\n");
      out.write("\t\t<input type=\"hidden\" name=\"portlet-boundary-id\" id=\"portlet-boundary-id\" />\n");
      out.write("\n");
      out.write("\t\t<fieldset class=\"block-labels\" id=\"portlet-config\">\n");
      out.write("\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f6(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t<label for=\"custom-title\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f7(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t<input class=\"text-input\" id=\"custom-title\" type=\"text\" name=\"custom-title\" value=\"\" />\n");
      out.write("\n");
      out.write("\t\t\t\t<select id=\"lfr-portlet-language\" name=\"lfr-portlet-language\">\n");
      out.write("\n");
      out.write("\t\t\t\t\t");

					Locale[] locales = LanguageUtil.getAvailableLocales();

					for (int i = 0; i < locales.length; i++) {
					
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t<option value=\"");
      out.print( LocaleUtil.toLanguageId(locales[i]) );
      out.write('"');
      out.write('>');
      out.print( locales[i].getDisplayName(locales[i]) );
      out.write("</option>\n");
      out.write("\n");
      out.write("\t\t\t\t\t");

					}
					
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t</select>\n");
      out.write("\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t<label for=\"lfr-point-links\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f8(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t<select id=\"lfr-point-links\">\n");
      out.write("\t\t\t\t\t<option value=\"\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f9(_jspx_page_context))
        return;
      out.write("</option>\n");
      out.write("\n");
      out.write("\t\t\t\t\t");

					long linkToPlid = 0;

					LayoutLister layoutLister = new LayoutLister();

					String rootNodeName = layout.getGroup().getName();
					LayoutView layoutView = layoutLister.getLayoutView(layout.getGroup().getGroupId(), layout.getPrivateLayout(), rootNodeName, locale);

					List layoutList = layoutView.getList();

					for (int i = 0; i < layoutList.size(); i++) {

						// id | parentId | ls | obj id | name | img | depth

						String layoutDesc = (String)layoutList.get(i);

						String[] nodeValues = StringUtil.split(layoutDesc, "|");

						long objId = GetterUtil.getLong(nodeValues[3]);
						String name = nodeValues[4];

						int depth = 0;

						if (i != 0) {
							depth = GetterUtil.getInteger(nodeValues[6]);
						}

						for (int j = 0; j < depth; j++) {
							name = "-&nbsp;" + name;
						}

						Layout linkableLayout = null;

						try {
							if (objId > 0) {
								linkableLayout = LayoutLocalServiceUtil.getLayout(objId);
							}
						}
						catch (Exception e) {
						}

						if (linkableLayout != null) {
					
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t<option ");
      out.print( (linkableLayout.getPlid() == linkToPlid) ? "selected" : "" );
      out.write(" value=\"");
      out.print( linkableLayout.getPlid() );
      out.write('"');
      out.write('>');
      out.print( name );
      out.write("</option>\n");
      out.write("\n");
      out.write("\t\t\t\t\t");

						}
					}
					
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t</select>\n");
      out.write("\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t<label class=\"inline-label\">\n");
      out.write("\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f10(_jspx_page_context))
        return;
      out.write(" <input type=\"checkbox\" name=\"use-custom-title-checkbox\" id=\"use-custom-title-checkbox\" />\n");
      out.write("\t\t\t\t</label>\n");
      out.write("\n");
      out.write("\t\t\t\t<label class=\"inline-label\">\n");
      out.write("\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f11(_jspx_page_context))
        return;
      out.write(" <input id=\"show-borders\" name=\"show-borders\" type=\"checkbox\" />\n");
      out.write("\t\t\t\t</label>\n");
      out.write("\n");
      out.write("\t\t\t\t<p class=\"form-hint portlet-msg-info\" id=\"border-note\">\n");
      out.write("\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f12(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\t\t\t\t</p>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t<fieldset class=\"block-labels\" id=\"text-styles\">\n");
      out.write("\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f13(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"common col\">\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-family\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f14(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-family\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"Arial\">Arial</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"Georgia\">Georgia</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"Times New Roman\">Times New Roman</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"Tahoma\">Tahoma</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"Trebuchet MS\">Trebuchet MS</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"Verdana\">Verdana</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<p class=\"label\">\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f15(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\t\t\t\t\t</p>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<label class=\"inline-label\" for=\"lfr-font-bold\">Bold</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" name=\"lfr-font-bold\" id=\"lfr-font-bold\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<label class=\"inline-label\" for=\"lfr-font-italic\">Italic</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" name=\"lfr-font-italic\" id=\"lfr-font-italic\" />\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-size\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f16(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-size\" name=\"lfr-font-size\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.1em\">0.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.2em\">0.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.3em\">0.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.4em\">0.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.5em\">0.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.6em\">0.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.7em\">0.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.8em\">0.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.9em\">0.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1em\">1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.1em\">1.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.2em\">1.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.3em\">1.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.4em\">1.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.5em\">1.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.6em\">1.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.7em\">1.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.8em\">1.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.9em\">1.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2em\">2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.1em\">2.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.2em\">2.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.3em\">2.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.4em\">2.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.5em\">2.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.6em\">2.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.7em\">2.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.8em\">2.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.9em\">2.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3em\">3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.1em\">3.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.2em\">3.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.3em\">3.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.4em\">3.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.5em\">3.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.6em\">3.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.7em\">3.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.8em\">3.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.9em\">3.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4em\">4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.1em\">4.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.2em\">4.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.3em\">4.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.4em\">4.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.5em\">4.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.6em\">4.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.7em\">4.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.8em\">4.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.9em\">4.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5em\">5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.1em\">5.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.2em\">5.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.3em\">5.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.4em\">5.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.5em\">5.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.6em\">5.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.7em\">5.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.8em\">5.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.9em\">5.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6em\">6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.1em\">6.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.2em\">6.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.3em\">6.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.4em\">6.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.5em\">6.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.6em\">6.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.7em\">6.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.8em\">6.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.9em\">6.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7em\">7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.1em\">7.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.2em\">7.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.3em\">7.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.4em\">7.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.5em\">7.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.6em\">7.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.7em\">7.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.8em\">7.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.9em\">7.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8em\">8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.1em\">8.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.2em\">8.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.3em\">8.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.4em\">8.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.5em\">8.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.6em\">8.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.7em\">8.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.8em\">8.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.9em\">8.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9em\">9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.1em\">9.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.2em\">9.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.3em\">9.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.4em\">9.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.5em\">9.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.6em\">9.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.7em\">9.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.8em\">9.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.9em\">9.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10em\">10em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.1em\">10.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.2em\">10.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.3em\">10.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.4em\">10.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.5em\">10.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.6em\">10.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.7em\">10.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.8em\">10.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.9em\">10.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11em\">11em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.1em\">11.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.2em\">11.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.3em\">11.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.4em\">11.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.5em\">11.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.6em\">11.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.7em\">11.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.8em\">11.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.9em\">11.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"12em\">12em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-color\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f17(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input id=\"lfr-font-color\" name=\"lfr-font-color\" class=\"text-input\" type=\"text\" size=\"9\" value=\"\" />\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-align\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f18(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-align\" name=\"lfr-font-align\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"justify\">justify</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"left\">left</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"right\">right</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"center\">center</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-decoration\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f19(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-decoration\" name=\"lfr-font-decoration\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"none\">none</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"underline\">underline</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"overline\">overline</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"line-through\">line-through</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"extra col\">\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-space\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f20(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-space\" name=\"lfr-font-space\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-1em\">-1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.95em\">-0.95em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.9em\">-0.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.85em\">-0.85em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.8em\">-0.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.75em\">-0.75em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.7em\">-0.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.65em\">-0.65em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.6em\">-0.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.55em\">-0.55em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.5em\">-0.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.45em\">-0.45em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.4em\">-0.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.35em\">-0.35em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.3em\">-0.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.25em\">-0.25em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.2em\">-0.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.15em\">-0.15em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.1em\">-0.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-0.05em\">-0.05em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"normal\">normal</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.05em\">0.05em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.1em\">0.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.15em\">0.15em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.2em\">0.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.25em\">0.25em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.3em\">0.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.35em\">0.35em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.4em\">0.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.45em\">0.45em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.5em\">0.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.55em\">0.55em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.6em\">0.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.65em\">0.65em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.7em\">0.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.75em\">0.75em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.8em\">0.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.85em\">0.85em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.9em\">0.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.95em\">0.95em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1em\">1em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-leading\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f21(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-leading\" name=\"lfr-font-leading\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.1em\">0.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.2em\">0.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.3em\">0.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.4em\">0.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.5em\">0.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.6em\">0.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.7em\">0.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.8em\">0.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0.9em\">0.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1em\">1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.1em\">1.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.2em\">1.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.3em\">1.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.4em\">1.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.5em\">1.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.6em\">1.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.7em\">1.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.8em\">1.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1.9em\">1.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2em\">2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.1em\">2.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.2em\">2.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.3em\">2.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.4em\">2.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.5em\">2.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.6em\">2.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.7em\">2.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.8em\">2.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2.9em\">2.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3em\">3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.1em\">3.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.2em\">3.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.3em\">3.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.4em\">3.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.5em\">3.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.6em\">3.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.7em\">3.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.8em\">3.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3.9em\">3.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4em\">4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.1em\">4.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.2em\">4.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.3em\">4.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.4em\">4.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.5em\">4.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.6em\">4.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.7em\">4.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.8em\">4.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4.9em\">4.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5em\">5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.1em\">5.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.2em\">5.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.3em\">5.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.4em\">5.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.5em\">5.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.6em\">5.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.7em\">5.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.8em\">5.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5.9em\">5.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6em\">6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.1em\">6.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.2em\">6.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.3em\">6.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.4em\">6.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.5em\">6.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.6em\">6.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.7em\">6.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.8em\">6.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6.9em\">6.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7em\">7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.1em\">7.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.2em\">7.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.3em\">7.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.4em\">7.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.5em\">7.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.6em\">7.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.7em\">7.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.8em\">7.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7.9em\">7.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8em\">8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.1em\">8.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.2em\">8.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.3em\">8.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.4em\">8.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.5em\">8.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.6em\">8.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.7em\">8.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.8em\">8.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8.9em\">8.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9em\">9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.1em\">9.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.2em\">9.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.3em\">9.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.4em\">9.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.5em\">9.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.6em\">9.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.7em\">9.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.8em\">9.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9.9em\">9.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10em\">10em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.1em\">10.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.2em\">10.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.3em\">10.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.4em\">10.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.5em\">10.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.6em\">10.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.7em\">10.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.8em\">10.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10.9em\">10.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11em\">11em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.1em\">11.1em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.2em\">11.2em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.3em\">11.3em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.4em\">11.4em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.5em\">11.5em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.6em\">11.6em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.7em\">11.7em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.8em\">11.8em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11.9em\">11.9em</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"12em\">12em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-font-tracking\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f22(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-font-tracking\" name=\"lfr-font-tracking\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-10px\">-10px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-9px\">-9px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-8px\">-8px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-7px\">-7px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-6px\">-6px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-5px\">-5px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-4px\">-4px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-3px\">-3px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-2px\">-2px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"-1px\">-1px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"0\">0</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"1px\">1px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"2px\">2px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"3px\">3px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"4px\">4px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"5px\">5px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"6px\">6px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"7px\">7px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"8px\">8px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"9px\">9px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"10px\">10px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"11px\">11px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"12px\">12px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"13px\">13px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"14px\">14px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"15px\">15px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"16px\">16px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"17px\">17px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"18px\">18px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"19px\">19px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"20px\">20px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"21px\">21px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"22px\">22px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"23px\">23px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"24px\">24px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"25px\">25px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"26px\">26px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"27px\">27px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"28px\">28px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"29px\">29px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"30px\">30px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"31px\">31px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"32px\">32px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"33px\">33px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"34px\">34px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"35px\">35px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"36px\">36px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"37px\">37px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"38px\">38px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"39px\">39px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"40px\">40px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"41px\">41px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"42px\">42px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"43px\">43px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"44px\">44px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"45px\">45px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"46px\">46px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"47px\">47px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"48px\">48px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"49px\">49px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"50px\">50px</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t<fieldset class=\"block-labels\" id=\"background-styles\">\n");
      out.write("\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f23(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t<label for=\"lfr-bg-color\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f24(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t<input class=\"text-input\" id=\"lfr-bg-color\" name=\"lfr-bg-color\" size=\"9\" type=\"text\" value=\"#f00\" />\n");
      out.write("\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t");
      out.write("\n");
      out.write("\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t<fieldset class=\"block-labels\" id=\"border-styles\">\n");
      out.write("\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f25(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t<fieldset class=\"col\" id=\"lfr-border-width\">\n");
      out.write("\t\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f26(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-use-for-all-width\">\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f27(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t<input checked=\"checked\" class=\"lfr-use-for-all\" id=\"lfr-use-for-all-width\" type=\"checkbox\" />\n");
      out.write("\t\t\t\t\t</label>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-width-top\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f28(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-border-width-top\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-width-top-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-width-right\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f29(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input id=\"lfr-border-width-right\" class=\"text-input\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-width-right-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-width-bottom\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f30(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input id=\"lfr-border-width-bottom\" class=\"text-input\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-width-bottom-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-width-width\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f31(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input id=\"lfr-border-width-left\" class=\"text-input\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-width-left-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t\t<fieldset class=\"col\" id=\"lfr-border-style\">\n");
      out.write("\t\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f32(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-use-for-all-style\">\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f33(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t<input checked=\"checked\" class=\"lfr-use-for-all\" id=\"lfr-use-for-all-style\" type=\"checkbox\" />\n");
      out.write("\t\t\t\t\t</label>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-style-top\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f34(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-style-top\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dashed\">dashed</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"double\">double</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dotted\">dotted</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"groove\">groove</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"hidden\">hidden</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"inset\">inset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"outset\">outset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"ridge\">ridge</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"solid\">solid</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-style-right\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f35(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-style-right\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dashed\">dashed</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"double\">double</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dotted\">dotted</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"groove\">groove</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"hidden\">hidden</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"inset\">inset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"outset\">outset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"ridge\">ridge</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"solid\">solid</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-style-bottom\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f36(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-style-bottom\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dashed\">dashed</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"double\">double</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dotted\">dotted</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"groove\">groove</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"hidden\">hidden</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"inset\">inset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"outset\">outset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"ridge\">ridge</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"solid\">solid</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-style-left\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f37(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-border-style-left\">\n");
      out.write("\t\t\t\t\t\t<option value=\"\"></option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dashed\">dashed</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"double\">double</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"dotted\">dotted</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"groove\">groove</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"hidden\">hidden</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"inset\">inset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"outset\">outset</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"ridge\">ridge</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"solid\">solid</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t\t<fieldset class=\"col\" id=\"lfr-border-color\">\n");
      out.write("\t\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f38(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-use-for-all-color\">\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f39(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t<input checked=\"checked\" class=\"lfr-use-for-all\" id=\"lfr-use-for-all-color\" type=\"checkbox\" />\n");
      out.write("\t\t\t\t\t</label>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-color-top\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f40(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-border-color-top\" type=\"text\" />\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-color-right\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f41(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-border-color-right\" type=\"text\" />\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-color-bottom\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f42(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-border-color-bottom\" type=\"text\" />\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-border-color-left\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f43(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-border-color-left\" type=\"text\" />\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</fieldset>\n");
      out.write("\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t<fieldset class=\"spacing block-labels\" id=\"spacing-styles\">\n");
      out.write("\t\t\t<legend>Spacing</legend>\n");
      out.write("\n");
      out.write("\t\t\t<fieldset class=\"col\" id=\"lfr-padding\">\n");
      out.write("\t\t\t\t<legend>Padding</legend>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-use-for-all-padding\">\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f44(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t<input checked=\"checked\" class=\"lfr-use-for-all\" id=\"lfr-use-for-all-padding\" type=\"checkbox\" />\n");
      out.write("\t\t\t\t\t</label>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-padding-top\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f45(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-padding-top\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-padding-top-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-padding-right\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f46(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-padding-right\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-padding-right-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-padding-bottom\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f47(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-padding-bottom\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-padding-bottom-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-padding-left\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f48(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-padding-left\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-padding-left-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t\t<fieldset class=\"col\" id=\"lfr-margin\">\n");
      out.write("\t\t\t\t<legend>Margin</legend>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-use-for-all-margin\">\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_liferay_002dui_005fmessage_005f49(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t<input checked=\"checked\" class=\"lfr-use-for-all\" id=\"lfr-use-for-all-margin\" type=\"checkbox\" />\n");
      out.write("\t\t\t\t\t</label>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-margin-top\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f50(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-margin-top\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-margin-top-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-margin-right\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f51(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-margin-right\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-margin-right-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-margin-bottom\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f52(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-margin-bottom\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-margin-bottom-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t\t<label for=\"lfr-margin-left\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f53(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input class=\"text-input\" id=\"lfr-margin-left\" type=\"text\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t<select id=\"lfr-margin-left-unit\">\n");
      out.write("\t\t\t\t\t\t<option value=\"%\">%</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"px\">px</option>\n");
      out.write("\t\t\t\t\t\t<option value=\"em\">em</option>\n");
      out.write("\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</fieldset>\n");
      out.write("\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t<fieldset class=\"block-labels\" id=\"css-styling\">\n");
      out.write("\t\t\t<legend>");
      if (_jspx_meth_liferay_002dui_005fmessage_005f54(_jspx_page_context))
        return;
      out.write("</legend>\n");
      out.write("\n");
      out.write("\t\t\t<div class=\"ctrl-holder\">\n");
      out.write("\t\t\t\t<label for=\"lfr-custom-css\">");
      if (_jspx_meth_liferay_002dui_005fmessage_005f55(_jspx_page_context))
        return;
      out.write("</label>\n");
      out.write("\n");
      out.write("\t\t\t\t<textarea id=\"lfr-custom-css\"></textarea>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</fieldset>\n");
      out.write("\n");
      out.write("\t\t<div class=\"button-holder\">\n");
      out.write("\t\t\t<input id=\"lfr-lookfeel-save\" type=\"button\" value=\"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f56(_jspx_page_context))
        return;
      out.write("\" />\n");
      out.write("\t\t\t<input id=\"lfr-lookfeel-reset\" type=\"button\" value=\"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f57(_jspx_page_context))
        return;
      out.write("\" />\n");
      out.write("\t\t</div>\n");
      out.write("\n");
      out.write("\t\t</form>\n");
      out.write("\t</div>\n");
      out.write("</div>");
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

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f0 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f0.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f0.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f0.setKey("portlet-configuration");
    int _jspx_eval_liferay_002dui_005fmessage_005f0 = _jspx_th_liferay_002dui_005fmessage_005f0.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f0);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f1 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f1.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f1.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f1.setKey("text-styles");
    int _jspx_eval_liferay_002dui_005fmessage_005f1 = _jspx_th_liferay_002dui_005fmessage_005f1.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f1);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f2 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f2.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f2.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f2.setKey("background-styles");
    int _jspx_eval_liferay_002dui_005fmessage_005f2 = _jspx_th_liferay_002dui_005fmessage_005f2.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f2);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f3 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f3.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f3.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f3.setKey("border-styles");
    int _jspx_eval_liferay_002dui_005fmessage_005f3 = _jspx_th_liferay_002dui_005fmessage_005f3.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f3);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f4 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f4.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f4.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f4.setKey("margin-and-padding");
    int _jspx_eval_liferay_002dui_005fmessage_005f4 = _jspx_th_liferay_002dui_005fmessage_005f4.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f4);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f5(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f5 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f5.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f5.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f5.setKey("advanced-styling");
    int _jspx_eval_liferay_002dui_005fmessage_005f5 = _jspx_th_liferay_002dui_005fmessage_005f5.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f5);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f6(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f6 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f6.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f6.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f6.setKey("portlet-configuration");
    int _jspx_eval_liferay_002dui_005fmessage_005f6 = _jspx_th_liferay_002dui_005fmessage_005f6.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f6);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f7(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f7 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f7.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f7.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f7.setKey("portlet-title");
    int _jspx_eval_liferay_002dui_005fmessage_005f7 = _jspx_th_liferay_002dui_005fmessage_005f7.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f7);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f8(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f8 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f8.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f8.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f8.setKey("link-portlet-urls-to-page");
    int _jspx_eval_liferay_002dui_005fmessage_005f8 = _jspx_th_liferay_002dui_005fmessage_005f8.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f8);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f8);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f9(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f9 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f9.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f9.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f9.setKey("current-page");
    int _jspx_eval_liferay_002dui_005fmessage_005f9 = _jspx_th_liferay_002dui_005fmessage_005f9.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f9);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f10(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f10 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f10.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f10.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f10.setKey("use-custom-title");
    int _jspx_eval_liferay_002dui_005fmessage_005f10 = _jspx_th_liferay_002dui_005fmessage_005f10.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f10);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f10);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f11(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f11 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f11.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f11.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f11.setKey("show-borders");
    int _jspx_eval_liferay_002dui_005fmessage_005f11 = _jspx_th_liferay_002dui_005fmessage_005f11.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f11);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f11);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f12(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f12 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f12.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f12.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f12.setKey("this-change-will-only-be-shown-after-you-refresh-the-page");
    int _jspx_eval_liferay_002dui_005fmessage_005f12 = _jspx_th_liferay_002dui_005fmessage_005f12.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f12);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f12);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f13(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f13 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f13.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f13.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f13.setKey("text-styles");
    int _jspx_eval_liferay_002dui_005fmessage_005f13 = _jspx_th_liferay_002dui_005fmessage_005f13.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f13);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f13);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f14(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f14 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f14.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f14.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f14.setKey("font");
    int _jspx_eval_liferay_002dui_005fmessage_005f14 = _jspx_th_liferay_002dui_005fmessage_005f14.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f14);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f14);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f15(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f15 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f15.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f15.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f15.setKey("font-style");
    int _jspx_eval_liferay_002dui_005fmessage_005f15 = _jspx_th_liferay_002dui_005fmessage_005f15.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f15);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f15);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f16(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f16 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f16.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f16.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f16.setKey("size");
    int _jspx_eval_liferay_002dui_005fmessage_005f16 = _jspx_th_liferay_002dui_005fmessage_005f16.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f16);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f16);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f17(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f17 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f17.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f17.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f17.setKey("color");
    int _jspx_eval_liferay_002dui_005fmessage_005f17 = _jspx_th_liferay_002dui_005fmessage_005f17.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f17);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f17);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f18(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f18 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f18.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f18.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f18.setKey("alignment");
    int _jspx_eval_liferay_002dui_005fmessage_005f18 = _jspx_th_liferay_002dui_005fmessage_005f18.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f18);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f18);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f19(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f19 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f19.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f19.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f19.setKey("text-decoration");
    int _jspx_eval_liferay_002dui_005fmessage_005f19 = _jspx_th_liferay_002dui_005fmessage_005f19.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f19);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f19);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f20(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f20 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f20.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f20.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f20.setKey("word-spacing");
    int _jspx_eval_liferay_002dui_005fmessage_005f20 = _jspx_th_liferay_002dui_005fmessage_005f20.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f20);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f20);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f21(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f21 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f21.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f21.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f21.setKey("line-height");
    int _jspx_eval_liferay_002dui_005fmessage_005f21 = _jspx_th_liferay_002dui_005fmessage_005f21.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f21.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f21);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f21);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f22(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f22 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f22.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f22.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f22.setKey("letter-spacing");
    int _jspx_eval_liferay_002dui_005fmessage_005f22 = _jspx_th_liferay_002dui_005fmessage_005f22.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f22.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f22);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f22);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f23(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f23 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f23.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f23.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f23.setKey("background-styles");
    int _jspx_eval_liferay_002dui_005fmessage_005f23 = _jspx_th_liferay_002dui_005fmessage_005f23.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f23.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f23);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f23);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f24(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f24 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f24.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f24.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f24.setKey("background-color");
    int _jspx_eval_liferay_002dui_005fmessage_005f24 = _jspx_th_liferay_002dui_005fmessage_005f24.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f24.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f24);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f24);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f25(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f25 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f25.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f25.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f25.setKey("border-styling");
    int _jspx_eval_liferay_002dui_005fmessage_005f25 = _jspx_th_liferay_002dui_005fmessage_005f25.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f25.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f25);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f25);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f26(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f26 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f26.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f26.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f26.setKey("border-width");
    int _jspx_eval_liferay_002dui_005fmessage_005f26 = _jspx_th_liferay_002dui_005fmessage_005f26.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f26.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f26);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f26);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f27(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f27 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f27.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f27.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f27.setKey("same-for-all");
    int _jspx_eval_liferay_002dui_005fmessage_005f27 = _jspx_th_liferay_002dui_005fmessage_005f27.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f27.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f27);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f27);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f28(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f28 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f28.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f28.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f28.setKey("top");
    int _jspx_eval_liferay_002dui_005fmessage_005f28 = _jspx_th_liferay_002dui_005fmessage_005f28.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f28.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f28);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f28);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f29(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f29 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f29.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f29.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f29.setKey("right");
    int _jspx_eval_liferay_002dui_005fmessage_005f29 = _jspx_th_liferay_002dui_005fmessage_005f29.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f29.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f29);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f29);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f30(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f30 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f30.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f30.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f30.setKey("bottom");
    int _jspx_eval_liferay_002dui_005fmessage_005f30 = _jspx_th_liferay_002dui_005fmessage_005f30.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f30.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f30);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f30);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f31(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f31 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f31.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f31.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f31.setKey("left");
    int _jspx_eval_liferay_002dui_005fmessage_005f31 = _jspx_th_liferay_002dui_005fmessage_005f31.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f31.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f31);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f31);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f32(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f32 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f32.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f32.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f32.setKey("border-style");
    int _jspx_eval_liferay_002dui_005fmessage_005f32 = _jspx_th_liferay_002dui_005fmessage_005f32.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f32.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f32);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f32);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f33(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f33 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f33.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f33.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f33.setKey("same-for-all");
    int _jspx_eval_liferay_002dui_005fmessage_005f33 = _jspx_th_liferay_002dui_005fmessage_005f33.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f33.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f33);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f33);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f34(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f34 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f34.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f34.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f34.setKey("top");
    int _jspx_eval_liferay_002dui_005fmessage_005f34 = _jspx_th_liferay_002dui_005fmessage_005f34.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f34.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f34);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f34);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f35(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f35 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f35.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f35.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f35.setKey("right");
    int _jspx_eval_liferay_002dui_005fmessage_005f35 = _jspx_th_liferay_002dui_005fmessage_005f35.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f35.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f35);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f35);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f36(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f36 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f36.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f36.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f36.setKey("bottom");
    int _jspx_eval_liferay_002dui_005fmessage_005f36 = _jspx_th_liferay_002dui_005fmessage_005f36.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f36.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f36);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f36);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f37(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f37 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f37.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f37.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f37.setKey("left");
    int _jspx_eval_liferay_002dui_005fmessage_005f37 = _jspx_th_liferay_002dui_005fmessage_005f37.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f37.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f37);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f37);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f38(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f38 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f38.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f38.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f38.setKey("border-color");
    int _jspx_eval_liferay_002dui_005fmessage_005f38 = _jspx_th_liferay_002dui_005fmessage_005f38.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f38.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f38);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f38);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f39(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f39 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f39.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f39.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f39.setKey("same-for-all");
    int _jspx_eval_liferay_002dui_005fmessage_005f39 = _jspx_th_liferay_002dui_005fmessage_005f39.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f39.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f39);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f39);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f40(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f40 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f40.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f40.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f40.setKey("top");
    int _jspx_eval_liferay_002dui_005fmessage_005f40 = _jspx_th_liferay_002dui_005fmessage_005f40.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f40.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f40);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f40);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f41(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f41 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f41.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f41.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f41.setKey("right");
    int _jspx_eval_liferay_002dui_005fmessage_005f41 = _jspx_th_liferay_002dui_005fmessage_005f41.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f41.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f41);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f41);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f42(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f42 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f42.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f42.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f42.setKey("bottom");
    int _jspx_eval_liferay_002dui_005fmessage_005f42 = _jspx_th_liferay_002dui_005fmessage_005f42.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f42.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f42);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f42);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f43(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f43 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f43.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f43.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f43.setKey("left");
    int _jspx_eval_liferay_002dui_005fmessage_005f43 = _jspx_th_liferay_002dui_005fmessage_005f43.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f43.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f43);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f43);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f44(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f44 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f44.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f44.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f44.setKey("same-for-all");
    int _jspx_eval_liferay_002dui_005fmessage_005f44 = _jspx_th_liferay_002dui_005fmessage_005f44.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f44.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f44);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f44);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f45(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f45 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f45.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f45.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f45.setKey("top");
    int _jspx_eval_liferay_002dui_005fmessage_005f45 = _jspx_th_liferay_002dui_005fmessage_005f45.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f45.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f45);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f45);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f46(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f46 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f46.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f46.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f46.setKey("right");
    int _jspx_eval_liferay_002dui_005fmessage_005f46 = _jspx_th_liferay_002dui_005fmessage_005f46.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f46.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f46);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f46);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f47(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f47 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f47.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f47.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f47.setKey("bottom");
    int _jspx_eval_liferay_002dui_005fmessage_005f47 = _jspx_th_liferay_002dui_005fmessage_005f47.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f47.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f47);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f47);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f48(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f48 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f48.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f48.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f48.setKey("left");
    int _jspx_eval_liferay_002dui_005fmessage_005f48 = _jspx_th_liferay_002dui_005fmessage_005f48.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f48.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f48);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f48);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f49(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f49 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f49.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f49.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f49.setKey("same-for-all");
    int _jspx_eval_liferay_002dui_005fmessage_005f49 = _jspx_th_liferay_002dui_005fmessage_005f49.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f49.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f49);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f49);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f50(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f50 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f50.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f50.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f50.setKey("top");
    int _jspx_eval_liferay_002dui_005fmessage_005f50 = _jspx_th_liferay_002dui_005fmessage_005f50.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f50.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f50);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f50);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f51(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f51 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f51.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f51.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f51.setKey("right");
    int _jspx_eval_liferay_002dui_005fmessage_005f51 = _jspx_th_liferay_002dui_005fmessage_005f51.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f51.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f51);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f51);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f52(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f52 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f52.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f52.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f52.setKey("bottom");
    int _jspx_eval_liferay_002dui_005fmessage_005f52 = _jspx_th_liferay_002dui_005fmessage_005f52.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f52.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f52);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f52);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f53(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f53 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f53.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f53.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f53.setKey("left");
    int _jspx_eval_liferay_002dui_005fmessage_005f53 = _jspx_th_liferay_002dui_005fmessage_005f53.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f53.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f53);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f53);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f54(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f54 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f54.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f54.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f54.setKey("advanced-css-styling");
    int _jspx_eval_liferay_002dui_005fmessage_005f54 = _jspx_th_liferay_002dui_005fmessage_005f54.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f54.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f54);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f54);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f55(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f55 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f55.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f55.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f55.setKey("enter-in-your-custom-css");
    int _jspx_eval_liferay_002dui_005fmessage_005f55 = _jspx_th_liferay_002dui_005fmessage_005f55.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f55.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f55);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f55);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f56(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f56 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f56.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f56.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f56.setKey("save");
    int _jspx_eval_liferay_002dui_005fmessage_005f56 = _jspx_th_liferay_002dui_005fmessage_005f56.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f56.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f56);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f56);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f57(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f57 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f57.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f57.setParent(null);
    _jspx_th_liferay_002dui_005fmessage_005f57.setKey("reset");
    int _jspx_eval_liferay_002dui_005fmessage_005f57 = _jspx_th_liferay_002dui_005fmessage_005f57.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f57.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f57);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f57);
    return false;
  }
}
