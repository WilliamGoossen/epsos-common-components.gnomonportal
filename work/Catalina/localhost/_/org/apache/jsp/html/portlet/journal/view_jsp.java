package org.apache.jsp.html.portlet.journal;

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
import com.liferay.portlet.documentlibrary.util.DLUtil;
import com.liferay.portlet.journal.ArticleContentException;
import com.liferay.portlet.journal.ArticleDisplayDateException;
import com.liferay.portlet.journal.ArticleExpirationDateException;
import com.liferay.portlet.journal.ArticleIdException;
import com.liferay.portlet.journal.ArticleTitleException;
import com.liferay.portlet.journal.ArticleTypeException;
import com.liferay.portlet.journal.DuplicateArticleIdException;
import com.liferay.portlet.journal.DuplicateStructureIdException;
import com.liferay.portlet.journal.DuplicateTemplateIdException;
import com.liferay.portlet.journal.NoSuchArticleException;
import com.liferay.portlet.journal.NoSuchStructureException;
import com.liferay.portlet.journal.NoSuchTemplateException;
import com.liferay.portlet.journal.RequiredStructureException;
import com.liferay.portlet.journal.RequiredTemplateException;
import com.liferay.portlet.journal.StructureDescriptionException;
import com.liferay.portlet.journal.StructureIdException;
import com.liferay.portlet.journal.StructureNameException;
import com.liferay.portlet.journal.StructureXsdException;
import com.liferay.portlet.journal.TemplateDescriptionException;
import com.liferay.portlet.journal.TemplateIdException;
import com.liferay.portlet.journal.TemplateNameException;
import com.liferay.portlet.journal.TemplateSmallImageNameException;
import com.liferay.portlet.journal.TemplateSmallImageSizeException;
import com.liferay.portlet.journal.TemplateXslException;
import com.liferay.portlet.journal.action.EditArticleAction;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.model.JournalStructure;
import com.liferay.portlet.journal.model.JournalTemplate;
import com.liferay.portlet.journal.model.impl.JournalArticleImpl;
import com.liferay.portlet.journal.model.impl.JournalTemplateImpl;
import com.liferay.portlet.journal.search.ArticleDisplayTerms;
import com.liferay.portlet.journal.search.ArticleSearch;
import com.liferay.portlet.journal.search.ArticleSearchTerms;
import com.liferay.portlet.journal.search.StructureDisplayTerms;
import com.liferay.portlet.journal.search.StructureSearch;
import com.liferay.portlet.journal.search.StructureSearchTerms;
import com.liferay.portlet.journal.search.TemplateDisplayTerms;
import com.liferay.portlet.journal.search.TemplateSearch;
import com.liferay.portlet.journal.search.TemplateSearchTerms;
import com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil;
import com.liferay.portlet.journal.service.JournalStructureLocalServiceUtil;
import com.liferay.portlet.journal.service.JournalTemplateLocalServiceUtil;
import com.liferay.portlet.journal.service.permission.JournalArticlePermission;
import com.liferay.portlet.journal.service.permission.JournalStructurePermission;
import com.liferay.portlet.journal.service.permission.JournalTemplatePermission;
import com.liferay.portlet.journal.util.JournalUtil;
import org.dom4j.Document;
import org.dom4j.DocumentFactory;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public final class view_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(29);
    _jspx_dependants.add("/html/portlet/journal/init.jsp");
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
    _jspx_dependants.add("/html/portlet/journal/article_search_results.jspf");
    _jspx_dependants.add("/html/portlet/journal/structure_search_results.jspf");
    _jspx_dependants.add("/html/portlet/journal/template_search_results.jspf");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005ftabs_005furl_005fnames_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fchoose;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fwhen_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005ftabs_005furl_005fnames_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fchoose = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fwhen_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fliferay_002dtheme_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005fdefineObjects_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.release();
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005ftabs_005furl_005fnames_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fchoose.release();
    _005fjspx_005ftagPool_005fc_005fwhen_005ftest.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fif_005ftest.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.release();
    _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.release();
    _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.release();
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

PortalPreferences prefs = PortletPreferencesFactoryUtil.getPortalPreferences(request);

DateFormat dateFormatDate = DateFormats.getDate(locale, timeZone);

      out.write('\n');
      out.write('\n');

String tabs1 = ParamUtil.getString(request, "tabs1", "articles");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/journal/view");
portletURL.setParameter("tabs1", tabs1);

