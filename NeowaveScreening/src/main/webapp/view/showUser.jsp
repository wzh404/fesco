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

var initData = [
	{code : '04', f: 0, g : 2, h: 0},
	{code : '05', f: 0, g : 0, h: 0},
	{code : '06', f: 0, g : 1.5, h: 0},
	{code : '01', f: 0, g : 1, h: 0},
	{code : '07', f: 0, g : 0.75, h: 0},
	{code : '08', f: 0, g : 0.75, h: 0},
	
	{code : '09', f: 0, g : 2, h: 0},
	{code : '10', f: 0, g : 2, h: 0},
	{code : '19', f: 0, g : 0.75, h: 0},
	{code : '30', f: 0, g : 1, h: 0},
	{code : '11', f: 0, g : 0.75, h: 0},
	{code : '12', f: 0, g : 0, h: 0},
	{code : '13', f: 0, g : 0, h: 0},
	{code : '14', f: 0, g : 0.5, h: 0},
	{code : '15', f: 0, g : 0.3, h: 0},
	
	{code : '16', f: 0, g : 0.1, h: 0},
	{code : '17', f: 0, g : 0.1, h: 0},
	
	{code : '18', f: 0, g : 0, h: 0},
	{code : '20', f: 0, g : 0, h: 0},
];

function init(data){
	for (var i = 0; i < data.length; i++){
		var code = data[i].code;
		if (code == '30'){
			var f = $('#sel_level_3 option:selected').attr('val');
			
			$('#f_' + code).html(f);
			$('#g_' + code).html(data[i].g);
			//var g = data[i].g.toString();
			
			cal_h(code);
		}
		else if (code == '18'){
			var h = $("#sel_18").val();
			$('#h_' + code).html(h);
		}
		else if (code == '20'){
			var c = $("#sel_02").val();	
			var r = $("#sel_03").val();
			var h = $("#risk_" + c + "_" + r).val();
			
			$('#h_' + code).html(h);
		}
		else{
			var f = $("#sel_" + code).val();
			$('#f_' + code).html(f);
			
			cal_g(code);
			//var g = $('#g_' + code).html();			
			
			cal_h(code);			
		}
		
		if (code == '01'){
			var desc = $('#sel_01 option:selected').attr('desc')
			$('#desc_01').html(desc);
		}
	}
	
	sum_h(data);
}

function sum_h(data){
	var h18 = 0;
	var h20 = 0;
	var sum = 0;
	for (var i = 0; i < data.length; i++){
		var code = data[i].code;
		var h = $('#h_' + code).html();
		if (code == '18'){				
			h18 = parseFloat(h);
		}
		else if (code == '20'){
			h20 = parseFloat(h);
		}
		else{
			sum += parseFloat(h);
		}		
	}
	
	var h = sum * h18 / 100.0 * h20 / 100.0;
	$('#h_99').html(h.toFixed(3));
}

function callAjax(url, data) {
    var json = null;

    $.ajax({
        url: url,
        data: data,
        type: "get",
        dataType: "json",
        async: false,
        success: function success(jsonData) {
            console.log(jsonData.resultCode);
            json = jsonData;
        },
        error: function error(XMLHttpRequest, textStatus, errorThrown) {
            console.log(textStatus + ": " + XMLHttpRequest.status);
        }
    });

    return json;
}

function appendOption(id, json){
	$("#" + id).append("<option value='"+ json.id + "'  val='" + json.val + "'>" + json.name +"</option>");	
}

function createSelectLevel(id, list, pid){
	for (var i = 0; i < list.length; i++){
		if (list[i].pid == pid && list[i].ppid == 0){
			appendOption(id, list[i]);
		}
	}
}

function createSelectLevel2(id, list, ppid){
	for (var i = 0; i < list.length; i++){
		if (list[i].ppid == ppid){
			appendOption(id, list[i]);
		}
	}
}

function onCondition(el, code) {
	$('#f_' + code).html(el.value);	
	if (code == '01'){
		var desc = el.options[el.selectedIndex].getAttribute("desc");
		$('#desc_01').html(desc);
	}
	else if (code == '11'){
		cal_g('05');
		cal_g('12');
		cal_g('13');
	}
	
	cal_g(code);
	cal_h(code);
	
	sum_h(initData);
}

function onCondition2(el, code){
	$('#h_' + code).html(el.value);
	
	sum_h(initData);
}

function onCondition3(){
	var c = $("#sel_02").val();	
	var r = $("#sel_03").val();
	var v = $("#risk_" + c + "_" + r).val();
	
	$('#h_20').html(v);
	sum_h(initData);
}

function onConditionLevel1(){
	$('#sel_level_2').empty();
	createSelectLevel('sel_level_2', json_dict_3.list, $('#sel_level_1').val());
	
	$('#sel_level_3').empty();
	createSelectLevel2('sel_level_3', json_dict_3.list, $('#sel_level_2').val());
	
	onConditionLevel3();
}

