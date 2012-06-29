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

public final class render_005fportlet_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.portal.render_portlet.jsp");

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
    _jspx_dependants.add("/html/portal/render_portlet-ext.jsp");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fchoose;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fwhen_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fotherwise;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fchoose = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fwhen_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fotherwise = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fif_005ftest.release();
    _005fjspx_005ftagPool_005fc_005fchoose.release();
    _005fjspx_005ftagPool_005fc_005fwhen_005ftest.release();
    _005fjspx_005ftagPool_005fc_005fotherwise.release();
    _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.release();
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.release();
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

Portlet portlet = (Portlet)request.getAttribute(WebKeys.RENDER_PORTLET);

String portletId = portlet.getPortletId();
String rootPortletId = portlet.getRootPortletId();
String instanceId = portlet.getInstanceId();

String portletPrimaryKey = PortletPermissionUtil.getPrimaryKey(plid.longValue(), portletId);

String queryString = (String)request.getAttribute(WebKeys.RENDER_PORTLET_QUERY_STRING);
String columnId = (String)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_ID);
Integer columnPos = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_POS);
Integer columnCount = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_COUNT);
Boolean renderPortletResource = (Boolean)request.getAttribute(WebKeys.RENDER_PORTLET_RESOURCE);

boolean runtimePortlet = (renderPortletResource != null) && renderPortletResource.booleanValue();

boolean denyAccess = false;

try {
	ResourceLocalServiceUtil.getResource(company.getCompanyId(), rootPortletId, ResourceImpl.SCOPE_INDIVIDUAL, portletPrimaryKey);
}
catch (NoSuchResourceException nsre) {
	boolean addDefaultResource = false;

	if (runtimePortlet) {
		addDefaultResource = true;
	}
	else if (layoutTypePortlet.hasPortletId(portletId)) {
		addDefaultResource = true;
	}
	else if (portlet.isAddDefaultResource()) {
		addDefaultResource = true;
	}
	else if (themeDisplay.isSignedIn()) {
		if (portletId.equals(PortletKeys.LAYOUT_CONFIGURATION) || portletId.equals(PortletKeys.LAYOUT_MANAGEMENT)) {
			Group group = layout.getGroup();

			if (group.isCommunity()) {
				if (GroupPermissionUtil.contains(permissionChecker, portletGroupId.longValue(), ActionKeys.MANAGE_LAYOUTS) ||
					LayoutPermissionUtil.contains(permissionChecker, layout, ActionKeys.UPDATE)) {

					addDefaultResource = true;
				}
			}
			else if (group.isOrganization()) {
				Organization organization = OrganizationLocalServiceUtil.getOrganization(group.getClassPK());

				if ((!organization.isLocation() && OrganizationPermissionUtil.contains(permissionChecker, organization.getOrganizationId(), ActionKeys.UPDATE)) ||
					(organization.isLocation() && LocationPermissionUtil.contains(permissionChecker, organization.getOrganizationId(), ActionKeys.UPDATE))) {

					addDefaultResource = true;
				}
			}
			else if (group.isUser()) {
				addDefaultResource = true;
			}
		}
	}

	if (!portlet.hasAddPortletPermission(user.getUserId())) {
		addDefaultResource = false;
	}

	if (addDefaultResource) {
		ResourceLocalServiceUtil.addResources(company.getCompanyId(), layout.getGroupId(), 0, rootPortletId, portletPrimaryKey, true, true, true);
	}
	else {
		denyAccess = true;
	}
}

boolean access = PortletPermissionUtil.contains(permissionChecker, plid.longValue(), portlet, ActionKeys.VIEW);

boolean stateMax = layoutTypePortlet.hasStateMaxPortletId(portletId);
boolean stateMin = layoutTypePortlet.hasStateMinPortletId(portletId);

boolean modeAbout = layoutTypePortlet.hasModeAboutPortletId(portletId);
boolean modeConfig = layoutTypePortlet.hasModeConfigPortletId(portletId);
boolean modeEdit = layoutTypePortlet.hasModeEditPortletId(portletId);
boolean modeEditDefaults = layoutTypePortlet.hasModeEditDefaultsPortletId(portletId);
boolean modeEditGuest = layoutTypePortlet.hasModeEditGuestPortletId(portletId);
boolean modeHelp = layoutTypePortlet.hasModeHelpPortletId(portletId);
boolean modePreview = layoutTypePortlet.hasModePreviewPortletId(portletId);
boolean modePrint = layoutTypePortlet.hasModePrintPortletId(portletId);

CachePortlet cachePortlet = null;

try {
	cachePortlet = PortletInstanceFactory.create(portlet, application);
}
/*catch (UnavailableException ue) {
	ue.printStackTrace();
}*/
catch (PortletException pe) {
	pe.printStackTrace();
}
catch (RuntimeException re) {
	re.printStackTrace();
}

PortletPreferences portletSetup = PortletPreferencesFactoryUtil.getPortletSetup(request, portletId, true, true);

PortletPreferencesIds portletPreferencesIds = PortletPreferencesFactoryUtil.getPortletPreferencesIds(request, portletId);

