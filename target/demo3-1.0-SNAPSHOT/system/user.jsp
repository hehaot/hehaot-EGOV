<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%@ page import="Util.StringUtil" %>
<%@ page import="bean.Page" %>
<%@page pageEncoding="GB18030"%>
<%
  Page<User> page1=(Page<User>) request.getAttribute("page");
  //�û��б���Ϣ
  List<User> userList= page1.getDataList();
  //��ҳ��
  Integer pagecount = page1.getPagecount();
  //�ܼ�¼������
  Integer totalsize = page1.getTotalsize();
  //ÿҳ��ʾ�ļ�¼����
  Integer pagesize = page1.getPagesize();
  //�ڼ�ҳ
  Integer pageno = page1.getPageno();
%>
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
  //��ҳ
  function changpage(pageno){
    document.location="/myWeb/PageQueryUser?pageno="+pageno;
  }
  //��ת��ָ��ҳ��
  function gopage(){
    //��ȡҳ��
    var pagenoDomObj=document.getElementById("mypageno");

    //�ǿ���֤
    if (pagenoDomObj.value==""){
      alert("ҳ�벻��Ϊ�գ�����д");
      pagenoDomObj.focus();
      return;
    }
    //������֤
    if (isNaN(pagenoDomObj.value)){
      alert("ҳ����������֣���������д");
      pagenoDomObj.value="";
      pagenoDomObj.focus();
      return;
    }
    //��Χ��֤
    var pageno=parseInt(pagenoDomObj.value);
    if (pageno < 1 ||pageno > <%=pagecount%>){
      alert("ҳ�������1- <%=pagecount%>֮��");
      pagenoDomObj.value="";
      pagenoDomObj.focus();
      return;
    }
    //��ת
    changpage(pageno);
  }

  //ɾ�����޸�ͼƬ������Ч��
  function controlDeleteUpdateImg(){
    var usercodes=document.getElementsByName("usercode");

    //ѭ��ͳ�Ʊ�ѡ�еĸ���
    var checkedCount=0;
    for (var i=0;i<usercodes.length;i++){
      if (usercodes[i].checked){
        checkedCount++;
      }
    }

    //����ѡ�е���������ɾ��ͼƬ���޸�ͼƬ����
    var updateImg=document.getElementById("updateImg");
    var deleteImg=document.getElementById("deleteImg");

    //ѡ��0����ɾ�����޸Ķ������ã�
    if (checkedCount==0){
    deleteImg.src="images/delete_disabled.jpg";
    updateImg.src="images/update_disabled.jpg";
      deleteImg.style="cursor:default";
      updateImg.style="cursor:default";
      deleteImg.disabled=true;
      updateImg.disabled=true;
    }
    //ѡ��1����ɾ�����޸Ķ����ã�
    if (checkedCount==1) {
      deleteImg.src = "images/delete.jpg";
      updateImg.src = "images/update.jpg";
      updateImg.style="cursor:pointer";
      deleteImg.style="cursor:pointer"
      deleteImg.disabled=false;
      updateImg.disabled=false;
    }
    //ѡ��1+����ɾ�����ã��޸Ĳ����ã�
      if (checkedCount>1) {
        deleteImg.src = "images/delete.jpg";
        updateImg.src = "images/update_disabled.jpg";
        deleteImg.style="cursor:pointer";
        updateImg.style="cursor:default";
        deleteImg.disabled=false;
        updateImg.disabled=true;
      }
      if(checkedCount==usercodes.length){
        document.getElementById("checkOrCancelAll").checked=true;
      }else
        document.getElementById("checkOrCancelAll").checked=false;
  }
