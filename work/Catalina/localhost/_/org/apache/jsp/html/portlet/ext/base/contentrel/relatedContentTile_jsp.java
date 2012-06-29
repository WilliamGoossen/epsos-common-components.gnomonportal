package org.apache.jsp.html.portlet.ext.base.contentrel;

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
import gnomon.hibernate.GnPersistenceService;
import gnomon.hibernate.model.gn.GnTopic;
import com.liferay.portal.util.LayoutLister;
import com.liferay.portal.util.LayoutView;
import com.ext.portlet.base.search.GnSearchResultRow;
import com.ext.portlet.base.contentrel.ContentRelUtil;
import com.ext.portlet.cms.generic.lucene.LuceneUtilities;
import gnomon.business.GeneralUtils;
import java.util.Vector;

public final class relatedContentTile_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(27);
    _jspx_dependants.add("/html/portlet/ext/base/contentrel/init.jsp");
    _jspx_dependants.add("/html/portlet/ext/base/init.jsp");
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
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fignore_005fid_005fclassname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005fpagesize_005fname_005fid_005fexport_005fdefaultsort_005fdefaultorder;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fsortProperty;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_005ftest;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fignore_005fid_005fclassname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005fpagesize_005fname_005fid_005fexport_005fdefaultsort_005fdefaultorder = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fsortProperty = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.release();
    _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fignore_005fid_005fclassname_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.release();
    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005fpagesize_005fname_005fid_005fexport_005fdefaultsort_005fdefaultorder.release();
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn.release();
    _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fsortProperty.release();
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
String instancePortletSearch = GetterUtil.getString(prefs.getValue("portlet-search", StringPool.BLANK));
String instancePortletBrowseType=GetterUtil.getString(prefs.getValue("browse-type", StringPool.BLANK));
String instancePortletListStyle = ParamUtil.getString(request,"listStyle",prefs.getValue("list-style", StringPool.BLANK));
String instancePortletTopicStyle = ParamUtil.getString(request,"topicStyle",prefs.getValue("topic-style", StringPool.BLANK));





String instancePortletShowRelContent = prefs.getValue("showRelContent", StringPool.BLANK);
String instancePortletShowRelContentDescription = prefs.getValue("showRelContentDescription", StringPool.BLANK);
com.ext.portlet.base.contentrel.ContentRelUtil relUtil = com.ext.portlet.base.contentrel.ContentRelUtil.getInstance();
String[] classNames = relUtil.getPortletClassNames();
String[] portletNames = relUtil.getPortletNames();



String instanceYearsStartYear = GetterUtil.getString(prefs.getValue("years_startYear", StringPool.BLANK));
boolean instanceYearsShowFuture = GetterUtil.getBoolean(prefs.getValue("years_showFuture", "true"), true);
boolean instanceYearsShowEmptyYears = GetterUtil.getBoolean(prefs.getValue("years_showEmptyYears", "true"), true);

boolean topicsOnOff = GetterUtil.getBoolean(prefs.getValue("topicsOnOff", "false"), false);
String topicFieldSetkey = GetterUtil.getString(prefs.getValue("topicFieldSetkey", StringPool.BLANK));

String instanceUseTopicNav = GetterUtil.getString(prefs.getValue("use-topic-nav", "no"));

boolean enableRatings = GetterUtil.getBoolean(prefs.getValue("enableRatings", StringPool.BLANK), false);  
boolean enableComments = GetterUtil.getBoolean(prefs.getValue("enableComments", StringPool.BLANK), false);  

String instanceEmbedMedia= GetterUtil.getString(prefs.getValue("embed_media", "no"));
String instanceRelEmbedMedia= GetterUtil.getString(prefs.getValue("embed_rel_media", "no"));

boolean showOnlyMine = GetterUtil.getBoolean(prefs.getValue("showOnlyMine", StringPool.BLANK), false);
boolean notifyPublisher = GetterUtil.getBoolean(prefs.getValue("notifyPublisher", StringPool.BLANK), false);

boolean crossPublishingEnabled = GetterUtil.getBoolean(prefs.getValue("crossPublishingEnabled", StringPool.BLANK), false);
boolean crossPublishingAuto = GetterUtil.getBoolean(prefs.getValue("crossPublishingAuto", StringPool.BLANK), false);
String crossPublishingTopics= GetterUtil.getString(prefs.getValue("crossPublishingTopics", ""));

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
      out.write('\n');
      out.write('\n');