PortletPreferences portletPreferences = PortletPreferencesLocalServiceUtil.getPreferences(portletPreferencesIds);

PortletConfig portletConfig = PortletConfigFactory.create(portlet, application);
PortletContext portletCtx = portletConfig.getPortletContext();

WindowState windowState = WindowState.NORMAL;

if (themeDisplay.isStatePopUp()) {
	windowState = LiferayWindowState.POP_UP;
}
else if (stateMax) {
	windowState = WindowState.MAXIMIZED;
}

PortletMode portletMode = PortletMode.VIEW;

if (modeAbout) {
	portletMode = LiferayPortletMode.ABOUT;
}
else if (modeConfig) {
	portletMode = LiferayPortletMode.CONFIG;
}
else if (modeEdit) {
	portletMode = PortletMode.EDIT;
}
else if (modeEditDefaults) {
	portletMode = LiferayPortletMode.EDIT_DEFAULTS;
}
else if (modeEditGuest) {
	portletMode = LiferayPortletMode.EDIT_GUEST;
}
else if (modeHelp) {
	portletMode = PortletMode.HELP;
}
else if (modePreview) {
	portletMode = LiferayPortletMode.PREVIEW;
}
else if (modePrint) {
	portletMode = LiferayPortletMode.PRINT;
}

HttpServletRequest originalReq = PortalUtil.getOriginalServletRequest(request);

RenderRequestImpl renderRequestImpl = RenderRequestFactory.create(originalReq, portlet, cachePortlet, portletCtx, windowState, portletMode, portletPreferences, plid.longValue());

if (Validator.isNotNull(queryString)) {
	DynamicServletRequest dynamicReq = (DynamicServletRequest)renderRequestImpl.getHttpServletRequest();

	String[] params = StringUtil.split(queryString, StringPool.AMPERSAND);

	for (int i = 0; i < params.length; i++) {
		String[] kvp = StringUtil.split(params[i], StringPool.EQUAL);

		dynamicReq.setParameter(kvp[0], kvp[1]);
	}
}

StringServletResponse stringServletRes = new StringServletResponse(response);

RenderResponseImpl renderResponseImpl = RenderResponseFactory.create(renderRequestImpl, stringServletRes, portletId, company.getCompanyId(), plid.longValue());

renderRequestImpl.defineObjects(portletConfig, renderResponseImpl);

String responseContentType = renderRequestImpl.getResponseContentType();

String currentURL = PortalUtil.getCurrentURL(request);

Portlet portletResourcePortlet = null;

if (portletId.equals(PortletKeys.PORTLET_CONFIGURATION)) {
	String portletResource = ParamUtil.getString(request, "portletResource");

	if (Validator.isNotNull(portletResource)) {
		portletResourcePortlet = PortletLocalServiceUtil.getPortletById(company.getCompanyId(), portletResource);
	}
}

boolean showCloseIcon = true;
boolean showConfigurationIcon = false;
boolean showEditIcon = false;
boolean showEditGuestIcon = false;
boolean showHelpIcon = portlet.hasPortletMode(responseContentType, PortletMode.HELP);
boolean showMaxIcon = true;
boolean showMinIcon = true;
boolean showMoveIcon = !stateMax && !themeDisplay.isStateExclusive();
boolean showPortletCssIcon = false;
boolean showPortletIcon = (portletResourcePortlet != null) ? Validator.isNotNull(portletResourcePortlet.getIcon()) : Validator.isNotNull(portlet.getIcon());
boolean showPrintIcon = portlet.hasPortletMode(responseContentType, LiferayPortletMode.PRINT);
boolean showRefreshIcon = portlet.isAjaxable() && (portlet.getRenderWeight() == 0);

Boolean portletParallelRender = (Boolean)request.getAttribute(WebKeys.PORTLET_PARALLEL_RENDER);

if ((portletParallelRender != null) && (portletParallelRender.booleanValue() == false)) {
	showRefreshIcon = false;
}

if (!portletId.equals(PortletKeys.PORTLET_CONFIGURATION)) {
	if (PortletPermissionUtil.contains(permissionChecker, plid.longValue(), portletId, ActionKeys.CONFIGURATION)) {
		showConfigurationIcon = true;
		showPortletCssIcon = true;
	}
}

if (portlet.hasPortletMode(responseContentType, PortletMode.EDIT)) {
	if (PortletPermissionUtil.contains(permissionChecker, plid.longValue(), portletId, ActionKeys.PREFERENCES)) {
		showEditIcon = true;
	}
}

if (portlet.hasPortletMode(responseContentType, LiferayPortletMode.EDIT_GUEST)) {
	if (showEditIcon && !layout.isPrivateLayout() && themeDisplay.isShowAddContentIcon()) {
		showEditGuestIcon = true;
	}
}

boolean supportsMimeType = portlet.hasPortletMode(responseContentType, portletMode);

if (responseContentType.equals(ContentTypes.XHTML_MP) && portlet.hasMultipleMimeTypes()) {
	supportsMimeType = GetterUtil.getBoolean(portletSetup.getValue("portlet-setup-supported-clients-mobile-devices-" + portletMode, String.valueOf(supportsMimeType)));
}

