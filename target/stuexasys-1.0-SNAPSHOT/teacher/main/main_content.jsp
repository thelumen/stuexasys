<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/25
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>权限管理</title>
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
    <script>
        function logout() {
            swal({
                    title: "您确定要退出登录？",
                    text: "",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "注销",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true
                },
                function () {
                    location.href = '${pageContext.request.contextPath}/shiro/logout';
                });
        }
        function updateInfo() {
            var password = $('[name="password"]').val();
            var name = $('[name="name"]').val();
            if (password !== '' && name !== '') {
                var formdata = $('#teacher_main_form').serializeObject();
                var data = JSON.stringify(formdata);
                $.ajax({
                    url: '${pageContext.request.contextPath}/teacher/updateInfo',
                    data: data,
                    contentType: 'application/json',
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data.isSuccess) {
                            $('#teacher_main_modal').modal("hide");
                            swal("year", "修改成功！请刷新本页：)", "success");
                        }
                    },
                    error: function () {
                        swal("oh..", "系统智商不在线，发生错误了...", "error");
                    }
                });
            } else {
                swal("oh..", "请填写姓名和密码 :)", "error");
            }
        }
    </script>
    <style>
        form input {
            border-width: 0;
            outline: none;
        }
    </style>
</head>
<body>
<div>
    <nav class="navbar navbar-fixed-top navbar-inverse ">
        <div class="container-fluid">
            <button type="button" class="navbar-toggle collapsed"
                    data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1"
                    aria-expanded="false" aria-haspopup="true">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-header">
                <a class="navbar-brand"
                   href="${pageContext.request.contextPath}/teacher/main">教师系统</a>
            </div>
            <div class="collapse navbar-collapse"
                 id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle"
                           data-toggle="dropdown">个人管理<span
                                class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/teacher/cource">课程管理</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="${pageContext.request.contextPath}/teacher/exam">发布考试信息</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle"
                           data-toggle="dropdown">考核管理<span
                                class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/teacher/another">附加题评分</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="${pageContext.request.contextPath}/teacher/student/grade">成绩统计</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle"
                           data-toggle="dropdown">其他<span
                                class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/teacher/question">题目录入</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="${pageContext.request.contextPath}/teacher/resource">上传资料</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" data-toggle="modal"
                           data-target="#teacher_main_modal">${currentTeacher.name}</a>
                    </li>
                    <li><a href="javascript:void(0);" onclick="logout();">注销</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<jsp:include page="/teacher/${category}/${name}_content.jsp"></jsp:include>
<%--个人信息完善--%>
<div id="teacher_main_modal" class="modal fade" tabindex="-1"
     role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="main_main_modal_about_h4">
                    个人信息</h4>
            </div>
            <div class="modal-body">
                <form id="teacher_main_form">
                    <label>教工号：<input name="teacherId" readonly type="text"
                                      value="${currentTeacher.teacherId}"></label>
                    <label>姓名：<input name="name" type="text"
                                     value="${currentTeacher.name}"></label>
                    <label>性别：<select name="gender">
                        <option>男</option>
                        <option>女</option>
                    </select></label>
                    <label>教研室：<input name="office" type="text"
                                      value="${currentTeacher.office}"></label>
                    <label>职称：<input name="position" type="text"
                                     value="${currentTeacher.position}"></label>
                    <label>密码：<input name="password" type="text"
                                     onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"
                                     value="${currentTeacher.password}"></label>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        onclick="updateInfo()">保存
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