//GNOMONSA (replaced portletGroupId with portletGroupIdOv multiple time below)
Long portletGroupIdOv = PortalUtil.getPortletGroupId(layout.getPlid());

      out.write("\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("\tfunction ");
      if (_jspx_meth_portlet_005fnamespace_005f0(_jspx_page_context))
        return;
      out.write("deleteArticles() {\n");
      out.write("\t\tif (confirm('");
      out.print( UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-articles") );
      out.write("')) {\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f1(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f2(_jspx_page_context))
        return;
      out.print( Constants.CMD );
      out.write(".value = \"");
      out.print( Constants.DELETE );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f3(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f4(_jspx_page_context))
        return;
      out.write("groupId.value = \"");
      out.print( portletGroupIdOv.longValue() );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f5(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f6(_jspx_page_context))
        return;
      out.write("deleteArticleIds.value = Liferay.Util.listCheckedExcept(document.");
      if (_jspx_meth_portlet_005fnamespace_005f7(_jspx_page_context))
        return;
      out.write("fm, \"");
      if (_jspx_meth_portlet_005fnamespace_005f8(_jspx_page_context))
        return;
      out.write("allRowIds\");\n");
      out.write("\t\t\tsubmitForm(document.");
      if (_jspx_meth_portlet_005fnamespace_005f9(_jspx_page_context))
        return;
      out.write("fm, \"");
      //  portlet:actionURL
      com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f0 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.get(com.liferay.taglib.portlet.ActionURLTag.class);
      _jspx_th_portlet_005factionURL_005f0.setPageContext(_jspx_page_context);
      _jspx_th_portlet_005factionURL_005f0.setParent(null);
      _jspx_th_portlet_005factionURL_005f0.setWindowState( WindowState.MAXIMIZED.toString() );
      int _jspx_eval_portlet_005factionURL_005f0 = _jspx_th_portlet_005factionURL_005f0.doStartTag();
      if (_jspx_eval_portlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_portlet_005factionURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_portlet_005factionURL_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_portlet_005factionURL_005f0.doInitBody();
        }
        do {
          if (_jspx_meth_portlet_005fparam_005f0(_jspx_th_portlet_005factionURL_005f0, _jspx_page_context))
            return;
          //  portlet:param
          com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f1 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
          _jspx_th_portlet_005fparam_005f1.setPageContext(_jspx_page_context);
          _jspx_th_portlet_005fparam_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f0);
          _jspx_th_portlet_005fparam_005f1.setName("redirect");
          _jspx_th_portlet_005fparam_005f1.setValue( currentURL );
          int _jspx_eval_portlet_005fparam_005f1 = _jspx_th_portlet_005fparam_005f1.doStartTag();
          if (_jspx_th_portlet_005fparam_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f1);
            return;
          }
          _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f1);
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
      out.write("\");\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\tfunction ");
      if (_jspx_meth_portlet_005fnamespace_005f10(_jspx_page_context))
        return;
      out.write("deleteStructures() {\n");
      out.write("\t\tif (confirm('");
      out.print( UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-structures") );
      out.write("')) {\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f11(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f12(_jspx_page_context))
        return;
      out.print( Constants.CMD );
      out.write(".value = \"");
      out.print( Constants.DELETE );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f13(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f14(_jspx_page_context))
        return;
      out.write("groupId.value = \"");
      out.print( portletGroupIdOv.longValue() );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f15(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f16(_jspx_page_context))
        return;
      out.write("deleteStructureIds.value = Liferay.Util.listCheckedExcept(document.");
      if (_jspx_meth_portlet_005fnamespace_005f17(_jspx_page_context))
        return;
      out.write("fm, \"");
      if (_jspx_meth_portlet_005fnamespace_005f18(_jspx_page_context))
        return;
      out.write("allRowIds\");\n");
      out.write("\t\t\tsubmitForm(document.");
      if (_jspx_meth_portlet_005fnamespace_005f19(_jspx_page_context))
        return;
      out.write("fm, \"");
      //  portlet:actionURL
      com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f1 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.get(com.liferay.taglib.portlet.ActionURLTag.class);
      _jspx_th_portlet_005factionURL_005f1.setPageContext(_jspx_page_context);
      _jspx_th_portlet_005factionURL_005f1.setParent(null);
      _jspx_th_portlet_005factionURL_005f1.setWindowState( WindowState.MAXIMIZED.toString() );
      int _jspx_eval_portlet_005factionURL_005f1 = _jspx_th_portlet_005factionURL_005f1.doStartTag();
      if (_jspx_eval_portlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_portlet_005factionURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_portlet_005factionURL_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_portlet_005factionURL_005f1.doInitBody();
        }
        do {
          if (_jspx_meth_portlet_005fparam_005f2(_jspx_th_portlet_005factionURL_005f1, _jspx_page_context))
            return;
          //  portlet:param
          com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f3 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
          _jspx_th_portlet_005fparam_005f3.setPageContext(_jspx_page_context);
          _jspx_th_portlet_005fparam_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
          _jspx_th_portlet_005fparam_005f3.setName("redirect");
          _jspx_th_portlet_005fparam_005f3.setValue( currentURL );
          int _jspx_eval_portlet_005fparam_005f3 = _jspx_th_portlet_005fparam_005f3.doStartTag();
          if (_jspx_th_portlet_005fparam_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f3);
            return;
          }
          _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f3);
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
      out.write("\");\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\tfunction ");
      if (_jspx_meth_portlet_005fnamespace_005f20(_jspx_page_context))
        return;
      out.write("deleteTemplates() {\n");
      out.write("\t\tif (confirm('");
      out.print( UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-templates") );
      out.write("')) {\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f21(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f22(_jspx_page_context))
        return;
      out.print( Constants.CMD );
      out.write(".value = \"");
      out.print( Constants.DELETE );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f23(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f24(_jspx_page_context))
        return;
      out.write("groupId.value = \"");
      out.print( portletGroupIdOv.longValue() );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f25(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f26(_jspx_page_context))
        return;
      out.write("deleteTemplateIds.value = Liferay.Util.listCheckedExcept(document.");
      if (_jspx_meth_portlet_005fnamespace_005f27(_jspx_page_context))
        return;
      out.write("fm, \"");
      if (_jspx_meth_portlet_005fnamespace_005f28(_jspx_page_context))
        return;
      out.write("allRowIds\");\n");
      out.write("\t\t\tsubmitForm(document.");
      if (_jspx_meth_portlet_005fnamespace_005f29(_jspx_page_context))
        return;
      out.write("fm, \"");
      //  portlet:actionURL
      com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f2 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.get(com.liferay.taglib.portlet.ActionURLTag.class);
      _jspx_th_portlet_005factionURL_005f2.setPageContext(_jspx_page_context);
      _jspx_th_portlet_005factionURL_005f2.setParent(null);
      _jspx_th_portlet_005factionURL_005f2.setWindowState( WindowState.MAXIMIZED.toString() );
      int _jspx_eval_portlet_005factionURL_005f2 = _jspx_th_portlet_005factionURL_005f2.doStartTag();
      if (_jspx_eval_portlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_portlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_portlet_005factionURL_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_portlet_005factionURL_005f2.doInitBody();
        }
        do {
          if (_jspx_meth_portlet_005fparam_005f4(_jspx_th_portlet_005factionURL_005f2, _jspx_page_context))
            return;
          //  portlet:param
          com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f5 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
          _jspx_th_portlet_005fparam_005f5.setPageContext(_jspx_page_context);
          _jspx_th_portlet_005fparam_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
          _jspx_th_portlet_005fparam_005f5.setName("redirect");
          _jspx_th_portlet_005fparam_005f5.setValue( currentURL );
          int _jspx_eval_portlet_005fparam_005f5 = _jspx_th_portlet_005fparam_005f5.doStartTag();
          if (_jspx_th_portlet_005fparam_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f5);
            return;
          }
          _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f5);
          int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f2.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_portlet_005factionURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_portlet_005factionURL_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f2);
        return;
      }
      _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f2);
      out.write("\");\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\tfunction ");
      if (_jspx_meth_portlet_005fnamespace_005f30(_jspx_page_context))
        return;
      out.write("expireArticles() {\n");
      out.write("\t\tif (confirm('");
      out.print( UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-expire-the-selected-articles") );
      out.write("')) {\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f31(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f32(_jspx_page_context))
        return;
      out.print( Constants.CMD );
      out.write(".value = \"");
      out.print( Constants.EXPIRE );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f33(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f34(_jspx_page_context))
        return;
      out.write("groupId.value = \"");
      out.print( portletGroupIdOv.longValue() );
      out.write("\";\n");
      out.write("\t\t\tdocument.");
      if (_jspx_meth_portlet_005fnamespace_005f35(_jspx_page_context))
        return;
      out.write('f');
      out.write('m');
      out.write('.');
      if (_jspx_meth_portlet_005fnamespace_005f36(_jspx_page_context))
        return;
      out.write("expireArticleIds.value = Liferay.Util.listCheckedExcept(document.");
      if (_jspx_meth_portlet_005fnamespace_005f37(_jspx_page_context))
        return;
      out.write("fm, \"");
      if (_jspx_meth_portlet_005fnamespace_005f38(_jspx_page_context))
        return;
      out.write("allRowIds\");\n");
      out.write("\t\t\tsubmitForm(document.");
      if (_jspx_meth_portlet_005fnamespace_005f39(_jspx_page_context))
        return;
      out.write("fm, \"");
      //  portlet:actionURL
      com.liferay.taglib.portlet.ActionURLTag _jspx_th_portlet_005factionURL_005f3 = (com.liferay.taglib.portlet.ActionURLTag) _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.get(com.liferay.taglib.portlet.ActionURLTag.class);
      _jspx_th_portlet_005factionURL_005f3.setPageContext(_jspx_page_context);
      _jspx_th_portlet_005factionURL_005f3.setParent(null);
      _jspx_th_portlet_005factionURL_005f3.setWindowState( WindowState.MAXIMIZED.toString() );
      int _jspx_eval_portlet_005factionURL_005f3 = _jspx_th_portlet_005factionURL_005f3.doStartTag();
      if (_jspx_eval_portlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_portlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_portlet_005factionURL_005f3.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_portlet_005factionURL_005f3.doInitBody();
        }
        do {
          if (_jspx_meth_portlet_005fparam_005f6(_jspx_th_portlet_005factionURL_005f3, _jspx_page_context))
            return;
          //  portlet:param
          com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f7 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
          _jspx_th_portlet_005fparam_005f7.setPageContext(_jspx_page_context);
          _jspx_th_portlet_005fparam_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
          _jspx_th_portlet_005fparam_005f7.setName("redirect");
          _jspx_th_portlet_005fparam_005f7.setValue( currentURL );
          int _jspx_eval_portlet_005fparam_005f7 = _jspx_th_portlet_005fparam_005f7.doStartTag();
          if (_jspx_th_portlet_005fparam_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f7);
            return;
          }
          _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f7);
          int evalDoAfterBody = _jspx_th_portlet_005factionURL_005f3.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_portlet_005factionURL_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_portlet_005factionURL_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f3);
        return;
      }
      _005fjspx_005ftagPool_005fportlet_005factionURL_005fwindowState.reuse(_jspx_th_portlet_005factionURL_005f3);
      out.write("\");\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<form action=\"");
      out.print( portletURL.toString() );
      out.write("\" method=\"post\" name=\"");
      if (_jspx_meth_portlet_005fnamespace_005f40(_jspx_page_context))
        return;
      out.write("fm\" onSubmit=\"submitForm(this); return false;\">\n");
      out.write("<input name=\"");
      if (_jspx_meth_portlet_005fnamespace_005f41(_jspx_page_context))
        return;
      out.print( Constants.CMD );
      out.write("\" type=\"hidden\" value=\"\" />\n");
      out.write("\n");
      //  liferay-ui:tabs
      com.liferay.taglib.ui.TabsTag _jspx_th_liferay_002dui_005ftabs_005f0 = (com.liferay.taglib.ui.TabsTag) _005fjspx_005ftagPool_005fliferay_002dui_005ftabs_005furl_005fnames_005fnobody.get(com.liferay.taglib.ui.TabsTag.class);
      _jspx_th_liferay_002dui_005ftabs_005f0.setPageContext(_jspx_page_context);
      _jspx_th_liferay_002dui_005ftabs_005f0.setParent(null);
      _jspx_th_liferay_002dui_005ftabs_005f0.setNames("articles,structures,templates,recent");
      _jspx_th_liferay_002dui_005ftabs_005f0.setUrl( portletURL.toString() );
      int _jspx_eval_liferay_002dui_005ftabs_005f0 = _jspx_th_liferay_002dui_005ftabs_005f0.doStartTag();
      if (_jspx_th_liferay_002dui_005ftabs_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fliferay_002dui_005ftabs_005furl_005fnames_005fnobody.reuse(_jspx_th_liferay_002dui_005ftabs_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fliferay_002dui_005ftabs_005furl_005fnames_005fnobody.reuse(_jspx_th_liferay_002dui_005ftabs_005f0);
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
          _jspx_th_c_005fwhen_005f0.setTest( tabs1.equals("articles") );
          int _jspx_eval_c_005fwhen_005f0 = _jspx_th_c_005fwhen_005f0.doStartTag();
          if (_jspx_eval_c_005fwhen_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write('\n');
              out.write('	');
              out.write('	');
              out.write('\n');
              out.write('	');
              out.write('	');
              out.write("\n");
              out.write("\t\t<input name=\"");
              if (_jspx_meth_portlet_005fnamespace_005f42(_jspx_th_c_005fwhen_005f0, _jspx_page_context))
                return;
              out.write("deleteArticleIds\" type=\"hidden\" value=\"\" />\n");
              out.write("\t\t<input name=\"");
              if (_jspx_meth_portlet_005fnamespace_005f43(_jspx_th_c_005fwhen_005f0, _jspx_page_context))
                return;
              out.write("expireArticleIds\" type=\"hidden\" value=\"\" />\n");
              out.write("\n");
              out.write("\t\t");

		String orderByCol = ParamUtil.getString(request, "orderByCol");
		String orderByType = ParamUtil.getString(request, "orderByType");

		if (Validator.isNotNull(orderByCol) && Validator.isNotNull(orderByType)) {
			prefs.setValue(PortletKeys.JOURNAL, "articles-order-by-col", orderByCol);
			prefs.setValue(PortletKeys.JOURNAL, "articles-order-by-type", orderByType);
		}
		else {
			orderByCol = prefs.getValue(PortletKeys.JOURNAL, "articles-order-by-col", "id");
			orderByType = prefs.getValue(PortletKeys.JOURNAL, "articles-order-by-type", "asc");
		}

		OrderByComparator orderByComparator = JournalUtil.getArticleOrderByComparator(orderByCol, orderByType);

		ArticleSearch searchContainer = new ArticleSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(3, "modified-date");
		headerNames.add(StringPool.BLANK);

		searchContainer.setRowChecker(new RowChecker(renderResponse));
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              //  liferay-ui:search-form
              com.liferay.taglib.ui.SearchFormTag _jspx_th_liferay_002dui_005fsearch_002dform_005f0 = (com.liferay.taglib.ui.SearchFormTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.get(com.liferay.taglib.ui.SearchFormTag.class);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f0.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f0);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f0.setPage("/html/portlet/journal/article_search.jsp");
              _jspx_th_liferay_002dui_005fsearch_002dform_005f0.setSearchContainer( searchContainer );
              int _jspx_eval_liferay_002dui_005fsearch_002dform_005f0 = _jspx_th_liferay_002dui_005fsearch_002dform_005f0.doStartTag();
              if (_jspx_th_liferay_002dui_005fsearch_002dform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dform_005f0);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dform_005f0);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              //  c:if
              org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
              _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
              _jspx_th_c_005fif_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f0);
              _jspx_th_c_005fif_005f0.setTest( renderRequest.getWindowState().equals(WindowState.MAXIMIZED) );
              int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
              if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");

			ArticleSearchTerms searchTerms = (ArticleSearchTerms)searchContainer.getSearchTerms();
			
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");

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

int total = 0;

if (searchTerms.isAdvancedSearch()) {
	total = JournalArticleLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchTerms.isAndOperator());
}
else {
	total = JournalArticleLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getKeywords(), searchTerms.getVersionObj(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate());
}