// Unauthenticated users and users without UPDATE permission for the layout
// cannot modify the layout

if (!themeDisplay.isSignedIn() ||
	!LayoutPermissionUtil.contains(permissionChecker, layout, ActionKeys.UPDATE)) {

	showCloseIcon = false;
	showMaxIcon = GetterUtil.getBoolean(PropsUtil.get(PropsUtil.LAYOUT_GUEST_SHOW_MAX_ICON));
	showMinIcon = GetterUtil.getBoolean(PropsUtil.get(PropsUtil.LAYOUT_GUEST_SHOW_MIN_ICON));
	showMoveIcon = false;
}

// Portlets cannot be moved unless they belong to the layout

if (!layoutTypePortlet.hasPortletId(portletId)) {
	showCloseIcon = false;
	showMoveIcon = false;
}

// Static portlets cannot be moved

if (portlet.isStatic()) {
	showCloseIcon = false;
	showMoveIcon = false;
}

// Deny access

if (denyAccess) {
	access = false;

	showCloseIcon = false;
	showConfigurationIcon = false;
	showEditIcon = false;
	showEditGuestIcon = false;
	showHelpIcon = false;
	showMaxIcon = false;
	showMinIcon = false;
	showMoveIcon = false;
	showPortletCssIcon = false;
	showPrintIcon = false;
}

portletDisplay.recycle();

portletDisplay.setId(portletId);
portletDisplay.setRootPortletId(rootPortletId);
portletDisplay.setInstanceId(instanceId);
portletDisplay.setResourcePK(portletPrimaryKey);
portletDisplay.setPortletName(portletConfig.getPortletName());
portletDisplay.setNamespace(PortalUtil.getPortletNamespace(portletId));

portletDisplay.setAccess(access);
portletDisplay.setActive(portlet.isActive());

portletDisplay.setColumnId(columnId);
portletDisplay.setColumnPos(columnPos.intValue());
portletDisplay.setColumnCount(columnCount.intValue());

portletDisplay.setStateExclusive(themeDisplay.isStateExclusive());
portletDisplay.setStateMax(stateMax);
portletDisplay.setStateMin(stateMin);
portletDisplay.setStatePopUp(themeDisplay.isStatePopUp());

portletDisplay.setModeAbout(modeAbout);
portletDisplay.setModeConfig(modeConfig);
portletDisplay.setModeEdit(modeEdit);
portletDisplay.setModeEditDefaults(modeEditDefaults);
portletDisplay.setModeEditGuest(modeEditGuest);
portletDisplay.setModeHelp(modeHelp);
portletDisplay.setModePreview(modePreview);
portletDisplay.setModePrint(modePrint);

portletDisplay.setShowCloseIcon(showCloseIcon);
portletDisplay.setShowConfigurationIcon(showConfigurationIcon);
portletDisplay.setShowEditIcon(showEditIcon);
portletDisplay.setShowEditGuestIcon(showEditGuestIcon);
portletDisplay.setShowHelpIcon(showHelpIcon);
portletDisplay.setShowMaxIcon(showMaxIcon);
portletDisplay.setShowMinIcon(showMinIcon);
portletDisplay.setShowMoveIcon(showMoveIcon);
portletDisplay.setShowPortletCssIcon(showPortletCssIcon);
portletDisplay.setShowPortletIcon(showPortletIcon);
portletDisplay.setShowPrintIcon(showPrintIcon);
portletDisplay.setShowRefreshIcon(showRefreshIcon);

portletDisplay.setRestoreCurrentView(portlet.isRestoreCurrentView());

// Portlet icon

String portletIcon = null;

if (portletResourcePortlet != null) {
	portletIcon = portletResourcePortlet.getContextPath() + portletResourcePortlet.getIcon();
}
else {
	portletIcon = portlet.getContextPath() + portlet.getIcon();
}

portletDisplay.setURLPortlet(portletIcon);

// URL close

String urlClose = "javascript: closePortlet('" + plid.longValue() + "', '" + portletDisplay.getId() + "', '" + themeDisplay.getDoAsUserId() + "');";

portletDisplay.setURLClose(urlClose.toString());

// URL configuration

PortletURLImpl urlConfiguration = new PortletURLImpl(request, PortletKeys.PORTLET_CONFIGURATION, plid.longValue(), false);

urlConfiguration.setWindowState(WindowState.MAXIMIZED);

if (Validator.isNotNull(portlet.getConfigurationActionClass())) {
	urlConfiguration.setParameter("struts_action", "/portlet_configuration/edit_configuration");
}
else {
	urlConfiguration.setParameter("struts_action", "/portlet_configuration/edit_permissions");
}

urlConfiguration.setParameter("portletResource", portletDisplay.getId());
urlConfiguration.setParameter("resourcePrimKey", PortletPermissionUtil.getPrimaryKey(plid.longValue(), portlet.getPortletId()));
urlConfiguration.setParameter("redirect", currentURL);
urlConfiguration.setParameter("backURL", currentURL);

