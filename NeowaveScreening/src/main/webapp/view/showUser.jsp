<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/amazeui.min.css"/>
<title>Fesco screening</title>
</head>

<style type="text/css">
	td{ height:40px;}
	th{ height:40px;}
</style>

<body>
<script type="text/javascript">
function onCondition(el, code) {
	$('#f_' + code).html(el.value);
	var f = el.value;
	var g = $('#g_' + code).text();
	
	if (code == '01'){
		var desc = el.options[el.selectedIndex].getAttribute("desc");
		$('#e_01').html(desc);
	}
	cal(code, f, g);
}

function cal(code, f, g){
	var sex = 1;
	var v = sex == 1 ? 16 : 17;
	var h = parseFloat(f) * parseFloat(g) * (0.45 / v / 5) * 100; 
	$('#h_' + code).html(h.toFixed(3));
}

function cal_r(code){
	var sex = 1;
	var v = sex == 1 ? 1.75 : 2;
	$('#g_' + code).html(v);
}

</script>

<header class="am-topbar am-topbar-inverse admin-header">
  <div class="am-topbar-brand">
    <strong>Fesco</strong> <small>岗位外包项目风险评估工具</small>
  </div>

  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

  <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
      <li class="am-dropdown" data-am-dropdown>
        <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
          <span class="am-icon-users"></span> 系统管理员 <span class="am-icon-caret-down"></span>
        </a>
        <ul class="am-dropdown-content">
          <li><a href="#"><span class="am-icon-user"></span> 帮助</a></li>
          <li><a href="#"><span class="am-icon-cog"></span> 设置</a></li>
          <li><a href="#"><span class="am-icon-power-off"></span> 退出</a></li>
        </ul>
      </li>
    </ul>
  </div>
</header>

<table border="1" style="width: 80%;border-collapse:collapse;" cellpadding="0" cellspacing="0" align="center">
	<tr bgcolor="#C4D79B"><th colspan="8" style="text-align:center">岗位外包项目风险评估工具 </th></tr>
	<tr bgcolor="#C4D79B">
		<th style="width: 15%;text-align:center">评估维度 </th>
		<th style="width: 20%;text-align:center">二级维度 </th>
		<th style="width: 35%;text-align:center" colspan="3">情况<br><span style="color:red">请按照实际情况更改白色区域内的内容</span></th>
		<th style="width: 10%;text-align:center">风险评估情况 </th>
		<th style="width: 10%;text-align:center">加权 </th>
		<th style="width: 10%;text-align:center">风险率 </th>
	</tr>
	<tr>
		<td style="text-align:center" rowspan="6" bgcolor="#B7DEE8">客户情况分析 </td>
		<td bgcolor="#B7DEE8">客户运营情况</td>
		<td colspan="3">
			<select style="width:100%; height:100%" onchange="javascript: onCondition(this, '04')">
			<c:forEach items="${dict.get('04')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
        </td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_04">1</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_04">2</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_04"></span>%</td>
	</tr>
	<tr>
		<td bgcolor="#B7DEE8">外包项目时长(商务合同周期)</td>
		<td colspan="3">
			<select style="width:100%; height:100%" onchange="javascript: onCondition(this, '05')">
			<c:forEach items="${dict.get('05')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
        </td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="f_05">1</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_05">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_05"></span>%</td>
	</tr>
	<tr>		
		<td bgcolor="#B7DEE8">客户管理参与度</td>
		<td colspan="3">
			<select style="width:100%; height:100%" onchange="javascript: onCondition(this, '06')">
			<c:forEach items="${dict.get('06')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="f_06">1</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_06">1.5</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_06"></span>%</td>
	</tr>
	<tr>
		<td bgcolor="#B7DEE8">行业</td>
		<td style="width:12%;">
			<select id="s_01" style="width:100%; height:100%;" onchange="javascript: onCondition(this, '01')">
			<c:forEach items="${dict.get('01')}" var="dict1">
                <option value="${dict1.val}" desc="${dict1.desc}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td colspan="2" bgcolor="#B7DEE8" style="width:23%; height: 90px">
			<div id="e_01" style="width:100%;height:100%;overflow:auto"></div>
		</td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="f_01"></span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_01">1</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_01"></span>%</td>
	</tr>
	<tr>		
		<td bgcolor="#B7DEE8">外包业务地域范围</td>
		<td colspan="3">-</td>
		<td style=" text-align:center" bgcolor="#D9D9D9">-</td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_07">0.75</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_07"></span>%</td>
	</tr>
	<tr>
		<td bgcolor="#B7DEE8">办公设施情况</td>
		<td colspan="3">-</td>
		<td style=" text-align:center" bgcolor="#D9D9D9">-</td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="r_08">0.75</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	
	<!--       -->
	<tr>
		<td style="text-align:center" rowspan="9" bgcolor="#FCD5B4">员工情况分析 </td>
		<td bgcolor="#FCD5B4">平均薪资水平</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">劳动合同平均年限</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">项目是否继承工龄</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">岗位分类</td>
		<td>-</td><td>-</td><td>-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">项目员工男女比例</td>
		<td colspan="3">
			<select style="width:100%; height:100%" onchange="javascript: onCondition(this, '11')">
			<c:forEach items="${dict.get('11')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_11">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_11">0.75</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_11"></span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">女工平均年龄</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">男工平均年龄</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">平均工龄</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">平均受教育程度</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	
	<!--  -->
	<tr>
		<td style="text-align:center" rowspan="2" bgcolor="#B8CCE4">行业情况分析 </td>
		<td bgcolor="#B8CCE4">行业健康度</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#B8CCE4">行业出现时长</td>
		<td colspan="3">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	
	<!--  -->
	<tr>
		<td style="text-align:center" rowspan="2" bgcolor="#C4BD97">项目分析 </td>
		<td bgcolor="#C4BD97">外包规模</td>
		<td colspan="5">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	<tr>
		<td bgcolor="#C4BD97">项目风险记录</td>
		<td colspan="3">-</td>
		<td colspan="2">-</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
	
	<tr>
		<td colspan="7" bgcolor="#E26B0A" style="text-align:center;">风险系数</td>
		<td style="text-align:center" bgcolor="#D9D9D9">-</td>
	</tr>
</table>
<script src="js/jquery.min.js"></script>
<script src="js/amazeui.min.js"></script>

<script type="text/javascript">
	cal_r('05');
</script>
</body>
</html>