<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/5/31
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人主页</title>
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
    <style>
        #contentContainer .col-md-4 {
            margin-bottom: 60px;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#changePasswordContent").hide();
            $("#changePasswordButton").click(function () {
                $("#changePasswordContent").slideToggle("slow");
            });
            $("#submitChanged").click(function () {
                var str=$("#submitForm").serializeObject();
                var jsonDate = JSON.stringify(str);
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/student/updateStudentInfo',
                    dataType: "json",
                    data: jsonDate,
                    contentType:'application/json',
                    success:function(data){
                        alert(data);
                    }
                })
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
<br>
<div class="container" id="contentContainer">
    <div class="row">
        <div class="col-md-4">
            <p class="h3">个人信息</p>
            <p>学号：${studentInfo.studentId}</p>
            <p>班级：${studentInfo.specialtyName}</p>
            <p>姓名：${studentInfo.name}</p>
            <form action="" id="submitForm">
                <c:if test="${studentInfo.gender=='0'}">
                    <p>性别：<label>
                        <input class="form-control" type="text" name="gender" value="男">
                    </label></p>
                </c:if>
                <c:if test="${!(studentInfo.gender=='0')}">
                    <p>性别：<label>
                        <input class="form-control" type="text" value="女">
                    </label></p>
                </c:if>
                <p>邮箱：<label>
                    <input class="form-control" type="text" id="email" name="email" value="${studentInfo.email}">
                </label></p>
                <p>号码：<label>
                    <input class="form-control" type="text" id="cellphone" name="cellphone" value="${studentInfo.cellphone}">
                </label></p>
                <hr>
                <button class="btn btn-primary" type="button" id="changePasswordButton">
                    修改密码
                </button>
                <div id="changePasswordContent">
                    <hr>
                    <p>旧密码：<label>
                        <input class="form-control" type="password" name="oldPassword" id="oldPassword">
                    </label></p>
                    <p>新密码：<label>
                        <input class="form-control" type="password" name="newPassword" id="newPassword">
                    </label></p>
                </div>
                <hr>
                <button class="btn btn-info" type="button" id="submitChanged">
                    提交修改
                </button>
            </form>
        </div>
        <div class="col-md-8" style="margin-bottom: 50px">
            <div class="tabbable" id="tabs-537556">
                <ul class="nav nav-tabs">
                    <li>
                        <a href="#panel-463107" data-toggle="tab">课程表</a>
                    </li>
                    <li class="active">
                        <a href="#panel-282388" data-toggle="tab">成绩表</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane" id="panel-463107">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>课程名称</th>
                                <th>开课时间</th>
                                <th>结课时间</th>
                                <th>学时</th>
                                <th>学分</th>
                            </tr>
                            </thead>
                            <c:if test="${!empty studentCourse}">
                                <c:forEach items="${studentCourse}" var="Info">
                                    <tr>
                                        <td>${Info.courseName}</td>
                                        <td>${Info.startTime}</td>
                                        <td>${Info.endTime}</td>
                                        <td>${Info.period}</td>
                                        <td>${Info.credit}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                    <div class="tab-pane active" id="panel-282388">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>课程名称</th>
                                <th>测试一</th>
                                <th>测试二</th>
                                <th>测试三</th>
                                <th>测试四</th>
                                <th>总分（折合后）</th>
                            </tr>
                            </thead>
                            <c:if test="${!empty studentGrade}">
                                <c:forEach items="${studentGrade}" var="Info">
                                    <tr>
                                        <td>${Info.courseName}</td>
                                        <td>${Info.grade1}</td>
                                        <td>${Info.grade2}</td>
                                        <td>${Info.grade3}</td>
                                        <td>${Info.grade4}</td>
                                        <td>${Info.total}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