portletDisplay.setURLConfiguration("javascript: self.location = '" + HttpUtil.encodeURL(urlConfiguration.toString()) + "&" + PortalUtil.getPortletNamespace(PortletKeys.PORTLET_CONFIGURATION) + "previewWidth=' + document.getElementById('p_p_id" + portletDisplay.getNamespace() + "').offsetWidth;");

// URL edit

PortletURLImpl urlEdit = new PortletURLImpl(request, portletDisplay.getId(), plid.longValue(), false);

if (portletDisplay.isModeEdit()) {
	urlEdit.setWindowState(WindowState.NORMAL);
	urlEdit.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizeEdit()) {
		urlEdit.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlEdit.setWindowState(WindowState.NORMAL);
	}

	urlEdit.setPortletMode(PortletMode.EDIT);
}

portletDisplay.setURLEdit(urlEdit.toString());

// URL edit guest

PortletURLImpl urlEditGuest = new PortletURLImpl(request, portletDisplay.getId(), plid.longValue(), false);

if (portletDisplay.isModeEditGuest()) {
	urlEditGuest.setWindowState(WindowState.NORMAL);
	urlEditGuest.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizeEdit()) {
		urlEditGuest.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlEditGuest.setWindowState(WindowState.NORMAL);
	}

	urlEditGuest.setPortletMode(LiferayPortletMode.EDIT_GUEST);
}

portletDisplay.setURLEditGuest(urlEditGuest.toString());

// URL help

PortletURLImpl urlHelp = new PortletURLImpl(request, portletDisplay.getId(), plid.longValue(), false);

if (portletDisplay.isModeHelp()) {
	urlHelp.setWindowState(WindowState.NORMAL);
	urlHelp.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizeHelp()) {
		urlHelp.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlHelp.setWindowState(WindowState.NORMAL);
	}

	urlHelp.setPortletMode(PortletMode.HELP);
}

portletDisplay.setURLHelp(urlHelp.toString());

// URL max

boolean action = !portletDisplay.isRestoreCurrentView();

PortletURLImpl urlMax = new PortletURLImpl(request, portletDisplay.getId(), plid.longValue(), action);

if (portletDisplay.isStateMax()) {
	urlMax.setWindowState(WindowState.NORMAL);
}
else {
	urlMax.setWindowState(WindowState.MAXIMIZED);
}

if (!action) {
	String portletNamespace = portletDisplay.getNamespace();

	Map renderParameters = RenderParametersPool.get(request, plid.longValue(), portletDisplay.getId());

	Iterator itr = renderParameters.entrySet().iterator();

	while (itr.hasNext()) {
		Map.Entry entry = (Map.Entry)itr.next();

		String key = (String)entry.getKey();

		if (key.startsWith(portletNamespace)) {
			key = key.substring(portletNamespace.length(), key.length());

			String[] values = (String[])entry.getValue();

			urlMax.setParameter(key, values);
		}
	}
}

portletDisplay.setURLMax(urlMax.toString());

// URL min

String urlMin = "javascript: minimizePortlet('" + plid.longValue() + "', '" + portletDisplay.getId() + "', " + portletDisplay.isStateMin() + ", '" + themeDisplay.getDoAsUserId() + "');";

portletDisplay.setURLMin(urlMin);

// URL portlet css

String urlPortletCss = "javascript: Liferay.PortletCSS.init('" + portletDisplay.getId() + "');";

portletDisplay.setURLPortletCss(urlPortletCss.toString());

// URL print

PortletURLImpl urlPrint = new PortletURLImpl(request, portletDisplay.getId(), plid.longValue(), false);

if (portletDisplay.isModePrint()) {
	urlPrint.setWindowState(WindowState.NORMAL);
	urlPrint.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isPopUpPrint()) {
		urlPrint.setWindowState(LiferayWindowState.POP_UP);
	}
	else {
		urlPrint.setWindowState(WindowState.NORMAL);
	}

	urlPrint.setPortletMode(LiferayPortletMode.PRINT);
}

portletDisplay.setURLPrint(urlPrint.toString());

// URL refresh

String urlRefresh = "javascript: " + portletDisplay.getNamespace() + "refreshPortlet();";

portletDisplay.setURLRefresh(urlRefresh);

// URL back

String urlBack = null;

if (portletDisplay.isModeEdit()) {
	urlBack = urlEdit.toString();
}
else if (portletDisplay.isModeHelp()) {
	urlBack = urlHelp.toString();
}
else if (portletDisplay.isModePrint()) {
	urlBack = urlPrint.toString();
}
else if (portletDisplay.isStateMax()) {
	if (portletDisplay.getId().equals(PortletKeys.PORTLET_CONFIGURATION)) {
		/*String portletResource = ParamUtil.getString(request, "portletResource");

		urlMax.setAnchor(false);

		urlBack = urlMax.toString() + "#p_" + portletResource;*/

		urlBack = ParamUtil.getString(renderRequestImpl, "backURL");
	}
	else {
		urlBack = urlMax.toString();
	}
}

if (urlBack != null) {
	portletDisplay.setShowBackIcon(true);
	portletDisplay.setURLBack(urlBack);
}

// Make sure the Tiles context is reset for the next portlet

if ((cachePortlet != null) && cachePortlet.isStrutsPortlet()) {
	request.removeAttribute(ComponentConstants.COMPONENT_CONTEXT);
}

