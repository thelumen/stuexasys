<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/29
  Time: 8:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/main">权限管理</a>
        </li>
        <li><a href="${pageContext.request.contextPath}/admin/teacher/main">教师列表</a>
        </li>
        <li class="active">新增/修改</li>
    </ol>
    <div>
        <form method="post"
              action="${pageContext.request.contextPath}/admin/teacher/${action}"
              class="form-horizontal">
            <%--ID--%>
            <div class="form-group" style="display: none">
                <label class="col-sm-2 control-label">id</label>
                <div class="col-sm-6">
                    <input class="form-control" name="id"
                           value="${teacherInfo.id}" style="width: 500px"
                           readonly/>
                </div>
            </div>
            <%--教工号--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">教工号</label>
                <div class="col-sm-10">
                    <input class="form-control" name="teacherId" maxlength="6"
                           minlength="6" required
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                           value="${teacherInfo.teacherId}" style="width: 500px"
                           placeholder="your unique id"/>
                </div>
            </div>
            <%--姓名--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10">
                    <input class="form-control" name="name"
                           value="${teacherInfo.name}" style="width: 500px"
                           placeholder="your name"/>
                </div>
            </div>
            <%--密码--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码（已加密）</label>
                <div class="col-sm-10">
                    <input class="form-control" name="password" required
                           minlength="3"
                           value="${teacherInfo.password}" style="width: 500px"
                           placeholder="password write here!"/>
                </div>
            </div>
            <%--性别--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别</label>
                <div class="col-sm-10">
                    <select id="admin_teacher_edit_select" style="width: 100px"
                            name="gender">
                        <option selected>男</option>
                        <option>女</option>
                    </select>
                </div>
            </div>
            <%--职位--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">职位</label>
                <div class="col-sm-10">
                    <input class="form-control" name="position"
                           value="${teacherInfo.position}" style="width: 500px"
                           placeholder="position write here!"/>
                </div>
            </div>
            <%--教研室--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">教研室</label>
                <div class="col-sm-10">
                    <input class="form-control" name="office"
                           value="${teacherInfo.office}" style="width: 500px"
                           placeholder="office write here!"/>
                </div>
            </div>
            <input type="submit" value="提交" style="margin-right: 400px"
                   class="btn btn-primary">
        </form>
    </div>
</div>
<script>
    $('#admin_teacher_edit_select').select2();
</script>