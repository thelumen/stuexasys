<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/8/24
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/main">首页</a>
        </li>
        <li class="active">学生管理</li>
    </ol>
    <div id="toolbar">
        <label>
            <select multiple="multiple" id="specialty" style="width: 400px">
            </select>
        </label>
        &nbsp;
        <input placeholder="学号" id="studentId">
        <button class="btn btn-primary" type="button"
                onclick="selectStudent()">
            查找
        </button>
        &nbsp;
        <shiro:hasPermission name="shiro:sys:admin">
            <button class="btn btn-success" type="button"
                    href="#modal-container-uploadStudent"
                    data-toggle="modal">上传学生
            </button>
        </shiro:hasPermission>
    </div>
    <table id="studentTable">
    </table>
    <%--学生信息上传模态框--%>
    <div class="modal fade" id="modal-container-uploadStudent"
         aria-hidden="true" aria-labelledby="myModalLabel">
        <form enctype="multipart/form-data" id="uploadForm" method="post">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" aria-hidden="true" type="button"
                                data-dismiss="modal">×
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            上传学生信息
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <br>
                                <label>&nbsp;&nbsp;请选择需要上传的<strong
                                        style="color: #985f0d">学生信息表</strong>：</label>
                                <div class="form-group">
                                    <br>
                                    <label>
                                        <input id="studentExcelFile" multiple
                                               type="file" class="file-loading"
                                               name="files">
                                    </label>
                                </div>
                                <br>
                                <a href="${pageContext.request.contextPath}/common/example/上传学生表样表.xls"
                                   class="form-control" style="border:none;">下载上传模板</a>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" type="button"
                                data-dismiss="modal">关闭
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    var table = $('#studentTable');
    var specialty_select = $('#specialty');
    var studentId_input = $('#studentId');

    //预加载
    $(function () {
        specialty_select.select2({
            maximumSelectionLength: 3
        });

        $.ajax({
            url: '${pageContext.request.contextPath}/specialty/all',
            dataType: 'json',
            success: function (data) {
                specialty_select.select2({
                    placeholder: "专业",
                    allowClear: true,
                    data: data,
                    maximumSelectionLength: 3
                });
                window._data = data;
            }
        });

        //table初始化
        table.bootstrapTable({
            method: "post",
            url: "${pageContext.request.contextPath}/admin/student/default/list",
            sidePagination: "server",
            idField: "studentId",
            toolbar: '#toolbar',
            showRefresh: "true",
            pagination: "true",
            showColumns: "true",
            showExport: "true",
            columns: [{
                field: 'studentId',
                title: '学号',
                sortable: true
            }, {
                field: 'name',
                title: '姓名',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '姓名不能为空';
                        }
                    }
                }
            }, {
                field: 'gender',
                title: '性别',
                editable: {
                    type: 'select',
                    source: [{value: '男', text: "男"}, {value: '女', text: "女"}],
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '不能为空';
                        }
                    }
                }
            }, {
                field: 'specialtyId',
                title: '专业',
                editable: {
                    type: 'select',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    source: function () {
                        var result = [];
                        $.each(window._data, function (key, value) {
                            result.push({value: value.id, text: value.text});
                        });
                        return result;
                    },
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '专业不能为空';
                        }
                    }
                }
            }, {
                field: 'cellphone',
                title: '电话',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
                        var cellphone = $.trim(value);
                        if (!myreg.test(cellphone)) {
                            return '请输入有效的手机号码！';
                        }
                    }
                }
            }, {
                field: 'email',
                title: '邮箱',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        var myreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
                        var email = $.trim(value);
                        if (!myreg.test(email)) {
                            return '请输入有效的E_mail！';
                        }
                    }
                }
            }, {
                field: 'password',
                title: '修改密码',
                formatter: function (value, row, index) {
                    return '修改密码';
                },
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '密码不能为空';
                        }
                    }
                }
            }, {
                field: 'edit',
                title: '编辑',
                formatter: initEditBtn(),
                events: 'editBtnEvent'
            }]
        });

        //文件上传
        $("#studentExcelFile").fileinput({
            language: 'zh',
            maxFileSize: 5000,
            uploadUrl: '${pageContext.request.contextPath}/admin/student/upload',
            showUpload: true,
            showRemove: true,
            uploadAsync: true,
            showPreview: false,
            showCancel: false,
            dropZoneEnabled: false,
            enctype: 'multipart/form-data',
            allowedFileExtensions: ['xls']
        }).on("fileuploaded", function (event, data, previewId, index) {
            var result = data.response;
            $.alert({
                title: "",
                content: result.msg,
                backgroundDismiss: true
            });
            if (result.code == 0) {
                table.bootstrapTable("refresh")
            }
        });
    });

    //查询学生
    function selectStudent() {
        var specialty = specialty_select.val();
        var studentId = studentId_input.val();
        //全不选，就显示预留学生
        if (specialty == null && studentId == '') {
            table.bootstrapTable("refresh", {
                url: "${pageContext.request.contextPath}/admin/student/default/list"
            });
            return false;
        }
        if (specialty == null) {
            specialty = null;
        }
        if (studentId != '') {
            if (isNaN(studentId) || studentId.length != 9) {
                $.alert({
                    title: "",
                    content: "学号为长度9的数字：)",
                    backgroundDismiss: true
                });
                return false;
            }
        } else {
            studentId = null;
        }
        table.bootstrapTable("refresh", {
            url: "${pageContext.request.contextPath}/admin/student/list/" + specialty + "/" + studentId
        });
    }

    //表格内的按钮初始化
    function initEditBtn() {
        var html = [];
        html.push('<button class="btn btn-primary updateStudent" type="button">保存</button>');
        <shiro:hasPermission name="shiro:sys:admin">
        html.push('<button class="btn btn-danger deleteStudent" type="button">删除</button>');
        </shiro:hasPermission>
        return html.join('');
    }

    //点击事件处理
    window.editBtnEvent = {
        'click .updateStudent': function (e, value, row, index) {
            $.confirm({
                title: "Warnning!",
                content: "您确定要更新该学生信息吗？",
                animation: 'right',
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
                            $.ajax({
                                type: 'post',
                                url: '${pageContext.request.contextPath}/admin/student/update',
                                dataType: "json",
                                data: JSON.stringify(row),
                                contentType: 'application/json',
                                success: function (result) {
                                    $.alert({
                                        title: "",
                                        content: result.msg,
                                        backgroundDismiss: true
                                    });
                                    if (result.code == 0) {
                                        table.bootstrapTable("refresh")
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.confirm({
                                        animation: 'rotateX',
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        backgroundDismiss: true,
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
        },
        'click .deleteStudent': function (e, value, row, index) {
            $.confirm({
                title: "Warnning!",
                content: "您确定要删除该学生吗？",
                animation: 'left',
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
                            $.ajax({
                                type: 'delete',
                                url: '${pageContext.request.contextPath}/admin/student/delete',
                                dataType: "json",
                                data: JSON.stringify(row),
                                contentType: 'application/json',
                                success: function (result) {
                                    $.alert({
                                        title: "",
                                        content: result.msg,
                                        backgroundDismiss: true
                                    });
                                    if (result.code == 0) {
                                        table.bootstrapTable("refresh")
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.confirm({
                                        animation: 'rotateX',
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        backgroundDismiss: true,
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
    }
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>