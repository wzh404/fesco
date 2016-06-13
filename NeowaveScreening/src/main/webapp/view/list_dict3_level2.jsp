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
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">三级字典</strong> /
                <small>岗位分类</small>
            </div>
        </div>        

        <br/>
        <div class="am-g">
            <div class="am-u-sm-12 am-u-md-6">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                        <button type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span>
                            <a href="javascript:remove();">删除</a>
                        </button>
                        <button type="button"  class="am-btn am-btn-default">
                            <span class="am-icon-plus"><a href="javascript:add(0, '0000', '');">添加</a></span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="am-g">
            <div class="am-u-sm-12">
                <table class="am-table   table-main">
                    <thead>
                    <tr>
                        <th class="table-title">二级分类   </th>
                        <th class="table-type">三级分类</th>
                        <th class="table-type">风险系数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${dict3List}" var="dict3">
                    <c:if test="${dict3.ppid == 0 }">
                        <tr>
                            <td rowspan="${listMap[dict3.id.intValue()].size()}" style="text-align:center;vertical-align:middle" bgcolor="#eeeeee">
                            	<a href="javascript:add('${dict3.id }', ${dict3.pid }, '${dict3.name}', '${dict3.val}');"><span>${dict3.name}</span></a>
                            </td>
                            <td><a href="javascript:add(${listMap[dict3.id.intValue()].get(0).id }, ${listMap[dict3.id.intValue()].get(0).pid }, '${listMap[dict3.id.intValue()].get(0).name}', '${listMap[dict3.id.intValue()].get(0).val}');">
                            	${listMap[dict3.id.intValue()].get(0).name}
                            	</a>	
                            </td>
                            <td>${listMap[dict3.id.intValue()].get(0).val}</td>                         
                        </tr>
                        
                        <c:forEach items="${listMap[dict3.id.intValue()]}" var="dict" varStatus="loop">
                        <c:if test="${loop.index != 0}">
                        	<tr>
                        		<td><a href="javascript:add(${dict.id }, ${dict.pid }, '${dict.name}', '${dict.val}');">${dict.name}</a></td>
                        		<td>${dict.val}</td>
                        	</tr>
                        </c:if>	
                        	
                        </c:forEach>
                        
                    </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">盈达资产</div>
        <div class="am-modal-bd">
            确定要删除选择的记录吗？
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>确定</span>
        </div>
    </div>
</div>

<div class="am-modal am-modal-confirm" tabindex="-1" id="dic-modal-add">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><span id="modal_add_title">${dictName}</span>
        </div>
        <form id="save_update_dict_form" method="post" action="/screening/dict3/update"/>
        <div class="am-modal-bd">
		            名称：<input type="text" id="dict_3_name" name="dict_3_name" value=""/><span style="color:red">*</span> &nbsp;&nbsp;
		            风险系数：<input type="text" id="dict_3_val" name="dict_3_val" value=""/><span style="color:red">*</span>
		        <input type="hidden" id="dict_3_id" name="dict_3_id" value=""/>
		        <input type="hidden" id="dict_3_pid" name="dict_3_pid" value=""/>
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

    function remove(){
//        alert($("#form1 input[name='dict_code']").val());
//        alert($("input[name='dict_ids']:checked").length);
        if ($("input[name='dict_ids']:checked").length > 0){
            $('#my-confirm').modal({
                relatedTarget: this,
                onConfirm: function(options) {
                    $('#form1').submit();
                },
                onCancel: function() {
//                    alert('算求，不弄了');
                }
            });
        }
    }

    function add(dict_3_id, dict_3_pid, dict_3_name, dict_3_val){
        $('#dict_3_id').val(dict_3_id);
        $('#dict_3_pid').val(dict_3_pid);
        $('#dict_3_name').val(dict_3_name);
        $('#dict_3_val').val(dict_3_val);

//        $('#dic-modal-add').find('[data-am-modal-confirm]').off('click.close.modal.amui');
        var $promt = $('#dic-modal-add').modal({
            relatedTarget: this,
            onConfirm: function(options) {
                if (trim($('#dict_3_name').val()) == '' || trim($('#dict_3_val').val()) == '' ){
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
