package org.apache.jsp.html.portal;

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
import com.liferay.portal.CookieNotSupportedException;
import com.liferay.portal.LayoutFriendlyURLException;
import com.liferay.portal.LayoutHiddenException;
import com.liferay.portal.LayoutNameException;
import com.liferay.portal.LayoutParentLayoutIdException;
import com.liferay.portal.LayoutPermissionException;
import com.liferay.portal.LayoutTypeException;
import com.liferay.portal.NoSuchResourceException;
import com.liferay.portal.NoSuchUserException;
import com.liferay.portal.PortletActiveException;
import com.liferay.portal.RequiredLayoutException;
import com.liferay.portal.RequiredRoleException;
import com.liferay.portal.SendPasswordException;
import com.liferay.portal.UserActiveException;
import com.liferay.portal.UserEmailAddressException;
import com.liferay.portal.UserLockoutException;
import com.liferay.portal.UserPasswordException;
import com.liferay.portal.UserScreenNameException;
import com.liferay.portal.action.LoginAction;
import com.liferay.portal.security.auth.AuthException;
import com.liferay.portal.service.impl.ThemeLocalUtil;
import com.liferay.portal.service.permission.GroupPermissionUtil;
import com.liferay.portal.service.permission.LocationPermissionUtil;
import com.liferay.portal.service.permission.OrganizationPermissionUtil;
import com.liferay.portal.struts.PortletRequestProcessor;
import com.liferay.portal.util.LayoutLister;
import com.liferay.portal.util.LayoutView;
import com.liferay.portal.util.OpenIdUtil;
import com.liferay.portlet.journalcontent.util.JournalContentUtil;
import com.liferay.portlet.layoutconfiguration.util.RuntimePortletUtil;
import com.liferay.util.servlet.fileupload.LiferayFileUpload;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.taglib.tiles.ComponentConstants;
import org.apache.struts.tiles.ComponentDefinition;
import org.apache.struts.tiles.TilesUtil;
import org.openid4java.association.AssociationException;
import org.openid4java.consumer.ConsumerException;
import org.openid4java.discovery.DiscoveryException;
import org.openid4java.message.MessageException;

public final class javascript_005fcached_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(25);
    _jspx_dependants.add("/html/portal/init.jsp");
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
    _jspx_dependants.add("/html/portal/layout/view/portlet_js.jspf");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_005ftest;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fif_005ftest.release();
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
      out.write('\n');
      out.write('\n');

response.setContentType(ContentTypes.TEXT_JAVASCRIPT);

      out.write("\n");
      out.write("\n");
      out.write("function submitFormAlert(countdown) {\n");
      out.write("\tvar msg = \"");
      out.print( UnicodeLanguageUtil.get(pageContext, "this-form-has-already-been-submitted") );
      out.write("\";\n");
      out.write("\n");
      out.write("\talert(msg.replace(\"{0}\", countdown));\n");
      out.write("}\n");
      out.write("\n");

String[] calendarDays = CalendarUtil.getDays(locale, "EEEE");

      out.write("\n");
      out.write("\n");
      out.write("Calendar._DN = new Array(\n");
      out.write("\t\"");
      out.print( calendarDays[0] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[1] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[2] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[3] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[4] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[5] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[6] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[0] );
      out.write("\"\n");
      out.write(");\n");
      out.write("\n");

calendarDays = CalendarUtil.getDays(locale, "EEE");

      out.write("\n");
      out.write("\n");
      out.write("Calendar._SDN = new Array(\n");
      out.write("\t\"");
      out.print( calendarDays[0] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[1] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[2] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[3] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[4] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[5] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[6] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarDays[0] );
      out.write("\"\n");
      out.write(");\n");
      out.write("\n");

String[] calendarMonths = CalendarUtil.getMonths(locale);

      out.write("\n");
      out.write("\n");
      out.write("Calendar._MN = new Array(\n");
      out.write("\t\"");
      out.print( calendarMonths[0] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[1] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[2] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[3] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[4] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[5] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[6] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[7] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[8] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[9] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[10] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[11] );
      out.write("\"\n");
      out.write(");\n");
      out.write("\n");

