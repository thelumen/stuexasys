<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/22
  Time: 20:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ol class="breadcrumb">
    <li><a href="${pageContext.request.contextPath}/admin/main">首页</a>
    </li>
    <li class="active">查看教师</li>
</ol>
<hr class="divider"/>
<br><br>
<div class="table-responsive">
    <table
            data-toggle="table"
            data-method="post"
            data-show-export="true"
            data-url="${pageContext.request.contextPath}/admin/teacher/list"
            data-side-pagination="server"
            data-show-refresh="true"
            data-id-field="teacherId"
            data-pagination="true"
            data-show-columns="true"
    >
        <thead>
        <tr>
            <th data-field="teacherId" data-width="300"
                data-sortable="true">
                职工号
            </th>
            <th data-field="name" data-width="300">
                姓名
            </th>
            <th data-field="gender" data-width="250">性别
            </th>
            <th data-field="position" data-width="350">职位</th>
            <th data-field="office" data-width="500">教研室</th>
            <th data-field="logintime" data-width="200">登录时间</th>
            <th data-field="ip" data-width="200">登录Ip</th>
            <th data-formatter="operateTeacher" data-width="200">操作
            </th>
        </tr>
        </thead>
    </table>
</div>
<script>
    //编辑
    function edit(id) {
        alert(id);
    }
    //删除
    function del(id) {
        alert(id);
    }
    //操作
    function operateTeacher(value, row) {
        var html = [];
        html.push('<button class="btn btn-primary" onclick="edit(\'{0}\')">编辑</button>'.replace('{0}', row.teacherId));
        html.push('<button class="btn btn-danger pull-right" onclick="del(\'{0}\');">删除</button>'.replace('{0}', row.teacherId));
        return html.join("");
    }
</script>