String redirect = (String)request.getParameter("redirect");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      //  tiles:useAttribute
      org.apache.struts.taglib.tiles.UseAttributeTag _jspx_th_tiles_005fuseAttribute_005f0 = (org.apache.struts.taglib.tiles.UseAttributeTag) _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.get(org.apache.struts.taglib.tiles.UseAttributeTag.class);
      _jspx_th_tiles_005fuseAttribute_005f0.setPageContext(_jspx_page_context);
      _jspx_th_tiles_005fuseAttribute_005f0.setParent(null);
      _jspx_th_tiles_005fuseAttribute_005f0.setId("rel_className");
      _jspx_th_tiles_005fuseAttribute_005f0.setName("className");
      _jspx_th_tiles_005fuseAttribute_005f0.setClassname("java.lang.String");
      int _jspx_eval_tiles_005fuseAttribute_005f0 = _jspx_th_tiles_005fuseAttribute_005f0.doStartTag();
      if (_jspx_th_tiles_005fuseAttribute_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.reuse(_jspx_th_tiles_005fuseAttribute_005f0);
        return;
      }
      _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.reuse(_jspx_th_tiles_005fuseAttribute_005f0);
      java.lang.String rel_className = null;
      rel_className = (java.lang.String) _jspx_page_context.findAttribute("rel_className");
      out.write('\r');
      out.write('\n');
      //  tiles:useAttribute
      org.apache.struts.taglib.tiles.UseAttributeTag _jspx_th_tiles_005fuseAttribute_005f1 = (org.apache.struts.taglib.tiles.UseAttributeTag) _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.get(org.apache.struts.taglib.tiles.UseAttributeTag.class);
      _jspx_th_tiles_005fuseAttribute_005f1.setPageContext(_jspx_page_context);
      _jspx_th_tiles_005fuseAttribute_005f1.setParent(null);
      _jspx_th_tiles_005fuseAttribute_005f1.setId("rel_primaryKey");
      _jspx_th_tiles_005fuseAttribute_005f1.setName("primaryKey");
      _jspx_th_tiles_005fuseAttribute_005f1.setClassname("java.lang.String");
      int _jspx_eval_tiles_005fuseAttribute_005f1 = _jspx_th_tiles_005fuseAttribute_005f1.doStartTag();
      if (_jspx_th_tiles_005fuseAttribute_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.reuse(_jspx_th_tiles_005fuseAttribute_005f1);
        return;
      }
      _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fid_005fclassname_005fnobody.reuse(_jspx_th_tiles_005fuseAttribute_005f1);
      java.lang.String rel_primaryKey = null;
      rel_primaryKey = (java.lang.String) _jspx_page_context.findAttribute("rel_primaryKey");
      out.write('\r');
      out.write('\n');
      //  tiles:useAttribute
      org.apache.struts.taglib.tiles.UseAttributeTag _jspx_th_tiles_005fuseAttribute_005f2 = (org.apache.struts.taglib.tiles.UseAttributeTag) _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fignore_005fid_005fclassname_005fnobody.get(org.apache.struts.taglib.tiles.UseAttributeTag.class);
      _jspx_th_tiles_005fuseAttribute_005f2.setPageContext(_jspx_page_context);
      _jspx_th_tiles_005fuseAttribute_005f2.setParent(null);
      _jspx_th_tiles_005fuseAttribute_005f2.setId("rel_style");
      _jspx_th_tiles_005fuseAttribute_005f2.setName("style");
      _jspx_th_tiles_005fuseAttribute_005f2.setClassname("java.lang.String");
      _jspx_th_tiles_005fuseAttribute_005f2.setIgnore(true);
      int _jspx_eval_tiles_005fuseAttribute_005f2 = _jspx_th_tiles_005fuseAttribute_005f2.doStartTag();
      if (_jspx_th_tiles_005fuseAttribute_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fignore_005fid_005fclassname_005fnobody.reuse(_jspx_th_tiles_005fuseAttribute_005f2);
        return;
      }
      _005fjspx_005ftagPool_005ftiles_005fuseAttribute_005fname_005fignore_005fid_005fclassname_005fnobody.reuse(_jspx_th_tiles_005fuseAttribute_005f2);
      java.lang.String rel_style = null;
      rel_style = (java.lang.String) _jspx_page_context.findAttribute("rel_style");
      out.write("\r\n");
      out.write("\r\n");


List<String> classNamesList1 = Arrays.asList(classNames);
ArrayList<String> classNamesList = new ArrayList<String>();
classNamesList.addAll(classNamesList1);
classNamesList.add(ContentRelUtil.JOURNAL_CLASSNAME);
classNames = classNamesList.toArray(new String[0]);
String docFields[]={"langs.fileSize","langs.fileName"};
// make certain our className is one of the content rel allowed classnames, otherwise do nothing

if (classNamesList.contains(rel_className)) {
	
	// reorder classNames based on configuration orderIndices if present
	Vector<String> orderVector = new Vector<String>();
	orderVector.setSize(classNames.length);
	for (String pClassName: classNames) {
		String orderIndex = prefs.getValue("showRelContentOrderIndex_"+pClassName, StringPool.BLANK);
		int order = -1;
		try { order = Integer.parseInt(orderIndex); 
		} catch (Exception numE) {}
		if (order >=0 && order<orderVector.size()) 
		{
			if (orderVector.get(order) == null)
				orderVector.remove(order);
			orderVector.add(order, pClassName);
		}
		else
		{
			orderVector.add(pClassName);
		}
	}
	int arrayIndex = 0;
	for (int v=0; v<orderVector.size(); v++) 
	{
		String orderedName = orderVector.get(v);
		if (Validator.isNotNull(orderedName))
		{
			classNames[arrayIndex] = orderedName;
			arrayIndex++;
		}
	}


      out.write("\r\n");
      out.write("\r\n");
      out.write("<script language=\"JavaScript\" src=\"/html/js/editor/modalwindow.js\" type=\"text/javascript\"></script><noscript></noscript>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<div style=\"");
      out.print( rel_style );
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("<!--  here list all related content items -->\r\n");
if (hasDelete) {  
      out.write("\r\n");
      out.write("<form name=\"BS_RELATED_CONTENT_LISTS_FORM\" action=\"");
      if (_jspx_meth_liferay_002dportlet_005factionURL_005f0(_jspx_page_context))
        return;
      out.write("\" method=\"post\">\r\n");
      out.write("<input type=\"hidden\" name=\"rel_className\" value=\"");
      out.print( rel_className );
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"rel_primaryKey\" value=\"");
      out.print( rel_primaryKey );
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"redirect\" value=\"");
      out.print( currentURL );
      out.write("\">\r\n");
} 
      out.write('\r');
      out.write('\n');

long companyId = PortalUtil.getCompanyId(request);
String mmsurl = PropsUtil.get(companyId, "bs.documents.media.server.url");
if (mmsurl!=null && mmsurl.endsWith("/")) 
    mmsurl = mmsurl.substring(0, mmsurl.length()-1);
boolean useThumbnails = GetterUtil.getBoolean(PropsUtil.get(companyId, "bs.documents.video.create.thumbnail"), false);

