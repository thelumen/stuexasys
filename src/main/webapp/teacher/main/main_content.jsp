<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script>
        //退出
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

        //个人信息展示和更改
        function updateTeacher() {
            $.confirm({
                title: "Personal Information",
                content: '<form id="me_form">\n' +
                '    教工号：\n' +
                '    <input name="teacherId" readonly type="text"\n' +
                '           value="${currentTeacher.teacherId}">\n' +
                '    <br>\n' +
                '    姓名：\n' +
                '    <input name="name" type="text"\n' +
                '           value="${currentTeacher.name}">\n' +
                '    <br>\n' +
                '    性别：\n' +
                '    <select name="gender">\n' +
                '        <option>${currentTeacher.gender}</option>\n' +
                '        <option>男</option>\n' +
                '        <option>女</option>\n' +
                '    </select>\n' +
                '    <br>\n' +
                '    教研室：\n' +
                '    <input name="office" type="text"\n' +
                '           value="${currentTeacher.office}">\n' +
                '    <br>\n' +
                '    职称：\n' +
                '    <input name="position" type="text"\n' +
                '           value="${currentTeacher.position}">\n' +
                '    <br>\n' +
                '    密码：\n' +
                '    <input name="password" type="text"\n' +
                '           onkeyup="value=value.replace(/[^\\w\\.\\/]/ig,\'\')"\n' +
                '           value="******">\n' +
                '</form>',
                animation: 'left',
                closeAnimation: 'rotateX',
                type: 'purple',
                backgroundDismiss: true,
                buttons: {
                    ok: {
                        text: "ok!",
                        theme: 'dark',
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action: function () {
                            var gender = $('[name="gender"]').val();
                            var password = $('[name="password"]').val();
                            var name = $('[name="name"]').val();
                            var formdata = $('#me_form').serializeObject();
                            $.ajax({
                                url: '${pageContext.request.contextPath}/teacher/update',
                                data: JSON.stringify(formdata),
                                contentType: 'application/json',
                                type: 'post',
                                dataType: 'json',
                                beforeSend: function () {
                                    if (password == '' || name == '') {
                                        $.alert({
                                            title: "",
                                            content: "不要忘记填写姓名和密码哟~",
                                            backgroundDismiss: true
                                        });
                                        return false;
                                    }
                                },
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
                                        backgroundDismiss: true,
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        content: "系统错误!",
                                        buttons: {
                                            confirm: {
                                                text: '确认',
                                                btnClass: 'waves-effect waves-button waves-light'
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    },
                    cancel: function () {
                    }
                }
            });
        }
    </script>
    <style>
        form input {
            border-width: 0;
            outline: none;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse"
                data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
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
                            <a href="${pageContext.request.contextPath}/course/main">课程管理</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/exam/main">发布考试信息</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                       data-toggle="dropdown">考核管理<span
                            class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/grade/another/main">附加题评分</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/grade/main">成绩统计</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                       data-toggle="dropdown">资源管理<span
                            class="caret"></span></a>
                    <ul class="dropdown-menu multi-level" role="menu"
                        aria-labelledby="dropdownMenu">
                        <li>
                            <a href="${pageContext.request.contextPath}/resource/main">上传资料</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                       data-toggle="dropdown">题目管理<span
                            class="caret"></span></a>
                    <ul class="dropdown-menu multi-level" role="menu"
                        aria-labelledby="dropdownMenu">
                        <li>
                            <a href="${pageContext.request.contextPath}/question/main">题目录入</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/question/showSingle">选择题管理</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/question/showTf">判断题管理</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/question/editQuestion">附加题管理</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"
                       onclick="updateTeacher()">${currentTeacher.name}</a>
                </li>
                <li><a href="javascript:void(0);" onclick="logout();">注销</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<jsp:include page="/teacher/${category}/${name}_content.jsp"></jsp:include>
</body>
</html>