// Render portlet

boolean portletException = false;

if (portlet.isActive() && access && supportsMimeType) {
	try {
		cachePortlet.render(renderRequestImpl, renderResponseImpl);
	}
	catch (UnavailableException ue) {
		portletException = true;

		PortletInstanceFactory.destroy(portlet);
	}
	catch (Exception e) {
		portletException = true;

		LogUtil.log(_log, e);
	}
}

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
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(null);
      _jspx_th_c_005fif_005f0.setTest( !themeDisplay.isStateExclusive() );
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write('\n');
          out.write('\n');
          out.write('	');

	String freeformStyles = StringPool.BLANK;

	if (themeDisplay.isFreeformLayout() && !runtimePortlet && !layoutTypePortlet.hasStateMax()) {
		StringMaker sm = new StringMaker();

		Properties freeformStyleProps = PropertiesUtil.load(portletSetup.getValue("portlet-freeform-styles", StringPool.BLANK));

		sm.append("style=\"position: absolute; ");
		sm.append("width: ");
		sm.append(GetterUtil.getString(freeformStyleProps.getProperty("width"), "400px"));
		sm.append("; ");
		sm.append("top: ");
		sm.append(GetterUtil.getString(freeformStyleProps.getProperty("top"), "0"));
		sm.append("; ");
		sm.append("left: ");
		sm.append(GetterUtil.getString(freeformStyleProps.getProperty("left"), "0"));
		sm.append(";\"");

		freeformStyles = sm.toString();
	}
	
          out.write("\n");
          out.write("\n");
          out.write("\t<div id=\"p_p_id");
          out.print( renderResponseImpl.getNamespace() );
          out.write("\" class=\"portlet-boundary portlet-boundary");
          out.print( PortalUtil.getPortletNamespace(portlet.getRootPortletId()) );
          out.write('"');
          out.write(' ');
          out.print( freeformStyles );
          out.write(">\n");
          out.write("\t\t<a name=\"p_");
          out.print( portletId );
          out.write("\"></a>\n");
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
          _jspx_th_c_005fwhen_005f0.setTest( !supportsMimeType );
          int _jspx_eval_c_005fwhen_005f0 = _jspx_th_c_005fwhen_005f0.doStartTag();
          if (_jspx_eval_c_005fwhen_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write('\n');
              out.write('	');
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
          //  c:when
          org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_005fwhen_005f1 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _005fjspx_005ftagPool_005fc_005fwhen_005ftest.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
          _jspx_th_c_005fwhen_005f1.setPageContext(_jspx_page_context);
          _jspx_th_c_005fwhen_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f0);
          _jspx_th_c_005fwhen_005f1.setTest( !access && !portlet.isShowPortletAccessDenied() );
          int _jspx_eval_c_005fwhen_005f1 = _jspx_th_c_005fwhen_005f1.doStartTag();
          if (_jspx_eval_c_005fwhen_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write('\n');
              out.write('	');
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
          out.write('\n');
          out.write('	');
          //  c:when
          org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_005fwhen_005f2 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _005fjspx_005ftagPool_005fc_005fwhen_005ftest.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
          _jspx_th_c_005fwhen_005f2.setPageContext(_jspx_page_context);
          _jspx_th_c_005fwhen_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f0);
          _jspx_th_c_005fwhen_005f2.setTest( !portlet.isActive() && !portlet.isShowPortletInactive() );
          int _jspx_eval_c_005fwhen_005f2 = _jspx_th_c_005fwhen_005f2.doStartTag();
          if (_jspx_eval_c_005fwhen_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write('\n');
              out.write('	');
              int evalDoAfterBody = _jspx_th_c_005fwhen_005f2.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fwhen_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f2);
            return;
          }
          _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f2);
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

		boolean useDefaultTemplate = portlet.isUseDefaultTemplate();
		Boolean useDefaultTemplateObj = renderResponseImpl.getUseDefaultTemplate();

		if (useDefaultTemplateObj != null) {
			useDefaultTemplate = useDefaultTemplateObj.booleanValue();
		}

		if ((cachePortlet != null) && cachePortlet.isStrutsPortlet()) {
			if (!access || portletException) {
				PortletRequestProcessor portletReqProcessor = (PortletRequestProcessor)portletCtx.getAttribute(WebKeys.PORTLET_STRUTS_PROCESSOR);

				ActionMapping actionMapping = portletReqProcessor.processMapping(request, response, (String)portlet.getInitParams().get("view-action"));

				ComponentDefinition definition = null;

				if (actionMapping != null) {

					// See action path /weather/view

					String definitionName = actionMapping.getForward();

					if (definitionName == null) {

						// See action path /journal/view_articles

						String[] definitionNames = actionMapping.findForwards();

						for (int definitionNamesPos = 0; definitionNamesPos < definitionNames.length; definitionNamesPos++) {
							if (definitionNames[definitionNamesPos].endsWith("view")) {
								definitionName = definitionNames[definitionNamesPos];

								break;
							}
						}

						if (definitionName == null) {
							definitionName = definitionNames[0];
						}
					}

					definition = TilesUtil.getDefinition(definitionName, request, application);
				}

				String templatePath = StrutsUtil.TEXT_HTML_DIR + "/common/themes/portlet.jsp";

				if (definition != null) {
					templatePath = StrutsUtil.TEXT_HTML_DIR + definition.getPath();
				}
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t");
              //  tiles:insert
              org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f0 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.get(org.apache.struts.taglib.tiles.InsertTag.class);
              _jspx_th_tiles_005finsert_005f0.setPageContext(_jspx_page_context);
              _jspx_th_tiles_005finsert_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fotherwise_005f0);
              _jspx_th_tiles_005finsert_005f0.setTemplate( templatePath );
              _jspx_th_tiles_005finsert_005f0.setFlush(false);
              int _jspx_eval_tiles_005finsert_005f0 = _jspx_th_tiles_005finsert_005f0.doStartTag();
              if (_jspx_eval_tiles_005finsert_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\t\t\t\t\t");
                  if (_jspx_meth_tiles_005fput_005f0(_jspx_th_tiles_005finsert_005f0, _jspx_page_context))
                    return;
                  out.write("\n");
                  out.write("\t\t\t\t");
                  int evalDoAfterBody = _jspx_th_tiles_005finsert_005f0.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
              }
              if (_jspx_th_tiles_005finsert_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.reuse(_jspx_th_tiles_005finsert_005f0);
                return;
              }
              _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.reuse(_jspx_th_tiles_005finsert_005f0);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");

			}
			else {
				if (useDefaultTemplate) {
					renderRequestImpl.setAttribute(WebKeys.PORTLET_CONTENT, stringServletRes.getString());
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t\t");
              //  tiles:insert
              org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f1 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.get(org.apache.struts.taglib.tiles.InsertTag.class);
              _jspx_th_tiles_005finsert_005f1.setPageContext(_jspx_page_context);
              _jspx_th_tiles_005finsert_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fotherwise_005f0);
              _jspx_th_tiles_005finsert_005f1.setTemplate( StrutsUtil.TEXT_HTML_DIR + "/common/themes/portlet.jsp" );
              _jspx_th_tiles_005finsert_005f1.setFlush(false);
              int _jspx_eval_tiles_005finsert_005f1 = _jspx_th_tiles_005finsert_005f1.doStartTag();
              if (_jspx_eval_tiles_005finsert_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\t\t\t\t\t\t");
                  //  tiles:put
                  org.apache.struts.taglib.tiles.PutTag _jspx_th_tiles_005fput_005f1 = (org.apache.struts.taglib.tiles.PutTag) _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.get(org.apache.struts.taglib.tiles.PutTag.class);
                  _jspx_th_tiles_005fput_005f1.setPageContext(_jspx_page_context);
                  _jspx_th_tiles_005fput_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_tiles_005finsert_005f1);
                  _jspx_th_tiles_005fput_005f1.setName("portlet_content");
                  _jspx_th_tiles_005fput_005f1.setValue( StringPool.BLANK );
                  int _jspx_eval_tiles_005fput_005f1 = _jspx_th_tiles_005fput_005f1.doStartTag();
                  if (_jspx_th_tiles_005fput_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f1);
                    return;
                  }
                  _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f1);
                  out.write("\n");
                  out.write("\t\t\t\t\t");
                  int evalDoAfterBody = _jspx_th_tiles_005finsert_005f1.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
              }
              if (_jspx_th_tiles_005finsert_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.reuse(_jspx_th_tiles_005finsert_005f1);
                return;
              }
              _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.reuse(_jspx_th_tiles_005finsert_005f1);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");

				}
				else {
					pageContext.getOut().print(stringServletRes.getString());
				}
			}
		}
		else {
			renderRequestImpl.setAttribute(WebKeys.PORTLET_CONTENT, stringServletRes.getString());

			String portletContent = StringPool.BLANK;

			if (portletException) {
				portletContent = "/portal/portlet_error.jsp";
			}
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t");
              //  c:choose
              org.apache.taglibs.standard.tag.common.core.ChooseTag _jspx_th_c_005fchoose_005f1 = (org.apache.taglibs.standard.tag.common.core.ChooseTag) _005fjspx_005ftagPool_005fc_005fchoose.get(org.apache.taglibs.standard.tag.common.core.ChooseTag.class);
              _jspx_th_c_005fchoose_005f1.setPageContext(_jspx_page_context);
              _jspx_th_c_005fchoose_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fotherwise_005f0);
              int _jspx_eval_c_005fchoose_005f1 = _jspx_th_c_005fchoose_005f1.doStartTag();
              if (_jspx_eval_c_005fchoose_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\t\t\t\t");
                  //  c:when
                  org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_005fwhen_005f3 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _005fjspx_005ftagPool_005fc_005fwhen_005ftest.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
                  _jspx_th_c_005fwhen_005f3.setPageContext(_jspx_page_context);
                  _jspx_th_c_005fwhen_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f1);
                  _jspx_th_c_005fwhen_005f3.setTest( useDefaultTemplate || portletException );
                  int _jspx_eval_c_005fwhen_005f3 = _jspx_th_c_005fwhen_005f3.doStartTag();
                  if (_jspx_eval_c_005fwhen_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                    do {
                      out.write("\n");
                      out.write("\t\t\t\t\t");
                      //  tiles:insert
                      org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f2 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.get(org.apache.struts.taglib.tiles.InsertTag.class);
                      _jspx_th_tiles_005finsert_005f2.setPageContext(_jspx_page_context);
                      _jspx_th_tiles_005finsert_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f3);
                      _jspx_th_tiles_005finsert_005f2.setTemplate( StrutsUtil.TEXT_HTML_DIR + "/common/themes/portlet.jsp" );
                      _jspx_th_tiles_005finsert_005f2.setFlush(false);
                      int _jspx_eval_tiles_005finsert_005f2 = _jspx_th_tiles_005finsert_005f2.doStartTag();
                      if (_jspx_eval_tiles_005finsert_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                        do {
                          out.write("\n");
                          out.write("\t\t\t\t\t\t");
                          //  tiles:put
                          org.apache.struts.taglib.tiles.PutTag _jspx_th_tiles_005fput_005f2 = (org.apache.struts.taglib.tiles.PutTag) _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.get(org.apache.struts.taglib.tiles.PutTag.class);
                          _jspx_th_tiles_005fput_005f2.setPageContext(_jspx_page_context);
                          _jspx_th_tiles_005fput_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_tiles_005finsert_005f2);
                          _jspx_th_tiles_005fput_005f2.setName("portlet_content");
                          _jspx_th_tiles_005fput_005f2.setValue( portletContent );
                          int _jspx_eval_tiles_005fput_005f2 = _jspx_th_tiles_005fput_005f2.doStartTag();
                          if (_jspx_th_tiles_005fput_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                            _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f2);
                            return;
                          }
                          _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f2);
                          out.write("\n");
                          out.write("\t\t\t\t\t");
                          int evalDoAfterBody = _jspx_th_tiles_005finsert_005f2.doAfterBody();
                          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                            break;
                        } while (true);
                      }
                      if (_jspx_th_tiles_005finsert_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                        _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.reuse(_jspx_th_tiles_005finsert_005f2);
                        return;
                      }
                      _005fjspx_005ftagPool_005ftiles_005finsert_005ftemplate_005fflush.reuse(_jspx_th_tiles_005finsert_005f2);
                      out.write("\n");
                      out.write("\t\t\t\t");
                      int evalDoAfterBody = _jspx_th_c_005fwhen_005f3.doAfterBody();
                      if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                        break;
                    } while (true);
                  }
                  if (_jspx_th_c_005fwhen_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f3);
                    return;
                  }
                  _005fjspx_005ftagPool_005fc_005fwhen_005ftest.reuse(_jspx_th_c_005fwhen_005f3);
                  out.write("\n");
                  out.write("\t\t\t\t");
                  //  c:otherwise
                  org.apache.taglibs.standard.tag.common.core.OtherwiseTag _jspx_th_c_005fotherwise_005f1 = (org.apache.taglibs.standard.tag.common.core.OtherwiseTag) _005fjspx_005ftagPool_005fc_005fotherwise.get(org.apache.taglibs.standard.tag.common.core.OtherwiseTag.class);
                  _jspx_th_c_005fotherwise_005f1.setPageContext(_jspx_page_context);
                  _jspx_th_c_005fotherwise_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f1);
                  int _jspx_eval_c_005fotherwise_005f1 = _jspx_th_c_005fotherwise_005f1.doStartTag();
                  if (_jspx_eval_c_005fotherwise_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                    do {
                      out.write("\n");
                      out.write("\t\t\t\t\t");
                      out.print( renderRequestImpl.getAttribute(WebKeys.PORTLET_CONTENT) );
                      out.write("\n");
                      out.write("\t\t\t\t");
                      int evalDoAfterBody = _jspx_th_c_005fotherwise_005f1.doAfterBody();
                      if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                        break;
                    } while (true);
                  }
                  if (_jspx_th_c_005fotherwise_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fc_005fotherwise.reuse(_jspx_th_c_005fotherwise_005f1);
                    return;
                  }
                  _005fjspx_005ftagPool_005fc_005fotherwise.reuse(_jspx_th_c_005fotherwise_005f1);
                  out.write("\n");
                  out.write("\t\t\t");
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
              out.write("\n");
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
      out.write('\n');
      out.write('\n');
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f1.setParent(null);
      _jspx_th_c_005fif_005f1.setTest( !themeDisplay.isStateExclusive() );
      int _jspx_eval_c_005fif_005f1 = _jspx_th_c_005fif_005f1.doStartTag();
      if (_jspx_eval_c_005fif_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t</div>\n");
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

String staticVar = "yes";

if (portletDisplay.isShowMoveIcon()) {
	staticVar = "no";
}
else {
	if (portlet.isStaticStart()) {
		staticVar = "start";
	}

	if (portlet.isStaticEnd()) {
		staticVar = "end";
	}
}

      out.write('\n');
      out.write('\n');
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      _jspx_th_c_005fif_005f2.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f2.setParent(null);
      _jspx_th_c_005fif_005f2.setTest( !themeDisplay.isStateExclusive() );
      int _jspx_eval_c_005fif_005f2 = _jspx_th_c_005fif_005f2.doStartTag();
      if (_jspx_eval_c_005fif_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\t<script type=\"text/javascript\">\n");
          out.write("\t\t");
          //  c:if
          org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f3 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
          _jspx_th_c_005fif_005f3.setPageContext(_jspx_page_context);
          _jspx_th_c_005fif_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
          _jspx_th_c_005fif_005f3.setTest( !runtimePortlet );
          int _jspx_eval_c_005fif_005f3 = _jspx_th_c_005fif_005f3.doStartTag();
          if (_jspx_eval_c_005fif_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t\tdocument.getElementById(\"p_p_id");
              out.print( renderResponseImpl.getNamespace() );
              out.write("\").portletId = \"");
              out.print( portletDisplay.getId() );
              out.write("\";\n");
              out.write("\t\t\tdocument.getElementById(\"p_p_id");
              out.print( renderResponseImpl.getNamespace() );
              out.write("\").columnPos = ");
              out.print( columnPos );
              out.write(";\n");
              out.write("\n");
              out.write("\t\t\t");
              //  c:if
              org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f4 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
              _jspx_th_c_005fif_005f4.setPageContext(_jspx_page_context);
              _jspx_th_c_005fif_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f3);
              _jspx_th_c_005fif_005f4.setTest( !staticVar.equals("no") );
              int _jspx_eval_c_005fif_005f4 = _jspx_th_c_005fif_005f4.doStartTag();
              if (_jspx_eval_c_005fif_005f4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\t\t\t\tdocument.getElementById(\"p_p_id");
                  out.print( renderResponseImpl.getNamespace() );
                  out.write("\").isStatic = \"");
                  out.print( staticVar );
                  out.write("\";\n");
                  out.write("\t\t\t");
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
              out.write("\n");
              out.write("\n");
              out.write("\t\t\tif (!Liferay.Portlet.isAjax(\"");
              out.print( portletDisplay.getId() );
              out.write("\")) {\n");
              out.write("\t\t\t\tLiferay.Portlet.process(\"");
              out.print( portletDisplay.getId() );
              out.write("\");\n");
              out.write("\t\t\t}\n");
              out.write("\t\t");
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
          out.write("\n");
          out.write("\n");
          out.write("\t\t");
          //  c:if
          org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f5 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
          _jspx_th_c_005fif_005f5.setPageContext(_jspx_page_context);
          _jspx_th_c_005fif_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
          _jspx_th_c_005fif_005f5.setTest( PortletPermissionUtil.contains(permissionChecker, plid.longValue(), portletId, ActionKeys.CONFIGURATION) );
          int _jspx_eval_c_005fif_005f5 = _jspx_th_c_005fif_005f5.doStartTag();
          if (_jspx_eval_c_005fif_005f5 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t\tjQuery(\n");
              out.write("\t\t\t\tfunction() {\n");
              out.write("\t\t\t\t\tLiferay.Util.portletTitleEdit(\n");
              out.write("\t\t\t\t\t\t{\n");
              out.write("\t\t\t\t\t\t\tobj: jQuery(\"#p_p_id_");
              out.print( portletDisplay.getId() );
              out.write("_\"),\n");
              out.write("\t\t\t\t\t\t\tplid: \"");
              out.print( layout.getPlid() );
              out.write("\",\n");
              out.write("\t\t\t\t\t\t\tdoAsUserId: \"");
              out.print( themeDisplay.getDoAsUserId() );
              out.write("\",\n");
              out.write("\t\t\t\t\t\t\tportletId: \"");
              out.print( portletDisplay.getId() );
              out.write("\"\n");
              out.write("\t\t\t\t\t\t}\n");
              out.write("\t\t\t\t\t);\n");
              out.write("\t\t\t\t}\n");
              out.write("\t\t\t);\n");
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
          out.write("\t</script>\n");
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
      out.write('\n');
      out.write('\n');

SessionMessages.clear(renderRequestImpl);
SessionErrors.clear(renderRequestImpl);

RenderRequestFactory.recycle(renderRequestImpl);
RenderResponseFactory.recycle(renderResponseImpl);

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

  private boolean _jspx_meth_tiles_005fput_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_tiles_005finsert_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:put
    org.apache.struts.taglib.tiles.PutTag _jspx_th_tiles_005fput_005f0 = (org.apache.struts.taglib.tiles.PutTag) _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.get(org.apache.struts.taglib.tiles.PutTag.class);
    _jspx_th_tiles_005fput_005f0.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005fput_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_tiles_005finsert_005f0);
    _jspx_th_tiles_005fput_005f0.setName("portlet_content");
    _jspx_th_tiles_005fput_005f0.setValue("/portal/portlet_error.jsp");
    int _jspx_eval_tiles_005fput_005f0 = _jspx_th_tiles_005fput_005f0.doStartTag();
    if (_jspx_th_tiles_005fput_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005fput_005fvalue_005fname_005fnobody.reuse(_jspx_th_tiles_005fput_005f0);
    return false;
  }
}
