<%@ page import="entity.User" %>
<%@ page import="Util.StringUtil" %>
<%@page pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
.STYLE2 {
	color: #03515d;
	font-size: 12px;
}
-->
a:link {font-size:12px; text-decoration:none; color:#000000;}
a:visited {font-size:12px; text-decoration:none; color:#000000;}
a:hover {font-size:12px; text-decoration:none; color:#FF0000;}

a.v1:link {font-size:12px; text-decoration:none; color:#03515d;}
a.v1:visited {font-size:12px; text-decoration:none; color:#03515d;}
</style>

</head>
<script>
  function goupdate(){
    document.getElementById("FormUpdateUser").submit();
  }
</script>

<body>
<form action="/myWeb/goUpdate" method="post" id="FormUpdateUser" target="I2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="26" background="images/main_03.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="227" height="26" background="images/main_01.gif" >&nbsp;</td>
        <td>&nbsp;</td>
        <td width="60"><img src="images/main_05.gif" width="60" height="26" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="64"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="227" height="64" background="images/main_06.jpg" nowrap="nowrap" >&nbsp;</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="26" background="images/main_07.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="26"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="640" height="26"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="30"><div align="center"><img src="images/user.png" width="14" height="14" /></div></td>
                        <%
                          User user=(User) session.getAttribute("user");
                        %>
                        <td  nowrap="nowrap" class="STYLE1">��ǰ��¼�û���<%=user.getUsername()%> &nbsp;&nbsp;&nbsp;&nbsp;�������ͣ�<%=StringUtil.getTextBycode(user.getOrgtype())%></td>
                      </tr>
                    </table></td>
                    <td width="19"><img src="images/main_09.gif" width="19" height="26" /></td>
                    <td width="200"><table width="46%" border="0" align="right" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="102"><table width="102" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="22"><div align="center"><img src="images/72.png" width="14" height="14" /></div></td>
                              <td width="80"><div align="center" class="STYLE1"><a onclick="goupdate();" id="updateUser" target="I2"style="cursor: pointer">������Ϣ�޸�</a>
                                <input type="hidden" name="usercode" id="usercode" value="<%=user.getUsercode()%>"></div></td>
                            </tr>
                        </table></td>
                        <td width="10"><img src="images/main_11.gif" width="6" height="26" /></td>
                        <td width="56"><table width="45" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="21"><div align="center"><img src="images/logout.gif" width="14" height="14" /></div></td>
                              <td width="24"><div align="center" class="STYLE1"><a href="/myWeb/logout" target="_top" style="cursor:pointer">�˳�</a></div></td>
                            </tr>
                        </table></td>
                        </tr>
                    </table></td>
                  </tr>
                </table></td>
                <td width="12"><img src="images/main_13.gif" width="12" height="26" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="38" background="images/main_15.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="38"><table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    </tr>
                </table></td>
                <td width="60%" ><div align="right"><img src="images/main_17.gif" width="60" height="38" /></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
