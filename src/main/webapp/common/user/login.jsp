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
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="row">
            <div class="col-md-6">
            </div>
            <div class="col-md-6">
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
                                      value="管理员"/>管理员</label>
                        <label><input name="type" type="radio"
                                      value="教师" checked/>教师</label>
                        <label><input name="type" type="radio"
                                      value="学生"/>学生</label>
                    </div>
                    <div class="form-group">
                        <div class="main-checkbox">
                            <label> <input type="checkbox"
                                           value="None"/></label>
                        </div>
                        <span class="text">Remember me</span>
                        <button type="submit"
                                class="btn btn-default">登录
                        </button>
                    </div>
                    <hr class="divider">
                    <div class="form-group">
                        <label class="pull-right"
                               style="color: #00b4ef">忘记密码</label>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>