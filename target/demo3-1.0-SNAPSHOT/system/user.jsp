<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%@ page import="Util.StringUtil" %>
<%@ page import="bean.Page" %>
<%@page pageEncoding="GB18030"%>
<%
  Page<User> page1=(Page<User>) request.getAttribute("page");
  //用户列表信息
  List<User> userList= page1.getDataList();
  //总页数
  Integer pagecount = page1.getPagecount();
  //总记录体条数
  Integer totalsize = page1.getTotalsize();
  //每页显示的记录条数
  Integer pagesize = page1.getPagesize();
  //第几页
  Integer pageno = page1.getPageno();
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

<script>
  //翻页
  function changpage(pageno){
    document.location="/myWeb/PageQueryUser?pageno="+pageno;
  }
  //跳转到指定页面
  function gopage(){
    //获取页面
    var pagenoDomObj=document.getElementById("mypageno");

    //非空验证
    if (pagenoDomObj.value==""){
      alert("页码不能为空，请填写");
      pagenoDomObj.focus();
      return;
    }
    //数字验证
    if (isNaN(pagenoDomObj.value)){
      alert("页码必须是数字，请重新填写");
      pagenoDomObj.value="";
      pagenoDomObj.focus();
      return;
    }
    //范围验证
    var pageno=parseInt(pagenoDomObj.value);
    if (pageno < 1 ||pageno > <%=pagecount%>){
      alert("页码必须在1- <%=pagecount%>之间");
      pagenoDomObj.value="";
      pagenoDomObj.focus();
      return;
    }
    //跳转
    changpage(pageno);
  }

  //删除和修改图片的联动效果
  function controlDeleteUpdateImg(){
    var usercodes=document.getElementsByName("usercode");

    //循环统计被选中的个数
    var checkedCount=0;
    for (var i=0;i<usercodes.length;i++){
      if (usercodes[i].checked){
        checkedCount++;
      }
    }

    //根据选中的数量进行删除图片和修改图片联动
    var updateImg=document.getElementById("updateImg");
    var deleteImg=document.getElementById("deleteImg");

    //选中0个（删除和修改都不能用）
    if (checkedCount==0){
    deleteImg.src="images/delete_disabled.jpg";
    updateImg.src="images/update_disabled.jpg";
      deleteImg.style="cursor:default";
      updateImg.style="cursor:default";
      deleteImg.disabled=true;
      updateImg.disabled=true;
    }
    //选中1个（删除和修改都能用）
    if (checkedCount==1) {
      deleteImg.src = "images/delete.jpg";
      updateImg.src = "images/update.jpg";
      updateImg.style="cursor:pointer";
      deleteImg.style="cursor:pointer"
      deleteImg.disabled=false;
      updateImg.disabled=false;
    }
    //选中1+个（删除能用，修改不能用）
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
//选中所有或者取消所有
  function checkOrCancelAll2(){
    var checkOrCancelAll=document.getElementById("checkOrCancelAll");
    var usercodes=document.getElementsByName("usercode");
    if (checkOrCancelAll.checked){
      //选中所有
      for (var i=0;i<usercodes.length;i++){
        usercodes[i].checked=true;
        controlDeleteUpdateImg();
      }
    }else{
      //取消所有
      for (var i=0;i<usercodes.length;i++){
        usercodes[i].checked=false;
        controlDeleteUpdateImg();
     }
   }
  }

  //跳转到修改页面
  function goUpdate(){
      document.getElementById("form1").submit();
  }
  //删除用户信息
  function dodelete(){
    if (window.confirm("您确定要删除用户信息吗？")) {
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
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">系统用户列表</span></td>
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

            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">序号</div></td>
            <td width="12%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">用户代码</div></td>
            <td width="24%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">用户姓名</div></td>
            <td width="38%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">机构类型</div></td>
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
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">共<%=totalsize%>条纪录，当前第<%=pageno%>/<%=pagecount%>页，每页<%=pagesize%>条纪录</span></td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">


                <%
                  //当前页码>1表示不在第一页上
                  boolean isNotFirstPage =pageno>1;
                  //当前页码<总页数表示不在最后一页上
                  boolean isNotLastPage =pageno<pagecount;
                %>

                <tr>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/firstPage<%=isNotFirstPage?"":"Disabled"%>.gif" <%=isNotFirstPage?"style='cursor:pointer' onclick='changpage(1)'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/prevPage<%=isNotFirstPage?"":"Disabled"%>.gif"  <%=isNotFirstPage?"style='cursor:pointer' onclick='changpage("+(pageno-1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/nextPage<%=isNotLastPage?"":"Disabled"%>.gif" <%=isNotLastPage?"style='cursor:pointer' onclick='changpage("+(pageno+1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/lastPage<%=isNotLastPage?"":"Disabled"%>.gif" <%=isNotLastPage?"style='cursor:pointer' onclick='changpage("+pagecount+")'":""%>/></div></td>
                  <td width="59" height="22" valign="middle"><div align="right">转到第</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input id="mypageno" name="textfield" type="text" class="STYLE1" style="height:14px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle">页</td>
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
