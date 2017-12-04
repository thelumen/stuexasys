<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/24
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员后台</title>
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
    </script>
</head>
<body>

<div>
    <nav class="navbar navbar-fixed-top">
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
                   href="${pageContext.request.contextPath}/admin/main">管理员系统</a>
            </div>
            <div class="collapse navbar-collapse"
                 id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/teacher/main">教师管理</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/student/main">学生管理</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/school/main">专业&学科</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/file/main">试卷管理</a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" data-toggle="modal"
                           data-target="#">${currentManager.name}</a>
                    </li>
                    <li><a href="javascript:void(0);" onclick="logout();">注销</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<jsp:include page="/manager/${category}/${name}_content.jsp"></jsp:include>
</body>
</html>