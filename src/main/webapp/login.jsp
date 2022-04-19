<%@page pageEncoding="GB18030"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%--base标记
			*base标记属于HTML语法范畴，和js无关，和Java更没有关系
			*base标记只对当前页面中的所有相对路径起作用，绝对路径不起作用
			*当前页面中所有相对路径，便面上看起来是相对路径，其实加上base上的路径之后就是一个绝对路径了
					<base href="http://localhost:8080/myWeb/">
			--%>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>外汇业务信息管理平台_用户登录</title>
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			overflow:hidden;
		}
		.STYLE1 {
			font-size: 12px;
			color: #a1c8c6;
		}
		.STYLE4 {color: #FFFFFF; font-size: 12px; }
		-->
		</style>

		<script charset="utf-8" type="text/javascript" src="js/egov.js"></script>
		<script type="text/javascript">
			function doLogin(){
				var ok=validateForm();
				if (ok){
					document.forms["loginForm"].submit();
				}
			}
			function validateForm(){
				var formItem1 =new FormItem("机构类型","orgtype");
				var formItem2 =new FormItem("用户代码","usercode");
				var formItem3 =new FormItem("用户密码","userpswd");
				var formItemArr=[formItem1,formItem2,formItem3];
				return $.isNotEmpty(formItemArr);
			}

			function pageLoad(){
				<%
					Object errorMsg=request.getAttribute("errorMsg");
					if (errorMsg!=null){
				%>
				alert("<%=errorMsg%>");
				<%
					}
				%>

			}

		</script>
	</head>
	<body onload="pageLoad()">
	<form action="/myWeb/login" method="post" name="loginForm">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr><td bgcolor="035551">&nbsp;</td></tr>
			<tr>
				<td height="311" background="img/login_03.gif">
					<table width="758" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr><td height="210" background="img/login1.jpg">&nbsp;</td></tr>
						<tr>
							<td height="101">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
		            					<td width="446" height="101" background="img/login_06.jpg">&nbsp;</td>
		            					<td width="156">
		            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
							                		<td width="40%" height="22"><span class="STYLE4">机构类型</span></td>
							                		<td width="71" height="22">
										            <select name="orgtype" id="orgtype" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">
                                                                                          <option value=""></option>
                                                                                          <option value="0" selected="selected">外汇管理局</option>
                                                                                          <option value="1">银行</option>
										            </select>
							                		</td>
							              		</tr>
												<tr>
							                		<td height="22"><span class="STYLE4">用户代码</span></td>
							                		<td width="71" height="22"><input type="text" name="usercode" id="usercode" value="001" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
							              		</tr>
							              		<tr>
							                		<td height="22"><span class="STYLE4">用户密码</span></td>
							                		<td height="22"><input type="password" name="userpswd" id="userpswd" value="123456" style="width:100px; height:22px; border:solid 1px #035551; color:#000000"></td>
							              		</tr>
							              		<tr>
							                		<td height="25">&nbsp;</td>
							                		<td height="25"><%--<input type="button" style="width:40px;height:25px" onclick="doLogin()" >--%><img src="img/dl.gif" width="37" height="19" border="0" style="cursor: pointer" onclick="doLogin()">
														&nbsp;&nbsp;&nbsp;&nbsp;<%--<button style="width:40px;height:25px">--%><img src="img/qx.gif" width="37" height="19" style="cursor: pointer"></td>
												</tr>
											</table>
										</td>
										<td width="156" background="img/login_09.gif">&nbsp;</td>
		          					</tr>
		        				</table>
		        			</td>
		      			</tr>
		    		</table>
		    	</td>
		  	</tr>
		  	<tr>
		    	<td bgcolor="1f7d78">&nbsp;</td>
		  	</tr>
		  	<tr>
		    	<td bgcolor="1f7d78"><div align="center"><span class="STYLE1">-- 何浩天 2022.3.25 --</span></div></td>
		  	</tr>
		</table>
	 </form>
	</body>
</html>
