<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/5/31
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>
<head>
    <title>个人主页</title>
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <style>
        #contentContainer .col-md-4 {
            margin-bottom: 60px;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle !important;
        }
    </style>
    <script>
        //校验邮箱
        function validate_email() {
            var myreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
            var email = $("#email").val();
            if (!myreg.test(email)) {
                $.alert({
                    title: "",
                    content: "邮箱格式不正确：(",
                    backgroundDismiss: true
                });
                return false;
            } else {
                $("#spanEmailShow").slideToggle("slow");
                return true;
            }
        }

        //校验号码
        function validate_cellphone() {
            var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
            var cellphone = $("#cellphone").val();
            if (!myreg.test(cellphone)) {
                $.alert({
                    title: "",
                    content: "手机号格式不规范：(",
                    backgroundDismiss: true
                });
                return false;
            } else {
                $("#spanCellShow").slideToggle("slow");
                return true;
            }
        }

        //更新学生
        function updateStudent() {
            if (validate_email() && validate_cellphone()) {
                var str = $("#submitForm").serializeObject();
                var jsonDate = JSON.stringify(str);
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/student/update',
                    dataType: "json",
                    data: jsonDate,
                    contentType: 'application/json',
                    success: function (result) {
                        $.alert({
                            title: "",
                            content: result.msg,
                            backgroundDismiss: true
                        });
                        if (result.code == 0) {
                            location.reload();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $.confirm({
                            animation: 'rotateX',
                            closeAnimation: 'rotateX',
                            backgroundDismiss: true,
                            title: false,
                            content: "系统错误！",
                            buttons: {
                                confirm: {
                                    text: '确认',
                                    btnClass: 'waves-effect waves-button waves-light'
                                }
                            }
                        });
                    }
                })
            }
        }

        $(function () {
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                });
            }
            //在IE中必须得有这两行
            window.history.pushState('forward', null, '#');
            window.history.forward(1);

            //修改密码 按键
            $("#changePasswordContent").hide();
            $("#spanEmailShow").hide();
            $("#spanCellShow").hide();
            $("#changePasswordButton").click(function () {
                $("#changePasswordContent").slideToggle("slow");
            });
        });
    </script>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/sea.jpg);background-attachment: fixed">
<%@include file="/student/nav/nav.jsp" %>
<br>
<div class="container" id="contentContainer">
    <div class="row">
        <div class="col-md-4" style="background: #BCD2EE">
            <br>
            <p class="h3">&nbsp;&nbsp;个人信息</p>
            <p>&nbsp;&nbsp;学号：${studentInfo.studentId}</p>
            <p>&nbsp;&nbsp;专业：${studentInfo.specialtyName}</p>
            <p>&nbsp;&nbsp;姓名：${studentInfo.name}</p>
            <form action="" id="submitForm">
                <p>&nbsp;&nbsp;性别：
                    <label>
                        <select class="form-control" name="gender">
                            <option>${studentInfo.gender}</option>
                            <option>男</option>
                            <option>女</option>
                        </select>
                    </label>
                </p>
                <p>&nbsp;&nbsp;邮箱：
                    <label>
                        <input class="form-control" type="text" id="email"
                               name="email"
                               onchange="validate_email()"
                               value="${studentInfo.email}">
                    </label>
                    <span class="glyphicon glyphicon-ok" aria-hidden="true"
                          id="spanEmailShow"></span>
                </p>
                <p>&nbsp;&nbsp;号码：
                    <label>
                        <input class="form-control" type="text" id="cellphone"
                               name="cellphone"
                               onchange="validate_cellphone()"
                               value="${studentInfo.cellphone}">
                    </label>
                    <span class="glyphicon glyphicon-ok" aria-hidden="true"
                          id="spanCellShow"></span>
                </p>
                <hr>
                <button class="btn btn-primary" type="button"
                        id="changePasswordButton">
                    修改密码
                </button>
                <div id="changePasswordContent">
                    <hr>
                    <p>&nbsp;&nbsp;旧密码：<label>
                        <input class="form-control" type="password"
                               name="oldPassword" id="oldPassword">
                    </label></p>
                    <p>&nbsp;&nbsp;新密码：<label>
                        <input class="form-control" type="password"
                               name="password" id="password">
                    </label></p>
                </div>
                <hr>
                <button class="btn btn-info" type="button"
                        onclick="updateStudent()">
                    提交修改
                </button>
            </form>
            <br>
        </div>
        <div class="col-md-8" style="margin-bottom: 50px;background: #BCD2EE">
            <br>
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
                    <div class="tab-pane table-responsive" id="panel-463107">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>课程名称</th>
                                <th>开课时间</th>
                                <th>结课时间</th>
                                <th>学时</th>
                                <th>学分</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${!empty studentCourse}">
                                <c:forEach items="${studentCourse}" var="Info">
                                    <tr>
                                        <td>${Info.courseName}</td>
                                        <td><fmt:formatDate
                                                value="${Info.startTime}"
                                                pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate
                                                value="${Info.endTime}"
                                                pattern="yyyy-MM-dd"/></td>
                                        <td>${Info.period}</td>
                                        <td>${Info.credit}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                        <p style="color: #002a80">(学分请以教务处数据为准)</p>
                    </div>
                    <div class="tab-pane active table-responsive"
                         id="panel-282388">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>课程名称</th>
                                <th>测试一</th>
                                <th>测试二</th>
                                <th>测试三</th>
                                <th>测试四</th>
                                <th>总分</th>
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
            <br>
        </div>
    </div>
</div>
</body>
</html>
