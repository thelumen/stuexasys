<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/22
  Time: 20:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/main">首页</a>
        </li>
        <li class="active">教师管理</li>
    </ol>
    <hr class="divider"/>
    <br><br>
    <shiro:hasPermission name="shiro:sys:admin">
        <div id="admin_teacher_tool">
            <button type="button" class="btn-primary" onclick="insert()">添加教师
            </button>
        </div>
    </shiro:hasPermission>
    <div class="table-responsive">
        <table
                id="manager_teacher_table"
                data-toolbar="#admin_teacher_tool"
                data-show-export="true"
                data-minimum-count-columns="2"
                data-show-pagination-switch="true"
                data-pagination="true"
                data-id-field="teacherId"
                data-toggle="table"
                data-method="post"
                data-show-footer="false"
                data-url="${pageContext.request.contextPath}/admin/teacher/list"
                data-side-pagination="server"
                data-show-refresh="true"
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
</div>
<script>
    //新增
    function insert() {
        location.href = '${pageContext.request.contextPath}/admin/teacher/insert';
    }

    //编辑
    function edit(id) {
        location.href = '${pageContext.request.contextPath}/admin/teacher/edit/' + id;
    }

    //删除
    function del(id) {
        swal({
                title: "您确定要要删除这位老师的信息吗？",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确认",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            },
            function () {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/teacher/delete/' + id,
                    type: 'delete',
                    dataType: 'json',
                    success: function (data) {
                        if (data) {
                            swal("Success", "该教师信息删除成功！", "success");
                            //location.reload();
                            $('#manager_teacher_table').bootstrapTable("refresh");
                        }
                        else {
                            swal("Error", "该教师信息删除失败...", "error");
                        }
                    },
                    error: function () {
                        swal("Error", "您没有权限！", "error");
                    }
                })
            });
    }

    //操作
    function operateTeacher(value, row) {
        var html = [];
        html.push('<button class="btn btn-primary" onclick="edit(\'{0}\')">编辑</button>'.replace('{0}', row.teacherId));
        <shiro:hasPermission name="shiro:sys:admin">
        html.push('<button class="btn btn-danger pull-right" onclick="del(\'{0}\');">删除</button>'.replace('{0}', row.teacherId));
        </shiro:hasPermission>
        return html.join("");
    }
</script>