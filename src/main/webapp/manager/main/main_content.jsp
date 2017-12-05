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
            $.confirm({
                title: "",
                content: "您确定要退出登录？",
                animation: 'right',
                closeAnimation: 'rotateX',
                type: 'red',
                backgroundDismiss: true,
                buttons: {
                    ok: {
                        text: "ok!",
                        theme: 'dark',
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action: function () {
                            location.href = '${pageContext.request.contextPath}/shiro/logout';
                        }
                    },
                    cancel: function () {
                    }
                }
            });
        }
    </script>
</head>
<body>
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
                <li><a href="javascript:void (0)">${currentManager.name}</a>
                </li>
                <li><a href="javascript:void(0);" onclick="logout();">注销</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<jsp:include page="/manager/${category}/${name}_content.jsp"></jsp:include>
</body>
</html>