calendarMonths = CalendarUtil.getMonths(locale, "MMM");

      out.write("\n");
      out.write("\n");
      out.write("Calendar._SMN = new Array(\n");
      out.write("\t\"");
      out.print( calendarMonths[0] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[1] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[2] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[3] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[4] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[5] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[6] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[7] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[8] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[9] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[10] );
      out.write("\",\n");
      out.write("\t\"");
      out.print( calendarMonths[11] );
      out.write("\"\n");
      out.write(");\n");
      out.write("\n");
      out.write("Calendar._TT = {};\n");
      out.write("\n");
      out.write("Calendar._TT[\"ABOUT\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f0(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"ABOUT\"] = Calendar._TT[\"ABOUT\"].replace(\"{0}\", String.fromCharCode(0x2039));\n");
      out.write("Calendar._TT[\"ABOUT\"] = Calendar._TT[\"ABOUT\"].replace(\"{1}\", String.fromCharCode(0x203a));\n");
      out.write("\n");
      out.write("Calendar._TT[\"ABOUT_TIME\"] = \"\";\n");
      out.write("Calendar._TT[\"CLOSE\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f1(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"DAY_FIRST\"] = \"Display %s First\";\n");
      out.write("Calendar._TT[\"DRAG_TO_MOVE\"] = \"\";\n");
      out.write("Calendar._TT[\"GO_TODAY\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f2(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"INFO\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f3(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"NEXT_MONTH\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f4(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"NEXT_YEAR\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f5(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"PART_TODAY\"] = \"\";\n");
      out.write("Calendar._TT[\"PREV_MONTH\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f6(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"PREV_YEAR\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f7(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"SEL_DATE\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f8(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"SUN_FIRST\"] = \"\";\n");
      out.write("Calendar._TT[\"TIME_PART\"] = \"\";\n");
      out.write("Calendar._TT[\"TODAY\"] = \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f9(_jspx_page_context))
        return;
      out.write("\";\n");
      out.write("Calendar._TT[\"WK\"] = \"\";\n");
      out.write("\n");
      out.write("Calendar._TT[\"DEF_DATE_FORMAT\"] = \"%Y-%m-%d\";\n");
      out.write("Calendar._TT[\"TT_DATE_FORMAT\"] = \"%a, %b %e\";\n");
      out.write("\n");
      out.write("Calendar._TT[\"WEEKEND\"] = \"0,6\";\n");
      out.write("\n");

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
      out.write("var loadingAnimation = new Image();\n");
      out.write("\n");
      out.write("loadingAnimation.src =  \"");
      out.print( themeDisplay.getPathThemeImages() );
      out.write("/progress_bar/loading_animation.gif\";\n");
      out.write("\n");
      out.write("function addPortletHTML(url, placeHolder) {\n");
      out.write("\tvar addPortletReturn = function(html) {\n");
      out.write("\t\tvar container = placeHolder.parentNode;\n");
      out.write("\t\tvar addDiv = document.createElement(\"div\");\n");
      out.write("\n");
      out.write("\t\taddDiv.style.display = \"none\";\n");
      out.write("\t\taddDiv.innerHTML = html;\n");
      out.write("\n");
      out.write("\t\tvar portletBound = _$J(\".portlet-boundary:first\", addDiv).get(0);\n");
      out.write("\n");
      out.write("\t\tportletBound.parentNode.removeChild(portletBound);\n");
      out.write("\n");
      out.write("\t\tvar portletId = portletBound.id;\n");
      out.write("\n");
      out.write("\t\tportletId = portletId.replace(/^p_p_id_/,\"\");\n");
      out.write("\t\tportletId = portletId.replace(/_$/,\"\");\n");
      out.write("\n");
      out.write("\t\tportletBound.portletId = portletId;\n");
      out.write("\n");
      out.write("\t\tLiferay.Portlet.flagAjax(portletId);\n");
      out.write("\n");
      out.write("\t\tcontainer.replaceChild(portletBound, placeHolder);\n");
      out.write("\n");
      out.write("\t\tjQuery(addDiv).evalScripts();\n");
      out.write("\n");
      out.write("\t\tif (!jQuery.browser.firefox) {\n");
      out.write("\t\t\tjQuery(portletBound).evalScripts();\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\t");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(null);
      _jspx_th_c_005fif_005f0.setTest( (layout != null) && (LayoutPermissionUtil.contains(permissionChecker, layout, ActionKeys.UPDATE)) );
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t\t\tif (!portletBound.isStatic) {\n");
          out.write("\t\t\t\tif (themeDisplay.isFreeformLayout()) {\n");
          out.write("\t\t\t\t\tLiferay.Freeform.add(portletBound);\n");
          out.write("\t\t\t\t}\n");
          out.write("\t\t\t\telse {\n");
          out.write("\t\t\t\t\tLiferay.Columns.add(portletBound);\n");
          out.write("\t\t\t\t}\n");
          out.write("\t\t\t}\n");
          out.write("\t\t");
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
      out.write("\n");
      out.write("\n");
      out.write("\t\tif (_$J.browser.firefox) {\n");
      out.write("\t\t\tsetTimeout(\"Liferay.Portlet.process(\\\"\" + portletId + \"\\\")\", 0);\n");
      out.write("\t\t}\n");
      out.write("\t\telse {\n");
      out.write("\t\t\tLiferay.Portlet.process(portletId);\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\tLiferay.Util.addInputType(portletBound.id);\n");
      out.write("\t\tLiferay.Util.addInputFocus(portletBound.id);\n");
      out.write("\n");
      out.write("\t\tif (window.location.hash) {\n");
      out.write("\t\t\twindow.location.hash = \"p_\" + portletId;\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\treturn portletId;\n");
      out.write("\t};\n");
      out.write("\n");
      out.write("\tAjaxUtil.request(url, {\n");
      out.write("\t\tonComplete: function(xmlHttpReq){\n");
      out.write("\t\t\taddPortletReturn(xmlHttpReq.responseText);\n");
      out.write("\t\t}\n");
      out.write("\t});\n");
      out.write("}\n");
      out.write("\n");
      out.write("function closePortlet(plid, portletId, doAsUserId, skipConfirm) {\n");
      out.write("\tif (skipConfirm || confirm('");
      out.print( UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-remove-this-component") );
      out.write("')) {\n");
      out.write("\t\tvar curItem = document.getElementById(\"p_p_id_\" + portletId + \"_\");\n");
      out.write("\t\tvar parent = curItem.parentNode;\n");
      out.write("\n");
      out.write("\t\tparent.removeChild(curItem);\n");
      out.write("\n");
      out.write("\t\tif (curItem = document.getElementById(portletId)) {\n");
      out.write("\t\t\tparent = curItem.parentNode;\n");
      out.write("\n");
      out.write("\t\t\tparent.removeChild(curItem);\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\tif (LayoutConfiguration) {\n");
      out.write("\t\t\tLayoutConfiguration.initialized = false;\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\tif (themeDisplay.layoutMaximized) {\n");
      out.write("\t\t\tself.location = \"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout?p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write('=');
      out.print( Constants.DELETE );
      out.write("&referer=\" + encodeURIComponent(\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/layout?p_l_id=\" + plid + \"&doAsUserId=\" + doAsUserId) + \"&refresh=1\";\n");
      out.write("\t\t}\n");
      out.write("\t\telse {\n");
      out.write("\t\t\tloadPage(\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout\", \"p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write('=');
      out.print( Constants.DELETE );
      out.write("\");\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\tLiferay.Portlet.remove(portletId);\n");
      out.write("\t}\n");
      out.write("\telse {\n");
      out.write("\t\tself.focus();\n");
      out.write("\t}\n");
      out.write("}\n");
      out.write("\n");
      out.write("function getRefreshPortletList() {\n");
      out.write("\n");
      out.write("\t");

	List portlets = PortletLocalServiceUtil.getPortlets(company.getCompanyId(), false, false);

	List nonAjaxPortlets = new ArrayList();

	for (int i = 0; i < portlets.size(); i++) {
		Portlet portlet = (Portlet)portlets.get(i);

		if (!portlet.isAjaxable()) {
			nonAjaxPortlets.add(portlet.getPortletId());
		}
	}

	StringMaker portletList = new StringMaker();

	for (int i = 0; i < nonAjaxPortlets.size(); i++) {
		portletList.append("_");
		portletList.append(nonAjaxPortlets.get(i));
		portletList.append(":true");
		portletList.append((i < nonAjaxPortlets.size() - 1) ? "," : "");
	}
	
      out.write("\n");
      out.write("\n");
      out.write("\tvar refreshPortletList = { ");
      out.print( portletList.toString() );
      out.write(" };\n");
      out.write("\n");
      out.write("\treturn refreshPortletList;\n");
      out.write("}\n");
      out.write("\n");
      out.write("function minimizePortlet(plid, portletId, restore, doAsUserId) {\n");
      out.write("\tif (themeDisplay.layoutMaximized) {\n");
      out.write("\t\tself.location = \"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout?p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&p_p_restore=\" + restore + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write("=minimize&referer=\" + encodeURIComponent(\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/layout?p_l_id=\" + plid + \"&doAsUserId=\" + doAsUserId) + \"&refresh=1\";\n");
      out.write("\t}\n");
      out.write("\telse {\n");
      out.write("\t\tvar portlet = jQuery('#p_p_id_' + portletId + '_');\n");
      out.write("\t\tvar portletContentContainer = portlet.find('.portlet-content-container');\n");
      out.write("\n");
      out.write("\t\tvar buttonsEl = jQuery(\"#p_p_body_\" + portletId + \"_min_buttons\");\n");
      out.write("\n");
      out.write("\t\tvar html = buttonsEl.html();\n");
      out.write("\n");
      out.write("\t\tif (restore) {\n");
      out.write("\t\t\tportletContentContainer.BlindDown('fast');\n");
      out.write("\n");
      out.write("\t\t\thtml = html.replace(\", true\", \", false\");\n");
      out.write("\t\t\thtml = html.replace(\"restore.png\", \"minimize.png\");\n");
      out.write("\t\t\thtml = html.replace(\"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f10(_jspx_page_context))
        return;
      out.write("\", \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f11(_jspx_page_context))
        return;
      out.write("\");\n");
      out.write("\n");
      out.write("\t\t\tloadPage(\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout\", \"p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&p_p_restore=\" + restore + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write("=minimize\");\n");
      out.write("\t\t}\n");
      out.write("\t\telse {\n");
      out.write("\t\t\tportletContentContainer.BlindUp('fast');\n");
      out.write("\n");
      out.write("\t\t\thtml = html.replace(\", false\", \", true\");\n");
      out.write("\t\t\thtml = html.replace(\"minimize.png\", \"restore.png\");\n");
      out.write("\t\t\thtml = html.replace(\"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f12(_jspx_page_context))
        return;
      out.write("\", \"");
      if (_jspx_meth_liferay_002dui_005fmessage_005f13(_jspx_page_context))
        return;
      out.write("\");\n");
      out.write("\n");
      out.write("\t\t\tloadPage(\"");
      out.print( themeDisplay.getPathMain() );
      out.write("/portal/update_layout\", \"p_l_id=\" + plid + \"&p_p_id=\" + portletId + \"&p_p_restore=\" + restore + \"&doAsUserId=\" + doAsUserId + \"&");
      out.print( Constants.CMD );
      out.write("=minimize\");\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\tbuttonsEl.html(html);\n");
      out.write("\t}\n");
      out.write("}");
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
    _jspx_th_liferay_002dui_005fmessage_005f0.setKey("date-selection");
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
    _jspx_th_liferay_002dui_005fmessage_005f1.setKey("close");
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
    _jspx_th_liferay_002dui_005fmessage_005f2.setKey("today");
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
    _jspx_th_liferay_002dui_005fmessage_005f3.setKey("help");
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
    _jspx_th_liferay_002dui_005fmessage_005f4.setKey("next-month");
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
    _jspx_th_liferay_002dui_005fmessage_005f5.setKey("next-year");
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
    _jspx_th_liferay_002dui_005fmessage_005f6.setKey("previous-month");
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
    _jspx_th_liferay_002dui_005fmessage_005f7.setKey("previous-year");
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
    _jspx_th_liferay_002dui_005fmessage_005f8.setKey("select-date");
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
    _jspx_th_liferay_002dui_005fmessage_005f9.setKey("today");
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
    _jspx_th_liferay_002dui_005fmessage_005f10.setKey("restore");
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
    _jspx_th_liferay_002dui_005fmessage_005f11.setKey("minimize");
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
    _jspx_th_liferay_002dui_005fmessage_005f12.setKey("minimize");
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
    _jspx_th_liferay_002dui_005fmessage_005f13.setKey("restore");
    int _jspx_eval_liferay_002dui_005fmessage_005f13 = _jspx_th_liferay_002dui_005fmessage_005f13.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f13);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f13);
    return false;
  }
}
