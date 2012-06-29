package org.apache.jsp.html.portlet.ext.epsos.demo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class documentXSL_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  public Object getDependants() {
    return _jspx_dependants;
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

 
String content = (String) request.getAttribute("transformedResult"); 

      out.write('\n');
      out.print( content );
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<div class=\"uni-form\">\n");
      out.write("<div class=\"button-holder\" id=\"buttonDiv\">\n");
      out.write("<input type=\"button\" \n");
      out.write("style=\"background-color: #fafafa;\n");
      out.write(" background-image: url(../images/forms/button.png);\n");
      out.write(" background-repeat: repeat-x;\n");
      out.write(" background-position: 0% 0%;\n");
      out.write(" border-width: 3px;\n");
      out.write(" border-style: double;\n");
      out.write(" border-color:#CCC;\n");
      out.write(" border-bottom-color:#666;\n");
      out.write(" border-right-color:#666;\n");
      out.write(" cursor:pointer;\n");
      out.write(" font-size:1.0em;\n");
      out.write(" padding:2px;\"\n");
      out.write("\n");
      out.write("value=\"");
      out.print( com.liferay.portal.kernel.language.LanguageUtil.get(pageContext, "print") );
      out.write("\" onClick=\"document.getElementById('buttonDiv').style.display='none'; window.print();\">\n");
      out.write("<input type=\"button\"  \n");
      out.write("style=\"background-color: #fafafa;\n");
      out.write(" background-image: url(../images/forms/button.png);\n");
      out.write(" background-repeat: repeat-x;\n");
      out.write(" background-position: 0% 0%;\n");
      out.write(" border-width: 3px;\n");
      out.write(" border-style: double;\n");
      out.write(" border-color:#CCC;\n");
      out.write(" border-bottom-color:#666;\n");
      out.write(" border-right-color:#666;\n");
      out.write(" cursor:pointer;\n");
      out.write(" font-size:1.0em;\n");
      out.write(" padding:2px;\"\n");
      out.write(" value=\"");
      out.print( com.liferay.portal.kernel.language.LanguageUtil.get(pageContext, "cancel") );
      out.write("\" onClick=\"self.close();\">\n");
      out.write("</div>\n");
      out.write("</div>\n");
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
