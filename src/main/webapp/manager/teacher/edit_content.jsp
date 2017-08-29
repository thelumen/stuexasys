<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/29
  Time: 8:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ol class="breadcrumb">
    <li><a href="${pageContext.request.contextPath}/admin/main">权限管理</a>
    </li>
    <li><a href="${pageContext.request.contextPath}/admin/teacher/main">教师列表</a>
    </li>
    <li class="active">信息修改</li>
</ol>
<div class="container" style="width: 1200px">
    <form method="post"
          action="${pageContext.request.contextPath}/admin/teacher/edit"
          class="form-horizontal">
        <%--ID--%>
        <div class="form-group" style="display: none;">
            <label class="col-sm-2 control-label">id</label>
            <div class="col-sm-10">
                <input class="form-control" name="id" value="${teacherInfo.id}"
                       readonly/>
            </div>
        </div>
        <%--教工号--%>
        <div class="form-group" style="display: none;">
            <label class="col-sm-2 control-label">教工号</label>
            <div class="col-sm-10">
                <input class="form-control" name="teacherId"
                       value="${teacherInfo.teacherId}"
                       placeholder="your unique id" readonly/>
            </div>
        </div>
        <%--姓名--%>
        <div class="form-group" style="display: none;">
            <label class="col-sm-2 control-label">姓名</label>
            <div class="col-sm-10">
                <input class="form-control" name="name"
                       value="${teacherInfo.name}"
                       placeholder="your name"/>
            </div>
        </div>
        <%--密码--%>
        <div class="form-group" style="display: none;">
            <label class="col-sm-2 control-label">密码（已加密）</label>
            <div class="col-sm-10">
                <input class="form-control" name="name"
                       value="${teacherInfo.password}"
                       placeholder="password write here!"/>
            </div>
        </div>
        <%--性别--%>
        <div class="form-group" style="display: none;">
            <label class="col-sm-2 control-label">性别</label>
            <div class="col-sm-10">
                <select name="gender">
                    <option selected>男</option>
                    <option>女</option>
                </select>
            </div>
        </div>
            <%--职位--%>
            <div class="form-group" style="display: none;">
                <label class="col-sm-2 control-label">职位</label>
                <div class="col-sm-10">
                    <input class="form-control" name="position"
                           value="${teacherInfo.position}"
                           placeholder="position write here!"/>
                </div>
            </div>
        <input type="submit" value="确认修改" style="margin-right: 200px"
               class="btn btn-primary">
    </form>
</div>
<script>

</script>