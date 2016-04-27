<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>岗位外包项目风险评估工具 - 后台管理</title>
    <meta name="description" content="系统管理后台">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <link rel="stylesheet" href="/screening/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/screening/css/admin.css">
</head>

<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
    以获得更好的体验！</p>
<![endif]-->

<jsp:include page="header.jsp"/>

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <jsp:include page="sidebar.jsp"/>
    <!-- sidebar end -->

    <!-- content start -->
    <form class="admin-content" id="form1" method="post" action="/admin/removeDict1">
        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">一级字典</strong> /
                <small>${dictName}</small>
            </div>
        </div>        

        <br/>
        <div class="am-g">
            <div class="am-u-sm-12">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                    	<th>风险系数表</th>
                    <c:forEach items="${contractList}" var="contract">
                        <th>${contract.name}</th>
                    </c:forEach>
                    </tr>
                    </thead>
                    
                    <tbody>
                    <c:forEach items="${riskList}" var="risk">
                        <tr>
                        	<td>${risk.name}</td>
                        <c:forEach items="${contractList}" var="contract">
	                        <c:forEach items="${dictRisk}" var="dict">
	                        	<c:if test="${dict.riskId.intValue() == contract.id.intValue() && dict.contractId.intValue() == risk.id.intValue()}">
	                            	<td><a href="javascript:add(${contract.id}, '${contract.name}', ${risk.id}, '${risk.name}', ${dict.val});">${dict.val}</a></td>
	                            </c:if>
	                        </c:forEach>
                        </c:forEach>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</div>
<!-- content end -->

<div class="am-modal am-modal-confirm" tabindex="-1" id="dic-modal-add">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><span id="modal_add_title">${dictName}</span>
        </div>
        <form id="save_update_dict_form" method="post" action="/screening/dict1/update3"/>
        <div class="am-modal-bd">
	        <table>
	        	<tr><td style="text-align: right;width:50%">赔付情况：</td>
	        		<td style="text-align: left;"><span id="risk_name"></span></td>
	        	</tr>
			    <tr>
			      	<td style="text-align: right">合同期限：</td>
			      	<td style="text-align: left;"><span id="contract_name"></span></td> 
			    </tr>
			    <tr>     
			      	<td style="text-align: right">风险系数：</td>
			      	<td><input type="text" id="dict_val" name="dict_val" value=""/><span style="color:red">%</span></td>
			    </tr>
			 </table>
		        <input type="hidden" id="contract_id" name="contract_id" value=""/>
		        <input type="hidden" id="risk_id" name="risk_id" value=""/>
        </div>
        </form>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>确定</span>
        </div>
    </div>
</div>

</div>

<jsp:include page="footer.jsp"/>

<script type="text/javascript">
	function trim(_s) { return _s.replace(/^\s+|\s+$/, ""); }

    function add(contract_id, contract_name, risk_id, risk_name, dict_val){
        //$('#modal_add_title').html(title);
       // $('#dict_id').val(dict_id);
        $('#contract_id').val(contract_id);
        $('#contract_name').html(contract_name);
        $('#risk_id').val(risk_id);
        $('#risk_name').html(risk_name);
        $('#dict_val').val(dict_val);

//        $('#dic-modal-add').find('[data-am-modal-confirm]').off('click.close.modal.amui');
        var $promt = $('#dic-modal-add').modal({
            relatedTarget: this,
            onConfirm: function(options) {
                if (trim($('#dict_val').val()) == ''){
                    return;
                }
                $('#save_update_dict_form').submit();
            },
            onCancel: function() {
//                alert('算求，不弄了');
            }
        });

        $promt.find('[data-am-modal-confirm]').off('click.close.modal.amui');
    }


</script>
</body>
</html>
