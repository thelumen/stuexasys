<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
    <link rel="stylesheet" href="/teacher/${category}/${name}.css">
    <script src="/teacher/${category}/${name}.js" charset="UTF-8"></script>
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
                                <a href="${pageContext.request.contextPath}/system/insertQues">选课</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="${pageContext.request.contextPath}/system/resource">修改资料</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle"
                           data-toggle="dropdown">学生管理<span
                                class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/system/userlist">学生信息</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#">附加题评分</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#">成绩统计</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <shiro:authenticated>
                        <li>用户[<shiro:principal/>]已身份验证通过</li>
                    </shiro:authenticated>>
                    <li><a href="javascript:void(0);" onclick="logout();">注销</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<jsp:include page="/teacher/${category}/${name}_content.jsp"></jsp:include>
</body>
</html>