//ѡ�����л���ȡ������
  function checkOrCancelAll2(){
    var checkOrCancelAll=document.getElementById("checkOrCancelAll");
    var usercodes=document.getElementsByName("usercode");
    if (checkOrCancelAll.checked){
      //ѡ������
      for (var i=0;i<usercodes.length;i++){
        usercodes[i].checked=true;
        controlDeleteUpdateImg();
      }
    }else{
      //ȡ������
      for (var i=0;i<usercodes.length;i++){
        usercodes[i].checked=false;
        controlDeleteUpdateImg();
     }
   }
  }

  //��ת���޸�ҳ��
  function goUpdate(){
      document.getElementById("form1").submit();
  }
  //ɾ���û���Ϣ
  function dodelete(){
    if (window.confirm("��ȷ��Ҫɾ���û���Ϣ��")) {
      document.getElementById("form1").action="/myWeb/delete";
      document.getElementById("form1").submit();
    }else{

    }
  }
</script>
</head>

<body onload="controlDeleteUpdateImg();">
<form action="/myWeb/goUpdate" id="form1" method="post" name="userForm">

  <input type="hidden" name="pageno" id="pageno" value="<%=pageno%>">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">ϵͳ�û��б�</span></td>
        <td width="281" background="images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img src="images/add.jpg" style="cursor:pointer" onclick="document.location='system/userAdd.jsp'"/></div></td>
                  </tr>
              </table></td>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img id="updateImg" src="images/update_disabled.jpg" disabled onclick="goUpdate()" /></div></td>
                  </tr>
              </table></td>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img id="deleteImg" src="images/delete_disabled.jpg" disabled="disabled" onclick="dodelete()"/></div></td>
                  </tr>
              </table></td>
            </tr>
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
          <tr>
            <td width="6%" height="26" background="images/tab_14.gif" class="STYLE1">

              <div align="center" class="STYLE2 STYLE1">
                <input type="checkbox" id="checkOrCancelAll" onclick="checkOrCancelAll2()" />
              </div>
            </td>

            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">���</div></td>
            <td width="12%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">�û�����</div></td>
            <td width="24%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">�û�����</div></td>
            <td width="38%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">��������</div></td>
          </tr>

          <%
            int i=0;
          for (User user: userList){
            %>
          <tr>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE1">
              <input name="usercode" value="<%=user.getUsercode()%>" type="checkbox" class="STYLE2" value="checkbox" onclick="controlDeleteUpdateImg()"/>
            </div></td>
            <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1"><%=++i%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=user.getUsercode()%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=user.getUsername()%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" ><a href="#"><%=StringUtil.getTextBycode(user.getOrgtype())%></a></div></td>

          </tr>
          <%
          }
          %>



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
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">��<%=totalsize%>����¼����ǰ��<%=pageno%>/<%=pagecount%>ҳ��ÿҳ<%=pagesize%>����¼</span></td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">


                <%
                  //��ǰҳ��>1��ʾ���ڵ�һҳ��
                  boolean isNotFirstPage =pageno>1;
                  //��ǰҳ��<��ҳ����ʾ�������һҳ��
                  boolean isNotLastPage =pageno<pagecount;
                %>

                <tr>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/firstPage<%=isNotFirstPage?"":"Disabled"%>.gif" <%=isNotFirstPage?"style='cursor:pointer' onclick='changpage(1)'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/prevPage<%=isNotFirstPage?"":"Disabled"%>.gif"  <%=isNotFirstPage?"style='cursor:pointer' onclick='changpage("+(pageno-1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/nextPage<%=isNotLastPage?"":"Disabled"%>.gif" <%=isNotLastPage?"style='cursor:pointer' onclick='changpage("+(pageno+1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/lastPage<%=isNotLastPage?"":"Disabled"%>.gif" <%=isNotLastPage?"style='cursor:pointer' onclick='changpage("+pagecount+")'":""%>/></div></td>
                  <td width="59" height="22" valign="middle"><div align="right">ת����</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input id="mypageno" name="textfield" type="text" class="STYLE1" style="height:14px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle">ҳ</td>
                  <td width="30" height="22" valign="middle"><img src="images/go.gif" width="37" height="15" style="cursor:pointer" onclick="gopage()"/></td>
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