searchContainer.setTotal(total);

List results = null;

if (searchTerms.isAdvancedSearch()) {
	results = JournalArticleLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), orderByComparator);
}
else {
	results = JournalArticleLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getKeywords(), searchTerms.getVersionObj(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchContainer.getStart(), searchContainer.getEnd(), orderByComparator);
}

searchContainer.setResults(results);

                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t<div class=\"separator\"><!-- --></div>\n");
                  out.write("\n");
                  out.write("\t\t\t<input type=\"button\" value=\"");
                  if (_jspx_meth_liferay_002dui_005fmessage_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
                    return;
                  out.write("\" onClick=\"");
                  if (_jspx_meth_portlet_005fnamespace_005f44(_jspx_th_c_005fif_005f0, _jspx_page_context))
                    return;
                  out.write("expireArticles();\" />\n");
                  out.write("\n");
                  out.write("\t\t\t<input type=\"button\" value=\"");
                  if (_jspx_meth_liferay_002dui_005fmessage_005f1(_jspx_th_c_005fif_005f0, _jspx_page_context))
                    return;
                  out.write("\" onClick=\"");
                  if (_jspx_meth_portlet_005fnamespace_005f45(_jspx_th_c_005fif_005f0, _jspx_page_context))
                    return;
                  out.write("deleteArticles();\" />\n");
                  out.write("\n");
                  out.write("\t\t\t<br /><br />\n");
                  out.write("\n");
                  out.write("\t\t\t");

			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				JournalArticle article = (JournalArticle)results.get(i);

				ResultRow row = new ResultRow(article, article.getArticleId() + EditArticleAction.VERSION_SEPARATOR + article.getVersion(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/journal/edit_article");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", String.valueOf(article.getGroupId()));
				rowURL.setParameter("articleId", article.getArticleId());
				rowURL.setParameter("version", String.valueOf(article.getVersion()));

				// Article id

				row.addText(article.getArticleId(), rowURL);

				// Version

				row.addText(String.valueOf(article.getVersion()), rowURL);

				// Title

				row.addText(article.getTitle(), rowURL);

				// Modified date

				row.addText(dateFormatDate.format(article.getModifiedDate()), rowURL);

				// Display date

				row.addText(dateFormatDate.format(article.getDisplayDate()), rowURL);

				// Author

				row.addText(PortalUtil.getUserName(article.getUserId(), article.getUserName()), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/journal/article_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");
                  //  liferay-ui:search-iterator
                  com.liferay.taglib.ui.SearchIteratorTag _jspx_th_liferay_002dui_005fsearch_002diterator_005f0 = (com.liferay.taglib.ui.SearchIteratorTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.get(com.liferay.taglib.ui.SearchIteratorTag.class);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f0.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f0.setSearchContainer( searchContainer );
                  int _jspx_eval_liferay_002dui_005fsearch_002diterator_005f0 = _jspx_th_liferay_002dui_005fsearch_002diterator_005f0.doStartTag();
                  if (_jspx_th_liferay_002dui_005fsearch_002diterator_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002diterator_005f0);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002diterator_005f0);
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");
                  //  liferay-ui:search-paginator
                  com.liferay.taglib.ui.SearchPaginatorTag _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0 = (com.liferay.taglib.ui.SearchPaginatorTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.get(com.liferay.taglib.ui.SearchPaginatorTag.class);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0.setSearchContainer( searchContainer );
                  int _jspx_eval_liferay_002dui_005fsearch_002dpaginator_005f0 = _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0.doStartTag();
                  if (_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f0);
                  out.write('\n');
                  out.write('	');
                  out.write('	');
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
          _jspx_th_c_005fwhen_005f1.setTest( tabs1.equals("structures") );
          int _jspx_eval_c_005fwhen_005f1 = _jspx_th_c_005fwhen_005f1.doStartTag();
          if (_jspx_eval_c_005fwhen_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t<input name=\"");
              if (_jspx_meth_portlet_005fnamespace_005f46(_jspx_th_c_005fwhen_005f1, _jspx_page_context))
                return;
              out.write("deleteStructureIds\" type=\"hidden\" value=\"\" />\n");
              out.write("\n");
              out.write("\t\t");
              //  liferay-ui:error
              com.liferay.taglib.ui.ErrorTag _jspx_th_liferay_002dui_005ferror_005f0 = (com.liferay.taglib.ui.ErrorTag) _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.get(com.liferay.taglib.ui.ErrorTag.class);
              _jspx_th_liferay_002dui_005ferror_005f0.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dui_005ferror_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f1);
              _jspx_th_liferay_002dui_005ferror_005f0.setException( RequiredStructureException.class );
              _jspx_th_liferay_002dui_005ferror_005f0.setMessage("required-structures-could-not-be-deleted");
              int _jspx_eval_liferay_002dui_005ferror_005f0 = _jspx_th_liferay_002dui_005ferror_005f0.doStartTag();
              if (_jspx_th_liferay_002dui_005ferror_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.reuse(_jspx_th_liferay_002dui_005ferror_005f0);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.reuse(_jspx_th_liferay_002dui_005ferror_005f0);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");

		StructureSearch searchContainer = new StructureSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		searchContainer.setRowChecker(new RowChecker(renderResponse));
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              //  liferay-ui:search-form
              com.liferay.taglib.ui.SearchFormTag _jspx_th_liferay_002dui_005fsearch_002dform_005f1 = (com.liferay.taglib.ui.SearchFormTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.get(com.liferay.taglib.ui.SearchFormTag.class);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f1.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f1);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f1.setPage("/html/portlet/journal/structure_search.jsp");
              _jspx_th_liferay_002dui_005fsearch_002dform_005f1.setSearchContainer( searchContainer );
              int _jspx_eval_liferay_002dui_005fsearch_002dform_005f1 = _jspx_th_liferay_002dui_005fsearch_002dform_005f1.doStartTag();
              if (_jspx_th_liferay_002dui_005fsearch_002dform_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dform_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dform_005f1);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              //  c:if
              org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
              _jspx_th_c_005fif_005f1.setPageContext(_jspx_page_context);
              _jspx_th_c_005fif_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f1);
              _jspx_th_c_005fif_005f1.setTest( renderRequest.getWindowState().equals(WindowState.MAXIMIZED) );
              int _jspx_eval_c_005fif_005f1 = _jspx_th_c_005fif_005f1.doStartTag();
              if (_jspx_eval_c_005fif_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");

			StructureSearchTerms searchTerms = (StructureSearchTerms)searchContainer.getSearchTerms();
			
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");

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

int total = 0;

if (searchTerms.isAdvancedSearch()) {
	total = JournalStructureLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getStructureId(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator());
}
else {
	total = JournalStructureLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getKeywords());
}

searchContainer.setTotal(total);

List results = null;

if (searchTerms.isAdvancedSearch()) {
	results = JournalStructureLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getStructureId(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), null);
}
else {
	results = JournalStructureLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getKeywords(), searchContainer.getStart(), searchContainer.getEnd(), null);
}

searchContainer.setResults(results);

                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t<div class=\"separator\"><!-- --></div>\n");
                  out.write("\n");
                  out.write("\t\t\t<input type=\"button\" value=\"");
                  if (_jspx_meth_liferay_002dui_005fmessage_005f2(_jspx_th_c_005fif_005f1, _jspx_page_context))
                    return;
                  out.write("\" onClick=\"");
                  if (_jspx_meth_portlet_005fnamespace_005f47(_jspx_th_c_005fif_005f1, _jspx_page_context))
                    return;
                  out.write("deleteStructures();\" />\n");
                  out.write("\n");
                  out.write("\t\t\t<br /><br />\n");
                  out.write("\n");
                  out.write("\t\t\t");

			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				JournalStructure structure = (JournalStructure)results.get(i);

				ResultRow row = new ResultRow(structure, structure.getStructureId(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/journal/edit_structure");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", String.valueOf(structure.getGroupId()));
				rowURL.setParameter("structureId", structure.getStructureId());

				// Structure id

				row.addText(structure.getStructureId(), rowURL);

				// Name and description

				StringMaker sm = new StringMaker();

				sm.append(structure.getName());

				if (Validator.isNotNull(structure.getDescription())) {
					sm.append("<br />");
					sm.append("<span style=\"font-size: xx-small;\">");
					sm.append(structure.getDescription());
					sm.append("</span>");
				}

				row.addText(sm.toString(), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/journal/structure_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");
                  //  liferay-ui:search-iterator
                  com.liferay.taglib.ui.SearchIteratorTag _jspx_th_liferay_002dui_005fsearch_002diterator_005f1 = (com.liferay.taglib.ui.SearchIteratorTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.get(com.liferay.taglib.ui.SearchIteratorTag.class);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f1.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f1);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f1.setSearchContainer( searchContainer );
                  int _jspx_eval_liferay_002dui_005fsearch_002diterator_005f1 = _jspx_th_liferay_002dui_005fsearch_002diterator_005f1.doStartTag();
                  if (_jspx_th_liferay_002dui_005fsearch_002diterator_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002diterator_005f1);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002diterator_005f1);
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");
                  //  liferay-ui:search-paginator
                  com.liferay.taglib.ui.SearchPaginatorTag _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1 = (com.liferay.taglib.ui.SearchPaginatorTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.get(com.liferay.taglib.ui.SearchPaginatorTag.class);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f1);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1.setSearchContainer( searchContainer );
                  int _jspx_eval_liferay_002dui_005fsearch_002dpaginator_005f1 = _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1.doStartTag();
                  if (_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f1);
                  out.write('\n');
                  out.write('	');
                  out.write('	');
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
          _jspx_th_c_005fwhen_005f2.setTest( tabs1.equals("templates") );
          int _jspx_eval_c_005fwhen_005f2 = _jspx_th_c_005fwhen_005f2.doStartTag();
          if (_jspx_eval_c_005fwhen_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\n");
              out.write("\t\t<input name=\"");
              if (_jspx_meth_portlet_005fnamespace_005f48(_jspx_th_c_005fwhen_005f2, _jspx_page_context))
                return;
              out.write("deleteTemplateIds\" type=\"hidden\" value=\"\" />\n");
              out.write("\n");
              out.write("\t\t");
              //  liferay-ui:error
              com.liferay.taglib.ui.ErrorTag _jspx_th_liferay_002dui_005ferror_005f1 = (com.liferay.taglib.ui.ErrorTag) _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.get(com.liferay.taglib.ui.ErrorTag.class);
              _jspx_th_liferay_002dui_005ferror_005f1.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dui_005ferror_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f2);
              _jspx_th_liferay_002dui_005ferror_005f1.setException( RequiredTemplateException.class );
              _jspx_th_liferay_002dui_005ferror_005f1.setMessage("required-templates-could-not-be-deleted");
              int _jspx_eval_liferay_002dui_005ferror_005f1 = _jspx_th_liferay_002dui_005ferror_005f1.doStartTag();
              if (_jspx_th_liferay_002dui_005ferror_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.reuse(_jspx_th_liferay_002dui_005ferror_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dui_005ferror_005fmessage_005fexception_005fnobody.reuse(_jspx_th_liferay_002dui_005ferror_005f1);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");

		TemplateSearch searchContainer = new TemplateSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		searchContainer.setRowChecker(new RowChecker(renderResponse));
		
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              //  liferay-ui:search-form
              com.liferay.taglib.ui.SearchFormTag _jspx_th_liferay_002dui_005fsearch_002dform_005f2 = (com.liferay.taglib.ui.SearchFormTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.get(com.liferay.taglib.ui.SearchFormTag.class);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f2.setPageContext(_jspx_page_context);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f2);
              _jspx_th_liferay_002dui_005fsearch_002dform_005f2.setPage("/html/portlet/journal/template_search.jsp");
              _jspx_th_liferay_002dui_005fsearch_002dform_005f2.setSearchContainer( searchContainer );
              int _jspx_eval_liferay_002dui_005fsearch_002dform_005f2 = _jspx_th_liferay_002dui_005fsearch_002dform_005f2.doStartTag();
              if (_jspx_th_liferay_002dui_005fsearch_002dform_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dform_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dform_005fsearchContainer_005fpage_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dform_005f2);
              out.write("\n");
              out.write("\n");
              out.write("\t\t");
              //  c:if
              org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
              _jspx_th_c_005fif_005f2.setPageContext(_jspx_page_context);
              _jspx_th_c_005fif_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f2);
              _jspx_th_c_005fif_005f2.setTest( renderRequest.getWindowState().equals(WindowState.MAXIMIZED) );
              int _jspx_eval_c_005fif_005f2 = _jspx_th_c_005fif_005f2.doStartTag();
              if (_jspx_eval_c_005fif_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");

			TemplateSearchTerms searchTerms = (TemplateSearchTerms)searchContainer.getSearchTerms();

			searchTerms.setStructureIdComparator(StringPool.EQUAL);
			
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");

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

int total = 0;

if (searchTerms.isAdvancedSearch()) {
	total = JournalTemplateLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getTemplateId(), searchTerms.getStructureId(), searchTerms.getStructureIdComparator(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator());
}
else {
	total = JournalTemplateLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getKeywords(), searchTerms.getStructureId(), searchTerms.getStructureIdComparator());
}

searchContainer.setTotal(total);

List results = null;

if (searchTerms.isAdvancedSearch()) {
	results = JournalTemplateLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getTemplateId(), searchTerms.getStructureId(), StringPool.EQUAL, searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), null);
}
else {
	results = JournalTemplateLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getKeywords(), searchTerms.getStructureId(), StringPool.EQUAL, searchContainer.getStart(), searchContainer.getEnd(), null);
}