function onConditionLevel2(){
	$('#sel_level_3').empty();
	createSelectLevel2('sel_level_3', json_dict_3.list, $('#sel_level_2').val());
	
	onConditionLevel3();
}

function onConditionLevel3(){
	var f = $('#sel_level_3 option:selected').attr('val');	
	$('#f_30').html(f);	
	cal_h('30');
	sum_h(initData);
}

function isFemale(){
	var v = $('#sel_11 option:selected').attr('code');
	return v == '1105';
}

function isMale(){
	var v = $('#sel_11 option:selected').attr('code');
	return v == '1101';
}

function cal_h(code){	
	var v = (isFemale() || isMale()) ? 16 : 17;
	
	var f = $('#f_' + code).html();
	var g = $('#g_' + code).html();
	var h = parseFloat(f) * parseFloat(g) * (0.45 / v / 5) * 100; 
	$('#h_' + code).html(h.toFixed(3));
}

function cal_g(code){
	var g = $('#g_' + code).html();
	
	if (code == '12' || code == '13'){		
		g = isMale() ? 0 : 0.75;		
	}
	else if (code == '05'){
		g = (isFemale() || isMale()) ? 1.75 : 2;
	}
	
	$('#g_' + code).html(g);
}

</script>

<header class="am-topbar am-topbar-inverse admin-header">
  <div class="am-topbar-brand">
    <strong>fesco</strong> <small>岗位外包项目风险评估工具</small>
  </div>

  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

  <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
      <li class="am-dropdown" data-am-dropdown>
        <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
          <span class="am-icon-users"></span> 系统管理 <span class="am-icon-caret-down"></span>
        </a>
        <ul class="am-dropdown-content">
          <li><a href="#"><span class="am-icon-user"></span> 帮助</a></li>
          <li><a href="/screening/home"><span class="am-icon-cog"></span> 设置</a></li>
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
			<select id="sel_04" style="width:100%; height:100%" onchange="javascript: onCondition(this, '04')">
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
			<select id="sel_05" style="width:100%; height:100%" onchange="javascript: onCondition(this, '05')">
			<c:forEach items="${dict.get('05')}" var="dict1">
                <option value="${dict1.desc}">${dict1.name}</option>
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
			<select id="sel_06" style="width:100%; height:100%" onchange="javascript: onCondition(this, '06')">
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
			<select id="sel_01" style="width:100%; height:100%;" onchange="javascript: onCondition(this, '01')">
			<c:forEach items="${dict.get('01')}" var="dict1">
                <option value="${dict1.val}" desc="${dict1.desc}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td colspan="2" bgcolor="#B7DEE8" style="width:23%; height: 90px">
			<div id="desc_01" style="width:100%;height:100%;overflow:auto"></div>
		</td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="f_01"></span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_01">1</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_01"></span>%</td>
	</tr>
	<tr>		
		<td bgcolor="#B7DEE8">外包业务地域范围</td>
		<td colspan="3">
			<select id="sel_07" style="width:100%; height:100%" onchange="javascript: onCondition(this, '07')">
			<c:forEach items="${dict.get('07')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
        </td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="f_07"></span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_07">0.75</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_07"></span>%</td>
	</tr>
	<tr>
		<td bgcolor="#B7DEE8">办公设施情况</td>
		<td colspan="3">
			<select id="sel_08" style="width:100%; height:100%" onchange="javascript: onCondition(this, '08')">
			<c:forEach items="${dict.get('08')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="f_08">0.75</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="g_08">0.75</span></td>
		<td style=" text-align:center" bgcolor="#D9D9D9"><span id="h_08"></span>%</td>
	</tr>
	
	<!--       -->
	<tr>
		<td style="text-align:center" rowspan="9" bgcolor="#FCD5B4">员工情况分析 </td>
		<td bgcolor="#FCD5B4">平均薪资水平</td>
		<td colspan="3">
			<select id="sel_09" style="width:100%; height:100%" onchange="javascript: onCondition(this, '09')">
			<c:forEach items="${dict.get('09')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_09">-</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_09">2</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_09">0.75</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">劳动合同平均年限</td>
		<td colspan="3">
			<select id="sel_10" style="width:100%; height:100%" onchange="javascript: onCondition(this, '10')">
			<c:forEach items="${dict.get('10')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_10">-</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_10">2</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_10">-</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">项目是否继承工龄</td>
		<td colspan="3">
			<select id="sel_19" style="width:100%; height:100%" onchange="javascript: onCondition(this, '19')">
				<option value="5">是</option>
				<option value="1">否</option>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_19">-</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_19">0.75</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_19">-</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">岗位分类</td>
		<td style="width:11%;">
			<select id="sel_level_1" style="width:100%; height:100%" onchange="javascript: onConditionLevel1()"></select>
		</td>
		<td style="width:12%;">
			<select id="sel_level_2" style="width:100%; height:100%" onchange="javascript: onConditionLevel2()"></select>
		</td>
		<td style="width:12%;">
			<select id="sel_level_3" style="width:100%; height:100%" onchange="javascript: onConditionLevel3()"></select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_30">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_30">1</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_30">0</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">项目员工男女比例</td>
		<td colspan="3">
			<select id="sel_11" style="width:100%; height:100%" onchange="javascript: onCondition(this, '11')">
			<c:forEach items="${dict.get('11')}" var="dict1">
                <option value="${dict1.val}" code="${dict1.code}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_11">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_11">0.75</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_11"></span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">女工平均年龄</td>
		<td colspan="3">
			<select id="sel_13" style="width:100%; height:100%" onchange="javascript: onCondition(this, '13')">
			<c:forEach items="${dict.get('13')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_13">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_13">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_13">0</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">男工平均年龄</td>
		<td colspan="3">
			<select id="sel_12" style="width:100%; height:100%" onchange="javascript: onCondition(this, '12')">
			<c:forEach items="${dict.get('12')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_12">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_12">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_12">0</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">平均工龄</td>
		<td colspan="3">
			<select id="sel_14" style="width:100%; height:100%" onchange="javascript: onCondition(this, '14')">
			<c:forEach items="${dict.get('14')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
        </td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_14">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_14">0.5</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_14">0</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#FCD5B4">平均受教育程度</td>
		<td colspan="3">
			<select id="sel_15" style="width:100%; height:100%" onchange="javascript: onCondition(this, '15')">
			<c:forEach items="${dict.get('15')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_15">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_15">0.3</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_15">0</span>%</td>
	</tr>
	
	<!--  -->
	<tr>
		<td style="text-align:center" rowspan="2" bgcolor="#B8CCE4">行业情况分析 </td>
		<td bgcolor="#B8CCE4">行业健康度</td>
		<td colspan="3">
			<select id="sel_16" style="width:100%; height:100%" onchange="javascript: onCondition(this, '16')">
			<c:forEach items="${dict.get('16')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_16">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_16">0.1</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_16">0</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#B8CCE4">行业出现时长</td>
		<td colspan="3">
			<select id="sel_17" style="width:100%; height:100%" onchange="javascript: onCondition(this, '17')">
			<c:forEach items="${dict.get('17')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="f_17">0</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="g_17">0.1</span></td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_17">0</span>%</td>
	</tr>
	
	<!--  -->
	<tr>
		<td style="text-align:center" rowspan="2" bgcolor="#C4BD97">项目分析 </td>
		<td bgcolor="#C4BD97">外包规模</td>
		<td colspan="5">
			<select id="sel_18" style="width:100%; height:100%" onchange="javascript: onCondition2(this, '18')">
			<c:forEach items="${dict.get('18')}" var="dict1">
                <option value="${dict1.val}">${dict1.name}</option>
            </c:forEach>
            </select>
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_18">0</span>%</td>
	</tr>
	<tr>
		<td bgcolor="#C4BD97">项目风险记录</td>
		<td colspan="3">
			<select id="sel_02" style="width:100%; height:100%" onchange="javascript: onCondition3()">
			<c:forEach items="${dict.get('02')}" var="dict1">
                <option value="${dict1.id}">${dict1.name}</option>
            </c:forEach>
            </select>
        </td>
		<td colspan="2">
			<select id="sel_03" style="width:100%; height:100%" onchange="javascript: onCondition3()">
			<c:forEach items="${dict.get('03')}" var="dict1">
                <option value="${dict1.id}">${dict1.name}</option>
            </c:forEach>
            </select>		
		</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_20">0</span>%</td>
	</tr>
	
	<tr>
		<td colspan="7" bgcolor="#E26B0A" style="text-align:center;">风险系数</td>
		<td style="text-align:center" bgcolor="#D9D9D9"><span id="h_99">0</span>%</td>
	</tr>
	<c:forEach items="${dict.dictRisk}" var="risk">
	<input type="hidden" id="risk_${risk.contractId}_${risk.riskId}" value="${risk.val}"/>	
	</c:forEach>
</table>

<script src="js/jquery.min.js"></script>
<script src="js/amazeui.min.js"></script>

<script type="text/javascript">
	var json_dict_3 = callAjax('dict3', {});
	createSelectLevel('sel_level_1', json_dict_3.list, 0);
	createSelectLevel('sel_level_2', json_dict_3.list, $('#sel_level_1').val());	
	createSelectLevel2('sel_level_3', json_dict_3.list, $('#sel_level_2').val());
	
	init(initData);
	   
</script>
</body>
</html>