String lang = GeneralUtils.getLocale(request);
boolean foundAtLeastOneItem = false;
boolean usedHeader = false;
int count_tables=0;
for (String className: classNames) {
count_tables++;
	if (Validator.isNull(instancePortletShowRelContent) || 
			instancePortletShowRelContent.indexOf(className) != -1) 
	{
		boolean isDocument = className.equals(gnomon.hibernate.model.base.documents.BsDocument.class.getName());
		boolean isJournal = className.equals(ContentRelUtil.JOURNAL_CLASSNAME);
			boolean isNew = className.equals(gnomon.hibernate.model.base.news.BsNew.class.getName());
		
		int sortcolumn=2;
		String sortorder="ascending";
		List<GnSearchResultRow> results = null;
		if (isJournal) {
			results = relUtil.searchRelatedArticles(companyId, "*", rel_className, rel_primaryKey, themeDisplay);
		}
		else {
			results = LuceneUtilities.searchForRelatedContent(request, lang, "*", new String[]{className}, rel_className, rel_primaryKey);
		}
		if (results != null && results.size() > 0) {
			foundAtLeastOneItem = true;
			String relatedPortletName = relUtil.getPortletNameForClassName(className);
			String langkey =  prefs.getValue("showRelContentLangKey_"+className, StringPool.BLANK);
			long rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+className, StringPool.BLANK));
			
			
			if (isJournal) {
			langkey =  prefs.getValue("showRelContentLangKey_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK);
				relatedPortletName = relUtil.JOURNAL_PORTLET;
				 rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK));
				}
			request.setAttribute("searchResults", results);
			if (!usedHeader) {
				usedHeader = true;
				
      out.write("\r\n");
      out.write("\t\t");
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");

			}
			
      out.write("\r\n");
      out.write("\t\t\t<fieldset>\r\n");
      out.write("\t\t\t<legend>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
 if (Validator.isNotNull(langkey)) {
      out.write("\r\n");
      out.write("\t\t\t\t");
      out.print( LanguageUtil.get(pageContext, langkey) );
      out.write(" \r\n");
      out.write("\t\t\t");
} else {
      out.write("\r\n");
      out.write("\t\t\t");
      out.print( LanguageUtil.get(pageContext, "javax.portlet.title."+relatedPortletName) );
      out.write("\r\n");
      out.write("\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t</legend>\r\n");
      out.write("\t\t\t");
if( isNew) {
					 sortcolumn=1;
					 sortorder="descending";
					
				}
				
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\t");

				String tablename="item"+count_tables;
				
      out.write("\r\n");
      out.write("\t\t\t\t");
      //  display:table
      org.displaytag.tags.TableTag _jspx_th_display_005ftable_005f0 = (org.displaytag.tags.TableTag) _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005fpagesize_005fname_005fid_005fexport_005fdefaultsort_005fdefaultorder.get(org.displaytag.tags.TableTag.class);
      _jspx_th_display_005ftable_005f0.setPageContext(_jspx_page_context);
      _jspx_th_display_005ftable_005f0.setParent(null);
      _jspx_th_display_005ftable_005f0.setUid(tablename);
      _jspx_th_display_005ftable_005f0.setName(new String("searchResults"));
      _jspx_th_display_005ftable_005f0.setDefaultsort(sortcolumn );
      _jspx_th_display_005ftable_005f0.setDefaultorder(sortorder);
      _jspx_th_display_005ftable_005f0.setPagesize(-1);
      _jspx_th_display_005ftable_005f0.setSort("list");
      _jspx_th_display_005ftable_005f0.setExport(false);
      _jspx_th_display_005ftable_005f0.setStyle("width: 100%;");
      int _jspx_eval_display_005ftable_005f0 = _jspx_th_display_005ftable_005f0.doStartTag();
      if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_display_005ftable_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_display_005ftable_005f0.doInitBody();
        }
        do {
          out.write('	');
 GnSearchResultRow searchItem = (GnSearchResultRow) pageContext.getAttribute(tablename); 
          out.write("\r\n");
          out.write("                ");
          if (_jspx_meth_display_005fsetProperty_005f0(_jspx_th_display_005ftable_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t");
 if (hasDelete) { 
          out.write("\r\n");
          out.write("\t\t\t");
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f0 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f0.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          int _jspx_eval_display_005fcolumn_005f0 = _jspx_th_display_005fcolumn_005f0.doStartTag();
          if (_jspx_eval_display_005fcolumn_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_display_005fcolumn_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_display_005fcolumn_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_display_005fcolumn_005f0.doInitBody();
            }
            do {
              out.write("\r\n");
              out.write("\t\t\t<input type=\"checkbox\" name=\"rel_relatedItem\" value=\"");
              out.print( searchItem.getClassName()+"."+searchItem.getId() );
              out.write("\">\r\n");
              out.write("\t\t\t");
              int evalDoAfterBody = _jspx_th_display_005fcolumn_005f0.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_display_005fcolumn_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_display_005fcolumn_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn.reuse(_jspx_th_display_005fcolumn_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn.reuse(_jspx_th_display_005fcolumn_005f0);
          out.write("\r\n");
          out.write("\t\t\t");
 } 
          out.write("\r\n");
          out.write("\t\t\t");
          //  display:column
          org.displaytag.tags.ColumnTag _jspx_th_display_005fcolumn_005f1 = (org.displaytag.tags.ColumnTag) _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fsortProperty.get(org.displaytag.tags.ColumnTag.class);
          _jspx_th_display_005fcolumn_005f1.setPageContext(_jspx_page_context);
          _jspx_th_display_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005ftable_005f0);
          _jspx_th_display_005fcolumn_005f1.setStyle("width:100%");
          _jspx_th_display_005fcolumn_005f1.setSortProperty("date");
          int _jspx_eval_display_005fcolumn_005f1 = _jspx_th_display_005fcolumn_005f1.doStartTag();
          if (_jspx_eval_display_005fcolumn_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_display_005fcolumn_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_display_005fcolumn_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_display_005fcolumn_005f1.doInitBody();
            }
            do {
              out.write("\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t");

			
	
				if (rootPlid<=0) {
/* IF WE WANT THE CONTENT TO OPEN IN CURRENT LAYOUT */
				
              out.write("\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t<strong>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t\t");
 if (searchItem.getPortlet().equals(ContentRelUtil.JOURNAL_PORTLET)) { 
              out.write("\r\n");
              out.write("\t\t\t\t<a title=\"");
              out.print( searchItem.getTitle() );
              out.write("\"   href=\"");
              out.print( searchItem.getUrl() );
              out.write('"');
              out.write('>');
              out.print( searchItem.getTitle() );
              out.write("\r\n");
              out.write("\t\t\t         </a>\r\n");
              out.write("\t\t\t   ");
 } else if(!isDocument){ 
              out.write("\r\n");
              out.write("\t\t\t \t<a title=\"");
              out.print( searchItem.getTitle() );
              out.write("\"  href=\"");
              //  liferay-portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_liferay_002dportlet_005factionURL_005f1 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_liferay_002dportlet_005factionURL_005f1.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dportlet_005factionURL_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f1);
              _jspx_th_liferay_002dportlet_005factionURL_005f1.setPortletName( searchItem.getPortlet() );
              _jspx_th_liferay_002dportlet_005factionURL_005f1.setWindowState((isDocument)?"exclusive":"maximized");
              int _jspx_eval_liferay_002dportlet_005factionURL_005f1 = _jspx_th_liferay_002dportlet_005factionURL_005f1.doStartTag();
              if (_jspx_eval_liferay_002dportlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_liferay_002dportlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_liferay_002dportlet_005factionURL_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_liferay_002dportlet_005factionURL_005f1.doInitBody();
                }
                do {
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  //  liferay-portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f1 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_liferay_002dportlet_005fparam_005f1.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dportlet_005fparam_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f1);
                  _jspx_th_liferay_002dportlet_005fparam_005f1.setName("struts_action");
                  _jspx_th_liferay_002dportlet_005fparam_005f1.setValue( searchItem.getUrl() );
                  int _jspx_eval_liferay_002dportlet_005fparam_005f1 = _jspx_th_liferay_002dportlet_005fparam_005f1.doStartTag();
                  if (_jspx_th_liferay_002dportlet_005fparam_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f1);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f1);
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  //  liferay-portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f2 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_liferay_002dportlet_005fparam_005f2.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dportlet_005fparam_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f1);
                  _jspx_th_liferay_002dportlet_005fparam_005f2.setName("mainid");
                  _jspx_th_liferay_002dportlet_005fparam_005f2.setValue( searchItem.getId() );
                  int _jspx_eval_liferay_002dportlet_005fparam_005f2 = _jspx_th_liferay_002dportlet_005fparam_005f2.doStartTag();
                  if (_jspx_th_liferay_002dportlet_005fparam_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f2);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f2);
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  if (_jspx_meth_liferay_002dportlet_005fparam_005f3(_jspx_th_liferay_002dportlet_005factionURL_005f1, _jspx_page_context))
                    return;
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  //  liferay-portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f4 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_liferay_002dportlet_005fparam_005f4.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dportlet_005fparam_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f1);
                  _jspx_th_liferay_002dportlet_005fparam_005f4.setName("redirect");
                  _jspx_th_liferay_002dportlet_005fparam_005f4.setValue( currentURL );
                  int _jspx_eval_liferay_002dportlet_005fparam_005f4 = _jspx_th_liferay_002dportlet_005fparam_005f4.doStartTag();
                  if (_jspx_th_liferay_002dportlet_005fparam_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f4);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f4);
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  int evalDoAfterBody = _jspx_th_liferay_002dportlet_005factionURL_005f1.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_liferay_002dportlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_liferay_002dportlet_005factionURL_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f1);
              out.write('"');
              out.write('>');
              out.print( searchItem.getTitle() );
              out.write("</a>\r\n");
              out.write("\t\t\t     \t\t\t        \r\n");
              out.write("\t\t\t\t ");
 } else if (isDocument) { 
					String docTitle=searchItem.getTitle();
					String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
					
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
							ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+companyId, filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
					if( gnomon.business.FileUploadHelper.fileIsImage(companyId, extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
								String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						
              out.write("\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t\t<a href=\"");
              out.print( fullpath);
              out.write("\"  class=\"thickbox\" rel=\"gallery\" title=\"");
              out.print(StringUtils.check_null(searchItem.getTitle(),""));
              out.write("\">\r\n");
              out.write("\t\t\t\t\t\t\t<img src=\"");
              out.print( thumb);
              out.write("\"  alt=\"");
              out.print(StringUtils.check_null(searchItem.getTitle(),""));
              out.write("\" >\r\n");
              out.write("\t\t\t\t\t\t\t</a> \r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t");
} else if( gnomon.business.FileUploadHelper.fileIsAudio(companyId, extension) && instanceRelEmbedMedia.equals("yes")) {
                            String audioURL = fullpath;
                            //if media server is configured, use its path
                            if (Validator.isNotNull(mmsurl))
                                audioURL = mmsurl + audioURL;
                            
              out.write("\r\n");
              out.write("                            <div id=\"myOnPageContent");
              out.print(searchItem.getId());
              out.write("\">\r\n");
              out.write("                                ");
              out.write("\r\n");
              out.write("                                <object id=\"mediaPlayer");
              out.print(searchItem.getId());
              out.write("\" width=\"100\" height=\"90\" \r\n");
              out.write("                                        classid=\"CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6\"\r\n");
              out.write("                                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'\r\n");
              out.write("                                        standby='Loading Microsoft Windows Media Player components...' type=\"application/x-oleobject\">  \r\n");
              out.write("                                    <param name=\"URL\" value=\"");
              out.print( audioURL );
              out.write("\" />\r\n");
              out.write("                                    <param name=\"SendPlayStateChangeEvents\" value=\"True\" />\r\n");
              out.write("                                    <param name=\"AutoStart\" value=\"false\" />\r\n");
              out.write("                                    <param name=\"defaultFrame\" value=\"1\" />\r\n");
              out.write("                                    <param name=\"PlayCount\" value=\"9999\" />\r\n");
              out.write("                                    <!-- <param name=\"SAMIFileName\" value=\"captions/sample.smi\" /> -->\r\n");
              out.write("                                    <embed type=\"application/x-mplayer2\"\r\n");
              out.write("                                        pluginspage = \"http://www.microsoft.com/Windows/MediaPlayer/en/download/\"\r\n");
              out.write("                                        src=\"");
              out.print( audioURL );
              out.write("\"\r\n");
              out.write("                                        id=\"mediaPlayer\"\r\n");
              out.write("                                        width=\"100\"\r\n");
              out.write("                                        height=\"90\"\r\n");
              out.write("                                        autostart=\"0\">\r\n");
              out.write("                                    </embed>\r\n");
              out.write("                                </object>\r\n");
              out.write("                                <p>");
              out.print( docTitle );
              out.write("</p>\r\n");
              out.write("                            </div>\r\n");
              out.write("\t\r\n");
              out.write("\t\t");
} else if (gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {
                            String videoURL = fullpath;
                            String thumb = gnomon.business.GeneralUtils.createVideoThumbnailPath(fullpath);
                            if (Validator.isNotNull(mmsurl))
                                videoURL = mmsurl + videoURL;
                            
              out.write("\r\n");
              out.write("                            ");
//=mmsurl + videopath 
              out.write("\r\n");
              out.write("                            ");
              //  c:if
              org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
              _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
              _jspx_th_c_005fif_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f1);
              _jspx_th_c_005fif_005f0.setTest( useThumbnails );
              int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
              if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\r\n");
                  out.write("                                <a class=\"thickbox\" href=\"");
                  out.print( fullpath);
                  out.write("#TB_inline?height=350&width=330&inlineId=myOnPageContent");
                  out.print(searchItem.getId());
                  out.write("\" rel=\"documents\" title=\"");
                  out.print(docTitle);
                  out.write("\">\r\n");
                  out.write("                                <img src=\"");
                  out.print( thumb);
                  out.write("\" alt=\"");
                  out.print(docTitle);
                  out.write("\" >\r\n");
                  out.write("                                <p>");
                  out.print( docTitle );
                  out.write("</p>\r\n");
                  out.write("                                </a>\r\n");
                  out.write("                            ");
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
              out.write("\r\n");
              out.write("                            <div id=\"myOnPageContent");
              out.print(searchItem.getId());
              out.write("\" style=\"");
              out.print( useThumbnails? "display: none;": "");
              out.write("\">\r\n");
              out.write("                                ");
              out.write("\r\n");
              out.write("                                <object id=\"mediaPlayer");
              out.print(searchItem.getId());
              out.write("\" width=\"320\" height=\"304\" \r\n");
              out.write("                                        classid=\"CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6\"\r\n");
              out.write("                                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'\r\n");
              out.write("                                        standby='Loading Microsoft Windows Media Player components...' type=\"application/x-oleobject\">  \r\n");
              out.write("                                    <param name=\"URL\" value=\"");
              out.print( videoURL );
              out.write("\" />\r\n");
              out.write("                                    <param name=\"SendPlayStateChangeEvents\" value=\"True\" />\r\n");
              out.write("                                    <param name=\"AutoStart\" value=\"false\" />\r\n");
              out.write("                                    <param name=\"defaultFrame\" value=\"1\" />\r\n");
              out.write("                                    <param name=\"PlayCount\" value=\"9999\" />\r\n");
              out.write("                                    <!-- <param name=\"SAMIFileName\" value=\"captions/sample.smi\" /> -->\r\n");
              out.write("                                    <embed type=\"application/x-mplayer2\"\r\n");
              out.write("                                        pluginspage = \"http://www.microsoft.com/Windows/MediaPlayer/en/download/\"\r\n");
              out.write("                                        src=\"");
              out.print( videoURL );
              out.write("\"\r\n");
              out.write("                                        id=\"mediaPlayer\"\r\n");
              out.write("                                        width=\"320\"\r\n");
              out.write("                                        height=\"304\"\r\n");
              out.write("                                        autostart=\"0\">\r\n");
              out.write("                                    </embed>\r\n");
              out.write("                                </object>\r\n");
              out.write("                                <p>");
              out.print( docTitle );
              out.write("</p>\r\n");
              out.write("                            </div>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t");
} else {
              out.write("\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t\t\t\t<a title=\"");
              out.print( searchItem.getTitle() );
              out.write("\"\t  href=\"");
              //  liferay-portlet:actionURL
              com.liferay.taglib.portlet.ActionURLTag _jspx_th_liferay_002dportlet_005factionURL_005f2 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.get(com.liferay.taglib.portlet.ActionURLTag.class);
              _jspx_th_liferay_002dportlet_005factionURL_005f2.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dportlet_005factionURL_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f1);
              _jspx_th_liferay_002dportlet_005factionURL_005f2.setPortletName( searchItem.getPortlet() );
              _jspx_th_liferay_002dportlet_005factionURL_005f2.setWindowState("exclusive");
              int _jspx_eval_liferay_002dportlet_005factionURL_005f2 = _jspx_th_liferay_002dportlet_005factionURL_005f2.doStartTag();
              if (_jspx_eval_liferay_002dportlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_liferay_002dportlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_liferay_002dportlet_005factionURL_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_liferay_002dportlet_005factionURL_005f2.doInitBody();
                }
                do {
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  //  liferay-portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f5 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_liferay_002dportlet_005fparam_005f5.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dportlet_005fparam_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f2);
                  _jspx_th_liferay_002dportlet_005fparam_005f5.setName("struts_action");
                  _jspx_th_liferay_002dportlet_005fparam_005f5.setValue( searchItem.getUrl() );
                  int _jspx_eval_liferay_002dportlet_005fparam_005f5 = _jspx_th_liferay_002dportlet_005fparam_005f5.doStartTag();
                  if (_jspx_th_liferay_002dportlet_005fparam_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f5);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f5);
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  //  liferay-portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f6 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_liferay_002dportlet_005fparam_005f6.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dportlet_005fparam_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f2);
                  _jspx_th_liferay_002dportlet_005fparam_005f6.setName("mainid");
                  _jspx_th_liferay_002dportlet_005fparam_005f6.setValue( searchItem.getId() );
                  int _jspx_eval_liferay_002dportlet_005fparam_005f6 = _jspx_th_liferay_002dportlet_005fparam_005f6.doStartTag();
                  if (_jspx_th_liferay_002dportlet_005fparam_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f6);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f6);
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  if (_jspx_meth_liferay_002dportlet_005fparam_005f7(_jspx_th_liferay_002dportlet_005factionURL_005f2, _jspx_page_context))
                    return;
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  //  liferay-portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f8 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_liferay_002dportlet_005fparam_005f8.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dportlet_005fparam_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f2);
                  _jspx_th_liferay_002dportlet_005fparam_005f8.setName("redirect");
                  _jspx_th_liferay_002dportlet_005fparam_005f8.setValue( currentURL );
                  int _jspx_eval_liferay_002dportlet_005fparam_005f8 = _jspx_th_liferay_002dportlet_005fparam_005f8.doStartTag();
                  if (_jspx_th_liferay_002dportlet_005fparam_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f8);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f8);
                  out.write("\r\n");
                  out.write("\t\t\t\t\t");
                  int evalDoAfterBody = _jspx_th_liferay_002dportlet_005factionURL_005f2.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_liferay_002dportlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_liferay_002dportlet_005factionURL_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f2);
              out.write("\">\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t<img style=\"float:left; border:0;\" alt=\"");
              out.print( docTitle );
              out.write("\" src=\"");
              out.print(themeDisplay.getPathThemeImage() + "/document_library/" + extension);
              out.write(".gif\" />\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t ");
              out.print( docTitle );
              out.write(' ');
              out.write('(');
              out.write(' ');
              out.print(extension);
              out.write(' ');
              out.write(' ');
              out.print(docsize!=null?docsize.intValue() + "KB": "");
              out.write(" )</a>\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t");
 }
					}
              out.write(" \r\n");
              out.write("\t\t\t        \r\n");
              out.write("\t\t\t</strong>\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t");
}  else { 			
				/* IF WE WANT THE CONTENT TO OPEN IN ANOTHER LAYOUT */
				PortletURLImpl pURL=null;
				
  		 		 if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, searchItem.getPortlet(), rootPlid, true);
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, searchItem.getPortlet(), rootPlid, true);
				}
    
  
		
				 if(isDocument)
			 			pURL.setWindowState("exclusive");
				else
						pURL.setWindowState(WindowState.NORMAL);
			
				pURL.setPortletMode(PortletMode.VIEW);
				pURL.setParameter("struts_action",  searchItem.getUrl() );	
    			pURL.setParameter("mainid" ,  searchItem.getId());
				pURL.setParameter("loadaction" , "view");
				pURL.setParameter("redirect" , currentURL);
			
			
			
              out.write("\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t<strong>\r\n");
              out.write("\t\t\t\t");
 if (!isDocument) { 
              out.write("\r\n");
              out.write("\t\t\t\t\t<a title=\"");
              out.print( searchItem.getTitle() );
              out.write("\"\thref=\"");
              out.print(pURL.toString());
              out.write('"');
              out.write('>');
              out.write(' ');
              out.print( searchItem.getTitle() );
              out.write("  </a>\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t");
 } else if(isDocument) { 
						String docTitle=searchItem.getTitle();
						String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
				
					
						ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+companyId, filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
						if( gnomon.business.FileUploadHelper.fileIsImage(extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
						String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						
						
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
				
              out.write("\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t<a href=\"");
              out.print( fullpath);
              out.write("\"  class=\"thickbox\" rel=\"gallery\" title=\"");
              out.print(StringUtils.check_null(searchItem.getTitle(),""));
              out.write("\">\r\n");
              out.write("\t\t\t\t<img src=\"");
              out.print( thumb);
              out.write("\"  alt=\"");
              out.print(StringUtils.check_null(searchItem.getTitle(),""));
              out.write("\" >\r\n");
              out.write("\t\t\t\t</a> \r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t");
} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceRelEmbedMedia.equals("yes")) {
                            String audioURL = fullpath;
                            //if media server is configured, use its path
                            if (Validator.isNotNull(mmsurl))
                                audioURL = mmsurl + audioURL;
                            
              out.write("\r\n");
              out.write("                            <div id=\"myOnPageContent");
              out.print(searchItem.getId());
              out.write("\">\r\n");
              out.write("                                ");
              out.write("\r\n");
              out.write("                                <object id=\"mediaPlayer");
              out.print(searchItem.getId());
              out.write("\" width=\"100\" height=\"90\" \r\n");
              out.write("                                        classid=\"CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6\"\r\n");
              out.write("                                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'\r\n");
              out.write("                                        standby='Loading Microsoft Windows Media Player components...' type=\"application/x-oleobject\">  \r\n");
              out.write("                                    <param name=\"URL\" value=\"");
              out.print( audioURL );
              out.write("\" />\r\n");
              out.write("                                    <param name=\"SendPlayStateChangeEvents\" value=\"True\" />\r\n");
              out.write("                                    <param name=\"AutoStart\" value=\"false\" />\r\n");
              out.write("                                    <param name=\"defaultFrame\" value=\"1\" />\r\n");
              out.write("                                    <param name=\"PlayCount\" value=\"9999\" />\r\n");
              out.write("                                    <!-- <param name=\"SAMIFileName\" value=\"captions/sample.smi\" /> -->\r\n");
              out.write("                                    <embed type=\"application/x-mplayer2\"\r\n");
              out.write("                                        pluginspage = \"http://www.microsoft.com/Windows/MediaPlayer/en/download/\"\r\n");
              out.write("                                        src=\"");
              out.print( audioURL );
              out.write("\"\r\n");
              out.write("                                        id=\"mediaPlayer\"\r\n");
              out.write("                                        width=\"100\"\r\n");
              out.write("                                        height=\"90\"\r\n");
              out.write("                                        autostart=\"0\">\r\n");
              out.write("                                    </embed>\r\n");
              out.write("                                </object>\r\n");
              out.write("                                <p>");
              out.print( docTitle );
              out.write("</p>\r\n");
              out.write("                            </div>\r\n");
              out.write("\t\r\n");
              out.write("\t\t");
} else if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {
            String videoURL = fullpath;
            String thumb = gnomon.business.GeneralUtils.createVideoThumbnailPath(fullpath);
            if (Validator.isNotNull(mmsurl))
                videoURL = mmsurl + videoURL;
            
              out.write("\r\n");
              out.write("            ");
//=mmsurl + videopath 
              out.write("\r\n");
              out.write("            ");
              //  c:if
              org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
              _jspx_th_c_005fif_005f1.setPageContext(_jspx_page_context);
              _jspx_th_c_005fif_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_display_005fcolumn_005f1);
              _jspx_th_c_005fif_005f1.setTest( useThumbnails );
              int _jspx_eval_c_005fif_005f1 = _jspx_th_c_005fif_005f1.doStartTag();
              if (_jspx_eval_c_005fif_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\r\n");
                  out.write("                <a class=\"thickbox\" href=\"");
                  out.print( fullpath);
                  out.write("#TB_inline?height=350&width=330&inlineId=myOnPageContent");
                  out.print(searchItem.getId());
                  out.write("\" rel=\"documents\" title=\"");
                  out.print(docTitle);
                  out.write("\">\r\n");
                  out.write("                <img src=\"");
                  out.print( thumb);
                  out.write("\" alt=\"");
                  out.print(docTitle);
                  out.write("\" >\r\n");
                  out.write("                <p>");
                  out.print( docTitle );
                  out.write("</p>\r\n");
                  out.write("                </a>\r\n");
                  out.write("            ");
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
              out.write("\r\n");
              out.write("            <div id=\"myOnPageContent");
              out.print(searchItem.getId());
              out.write("\" style=\"");
              out.print( useThumbnails? "display: none;": "");
              out.write("\">\r\n");
              out.write("                ");
              out.write("\r\n");
              out.write("                <object id=\"mediaPlayer");
              out.print(searchItem.getId());
              out.write("\" width=\"320\" height=\"304\" \r\n");
              out.write("                        classid=\"CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6\"\r\n");
              out.write("                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'\r\n");
              out.write("                        standby='Loading Microsoft Windows Media Player components...' type=\"application/x-oleobject\">  \r\n");
              out.write("                    <param name=\"URL\" value=\"");
              out.print( videoURL );
              out.write("\" />\r\n");
              out.write("                    <param name=\"SendPlayStateChangeEvents\" value=\"True\" />\r\n");
              out.write("                    <param name=\"AutoStart\" value=\"false\" />\r\n");
              out.write("                    <param name=\"defaultFrame\" value=\"1\" />\r\n");
              out.write("                    <param name=\"PlayCount\" value=\"9999\" />\r\n");
              out.write("                    <!-- <param name=\"SAMIFileName\" value=\"captions/sample.smi\" /> -->\r\n");
              out.write("                    <embed type=\"application/x-mplayer2\"\r\n");
              out.write("                        pluginspage = \"http://www.microsoft.com/Windows/MediaPlayer/en/download/\"\r\n");
              out.write("                        src=\"");
              out.print( videoURL );
              out.write("\"\r\n");
              out.write("                        id=\"mediaPlayer\"\r\n");
              out.write("                        width=\"320\"\r\n");
              out.write("                        height=\"304\"\r\n");
              out.write("                        autostart=\"0\">\r\n");
              out.write("                    </embed>\r\n");
              out.write("                </object>\r\n");
              out.write("                <p>");
              out.print( docTitle );
              out.write("</p>\r\n");
              out.write("            </div>\r\n");
              out.write("\t\t");
} else {
              out.write("\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t\t\t\t<a title=\"");
              out.print( searchItem.getTitle() );
              out.write("\" href=\"");
              out.print(pURL.toString());
              out.write("\">\r\n");
              out.write("\t\t\t\t\t<img style=\"float:left; border:0;\" alt=\"");
              out.print( searchItem.getTitle() );
              out.write("\" src=\"");
              out.print(themeDisplay.getPathThemeImage() + "/document_library/" + extension);
              out.write(".gif\" />\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t ");
              out.print( docTitle );
              out.write(' ');
              out.write('(');
              out.write(' ');
              out.print(extension);
              out.write(' ');
              out.write(' ');
              out.print(docsize!=null?docsize.intValue() + "KB": "");
              out.write(" )</a>\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t");
 }
				}
					 
              out.write(" \r\n");
              out.write("\t\t\t        \r\n");
              out.write("\t\t\t</strong>\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t");
} // end of else or rootplid
              out.write("\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t");
 if (Validator.isNotNull(instancePortletShowRelContentDescription) && 
				instancePortletShowRelContentDescription.indexOf(className) != -1) { 
              out.write(" \r\n");
              out.write("\t\t\t\t<br/>\r\n");
              out.write("\t\t\t\t");
 if (className.equals(gnomon.hibernate.model.base.news.BsNew.class.getName())) { 
              out.write("\r\n");
              out.write("\t\t\t\t");
              out.print( StringUtils.check_null(searchItem.getDescription(),"") );
              out.write("\r\n");
              out.write("\t\t\t\t");
 } else { 
              out.write("\r\n");
              out.write("\t\t\t\t");
              out.print( StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(searchItem.getDescription(),"")).trim(),500) );
              out.write("\r\n");
              out.write("\t\t\t\t");
 } 
              out.write("\r\n");
              out.write("\t\t\t");
 } 
              out.write("\r\n");
              out.write("\t\t\t");
              int evalDoAfterBody = _jspx_th_display_005fcolumn_005f1.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_display_005fcolumn_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_display_005fcolumn_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fsortProperty.reuse(_jspx_th_display_005fcolumn_005f1);
            return;
          }
          _005fjspx_005ftagPool_005fdisplay_005fcolumn_005fstyle_005fsortProperty.reuse(_jspx_th_display_005fcolumn_005f1);
          out.write("\r\n");
          out.write("\t\t\t");
          int evalDoAfterBody = _jspx_th_display_005ftable_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_display_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_display_005ftable_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005fpagesize_005fname_005fid_005fexport_005fdefaultsort_005fdefaultorder.reuse(_jspx_th_display_005ftable_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fdisplay_005ftable_005fstyle_005fsort_005fpagesize_005fname_005fid_005fexport_005fdefaultsort_005fdefaultorder.reuse(_jspx_th_display_005ftable_005f0);
      out.write("\r\n");
      out.write("\t\t\t</fieldset>\r\n");
      out.write("\t\t\t");

		}
	}
}