searchContainer.setResults(results);

                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t<div class=\"separator\"><!-- --></div>\n");
                  out.write("\n");
                  out.write("\t\t\t<input type=\"button\" value=\"");
                  if (_jspx_meth_liferay_002dui_005fmessage_005f3(_jspx_th_c_005fif_005f2, _jspx_page_context))
                    return;
                  out.write("\" onClick=\"");
                  if (_jspx_meth_portlet_005fnamespace_005f49(_jspx_th_c_005fif_005f2, _jspx_page_context))
                    return;
                  out.write("deleteTemplates();\" />\n");
                  out.write("\n");
                  out.write("\t\t\t<br /><br />\n");
                  out.write("\n");
                  out.write("\t\t\t");

			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				JournalTemplate template = (JournalTemplate)results.get(i);

				ResultRow row = new ResultRow(template, template.getTemplateId(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/journal/edit_template");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", String.valueOf(template.getGroupId()));
				rowURL.setParameter("templateId", template.getTemplateId());

				row.setParameter("rowHREF", rowURL.toString());

				// Template id

				row.addText(template.getTemplateId(), rowURL);

				// Name, description, and image

				row.addJSP("/html/portlet/journal/template_description.jsp");

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/journal/template_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");
                  //  liferay-ui:search-iterator
                  com.liferay.taglib.ui.SearchIteratorTag _jspx_th_liferay_002dui_005fsearch_002diterator_005f2 = (com.liferay.taglib.ui.SearchIteratorTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.get(com.liferay.taglib.ui.SearchIteratorTag.class);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f2.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
                  _jspx_th_liferay_002dui_005fsearch_002diterator_005f2.setSearchContainer( searchContainer );
                  int _jspx_eval_liferay_002dui_005fsearch_002diterator_005f2 = _jspx_th_liferay_002dui_005fsearch_002diterator_005f2.doStartTag();
                  if (_jspx_th_liferay_002dui_005fsearch_002diterator_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002diterator_005f2);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002diterator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002diterator_005f2);
                  out.write("\n");
                  out.write("\n");
                  out.write("\t\t\t");
                  //  liferay-ui:search-paginator
                  com.liferay.taglib.ui.SearchPaginatorTag _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2 = (com.liferay.taglib.ui.SearchPaginatorTag) _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.get(com.liferay.taglib.ui.SearchPaginatorTag.class);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2.setPageContext(_jspx_page_context);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
                  _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2.setSearchContainer( searchContainer );
                  int _jspx_eval_liferay_002dui_005fsearch_002dpaginator_005f2 = _jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2.doStartTag();
                  if (_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2);
                    return;
                  }
                  _005fjspx_005ftagPool_005fliferay_002dui_005fsearch_002dpaginator_005fsearchContainer_005fnobody.reuse(_jspx_th_liferay_002dui_005fsearch_002dpaginator_005f2);
                  out.write('\n');
                  out.write('	');
                  out.write('	');
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
          //  c:when
          org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_005fwhen_005f3 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _005fjspx_005ftagPool_005fc_005fwhen_005ftest.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
          _jspx_th_c_005fwhen_005f3.setPageContext(_jspx_page_context);
          _jspx_th_c_005fwhen_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fchoose_005f0);
          _jspx_th_c_005fwhen_005f3.setTest( tabs1.equals("recent") );
          int _jspx_eval_c_005fwhen_005f3 = _jspx_th_c_005fwhen_005f3.doStartTag();
          if (_jspx_eval_c_005fwhen_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write('\n');
              out.write('	');
              out.write('	');
              out.print( LanguageUtil.format(pageContext, "this-page-displays-the-last-x-articles,-structures,-and-templates-that-you-accessed", String.valueOf(JournalUtil.MAX_STACK_SIZE), false) );
              out.write("\n");
              out.write("\n");
              out.write("\t\t<br /><br />\n");
              out.write("\n");
              out.write("\t\t<table class=\"liferay-table\" width=\"100%\">\n");
              out.write("\t\t<tr>\n");
              out.write("\t\t\t<td valign=\"top\" width=\"33%\">\n");
              out.write("\t\t\t\t<table border=\"0\" cellpadding=\"4\" cellspacing=\"0\" width=\"100%\">\n");
              out.write("\t\t\t\t<tr class=\"portlet-section-header\" style=\"font-size: x-small; font-weight: bold;\">\n");
              out.write("\t\t\t\t\t<td>\n");
              out.write("\t\t\t\t\t\t");
              out.print( LanguageUtil.format(pageContext, "last-x-articles", String.valueOf(JournalUtil.MAX_STACK_SIZE), false) );
              out.write("\n");
              out.write("\t\t\t\t\t</td>\n");
              out.write("\t\t\t\t</tr>\n");
              out.write("\n");
              out.write("\t\t\t\t");

				Stack recentArticles = JournalUtil.getRecentArticles(renderRequest);

				int recentArticlesSize = recentArticles.size();

				for (int i = recentArticlesSize - 1; i >= 0; i--) {
					JournalArticle article = (JournalArticle)recentArticles.get(i);

					String className = "portlet-section-body";
					String classHoverName = "portlet-section-body-hover";

					if (MathUtil.isEven(i)) {
						className = "portlet-section-alternate";
						classHoverName = "portlet-section-alternate-hover";
					}
				
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t\t<tr class=\"");
              out.print( className );
              out.write("\" style=\"font-size: x-small;\" onMouseEnter=\"this.className = '");
              out.print( classHoverName );
              out.write("';\" onMouseLeave=\"this.className = '");
              out.print( className );
              out.write("';\">\n");
              out.write("\t\t\t\t\t\t<td nowrap>\n");
              out.write("\t\t\t\t\t\t\t<a href=\"");
              //  portlet:renderURL
              com.liferay.taglib.portlet.RenderURLTag _jspx_th_portlet_005frenderURL_005f0 = (com.liferay.taglib.portlet.RenderURLTag) _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.get(com.liferay.taglib.portlet.RenderURLTag.class);
              _jspx_th_portlet_005frenderURL_005f0.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005frenderURL_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f3);
              _jspx_th_portlet_005frenderURL_005f0.setWindowState( WindowState.MAXIMIZED.toString() );
              int _jspx_eval_portlet_005frenderURL_005f0 = _jspx_th_portlet_005frenderURL_005f0.doStartTag();
              if (_jspx_eval_portlet_005frenderURL_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005frenderURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005frenderURL_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005frenderURL_005f0.doInitBody();
                }
                do {
                  if (_jspx_meth_portlet_005fparam_005f8(_jspx_th_portlet_005frenderURL_005f0, _jspx_page_context))
                    return;
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f9 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f9.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f0);
                  _jspx_th_portlet_005fparam_005f9.setName("redirect");
                  _jspx_th_portlet_005fparam_005f9.setValue( currentURL );
                  int _jspx_eval_portlet_005fparam_005f9 = _jspx_th_portlet_005fparam_005f9.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f9);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f9);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f10 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f10.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f0);
                  _jspx_th_portlet_005fparam_005f10.setName("groupId");
                  _jspx_th_portlet_005fparam_005f10.setValue( String.valueOf(article.getGroupId()) );
                  int _jspx_eval_portlet_005fparam_005f10 = _jspx_th_portlet_005fparam_005f10.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f10);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f10);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f11 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f11.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f0);
                  _jspx_th_portlet_005fparam_005f11.setName("articleId");
                  _jspx_th_portlet_005fparam_005f11.setValue( article.getArticleId() );
                  int _jspx_eval_portlet_005fparam_005f11 = _jspx_th_portlet_005fparam_005f11.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f11);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f11);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f12 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f12.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f0);
                  _jspx_th_portlet_005fparam_005f12.setName("version");
                  _jspx_th_portlet_005fparam_005f12.setValue( String.valueOf(article.getVersion()) );
                  int _jspx_eval_portlet_005fparam_005f12 = _jspx_th_portlet_005fparam_005f12.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f12);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f12);
                  int evalDoAfterBody = _jspx_th_portlet_005frenderURL_005f0.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005frenderURL_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005frenderURL_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.reuse(_jspx_th_portlet_005frenderURL_005f0);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.reuse(_jspx_th_portlet_005frenderURL_005f0);
              out.write('"');
              out.write('>');
              out.print( article.getArticleId() );
              out.write("</a>\n");
              out.write("\t\t\t\t\t\t</td>\n");
              out.write("\t\t\t\t\t</tr>\n");
              out.write("\n");
              out.write("\t\t\t\t");

				}
				
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t</table>\n");
              out.write("\t\t\t</td>\n");
              out.write("\t\t\t<td valign=\"top\" width=\"33%\">\n");
              out.write("\t\t\t\t<table border=\"0\" cellpadding=\"4\" cellspacing=\"0\" width=\"100%\">\n");
              out.write("\t\t\t\t<tr class=\"portlet-section-header\" style=\"font-size: x-small; font-weight: bold;\">\n");
              out.write("\t\t\t\t\t<td>\n");
              out.write("\t\t\t\t\t\t");
              out.print( LanguageUtil.format(pageContext, "last-x-structures", String.valueOf(JournalUtil.MAX_STACK_SIZE), false) );
              out.write("\n");
              out.write("\t\t\t\t\t</td>\n");
              out.write("\t\t\t\t</tr>\n");
              out.write("\n");
              out.write("\t\t\t\t");

				Stack recentStructures = JournalUtil.getRecentStructures(renderRequest);

				int recentStructuresSize = recentStructures.size();

				for (int i = recentStructuresSize - 1; i >= 0; i--) {
					JournalStructure structure = (JournalStructure)recentStructures.get(i);

					String className = "portlet-section-body";
					String classHoverName = "portlet-section-body-hover";

					if (MathUtil.isEven(i)) {
						className = "portlet-section-alternate";
						classHoverName = "portlet-section-alternate-hover";
					}
				
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t\t<tr class=\"");
              out.print( className );
              out.write("\" style=\"font-size: x-small;\" onMouseEnter=\"this.className = '");
              out.print( classHoverName );
              out.write("';\" onMouseLeave=\"this.className = '");
              out.print( className );
              out.write("';\">\n");
              out.write("\t\t\t\t\t\t<td nowrap>\n");
              out.write("\t\t\t\t\t\t\t<a href=\"");
              //  portlet:renderURL
              com.liferay.taglib.portlet.RenderURLTag _jspx_th_portlet_005frenderURL_005f1 = (com.liferay.taglib.portlet.RenderURLTag) _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.get(com.liferay.taglib.portlet.RenderURLTag.class);
              _jspx_th_portlet_005frenderURL_005f1.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005frenderURL_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f3);
              _jspx_th_portlet_005frenderURL_005f1.setWindowState( WindowState.MAXIMIZED.toString() );
              int _jspx_eval_portlet_005frenderURL_005f1 = _jspx_th_portlet_005frenderURL_005f1.doStartTag();
              if (_jspx_eval_portlet_005frenderURL_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005frenderURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005frenderURL_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005frenderURL_005f1.doInitBody();
                }
                do {
                  if (_jspx_meth_portlet_005fparam_005f13(_jspx_th_portlet_005frenderURL_005f1, _jspx_page_context))
                    return;
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f14 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f14.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f1);
                  _jspx_th_portlet_005fparam_005f14.setName("redirect");
                  _jspx_th_portlet_005fparam_005f14.setValue( currentURL );
                  int _jspx_eval_portlet_005fparam_005f14 = _jspx_th_portlet_005fparam_005f14.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f14);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f14);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f15 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f15.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f15.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f1);
                  _jspx_th_portlet_005fparam_005f15.setName("groupId");
                  _jspx_th_portlet_005fparam_005f15.setValue( String.valueOf(structure.getGroupId()) );
                  int _jspx_eval_portlet_005fparam_005f15 = _jspx_th_portlet_005fparam_005f15.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f15);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f15);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f16 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f16.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f16.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f1);
                  _jspx_th_portlet_005fparam_005f16.setName("structureId");
                  _jspx_th_portlet_005fparam_005f16.setValue( structure.getStructureId() );
                  int _jspx_eval_portlet_005fparam_005f16 = _jspx_th_portlet_005fparam_005f16.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f16);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f16);
                  int evalDoAfterBody = _jspx_th_portlet_005frenderURL_005f1.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005frenderURL_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005frenderURL_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.reuse(_jspx_th_portlet_005frenderURL_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.reuse(_jspx_th_portlet_005frenderURL_005f1);
              out.write('"');
              out.write('>');
              out.print( structure.getName() );
              out.write("</a>\n");
              out.write("\t\t\t\t\t\t</td>\n");
              out.write("\t\t\t\t\t</tr>\n");
              out.write("\n");
              out.write("\t\t\t\t");

				}
				
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t</table>\n");
              out.write("\t\t\t</td>\n");
              out.write("\t\t\t<td valign=\"top\" width=\"33%\">\n");
              out.write("\t\t\t\t<table border=\"0\" cellpadding=\"4\" cellspacing=\"0\" width=\"100%\">\n");
              out.write("\t\t\t\t<tr class=\"portlet-section-header\" style=\"font-size: x-small; font-weight: bold;\">\n");
              out.write("\t\t\t\t\t<td>\n");
              out.write("\t\t\t\t\t\t");
              out.print( LanguageUtil.format(pageContext, "last-x-templates", String.valueOf(JournalUtil.MAX_STACK_SIZE), false) );
              out.write("\n");
              out.write("\t\t\t\t\t</td>\n");
              out.write("\t\t\t\t</tr>\n");
              out.write("\n");
              out.write("\t\t\t\t");

				Stack recentTemplates = JournalUtil.getRecentTemplates(renderRequest);

				int recentTemplatesSize = recentTemplates.size();

				for (int i = recentTemplatesSize - 1; i >= 0; i--) {
					JournalTemplate template = (JournalTemplate)recentTemplates.get(i);

					String className = "portlet-section-body";
					String classHoverName = "portlet-section-body-hover";

					if (MathUtil.isEven(recentTemplatesSize - i - 1)) {
						className = "portlet-section-alternate";
						classHoverName = "portlet-section-alternate-hover";
					}
				
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t\t<tr class=\"");
              out.print( className );
              out.write("\" style=\"font-size: x-small;\" onMouseEnter=\"this.className = '");
              out.print( classHoverName );
              out.write("';\" onMouseLeave=\"this.className = '");
              out.print( className );
              out.write("';\">\n");
              out.write("\t\t\t\t\t\t<td nowrap>\n");
              out.write("\t\t\t\t\t\t\t<a href=\"");
              //  portlet:renderURL
              com.liferay.taglib.portlet.RenderURLTag _jspx_th_portlet_005frenderURL_005f2 = (com.liferay.taglib.portlet.RenderURLTag) _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.get(com.liferay.taglib.portlet.RenderURLTag.class);
              _jspx_th_portlet_005frenderURL_005f2.setPageContext(_jspx_page_context);
              _jspx_th_portlet_005frenderURL_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f3);
              _jspx_th_portlet_005frenderURL_005f2.setWindowState( WindowState.MAXIMIZED.toString() );
              int _jspx_eval_portlet_005frenderURL_005f2 = _jspx_th_portlet_005frenderURL_005f2.doStartTag();
              if (_jspx_eval_portlet_005frenderURL_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_portlet_005frenderURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_portlet_005frenderURL_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_portlet_005frenderURL_005f2.doInitBody();
                }
                do {
                  if (_jspx_meth_portlet_005fparam_005f17(_jspx_th_portlet_005frenderURL_005f2, _jspx_page_context))
                    return;
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f18 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f18.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f18.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f2);
                  _jspx_th_portlet_005fparam_005f18.setName("redirect");
                  _jspx_th_portlet_005fparam_005f18.setValue( currentURL );
                  int _jspx_eval_portlet_005fparam_005f18 = _jspx_th_portlet_005fparam_005f18.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f18);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f18);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f19 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f19.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f19.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f2);
                  _jspx_th_portlet_005fparam_005f19.setName("groupId");
                  _jspx_th_portlet_005fparam_005f19.setValue( String.valueOf(template.getGroupId()) );
                  int _jspx_eval_portlet_005fparam_005f19 = _jspx_th_portlet_005fparam_005f19.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f19);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f19);
                  //  portlet:param
                  com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f20 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
                  _jspx_th_portlet_005fparam_005f20.setPageContext(_jspx_page_context);
                  _jspx_th_portlet_005fparam_005f20.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f2);
                  _jspx_th_portlet_005fparam_005f20.setName("templateId");
                  _jspx_th_portlet_005fparam_005f20.setValue( template.getTemplateId() );
                  int _jspx_eval_portlet_005fparam_005f20 = _jspx_th_portlet_005fparam_005f20.doStartTag();
                  if (_jspx_th_portlet_005fparam_005f20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f20);
                    return;
                  }
                  _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f20);
                  int evalDoAfterBody = _jspx_th_portlet_005frenderURL_005f2.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_portlet_005frenderURL_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_portlet_005frenderURL_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.reuse(_jspx_th_portlet_005frenderURL_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fportlet_005frenderURL_005fwindowState.reuse(_jspx_th_portlet_005frenderURL_005f2);
              out.write('"');
              out.write('>');
              out.print( template.getName() );
              out.write("</a>\n");
              out.write("\t\t\t\t\t\t</td>\n");
              out.write("\t\t\t\t\t</tr>\n");
              out.write("\n");
              out.write("\t\t\t\t");

				}
				
              out.write("\n");
              out.write("\n");
              out.write("\t\t\t\t</table>\n");
              out.write("\t\t\t</td>\n");
              out.write("\t\t</tr>\n");
              out.write("\t\t</table>\n");
              out.write("\t");
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
      out.write("</form>");
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

  private boolean _jspx_meth_portlet_005fnamespace_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f0 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f0.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f0.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f0 = _jspx_th_portlet_005fnamespace_005f0.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f0);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f1 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f1.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f1.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f1 = _jspx_th_portlet_005fnamespace_005f1.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f1);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f2 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f2.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f2.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f2 = _jspx_th_portlet_005fnamespace_005f2.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f2);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f3 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f3.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f3.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f3 = _jspx_th_portlet_005fnamespace_005f3.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f3);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f4 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f4.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f4.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f4 = _jspx_th_portlet_005fnamespace_005f4.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f4);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f5(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f5 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f5.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f5.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f5 = _jspx_th_portlet_005fnamespace_005f5.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f5);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f6(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f6 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f6.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f6.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f6 = _jspx_th_portlet_005fnamespace_005f6.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f6);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f7(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f7 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f7.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f7.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f7 = _jspx_th_portlet_005fnamespace_005f7.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f7);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f8(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f8 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f8.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f8.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f8 = _jspx_th_portlet_005fnamespace_005f8.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f8);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f8);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f9(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f9 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f9.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f9.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f9 = _jspx_th_portlet_005fnamespace_005f9.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f9);
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
    _jspx_th_portlet_005fparam_005f0.setValue("/journal/edit_article");
    int _jspx_eval_portlet_005fparam_005f0 = _jspx_th_portlet_005fparam_005f0.doStartTag();
    if (_jspx_th_portlet_005fparam_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f0);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f10(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f10 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f10.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f10.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f10 = _jspx_th_portlet_005fnamespace_005f10.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f10);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f10);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f11(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f11 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f11.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f11.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f11 = _jspx_th_portlet_005fnamespace_005f11.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f11);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f11);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f12(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f12 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f12.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f12.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f12 = _jspx_th_portlet_005fnamespace_005f12.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f12);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f12);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f13(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f13 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f13.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f13.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f13 = _jspx_th_portlet_005fnamespace_005f13.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f13);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f13);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f14(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f14 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f14.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f14.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f14 = _jspx_th_portlet_005fnamespace_005f14.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f14);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f14);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f15(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f15 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f15.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f15.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f15 = _jspx_th_portlet_005fnamespace_005f15.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f15);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f15);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f16(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f16 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f16.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f16.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f16 = _jspx_th_portlet_005fnamespace_005f16.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f16);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f16);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f17(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f17 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f17.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f17.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f17 = _jspx_th_portlet_005fnamespace_005f17.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f17);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f17);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f18(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f18 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f18.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f18.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f18 = _jspx_th_portlet_005fnamespace_005f18.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f18);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f18);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f19(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f19 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f19.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f19.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f19 = _jspx_th_portlet_005fnamespace_005f19.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f19);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f19);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f2 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f2.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f1);
    _jspx_th_portlet_005fparam_005f2.setName("struts_action");
    _jspx_th_portlet_005fparam_005f2.setValue("/journal/edit_structure");
    int _jspx_eval_portlet_005fparam_005f2 = _jspx_th_portlet_005fparam_005f2.doStartTag();
    if (_jspx_th_portlet_005fparam_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f2);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f20(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f20 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f20.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f20.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f20 = _jspx_th_portlet_005fnamespace_005f20.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f20);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f20);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f21(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f21 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f21.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f21.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f21 = _jspx_th_portlet_005fnamespace_005f21.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f21.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f21);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f21);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f22(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f22 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f22.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f22.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f22 = _jspx_th_portlet_005fnamespace_005f22.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f22.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f22);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f22);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f23(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f23 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f23.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f23.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f23 = _jspx_th_portlet_005fnamespace_005f23.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f23.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f23);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f23);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f24(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f24 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f24.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f24.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f24 = _jspx_th_portlet_005fnamespace_005f24.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f24.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f24);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f24);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f25(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f25 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f25.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f25.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f25 = _jspx_th_portlet_005fnamespace_005f25.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f25.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f25);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f25);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f26(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f26 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f26.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f26.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f26 = _jspx_th_portlet_005fnamespace_005f26.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f26.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f26);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f26);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f27(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f27 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f27.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f27.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f27 = _jspx_th_portlet_005fnamespace_005f27.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f27.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f27);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f27);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f28(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f28 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f28.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f28.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f28 = _jspx_th_portlet_005fnamespace_005f28.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f28.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f28);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f28);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f29(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f29 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f29.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f29.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f29 = _jspx_th_portlet_005fnamespace_005f29.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f29.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f29);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f29);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f4 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f4.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f2);
    _jspx_th_portlet_005fparam_005f4.setName("struts_action");
    _jspx_th_portlet_005fparam_005f4.setValue("/journal/edit_template");
    int _jspx_eval_portlet_005fparam_005f4 = _jspx_th_portlet_005fparam_005f4.doStartTag();
    if (_jspx_th_portlet_005fparam_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f4);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f30(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f30 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f30.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f30.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f30 = _jspx_th_portlet_005fnamespace_005f30.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f30.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f30);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f30);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f31(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f31 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f31.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f31.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f31 = _jspx_th_portlet_005fnamespace_005f31.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f31.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f31);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f31);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f32(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f32 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f32.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f32.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f32 = _jspx_th_portlet_005fnamespace_005f32.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f32.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f32);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f32);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f33(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f33 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f33.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f33.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f33 = _jspx_th_portlet_005fnamespace_005f33.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f33.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f33);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f33);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f34(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f34 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f34.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f34.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f34 = _jspx_th_portlet_005fnamespace_005f34.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f34.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f34);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f34);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f35(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f35 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f35.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f35.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f35 = _jspx_th_portlet_005fnamespace_005f35.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f35.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f35);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f35);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f36(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f36 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f36.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f36.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f36 = _jspx_th_portlet_005fnamespace_005f36.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f36.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f36);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f36);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f37(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f37 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f37.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f37.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f37 = _jspx_th_portlet_005fnamespace_005f37.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f37.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f37);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f37);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f38(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f38 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f38.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f38.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f38 = _jspx_th_portlet_005fnamespace_005f38.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f38.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f38);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f38);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f39(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f39 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f39.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f39.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f39 = _jspx_th_portlet_005fnamespace_005f39.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f39.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f39);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f39);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005factionURL_005f3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f6 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f6.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005factionURL_005f3);
    _jspx_th_portlet_005fparam_005f6.setName("struts_action");
    _jspx_th_portlet_005fparam_005f6.setValue("/journal/edit_article");
    int _jspx_eval_portlet_005fparam_005f6 = _jspx_th_portlet_005fparam_005f6.doStartTag();
    if (_jspx_th_portlet_005fparam_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f6);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f40(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f40 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f40.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f40.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f40 = _jspx_th_portlet_005fnamespace_005f40.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f40.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f40);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f40);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f41(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f41 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f41.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f41.setParent(null);
    int _jspx_eval_portlet_005fnamespace_005f41 = _jspx_th_portlet_005fnamespace_005f41.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f41.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f41);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f41);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f42(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fwhen_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f42 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f42.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f42.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f0);
    int _jspx_eval_portlet_005fnamespace_005f42 = _jspx_th_portlet_005fnamespace_005f42.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f42.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f42);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f42);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f43(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fwhen_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f43 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f43.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f43.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f0);
    int _jspx_eval_portlet_005fnamespace_005f43 = _jspx_th_portlet_005fnamespace_005f43.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f43.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f43);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f43);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f0 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f0.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
    _jspx_th_liferay_002dui_005fmessage_005f0.setKey("expire");
    int _jspx_eval_liferay_002dui_005fmessage_005f0 = _jspx_th_liferay_002dui_005fmessage_005f0.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f0);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f44(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f44 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f44.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f44.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
    int _jspx_eval_portlet_005fnamespace_005f44 = _jspx_th_portlet_005fnamespace_005f44.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f44.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f44);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f44);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f1 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f1.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
    _jspx_th_liferay_002dui_005fmessage_005f1.setKey("delete");
    int _jspx_eval_liferay_002dui_005fmessage_005f1 = _jspx_th_liferay_002dui_005fmessage_005f1.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f1);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f45(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f45 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f45.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f45.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
    int _jspx_eval_portlet_005fnamespace_005f45 = _jspx_th_portlet_005fnamespace_005f45.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f45.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f45);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f45);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f46(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fwhen_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f46 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f46.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f46.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f1);
    int _jspx_eval_portlet_005fnamespace_005f46 = _jspx_th_portlet_005fnamespace_005f46.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f46.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f46);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f46);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f2 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f2.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f1);
    _jspx_th_liferay_002dui_005fmessage_005f2.setKey("delete");
    int _jspx_eval_liferay_002dui_005fmessage_005f2 = _jspx_th_liferay_002dui_005fmessage_005f2.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f2);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f47(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f47 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f47.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f47.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f1);
    int _jspx_eval_portlet_005fnamespace_005f47 = _jspx_th_portlet_005fnamespace_005f47.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f47.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f47);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f47);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f48(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fwhen_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f48 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f48.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f48.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fwhen_005f2);
    int _jspx_eval_portlet_005fnamespace_005f48 = _jspx_th_portlet_005fnamespace_005f48.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f48.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f48);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f48);
    return false;
  }

  private boolean _jspx_meth_liferay_002dui_005fmessage_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  liferay-ui:message
    com.liferay.taglib.ui.MessageTag _jspx_th_liferay_002dui_005fmessage_005f3 = (com.liferay.taglib.ui.MessageTag) _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.get(com.liferay.taglib.ui.MessageTag.class);
    _jspx_th_liferay_002dui_005fmessage_005f3.setPageContext(_jspx_page_context);
    _jspx_th_liferay_002dui_005fmessage_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
    _jspx_th_liferay_002dui_005fmessage_005f3.setKey("delete");
    int _jspx_eval_liferay_002dui_005fmessage_005f3 = _jspx_th_liferay_002dui_005fmessage_005f3.doStartTag();
    if (_jspx_th_liferay_002dui_005fmessage_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fliferay_002dui_005fmessage_005fkey_005fnobody.reuse(_jspx_th_liferay_002dui_005fmessage_005f3);
    return false;
  }

  private boolean _jspx_meth_portlet_005fnamespace_005f49(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:namespace
    com.liferay.taglib.portlet.NamespaceTag _jspx_th_portlet_005fnamespace_005f49 = (com.liferay.taglib.portlet.NamespaceTag) _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.get(com.liferay.taglib.portlet.NamespaceTag.class);
    _jspx_th_portlet_005fnamespace_005f49.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fnamespace_005f49.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f2);
    int _jspx_eval_portlet_005fnamespace_005f49 = _jspx_th_portlet_005fnamespace_005f49.doStartTag();
    if (_jspx_th_portlet_005fnamespace_005f49.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f49);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fnamespace_005fnobody.reuse(_jspx_th_portlet_005fnamespace_005f49);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005frenderURL_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f8 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f8.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f0);
    _jspx_th_portlet_005fparam_005f8.setName("struts_action");
    _jspx_th_portlet_005fparam_005f8.setValue("/journal/edit_article");
    int _jspx_eval_portlet_005fparam_005f8 = _jspx_th_portlet_005fparam_005f8.doStartTag();
    if (_jspx_th_portlet_005fparam_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f8);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f8);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f13(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005frenderURL_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f13 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f13.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f1);
    _jspx_th_portlet_005fparam_005f13.setName("struts_action");
    _jspx_th_portlet_005fparam_005f13.setValue("/journal/edit_structure");
    int _jspx_eval_portlet_005fparam_005f13 = _jspx_th_portlet_005fparam_005f13.doStartTag();
    if (_jspx_th_portlet_005fparam_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f13);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f13);
    return false;
  }

  private boolean _jspx_meth_portlet_005fparam_005f17(javax.servlet.jsp.tagext.JspTag _jspx_th_portlet_005frenderURL_005f2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  portlet:param
    com.liferay.taglib.util.ParamTag _jspx_th_portlet_005fparam_005f17 = (com.liferay.taglib.util.ParamTag) _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.get(com.liferay.taglib.util.ParamTag.class);
    _jspx_th_portlet_005fparam_005f17.setPageContext(_jspx_page_context);
    _jspx_th_portlet_005fparam_005f17.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_portlet_005frenderURL_005f2);
    _jspx_th_portlet_005fparam_005f17.setName("struts_action");
    _jspx_th_portlet_005fparam_005f17.setValue("/journal/edit_template");
    int _jspx_eval_portlet_005fparam_005f17 = _jspx_th_portlet_005fparam_005f17.doStartTag();
    if (_jspx_th_portlet_005fparam_005f17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f17);
      return true;
    }
    _005fjspx_005ftagPool_005fportlet_005fparam_005fvalue_005fname_005fnobody.reuse(_jspx_th_portlet_005fparam_005f17);
    return false;
  }
}
