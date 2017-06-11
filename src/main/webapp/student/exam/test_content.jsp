<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/6/11
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试</title>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
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
            <ul class="nav navbar-nav navbar-right">
                <%--导航栏右侧 通过类选择器动态展示用户状态--%>
                <li class="dropdown">
                    <a class="dropdown-toggle" href="#" data-toggle="dropdown"
                       id="navDropdown">${studentInfo.name}<strong class="caret"></strong></a>
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
<hr>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>一，选择题（共20题）</h2>
            <c:forEach items="${testPaper.singleTakenList}" var="testPaperSingle" varStatus="statusSingle">
                <p style="word-break: break-all">${statusSingle}.${testPaperSingle.name}</p>
                <p><label>A.<input type="radio" name="single-${statusSingle}">${testPaperSingle.que1}</label></p>
                <p><label>B.<input type="radio" name="single-${statusSingle}">${testPaperSingle.que1}</label></p>
                <p><label>C.<input type="radio" name="single-${statusSingle}">${testPaperSingle.que1}</label></p>
                <p><label>D.<input type="radio" name="single-${statusSingle}">${testPaperSingle.que1}</label></p>
            </c:forEach>
            <h2>二，判断题（共5题）</h2>
            <c:forEach items="${testPaper.tfTakenList}" var="testPaperTf" varStatus="statusTf">
                <p style="word-break: break-all">${statusTf}.${testPaperTf.name}</p>
                <p><label><input type="radio" name="tf-${statusTf}">正确</label></p>
                <p><label><input type="radio" name="tf-${statusTf}">错误</label></p>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>
