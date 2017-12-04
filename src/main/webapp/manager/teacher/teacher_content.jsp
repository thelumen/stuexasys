<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/22
  Time: 20:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/main">首页</a>
        </li>
        <li class="active">教师管理</li>
    </ol>
    <hr class="divider"/>
    <shiro:hasPermission name="shiro:sys:admin">
        <div id="admin_teacher_tool">
            <button type="button" class="btn btn-primary" onclick="insert()">
                添加教师
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
                data-unique-id="teacherId"
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
                <th data-formatter="operateTeacher" data-width="200">操作
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    var table = $('#manager_teacher_table');

    //新增教师
    function insert() {
        $.confirm({
            title: "新增教师",
            content: '<form id="teacher_insert_form">' +
            '<input class="form-control" name="teacherId" id="teacherId" placeholder="教工号"/>' +
            ' <input class="form-control" name="name" id="name" placeholder="姓名"/>' +
            '<input class="form-control" name="password" id="password" required placeholder="密码"/>' +
            '<br>性别：<select style="width: 100px" name="gender">' +
            '<option>男</option>' +
            '<option>女</option>' +
            '</select>' +
            '<br><br><input class="form-control" name="position" placeholder="职位"/>' +
            '<input class="form-control" name="office" placeholder="办公室"/>' +
            '</form>',
            animation: 'right',
            closeAnimation: 'rotateX',
            type: 'red',
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        var teacherId = $('#teacherId').val();
                        var name = $('#name').val();
                        var pwd = $('#password').val();
                        if (teacherId == '' || name == '' || pwd == '') {
                            $.alert({
                                title: "",
                                content: "不要忘记填写教工号，姓名和密码哦!",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (isNaN(teacherId) || Number(teacherId) < 100000 || Number(teacherId) > 999999) {
                            $.alert({
                                title: "",
                                content: "教工号是6位的数字：)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        var data = $('#teacher_insert_form').serializeArray();
                        $.ajax({
                            type: 'post',
                            url: '${pageContext.request.contextPath}/admin/teacher/insert',
                            dataType: 'json',
                            data: data,
                            success: function (result) {
                                if (result.code === 0) {
                                    table.bootstrapTable("refresh");
                                }
                                $.alert({
                                    title: "",
                                    content: result.msg,
                                    backgroundDismiss: true
                                });
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

    //编辑
    function edit(id) {
        var data = JSON.stringify(table.bootstrapTable("getRowByUniqueId", id));
        var array = JSON.parse(data);
        $.confirm({
            title: "修改教师",
            content: '<form id="teacher_mod_form">' +
            '<input class="form-control" name="id" placeholder="数据库流水号" readonly value="' + array.id + '"/>' +
            '<input class="form-control" name="teacherId" id="teacherId" readonly placeholder="教工号" value="' + array.teacherId + '"/>' +
            ' <input class="form-control" name="name" id="name" placeholder="姓名" value="' + array.name + '"/>' +
            '<input class="form-control" name="password" id="password" required placeholder="密码" value="' + array.password + '"/>' +
            '<br>性别：<select style="width: 100px" name="gender">' +
            '<option>' + array.gender + '</option>' +
            '<option>男</option>' +
            '<option>女</option>' +
            '</select>' +
            '<br><br><input class="form-control" name="position" placeholder="职位" value="' + array.position + '"/>' +
            '<input class="form-control" name="office" placeholder="办公室"value="' + array.office + '"/>' +
            '</form>',
            animation: 'right',
            closeAnimation: 'rotateX',
            backgroundDismiss: true,
            type: 'purple',
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        var teacherId = $('#teacherId').val();
                        var name = $('#name').val();
                        var pwd = $('#password').val();
                        if (teacherId == '' || name == '' || pwd == '') {
                            $.alert({
                                title: "",
                                content: "不要忘记填写教工号，姓名和密码哦!",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (isNaN(teacherId) || Number(teacherId) < 100000 || Number(teacherId) > 999999) {
                            $.alert({
                                title: "",
                                content: "教工号是6位的数字：)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        var finalData = $('#teacher_mod_form').serializeArray();
                        $.ajax({
                            type: 'post',
                            url: '${pageContext.request.contextPath}/admin/teacher/update',
                            dataType: 'json',
                            data: finalData,
                            success: function (result) {
                                if (result.code === 0) {
                                    table.bootstrapTable("refresh");
                                }
                                $.alert({
                                    title: "",
                                    content: result.msg,
                                    backgroundDismiss: true
                                });
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

    //删除
    function del(id) {
        $.confirm({
            title: "Warnning",
            content: '您确定要要删除这位老师的信息吗？相关联的课程和考试信息也将被删除！',
            animation: 'left',
            closeAnimation: 'rotateX',
            backgroundDismiss: true,
            type: 'red',
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/teacher/delete/' + id,
                            type: 'delete',
                            dataType: 'json',
                            success: function (result) {
                                if (result.code === 0) {
                                    table.bootstrapTable("refresh");
                                }
                                $.alert({
                                    title: "",
                                    content: result.msg,
                                    backgroundDismiss: true
                                });
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

    //操作
    function operateTeacher(value, row) {
        var html = [];
        html.push('<button class="btn btn-primary" onclick="edit(\'{0}\')">编辑</button>'.replace('{0}', row.teacherId));
        <shiro:hasPermission name="shiro:sys:admin">
        html.push('<button class="btn btn-danger" onclick="del(\'{0}\');">删除</button>'.replace('{0}', row.teacherId));
        </shiro:hasPermission>
        return html.join(" ");
    }
</script>