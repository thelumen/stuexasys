<%--
  Created by IntelliJ IDEA.
  User: 96216
  Date: 2017/9/3
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">判断题管理</li>
    </ol>
    <div id="tf_select_clause">
        <label>选择 <strong style="color: #985f0d">授课课程</strong>：
            <select name="courseId" id="course_select"
                    style="width: 200px">
                <option selected></option>
            </select>
        </label>
        <label>选择 <strong style="color: #985f0d">课程章节</strong>：
            <select name="section" id="section_select"
                    style="width: 200px">
            </select>
        </label>
        <button class="btn btn-primary" type="button" onclick="checkShort()">
            查询
        </button>
    </div>
    <table id="table">
    </table>
</div>
<script>
    var course_select = $('#course_select');
    var section_select = $('#section_select');
    var table = $('#table');

    //查询判断题
    function checkShort() {
        var courseId = course_select.val();
        var section = section_select.val();
        if (section == '' || courseId == '') {
            $.alert({
                title: "",
                content: "请选择所要查询的课程和章节：)",
                backgroundDismiss: true
            });
            return false;
        }
        table.bootstrapTable("refresh",
            {url: "${pageContext.request.contextPath}/question/tf/list/" + courseId + "/" + section})
    }

    //预加载
    $(function () {
        course_select.select2();
        section_select.select2();
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                course_select.select2({
                    data: data
                });
            }
        });
        course_select.on("select2:select", function (e) {
            var courseId = course_select.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/course/section/' + courseId,
                dataType: 'json',
                success: function (data) {
                    section_select.empty();
                    section_select.select2({
                        data: data
                    });
                }
            });
        });

        //初始化表格
        table.bootstrapTable({
            method: "post",
            sidePagination: "server",
            idField: "id",
            showRefresh: "true",
            pagination: "true",
            toolbar: "#tf_select_clause",
            showColumns: "true",
            columns: [{
                field: 'id',
                title: '题号',
                width: 30,
                sortable: true
            }, {
                field: 'courseId',
                title: '课号',
                width: 30,
                sortable: true
            }, {
                field: 'section',
                title: '章节',
                width: 30,
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '章节不能为空';
                        }
                    }
                }
            }, {
                field: 'levels',
                title: '难度级别',
                width: 20,
                editable: {
                    type: 'select',
                    source: [{value: '1', text: "简单"}, {
                        value: '2',
                        text: "中等"
                    }, {value: '3', text: "困难"}],
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '不能为空';
                        }
                    }
                }
            }, {
                field: 'content',
                title: '题干',
                width: 400,
                editable: {
                    type: 'text',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '题干不能为空';
                        }
                    }
                }
            }, {
                field: 'result',
                title: '答案',
                width: 30,
                editable: {
                    type: 'select',
                    source: [{value: '1', text: "正确"}, {
                        value: '0',
                        text: "错误"
                    }],
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '不能为空';
                        }
                    }
                }
            }, {
                field: 'edit',
                title: '操作',
                width: 70,
                formatter: initEditBtn(),
                events: 'editBtnEvent'
            }]
        });
    });

    //按钮初始化
    function initEditBtn() {
        var html = [];
        html.push('<button class="btn btn-primary updateShort" type="button">更新</button>');
        html.push('<button class="btn btn-danger deleteShort" type="button">删除</button>');
        return html.join('');
    }

    //表格内按钮点击事件处理
    window.editBtnEvent = {
        'click .updateShort': function (e, value, row, index) {
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/question/tf/update',
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
        'click .deleteShort': function (e, value, row, index) {
            $.confirm({
                title: "Warnning!",
                content: "您确定要删除该题目吗？",
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
                            $.ajax({
                                type: 'post',
                                url: '${pageContext.request.contextPath}/question/tf/delete',
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