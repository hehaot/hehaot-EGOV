<%@page pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.g/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
  function addNewLine(invregnum,invname,cty){
    //��ȡ���
    var invListTable =document.getElementById("invListTable");
    //��ȡ�������������
    var index=invListTable.rows.length;
    //�ڱ��ĩβ���һ��
    var tableRow = invListTable.insertRow();

    //����tableRow��id
    tableRow.id=invregnum;

    //���ñ���ɫ
    tableRow.style.background = "white";
    //���������5����Ԫ��
    var tableCell0 = tableRow.insertCell(0);
    var tableCell1 = tableRow.insertCell(1);
    var tableCell2 = tableRow.insertCell(2);
    var tableCell3 = tableRow.insertCell(3);
    var tableCell4 = tableRow.insertCell(4);
    //��ÿһ����Ԫ������HTML
    tableCell0.innerHTML='<div align="center" style="padding:5px" class="STYLE2 STYLE1"><input type="hidden" name="invregnum" value="'+invregnum+'">'+invname+'</div>';
    tableCell1.innerHTML='<div align="center" style="padding:2px" class="STYLE2"><input type="hidden" name="cty" value="'+cty+'">'+cty+'</div>';
    tableCell2.innerHTML='<div align="center" style="padding:5px" class="STYLE2 STYLE1"><input type="text" name="regcapItem" onblur="computeCap();" style="width:90px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div>';
    tableCell3.innerHTML='<div align="center" style="padding:2px" class="STYLE2"><input type="text" name="scale" style="width:90px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div>';
    tableCell4.innerHTML='<div align="center" style="padding:2px" class="STYLE2"><img onclick="delRow('+invregnum+');" src="images/delete.jpg"/></div>';
  }
  //ɾ����ǰ��
  function delRow(tableRowId){
    var invListTable=document.getElementById("invListTable");
    var tableRow = document.getElementById(tableRowId);
    invListTable.deleteRow(tableRow.rowIndex);
  }
//����ע���ʽ���ⷽ��ע���ʽ�
  function computeCap(){
    //��ȡ���еġ�ע���ʱ����ʶ�����
    var regcaapItems=document.getElementsByName("regcapItem");

    //��ȡ���й���
    var ctys=document.getElementsByName("cty");

    //��������
    var totalRegcap=0;
    var outtotalRegcap=0;
    for (var i=0;i<regcaapItems.length;i++) {
      var regcapItem = regcaapItems[i];
      if (regcapItem.value != "") {
        totalRegcap += parseInt(regcapItem.value);
        if (ctys[i].value != "�й�"){
          outtotalRegcap+=parseInt(regcapItem.value);
        }
      }
    }
    //��ע���ʱ����õ���ע���ʱ����ı�����
    var regcap=document.getElementById("regcap");
    regcap.value=totalRegcap;
    //�ⷽ��ע���ʱ�
    var outregcap=document.getElementById("outregcap");
    outregcap.value=outtotalRegcap;

    //�ⷽ�ĳ��ʱ���
    var tipScale = document.getElementById("tipScale");
    tipScale.innerHTML =(outtotalRegcap / totalRegcap * 100).toFixed(2) + "%";
  }

  function doSave(){
    document.getElementById("enForm").submit();
  }
</script>
</head>

<body>
<form action="/myWeb/saveEn" method="post" id="enForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">����������ҵ�Ǽ�-¼��</span></td>
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
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>��ҵ������Ϣ</B></font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��֯��������:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><%=request.getParameter("orgcode")%><input type="hidden" name="orgcode" value="<%=request.getParameter("orgcode")%>"></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">���Ǽ�֤��:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="regno" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��ҵ��������:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="cnname" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��ҵӢ������:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="enname" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��ϵ��:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="contactman" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��ϵ�绰:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="contacttel" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
          </tr>
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" width="100%" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>��ҵ�ʽ������Ϣ</B></font></div></td>
          </tr>        
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">ע���ʱ�:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" readonly="readonly" name="regcap" id="regcap" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">ע�����:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
		      <select name="regcry" style="WIDTH:100px">
		        <option value="000">�����</option>
		        <option value="001">��Ԫ</option>
		        <option value="002">Ӣ��</option>
		        <option value="003">��Ԫ</option>
		      </select> <font color="red">*</font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�ⷽע���ʱ�:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" readonly="readonly" name="outregcap" id="outregcap" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�ⷽ���ʱ���:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><span id="tipScale">0%</span></div></td>
          </tr>
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>Ͷ�����ʽ��������</B></font></div></td>
          </tr> 
          <tr>
            <td width="100%" bgcolor="#FFFFFF" class="STYLE1" colspan="4">
                <table id="invListTable" border="0" width="100%" height="100%" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
		          <tr>
		            <td width="20%" bgcolor="#CCCCCC" height="20" class="STYLE1"><div align="center" style="padding:5px" class="STYLE2 STYLE1">Ͷ��������</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2">����</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:5px" class="STYLE2 STYLE1">ע���ʱ����ʶ�</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2">����������</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2"><img src="images/query.jpg" onclick="window.open('foreignExchange/orgcodeSelect.jsp', '��ҳ��ѯͶ������Ϣ', 'width=720, height=400, scrollbars=no')"/></div></td>
		          </tr>


                </table>
            </td>
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
          <tr height="30"><td bgcolor="#FFFFFF" height="30" class="STYLE1" colspan="2" align="center"><img src="images/ok.jpg" onclick="doSave();"/>&nbsp;&nbsp;<img src="images/back.jpg" onclick="document.location='newInputOrg.html'"/></td></tr>
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
