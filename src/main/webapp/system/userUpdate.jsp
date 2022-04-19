<%@ page import="entity.User" %>
<%@page pageEncoding="GB18030"%>
<%
  User user=(User)request.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
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
<%--导入js文件--%>
  <script charset="utf-8" type="text/javascript" src="js/egov.js"></script>
<script>
  /*
  //第一种方式：面型过程的js代码，开发效率较低
  function validateForm(){
  //用户代码、密码、姓名、确认密码、机构类型不能为空
  var usernameDomeObj=document.getElementById("username");
  if (usernameDomeObj.value==""){
    alert("用户名称不能为空，请填写。");
    usernameDomeObj.focus();
    return false;
  }

  var userpswdDomeObj=document.getElementById("userpswd");
  if (userpswdDomeObj.value==""){
    alert("用户密码不能为空，请填写。");
    userpswdDomeObj.focus();
    return false;
  }

  var checkpswdDomeObj=document.getElementById("checkpswd");
  if (checkpswdDomeObj.value==""){
    alert("确认密码不能为空，请填写。");
    checkpswdDomeObj.focus();
    return false;
  }

  //用户密码和确认密码必须一致
  if(userpswdDomeObj.value != checkpswdDomeObj.value){
    alert("用户密码和确认密码不一致，请重新填写。");
    userpswdDomeObj.value="";
    checkpswdDomeObj.value="";
    userpswdDomeObj.focus();
    return false;
  }
  var orgtypeDomeObj=document.getElementById("orgtype");
  if (orgtypeDomeObj.value==""){
    alert("机构类型不能为空，请填写。");
    orgtypeDomeObj.focus();
    return false;
  }
  return true;
  }*/
  //第二种方法面向对象
  function validateForm(){
    //创建FormItem对象
    var formItem1 = new FormItem("用户姓名","username");
    var formItem2 = new FormItem("用户密码","userpswd");
    var formItem3 = new FormItem("确认密码","checkpswd");
    var formItem4 = new FormItem("机构类型","orgtype");
    //创建数组对象
    var formItemArr=[formItem1,formItem2,formItem3,formItem4];
    return $.isNotEmpty(formItemArr) && $.isSame(formItem2,formItem3);
  }

 function doUpdate(){
    var ok=validateForm();
    if (ok){
      document.getElementById("userForm").submit();
    }
  }
</script>
</head>

<body>
<form action="/myWeb/update" method="post" name="userForm" id="userForm">
<%--  使用隐藏于提交页码--%>
  <input type="hidden" id="pageno" name="pageno" value="<%=request.getParameter("pageno")%>">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">修改系统用户</span></td>
        <td width="281" background="images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
        </table></td>
        <td width="14"><img src="images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
          <tr height="26"></tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户代码</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><%=user.getUsercode()%>
              <input type="hidden" id="usercode" name="usercode" value="<%=user.getUsercode()%>"></div></td><%--隐藏域，这样就能把usercode提交了--%>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户姓名</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input id="username" type="text" name="username" value="<%=user.getUsername()%>" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户密码</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input id="userpswd" type="password" name="userpswd" value="<%=user.getUserpswd()%>" style="width:100px; height:20px; border:solid 1px #035551; color:#000000;">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">确认密码</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input id="checkpswd" type="password" name="checkpswd" value="<%=user.getUserpswd()%>" style="width:100px; height:20px; border:solid 1px #035551; color:#000000;">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">机构类型</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
            <select name="orgtype" id="orgtype" style="width:105px; height:20px; border:solid 1px #035551; color:#000000">
              <option value="0" <%="0".equals(user.getOrgtype())?"selected":""%>>外汇管理局</option>
              <option value="1" <%="1".equals(user.getOrgtype())?"selected":""%>>银行</option>
            </select>&nbsp;<font color='red'>*</font></div></td>
          </tr>
        </table></td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
          <tr height="26"><td bgcolor="#FFFFFF" height="26" class="STYLE1" colspan="2" style="padding-top:5px;padding-left:200px">
            <img src="images/save.jpg" style="cursor:pointer" onclick="doUpdate()"/>&nbsp;&nbsp;
            <img src="images/clear.jpg" style="cursor:pointer" /></td></tr>
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
            <td width="75%" valign="top" class="STYLE1"><div align="left">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="62" height="22" valign="middle"></td>
                  <td width="50" height="22" valign="middle"></td>
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
