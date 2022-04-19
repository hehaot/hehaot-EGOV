<%@ page import="bean.Page" %>
<%@ page import="bean.Enterprise" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@page pageEncoding="GB18030"%>
<%
String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  Page<Enterprise> pageObj=(Page<Enterprise>) request.getAttribute("page");
  Integer pagesize = 0;
  Integer pagecount = 0;
  Integer totalsize = 0;
  Integer pageno = 0;
  List<Enterprise> enList=null;
  if (pageObj !=null){
    pagesize=pageObj.getPagesize();
    pagecount=pageObj.getPagecount();
    totalsize=pageObj.getTotalsize();
    pageno=pageObj.getPageno();
    enList = pageObj.getDataList();
  }

%>
<html>
<head>
  <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="clander/date.js"></script>
<script type="text/javascript" src="clander/setday.js"></script>
<script>document.onclick=function() {}</script>
<title>外商投资企业选择</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {font-size: 12px}
.STYLE4 {
	font-size: 12px;
	color: #1F4A65;
	font-weight: bold;
}

a:link {
	font-size: 12px;
	color: #06482a;
	text-decoration: none;

}
a:visited {
	font-size: 12px;
	color: #06482a;
	text-decoration: none;
}
a:hover {
	font-size: 12px;
	color: #FF0000;
	text-decoration: underline;
}
a:active {
	font-size: 12px;
	color: #FF0000;
	text-decoration: none;
}
.STYLE7 {font-size: 12px}

-->
</style>

<script>
  function pageQueryEn(){
    // document.all.dataTableBody.style.display='';
    document.getElementById("enForm").submit();
  }
  function changepage(pageno){
    document.getElementById("enForm").action="/myWeb/pageQueryEn?pageno="+pageno;
    document.getElementById("enForm").submit();
  }
</script>
</head>

<body>
<form action="/myWeb/pageQueryEn" method="post" name="enForm" id="enForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">外商投资企业列表</span></td>
        <td width="281" background="images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"></td>
                  </tr>
              </table></td>
            </tr>
        </table></td>
        <td width="14"><img src="images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr height="5">
          <td width="9" background="images/tab_12.gif">&nbsp;</td>
          <td bgcolor="#f3ffe3">&nbsp;</td>
          <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3">
        	<table width="99%" border="0" align="center" cellpadding="0" cellspacing="1">
        	    <tr>
        	        <td width="120" class="STYLE1">组织机构代码:</td>
        	        <td width="140" class="STYLE1"><input type="text" name="orgcode" value="${param.orgcode}" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
        	        <td width="90" class="STYLE1">企业中文名称:</td>
        	        <td width="130" class="STYLE1" ><input type="text" name="cnname" value="${param.cnname}" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
				    <td width="60"  nowrap class="STYLE1">登记日期:</td>
				    <td class="class1_td alignleft" nowrap>
				        <input type="date" name="startdate" value="${param.startdate}" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" >
				  &nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="date" name="enddate" value="${param.enddate}" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" >
				      </td> 
        	    </tr>
        	    <tr>
        	        <td class="STYLE1" colspan="5" align="left"></td>
        	        <td nowrap class="STYLE1" align="right"><button style="width:68px;height:27px" onclick="pageQueryEn();" ><img src="images/query.jpg" /></button>&nbsp;&nbsp;<button style="width:68px;height:27px"><img src="images/clear.jpg" /></button>&nbsp;&nbsp;</td>
        	    </tr>
        	</table>
        </td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
      <tr height="10">
          <td width="9" background="images/tab_12.gif">&nbsp;</td>
          <td bgcolor="#f3ffe3">&nbsp;</td>
          <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
  </table>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" id="dataTable" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
        <thead class="class1_thead">
          <tr>
            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">序号</div></td>
            <td width="20%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">组织机构代码</div></td>
            <td width="24%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">企业中文名称</div></td>
            <td width="10%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">登记日期</div></td>
            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">经办人</div></td>
            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">投资比例</div></td>
          </tr>
          </thead>
          <tbody id="dataTableBody">

          <c:if test="${not empty page.dataList}">
            <c:forEach items="${page.dataList}" var="en" varStatus="enStatus">
              <tr>
              <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1">${enStatus.count}</div></td>
              <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"  style="cursor:pointer" onclick="window.opener.document.all.orgcode.value='${en.orgcode}';window.close();">${en.orgcode}</div></td>
              <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${en.cnname}</div></td>
              <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${en.regdate}</div></td>
              <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${en.username}</div></td>
              <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${(en.outregcap/en.regcap)*100}%</div></td>
              </tr>

            </c:forEach>
          </c:if>
          <%--<%
            if (enList!=null) {
              int i=1;
              for (Enterprise en:enList){
                Double d1=Double.parseDouble(en.getOutregcap().trim())/Double.parseDouble(en.getRegcap().trim())*100;
                DecimalFormat df = new DecimalFormat("0.00");
                String num=df.format(d1);
                %>

          <%
              }
            }
          %>--%>



          </tbody>
        </table></td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="29"><img src="images/tab_20.gif" width="15" height="29" /></td>
        <td background="images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">共<%=totalsize%>条纪录，当前第<%=pageno%>/<%=pagecount%>页，每页<%=pagesize%>条纪录</span></td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                <%
                  boolean isNotFirstPage=pageno>1;
                  boolean isNotLastPage=pageno<pagecount;
                %>
                <tr>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/firstPage<%=isNotFirstPage?"":"Disabled"%>.gif" <%=isNotFirstPage?"style='cursor:pointer' onclick='changepage(1)'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/prevPage<%=isNotFirstPage?"":"Disabled"%>.gif"  <%=isNotFirstPage?"style='cursor:pointer' onclick='changepage("+(pageno-1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/nextPage<%=isNotLastPage?"":"Disabled"%>.gif"  <%=isNotLastPage?"style='cursor:pointer' onclick='changepage("+(pageno+1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/lastPage<%=isNotLastPage?"":"Disabled"%>.gif" <%=isNotLastPage?"style='cursor:pointer' onclick='changepage("+pagecount+")'":""%>/></div></td>
                  <td width="59" height="22" valign="middle"><div align="right" class="STYLE2 STYLE1">转到第</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input name="textfield" type="text" class="STYLE1" style="height:20px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle" class="STYLE2 STYLE1">页</td>
                  <td width="30" height="22" valign="middle"><img src="images/go.gif" width="37" height="15" /></td>
                </tr>
              </table>
            </div></td>
          </tr>
        </table></td>
        <td width="14"><img src="images/tab_22.gif" width="14" height="29" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
