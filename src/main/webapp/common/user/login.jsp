<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/22
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <jsp:include
            page="/common/inc/head.jsp"></jsp:include>
    <script>
        $(function () {
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                });
            }
            window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
            window.history.forward(1);
        })
    </script>
    <style>
        img {
            border-radius: 20px;
        }
    </style>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/sea.jpg) fixed;">
<c:if test="${!empty exception}">
    <script>
        $.alert({
            title: "登入失败",
            content:
            '可能原因：<br>' +
            '1.账号信息错误；<br>' +
            '2.身份类型错误（管理员 or 教师 or 学生）;<br>' +
            '3.不存在该账号',
            backgroundDismiss: true,
            type: "red"
        });
    </script>
</c:if>
<div class="container">
    <div class="row">
        <div class="col-md-7">
            <div style="vertical-align: middle">
                <br><br>
                <img src="${pageContext.request.contextPath}/common/image/bg-t.jpg"
                     class="img-responsive center-block">
            </div>
        </div>
        <div class="col-md-5">
            <form method="post"
                  action="${pageContext.request.contextPath}/shiro/login"
                  class="form-horizontal">
                <hr class="divider"/>
                <h1>用户登录
                    <small>All is well.</small>
                </h1>
                <br>
                <div class="form-group">
                    <input type="text" class="form-control"
                           maxlength="9" minlength="6"
                           name="account" required
                           placeholder="请填写您的账号">
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control"
                           minlength="3" maxlength="18"
                           name="password" required
                           placeholder="请填写您的密码">
                </div>
                <div class="form-group">
                    <label><input name="type" type="radio"
                                  value="2"/>管理员</label>
                    <label><input name="type" type="radio"
                                  value="1"/>教师</label>
                    <label><input name="type" type="radio"
                                  value="0" checked/>学生</label>
                </div>
                <div class="form-group">
                    <button type="submit"
                            class="btn btn-default">登录
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>