if (foundAtLeastOneItem && hasDelete) { 
      out.write("\r\n");
      out.write("<input type=\"submit\" value=\"");
      out.print( LanguageUtil.get(pageContext, "bs.related.content.delete") );
      out.write("\" onClick=\"return confirm('");
      out.print( LanguageUtil.get(pageContext, "bs.related.content.delete-are-you-sure") );
      out.write("');\">\r\n");
 } 
      out.write("\r\n");
      out.write("\r\n");
if (hasDelete) {  
      out.write("\r\n");
      out.write("</form>\r\n");
} 
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
 if (hasAdd) { 
      out.write("\r\n");
      out.write("<a href=\"javascript:openDialog('");
      //  liferay-portlet:actionURL
      com.liferay.taglib.portlet.ActionURLTag _jspx_th_liferay_002dportlet_005factionURL_005f3 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.get(com.liferay.taglib.portlet.ActionURLTag.class);
      _jspx_th_liferay_002dportlet_005factionURL_005f3.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dportlet_005factionURL_005f3.setParent(null);
      _jspx_th_liferay_002dportlet_005factionURL_005f3.setPortletName("bs_content_rels");
      _jspx_th_liferay_002dportlet_005factionURL_005f3.setWindowState("pop_up");
      int _jspx_eval_liferay_002dportlet_005factionURL_005f3 = _jspx_th_liferay_002dportlet_005factionURL_005f3.doStartTag();
      if (_jspx_eval_liferay_002dportlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_liferay_002dportlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_liferay_002dportlet_005factionURL_005f3.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_liferay_002dportlet_005factionURL_005f3.doInitBody();
        }
        do {
          out.write("\r\n");
          out.write("\t\t");
          if (_jspx_meth_liferay_002dportlet_005fparam_005f9(_jspx_th_liferay_002dportlet_005factionURL_005f3, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t");
          //  liferay-portlet:param
          com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f10 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
          _jspx_th_liferay_002dportlet_005fparam_005f10.setPageContext(_jspx_page_context);
          _jspx_th_liferay_002dportlet_005fparam_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f3);
          _jspx_th_liferay_002dportlet_005fparam_005f10.setName("rel_className");
          _jspx_th_liferay_002dportlet_005fparam_005f10.setValue( rel_className );
          int _jspx_eval_liferay_002dportlet_005fparam_005f10 = _jspx_th_liferay_002dportlet_005fparam_005f10.doStartTag();
          if (_jspx_th_liferay_002dportlet_005fparam_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f10);
            return;
          }
          _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f10);
          out.write("\r\n");
          out.write("\t\t");
          //  liferay-portlet:param
          com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f11 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
          _jspx_th_liferay_002dportlet_005fparam_005f11.setPageContext(_jspx_page_context);
          _jspx_th_liferay_002dportlet_005fparam_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f3);
          _jspx_th_liferay_002dportlet_005fparam_005f11.setName("rel_primaryKey");
          _jspx_th_liferay_002dportlet_005fparam_005f11.setValue( rel_primaryKey );
          int _jspx_eval_liferay_002dportlet_005fparam_005f11 = _jspx_th_liferay_002dportlet_005fparam_005f11.doStartTag();
          if (_jspx_th_liferay_002dportlet_005fparam_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f11);
            return;
          }
          _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f11);
          out.write("\r\n");
          out.write("\t\t");
          int evalDoAfterBody = _jspx_th_liferay_002dportlet_005factionURL_005f3.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_liferay_002dportlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_liferay_002dportlet_005factionURL_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f3);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f3);
      out.write("', 650, 450);\">\r\n");
      out.write("<img src=\"");
      out.print( themeDisplay.getPathThemeImage() );
      out.write("/common/links.png\" alt=\"link icon\">\t\t\r\n");
      out.print( LanguageUtil.get(pageContext, "bs.related.content.add") );
      out.write(" ...\r\n");
      out.write("</a>\t\r\n");
 } 
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
 } 
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

  private boolean _jspx_meth_liferay_002dportlet_005factionURL_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-portlet:actionURL
    com.liferay.taglib.portlet.ActionURLTag _jspx_th_liferay_002dportlet_005factionURL_005f0 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.get(com.liferay.taglib.portlet.ActionURLTag.class);
    _jspx_th_liferay_002dportlet_005factionURL_005f0.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dportlet_005factionURL_005f0.setParent(null);
    _jspx_th_liferay_002dportlet_005factionURL_005f0.setPortletName("bs_content_rels");
    _jspx_th_liferay_002dportlet_005factionURL_005f0.setWindowState("maximized");
    int _jspx_eval_liferay_002dportlet_005factionURL_005f0 = _jspx_th_liferay_002dportlet_005factionURL_005f0.doStartTag();
    if (_jspx_eval_liferay_002dportlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_liferay_002dportlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_liferay_002dportlet_005factionURL_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_liferay_002dportlet_005factionURL_005f0.doInitBody();
      }
      do {
        if (_jspx_meth_liferay_002dportlet_005fparam_005f0(_jspx_th_liferay_002dportlet_005factionURL_005f0, _jspx_page_context))
          return true;
        int evalDoAfterBody = _jspx_th_liferay_002dportlet_005factionURL_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_liferay_002dportlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_liferay_002dportlet_005factionURL_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dportlet_005factionURL_005fwindowState_005fportletName.reuse(_jspx_th_liferay_002dportlet_005factionURL_005f0);
    return false;
  }

  private boolean _jspx_meth_liferay_002dportlet_005fparam_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_liferay_002dportlet_005factionURL_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f0 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_liferay_002dportlet_005fparam_005f0.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dportlet_005fparam_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f0);
    _jspx_th_liferay_002dportlet_005fparam_005f0.setName("struts_action");
    _jspx_th_liferay_002dportlet_005fparam_005f0.setValue("/ext/contentrel/deleteRelatedItems");
    int _jspx_eval_liferay_002dportlet_005fparam_005f0 = _jspx_th_liferay_002dportlet_005fparam_005f0.doStartTag();
    if (_jspx_th_liferay_002dportlet_005fparam_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f0);
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
    _jspx_th_display_005fsetProperty_005f0.setName("basic.show.header");
    _jspx_th_display_005fsetProperty_005f0.setValue("false");
    int _jspx_eval_display_005fsetProperty_005f0 = _jspx_th_display_005fsetProperty_005f0.doStartTag();
    if (_jspx_th_display_005fsetProperty_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fdisplay_005fsetProperty_005fvalue_005fname_005fnobody.reuse(_jspx_th_display_005fsetProperty_005f0);
    return false;
  }

  private boolean _jspx_meth_liferay_002dportlet_005fparam_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_liferay_002dportlet_005factionURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f3 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_liferay_002dportlet_005fparam_005f3.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dportlet_005fparam_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f1);
    _jspx_th_liferay_002dportlet_005fparam_005f3.setName("loadaction");
    _jspx_th_liferay_002dportlet_005fparam_005f3.setValue("view");
    int _jspx_eval_liferay_002dportlet_005fparam_005f3 = _jspx_th_liferay_002dportlet_005fparam_005f3.doStartTag();
    if (_jspx_th_liferay_002dportlet_005fparam_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f3);
    return false;
  }

  private boolean _jspx_meth_liferay_002dportlet_005fparam_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_liferay_002dportlet_005factionURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f7 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_liferay_002dportlet_005fparam_005f7.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dportlet_005fparam_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f2);
    _jspx_th_liferay_002dportlet_005fparam_005f7.setName("loadaction");
    _jspx_th_liferay_002dportlet_005fparam_005f7.setValue("view");
    int _jspx_eval_liferay_002dportlet_005fparam_005f7 = _jspx_th_liferay_002dportlet_005fparam_005f7.doStartTag();
    if (_jspx_th_liferay_002dportlet_005fparam_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f7);
    return false;
  }

  private boolean _jspx_meth_liferay_002dportlet_005fparam_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_liferay_002dportlet_005factionURL_005f3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_liferay_002dportlet_005fparam_005f9 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_liferay_002dportlet_005fparam_005f9.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dportlet_005fparam_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_liferay_002dportlet_005factionURL_005f3);
    _jspx_th_liferay_002dportlet_005fparam_005f9.setName("struts_action");
    _jspx_th_liferay_002dportlet_005fparam_005f9.setValue("/ext/contentrel/search");
    int _jspx_eval_liferay_002dportlet_005fparam_005f9 = _jspx_th_liferay_002dportlet_005fparam_005f9.doStartTag();
    if (_jspx_th_liferay_002dportlet_005fparam_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_liferay_002dportlet_005fparam_005f9);
    return false;
  }
}
