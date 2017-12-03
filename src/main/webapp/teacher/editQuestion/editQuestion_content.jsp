<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/9/5
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">附加题管理</li>
    </ol>
    <div id="editQ_toolbar">
        <label>
            <select id="course" style="width: 200px"></select>
        </label>
        <button class="btn btn-primary" type="button" onclick="checkAnother()">
            查找
        </button>
    </div>
    <div>
        <table id="table">
        </table>
    </div>
</div>
<script>

    var course = $('#course');
    var table = $('#table');

    //查询附加题
    function checkAnother() {
        var courseId = course.val();
        if (courseId == '') {
            $.alert({
                title: "",
                content: "请选择课程：)",
                backgroundDismiss: true
            });
            return false;
        }
        table.bootstrapTable("refresh", {
            url: '${pageContext.request.contextPath}/question/another/list/' + courseId,
            silent: true
        });
    }

    //预加载
    $(function () {
        course.select2();
        //初始化下拉框
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                course.select2({
                    placeholder: "请选择课程：)",
                    data: data
                });
            }
        });

        //表格初始化
        table.bootstrapTable({
            method: "post",
            sidePagination: "server",
            idField: "questionId",
            showRefresh: "true",
            toolbar: "#editQ_toolbar",
            pagination: "true",
            showColumns: "true",
            showExport: "true",
            columns: [{
                field: 'courseName',
                title: '课程名称'
            }, {
                field: 'content',
                title: '题目',
                editable: {
                    type: 'textarea',
                    title: '修改题干',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '题干不能为空';
                        }
                    }
                }
            }, {
                field: 'result',
                title: '参考答案',
                editable: {
                    type: 'textarea',
                    title: '修改答案'
                }
            }, {
                field: 'edit',
                title: '操作',
                formatter: initEditBtn(),
                events: 'editBtnEvent'
            }]
        });
    });

    //表格内的按钮初始化
    function initEditBtn() {
        var html = [];
        html.push('<button class="btn btn-primary updateAnother" type="button">保存</button>');
        html.push('&nbsp;&nbsp;');
        html.push('<button class="btn btn-danger deleteAnother" type="button">删除</button>');
        return html.join('');
    }

    //点击事件处理
    window.editBtnEvent = {
        'click .updateAnother': function (e, value, row, index) {
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/question/another/update',
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
        },
        'click .deleteAnother': function (e, value, row, index) {
            $.confirm({
                title: "Warnning!",
                content: "您确定要删除该题目吗？",
                animation: 'right',
                closeAnimation: 'rotateX',
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
                                url: '${pageContext.request.contextPath}/question/another/delete',
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