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
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navber-header">
            <button type="button" class="navbar-toggle collapsed"
                    data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1"
                    aria-expanded="false">
                <span class="sr-only">学生考试系统</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand"
               href="${pageContext.request.contextPath}/student/main">学生考试系统</a>
        </div>
        <div class="collapse navbar-collapse"
             id="bs-example-navbar-collapse-1"><%--导航栏左侧--%>
            <ul class="nav navbar-nav">
                <li>
                    <a href='${pageContext.request.contextPath}/student/info'>个人信息</a>
                </li>
                <li>
                    <a href='${pageContext.request.contextPath}/student/exam'>测试</a>
                </li>
                <li>
                    <a href='${pageContext.request.contextPath}/student/resource'>资源下载</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="${pageContext.request.contextPath}/student/info">
                        <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;${currentStudent.name}
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0);" onclick="logout();">登出&nbsp;&nbsp;</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
