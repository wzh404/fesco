<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>

<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
	<div class="am-offcanvas-bar admin-offcanvas-bar">
		<ul class="am-list admin-sidebar-list">
			<li><a href="#"><span class="am-icon-home"></span>
					首页</a></li>

			<li class="admin-parent"><a class="am-cf"
				data-am-collapse="{target: '#collapse-nav'}"> <span
					class="am-icon-file"></span> 数据字典 <span
					class="am-icon-angle-right am-fr am-margin-right"></span>
			</a>
				<ul class="am-list am-collapse admin-sidebar-sub am-in"
					id="collapse-nav">
					<li><a href="/screening/dict1/list/01"><span
							class="am-icon-check"></span> 行业分类</a></li>
					<li><a href="/screening/dict1/list/04"><span
							class="am-icon-check"></span> 客户业务运营情况</a></li>
					<li><a href="/screening/dict1/list/05"><span
							class="am-icon-check"></span> 业务存续时长</a></li>
					<li><a href="/screening/dict1/list/06"><span
							class="am-icon-check"></span> 客户管理参与度</a></li>
					<li><a href="/screening/dict1/list/07"><span
							class="am-icon-check"></span> 外包业务地域范围</a></li>
					<li><a href="/screening/dict1/list/08"><span
							class="am-icon-check"></span> 办公设施情况</a></li>
					<li><a href="/screening/dict1/list/09"><span
							class="am-icon-check"></span> 平均薪资水平</a></li>
					<li><a href="/screening/dict1/list/10"><span
							class="am-icon-check"></span> 劳动合同平均年限</a></li>
					<li><a href="/screening/dict1/list/11"><span
							class="am-icon-check"></span> 男女员工比例</a></li>
					<li><a href="/screening/dict1/list/12"><span
							class="am-icon-check"></span> 年龄评估男</a></li>
					<li><a href="/screening/dict1/list/13"><span
							class="am-icon-check"></span> 年龄评估女</a></li>
					<li><a href="/screening/dict1/list/14"><span
							class="am-icon-check"></span> 平均工龄</a></li>
					<li><a href="/screening/dict1/list/15"><span
							class="am-icon-check"></span> 受教育程度</a></li>
					<li><a href="/screening/dict1/list/16"><span
							class="am-icon-check"></span> 行业健康度</a></li>
					<li><a href="/screening/dict1/list/17"><span
							class="am-icon-check"></span> 行业出现时间</a></li>
					<li><a href="/screening/dict1/list/18"><span
							class="am-icon-check"></span> 外包规模</a></li>
				</ul></li>
			<li><a href="/screening/dict3"><span class="am-icon-bookmark"></span> 岗位分类</a></li>
			<li><a href="/admin/listUser"><span class="am-icon-bookmark"></span> 项目风险记录</a></li>
		</ul>

		<div class="am-panel am-panel-default admin-sidebar-panel">
			<div class="am-panel-bd">
				<p>
					<span class="am-icon-bookmark"></span> 公告
				</p>

				<p>时光静好，与君语；细水流年，与君同。—— Amaze UI</p>
			</div>
		</div>
	</div>
</div>