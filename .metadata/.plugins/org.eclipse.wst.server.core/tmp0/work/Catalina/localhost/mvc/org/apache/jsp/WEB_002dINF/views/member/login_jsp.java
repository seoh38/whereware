/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.56
 * Generated at: 2022-03-19 16:38:21 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.member;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("/WEB-INF/lib/taglibs-standard-impl-1.2.5.jar", Long.valueOf(1643336605561L));
    _jspx_dependants.put("jar:file:/C:/WhereWare/WW/src/main/webapp/WEB-INF/lib/taglibs-standard-impl-1.2.5.jar!/META-INF/fn.tld", Long.valueOf(1425946270000L));
    _jspx_dependants.put("jar:file:/C:/WhereWare/WW/src/main/webapp/WEB-INF/lib/taglibs-standard-impl-1.2.5.jar!/META-INF/fmt.tld", Long.valueOf(1425946270000L));
    _jspx_dependants.put("jar:file:/C:/WhereWare/WW/src/main/webapp/WEB-INF/lib/taglibs-standard-impl-1.2.5.jar!/META-INF/c.tld", Long.valueOf(1425946270000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fset_005f0(_jspx_page_context))
        return;
      out.write("     \r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ path }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/css/login.css\">\r\n");
      out.write("<link\r\n");
      out.write("      href=\"https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i\"\r\n");
      out.write("      rel=\"stylesheet\">\r\n");
      out.write("      \r\n");
      out.write("<title>WHEREWARE</title>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("        <div class=\"wrapper\">\r\n");
      out.write("            <div class=\"container\">\r\n");
      out.write("            \r\n");
      out.write("                    <div class=\"logo\">\r\n");
      out.write("                    	WHEREWARE\r\n");
      out.write("                    </div>\r\n");
      out.write("                \r\n");
      out.write("				<form id=\"login_form\" action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${path}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/member/login\" method=\"post\">\r\n");
      out.write("				\r\n");
      out.write("                <div class=\"form-group\"> \r\n");
      out.write("                    <span class=\"box int_id\">\r\n");
      out.write("                        <input type=\"text\" id=\"userId\" name=\"id\" class=\"input\" placeholder=\"USERID\"/>\r\n");
      out.write("                    </span>\r\n");
      out.write("                </div>\r\n");
      out.write("\r\n");
      out.write("                <div class=\"form-group\">\r\n");
      out.write("                    <span class=\"box int_pwd\">\r\n");
      out.write("                        <input type=\"password\" id=\"userPwd\" name=\"password\" class=\"input\" placeholder=\"Password\"/>\r\n");
      out.write("                    </span>\r\n");
      out.write("                </div>\r\n");
      out.write("\r\n");
      out.write("                <div>\r\n");
      out.write("                    <input type=\"checkbox\" name=\"id_save\" id=\"id_check\"> SAVE ID\r\n");
      out.write("                </div>\r\n");
      out.write("                \r\n");
      out.write("                <div>\r\n");
      out.write("                    <button type=\"submit\" style=\"cursor:pointer;\" id=\"btn login_btn\">Log In</button>\r\n");
      out.write("                </div>\r\n");
      out.write("                \r\n");
      out.write("                <p id=\"findPwdAndSignUp\">\r\n");
      out.write("                    <a onclick=\"location.href='");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${path}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/member/findIdOrPwd'\" id=\"findIDorPwd\">아이디 / 비밀번호 </a>\r\n");
      out.write("\r\n");
      out.write("                    <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${path}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/member/joinTerms\" id=\"enrollBtn\">회원가입</a>\r\n");
      out.write("                </p>\r\n");
      out.write("				</form>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    \r\n");
      out.write("    <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ path }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/jquery-3.6.0.js\"></script>\r\n");
      out.write("    <!-- 아이디 기억하기 js -->\r\n");
      out.write("    <script>\r\n");
      out.write("    $(document).ready(function(){\r\n");
      out.write("    	 \r\n");
      out.write("        // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.\r\n");
      out.write("        var key = getCookie(\"key\");\r\n");
      out.write("        $(\"#userId\").val(key); \r\n");
      out.write("         \r\n");
      out.write("        if($(\"#userId\").val() != \"\"){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,\r\n");
      out.write("            $(\"#id_check\").attr(\"checked\", true); // ID 저장하기를 체크 상태로 두기.\r\n");
      out.write("        }\r\n");
      out.write("         \r\n");
      out.write("        $(\"#id_check\").change(function(){ // 체크박스에 변화가 있다면,\r\n");
      out.write("            if($(\"#id_check\").is(\":checked\")){ // ID 저장하기 체크했을 때,\r\n");
      out.write("                setCookie(\"key\", $(\"#userId\").val(), 7); // 7일 동안 쿠키 보관\r\n");
      out.write("            }else{ // ID 저장하기 체크 해제 시,\r\n");
      out.write("                deleteCookie(\"key\");\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("         \r\n");
      out.write("        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.\r\n");
      out.write("        $(\"#userId\").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,\r\n");
      out.write("            if($(\"#id_check\").is(\":checked\")){ // ID 저장하기를 체크한 상태라면,\r\n");
      out.write("                setCookie(\"key\", $(\"#userId\").val(), 7); // 7일 동안 쿠키 보관\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("    });\r\n");
      out.write("     \r\n");
      out.write("    function setCookie(cookieName, value, exdays){\r\n");
      out.write("        var exdate = new Date();\r\n");
      out.write("        exdate.setDate(exdate.getDate() + exdays);\r\n");
      out.write("        var cookieValue = escape(value) + ((exdays==null) ? \"\" : \"; expires=\" + exdate.toGMTString());\r\n");
      out.write("        document.cookie = cookieName + \"=\" + cookieValue;\r\n");
      out.write("    }\r\n");
      out.write("     \r\n");
      out.write("    function deleteCookie(cookieName){\r\n");
      out.write("        var expireDate = new Date();\r\n");
      out.write("        expireDate.setDate(expireDate.getDate() - 1);\r\n");
      out.write("        document.cookie = cookieName + \"= \" + \"; expires=\" + expireDate.toGMTString();\r\n");
      out.write("    }\r\n");
      out.write("     \r\n");
      out.write("    function getCookie(cookieName) {\r\n");
      out.write("        cookieName = cookieName + '=';\r\n");
      out.write("        var cookieData = document.cookie;\r\n");
      out.write("        var start = cookieData.indexOf(cookieName);\r\n");
      out.write("        var cookieValue = '';\r\n");
      out.write("        if(start != -1){\r\n");
      out.write("            start += cookieName.length;\r\n");
      out.write("            var end = cookieData.indexOf(';', start);\r\n");
      out.write("            if(end == -1)end = cookieData.length;\r\n");
      out.write("            cookieValue = cookieData.substring(start, end);\r\n");
      out.write("        }\r\n");
      out.write("        return unescape(cookieValue);\r\n");
      out.write("    }   \r\n");
      out.write("	\r\n");
      out.write("    </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f0_reused = false;
    try {
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent(null);
      // /WEB-INF/views/member/login.jsp(7,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("path");
      // /WEB-INF/views/member/login.jsp(7,0) name = value type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setValue(new org.apache.jasper.el.JspValueExpression("/WEB-INF/views/member/login.jsp(7,0) '${ pageContext.request.contextPath }'",_jsp_getExpressionFactory().createValueExpression(_jspx_page_context.getELContext(),"${ pageContext.request.contextPath }",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
      int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
      if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
      _jspx_th_c_005fset_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f0_reused);
    }
    return false;
  }
}
