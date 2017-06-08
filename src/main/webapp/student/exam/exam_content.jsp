<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/5/31
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fum" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生测试</title>
    <jsp:include page="/common/inc/head.jsp"></jsp:include>

    <script>
        $(document).ready(function () {
            $(".ID").hide();
            $("button.btn-success").click(function () {
                var examInfo;
                var rows = this.value;
                var s = rows.split("_");
                examInfo = {"courseId": s[0], "content": s[1]};
                var jsonDate = JSON.stringify(examInfo);
                alert(jsonDate);
                $.ajax({
                    type: "post",
                    url: '${pageContext.request.contextPath}/student/startTest',
                    dataType: "json",
                    contentType: 'application/json',
                    data: jsonDate,
                    success: function (data) {
                        alert(data.msg);
                    }
                });
            })
        })
    </script>
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
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>课程名称</th>
                    <th>测试编号</th>
                    <th>测试章节</th>
                    <th>测试时间</th>
                    <th>考试信号</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty studentExamInfo}">
                    <c:forEach items="${studentExamInfo}" var="Info" varStatus="status">
                        <tr class="rowId">
                            <td>${Info.courseName}</td>
                            <td>${Info.testNum}</td>
                            <td>${Info.content}</td>
                            <td><fum:formatDate value="${Info.date}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:if test="${Info.test==1}">
                                    <button type="button" class="btn btn-success"
                                            value="${Info.courseId}_${Info.content}">
                                        <label>开始考试</label>
                                    </button>
                                </c:if>
                                <c:if test="${!(Info.test==1)}">
                                    <button type="button" class="btn btn-primary" disabled="disabled">
                                        <label>等待开始</label>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
