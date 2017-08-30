<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/8/20
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    function logout() {
        swal({
                title: "您确定要退出登录？",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "登出",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            },
            function () {
                location.href = '${pageContext.request.contextPath}/shiro/logout';
            });
    }
</script>
<nav class="navbar-inverse navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navber-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">学生考试系统</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/student/main">学生考试系统</a><%--导航栏大标题--%>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"><%--导航栏左侧--%>
            <ul class="nav navbar-nav">
                <li><a href='${pageContext.request.contextPath}/student/personPage'>个人信息</a></li>
                <li><a href='${pageContext.request.contextPath}/student/exam'>测试</a></li>
                <li><a href='${pageContext.request.contextPath}/student/resourcesDownload'>资源下载</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <%--导航栏右侧 通过类选择器动态展示用户状态--%>
                <li class="dropdown">
                    <a class="dropdown-toggle" href="#" data-toggle="dropdown" id="navDropdown"><span
                            class="glyphicon glyphicon-user"></span> ${currentStudent.userName}<strong
                            class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li><a href='${pageContext.request.contextPath}/student/personPage'>个人信息</a></li>
                        <li><a href='${pageContext.request.contextPath}/student/exam'>测试</a></li>
                        <li><a href='${pageContext.request.contextPath}/student/resourcesDownload'>资源下载</a></li>
                        <li role='separator' class='divider'></li>
                        <li><a href="javascript:void(0);" onclick="logout();">登出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
