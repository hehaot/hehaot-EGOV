<%@page pageEncoding="GB18030"%>
<%

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <base href="http://localhost:8080/myWeb/">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
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

//�ύ�û����ݱ���Ϣ����������
  function dosave(){
    //��֤�������Ƿ�Ϸ�
    var ok=validateForm();
    //����Ϸ����ύ��
    if (ok){
      document.forms[0].submit();
    }
  }

  //У���
function validateForm(){
    //�û����롢���롢������ȷ�����롢�������Ͳ���Ϊ��
    var usercodeDomeObj=document.getElementById("usercode");
    if (usercodeDomeObj.value==""){
      alert("�û����벻��Ϊ�գ�����д��");
      usercodeDomeObj.focus();
      return false;
    }

  var usernameDomeObj=document.getElementById("username");
  if (usernameDomeObj.value==""){
    alert("�û����Ʋ���Ϊ�գ�����д��");
    usernameDomeObj.focus();
    return false;
  }

  var userpswdDomeObj=document.getElementById("userpswd");
  if (userpswdDomeObj.value==""){
    alert("�û����벻��Ϊ�գ�����д��");
    userpswdDomeObj.focus();
    return false;
  }

  var checkpswdDomeObj=document.getElementById("checkpswd");
  if (checkpswdDomeObj.value==""){
    alert("ȷ�����벻��Ϊ�գ�����д��");
    checkpswdDomeObj.focus();
    return false;
  }

  //�û������ȷ���������һ��
  if(userpswdDomeObj.value != checkpswdDomeObj.value){
    alert("�û������ȷ�����벻һ�£���������д��");
    userpswdDomeObj.value="";
    checkpswdDomeObj.value="";
    userpswdDomeObj.focus();
    return false;
  }
  var orgtypeDomeObj=document.getElementById("orgtype");
  if (orgtypeDomeObj.value==""){
    alert("�������Ͳ���Ϊ�գ�����д��");
    orgtypeDomeObj.focus();
    return false;
  }
    return true;
}
function pageLoad(){
  <%
 Object errorMsg=request.getAttribute("errorMsg");
 if(errorMsg != null){
   %>
  alert("<%=errorMsg%>");
  <%
    }
  %>
}

//ʹ��ajaxУ���û������Ƿ����
function checkUsercode(usercode){
    var xmlHttp=new XMLHttpRequest();
    xmlHttp.onreadystatechange=function (){
      if( xmlHttp.readyState == 4 && xmlHttp.status == 200){
        document.getElementById("tipUsercode").innerHTML=xmlHttp.responseText;
      }

    }
    xmlHttp.open("get","/myWeb/checkUsercode?_="+new Date().getTime()+"&usercode="+usercode,true);
    xmlHttp.send();
}
</script>
</head>

<body onload="pageLoad()" >
<form action="/myWeb/saveUser" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">����ϵͳ�û�</span></td>
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
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�û�����</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" id="usercode" name="usercode" onblur="checkUsercode(this.value)" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font><span id="tipUsercode"></span></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�û�����</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" id="username" name="username" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�û�����</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" id="userpswd" name="userpswd" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">ȷ������</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" id="checkpswd" name="checkpswd" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��������</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
            <select name="orgtype" id="orgtype" style="width:105px; height:20px; border:solid 1px #035551; color:#000000">
              <option value=""></option>
              <option value="0">�������</option>
              <option value="1">����</option>
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
          <tr height="26"><td bgcolor="#FFFFFF" height="26" class="STYLE1" colspan="2"
                              style="padding-top:5px;padding-left:200px"><img src="images/save.jpg"
              style="cursor:hand" onclick="dosave()" />&nbsp;&nbsp;<img src="images/clear.jpg" style="cursor:hand" /></td></tr>
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
