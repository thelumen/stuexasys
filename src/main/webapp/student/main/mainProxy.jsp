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
    <title>学生考试系统</title>
    <%@include file="/common/inc/head.jsp"%>
    <script>
        $(document).ready(function () {
        })
    </script>
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
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/bg-蓝色科技.png)">
<%@include file="/student/nav/nav.jsp"%>
<br>
<div class="container">
    <div class="row">
        <div class="jumbotron"
             style="background: url(${pageContext.request.contextPath}/common/image/bg-灰色科技.jpg) no-repeat">
            <h1>
                个人信息
            </h1>
            <p>
                个人基本信息，课程表、成绩表，可在此页面进行密码修改
            </p>
            <p>
                <a href="${pageContext.request.contextPath}/student/personPage">前往</a>
            </p>
        </div>
        <div class="jumbotron" style="background: url(${pageContext.request.contextPath}/common/image/bg-科技辐射.jpg)">
            <h1>
                测试
            </h1>
            <p>
                课堂测验入口
            </p>
            <p>
                <a href="${pageContext.request.contextPath}/student/exam">前往</a>
            </p>
        </div>
        <div class="jumbotron"
             style="background: url(${pageContext.request.contextPath}/common/image/bg-挂纸.jpg) no-repeat">
            <h1>
                资源下载
            </h1>
            <p>
                获取老师上传的学习资源或者作业等
            </p>
            <p>
                <a href="${pageContext.request.contextPath}/student/resourcesDownload">前往</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
