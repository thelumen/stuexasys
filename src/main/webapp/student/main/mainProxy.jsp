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
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
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
        <div class="jumbotron" style="background: url(${pageContext.request.contextPath}/common/image/Image-4.jpg)">
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
                <a href="${pageContext.request.contextPath}/student/resources/download">前往</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
