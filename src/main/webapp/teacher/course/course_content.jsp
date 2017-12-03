<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/25
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">选课管理</li>
    </ol>
    <div class="container-fluid" style="text-align: center">
        <form id="course_form">
            <label>请选择 <strong style="color: #985f0d">您的课程</strong>：<select
                    name="courseId"
                    id="course_select"
                    style="width: 200px"></select></label>
            <label style="margin-left: 20px">请选择 <strong
                    style="color: #985f0d">您的教课专业</strong>：
                <select id="specialty_select" name="specialtyId"
                        style="width: 200px"></select></label><br>
            <label>开课时间：<input id="starttime" name="starttime" type="date"
                               required></label>
            <label style="margin-left: 20px">结课时间：
                <input id="endtime" name="endtime" type="date" required></label>
            <button style="margin-left: 30px" class="btn btn-warning"
                    type="button"
                    onclick="takeTheCourse()">
                确认选课
            </button>
        </form>
    </div>
    <hr class="divider"/>
    <br><br>
    <div class="table-responsive">
        <table id="teacher_course_table"
               data-toggle="table"
               data-show-refresh="true"
               data-show-pagination-switch="true"
               data-pagination="true"
               data-id-field="teacherId"
               data-page-list="[10, 25, 50, 100, ALL]"
               data-side-pagination="server"
               data-url="${pageContext.request.contextPath}/course/list"
               data-method="post"
               data-row-style="rowStyle"
               data-show-export="true"
               data-query-params="$.fn.bootstrapTable.queryParams"
        >
            <thead>
            <tr>
                <th colspan="2">教师信息</th>
                <th colspan="4">课程和班级</th>
                <th colspan="2">时间信息</th>
                <th data-field="on" data-width="200" rowspan="2">状态</th>
                <th data-formatter="operateCourseTaken" data-width="150"
                    rowspan="2">操作
                </th>
            </tr>
            <tr>
                <th data-field="teacherId">教师ID</th>
                <th data-field="teacherName" data-width="400">教师姓名</th>
                <th data-field="courseId" data-width="200">课程编号</th>
                <th data-field="courseName" data-width="200">课程名称</th>
                <th data-field="specialtyId" data-width="200">专业编号
                </th>
                <th data-field="specialtyName" data-width="200">专业名称
                </th>
                <th data-field="starttime" data-width="200">开课时间</th>
                <th data-field="endtime" data-width="200">结课时间</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    var courseSelect = $('#course_select');
    var specialtySelect = $('#specialty_select');
    var table = $('#teacher_course_table');

    //删除选课信息
    function deleteCourse(content) {
        $.confirm({
            title: "Warnning!",
            content: "删除成功后将会同时删除相应的考试信息，您确定吗？",
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
                            url: '${pageContext.request.contextPath}/course/delete/' + content,
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
                                    content: "您没有权限!",
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

    //选课
    function takeTheCourse() {
        var data = $('#course_form').serializeObject();
        $.ajax({
            url: '${pageContext.request.contextPath}/course/insert',
            type: 'post',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify(data),
            beforeSend: function () {
                if ($('#endtime').val() == '' || $('#starttime').val() == '') {
                    $.alert({
                        title: "",
                        content: "不要忘记填写开课和结课时间哦!",
                        backgroundDismiss: true
                    });
                    return false;
                }
            },
            success: function (result) {
                $.alert({
                    title: "",
                    content: result.msg,
                    backgroundDismiss: true
                });
                if (result.code == 0) {
                    table.bootstrapTable("refresh");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    backgroundDismiss: true,
                    closeAnimation: 'rotateX',
                    title: false,
                    content: "您选择的课程和专业已存在!",
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

    //预加载
    $(function () {
        courseSelect.select2();
        specialtySelect.select2();
        //全部课程
        $.ajax({
            url: '${pageContext.request.contextPath}/course/all',
            dataType: 'json',
            success: function (data) {
                courseSelect.select2({
                    data: data
                });
            }
        });
        //全部专业
        $.ajax({
            url: '${pageContext.request.contextPath}/specialty/all',
            dataType: 'json',
            success: function (data) {
                specialtySelect.select2({
                    data: data
                });
            }
        });
    });

    //添加操作按钮
    function operateCourseTaken(value, row) {
        var html = '<button class="btn btn-danger" onclick="deleteCourse(\'{0}\');">删除</button>'.replace('{0}',
            row.teacherId + "&" + row.courseId + "&" + row.specialtyId);
        return html;
    }

    //样式
    function rowStyle(row, index) {
        var classes = ['active', 'info', 'warning'];

        if (index % 2 === 0 && index / 2 < classes.length) {
            return {
                classes: classes[index / 2]
            };
        }
        if (index / 2 >= classes.length) {
            return {
                classes: classes[index / 2 % 3]
            };
        }
        return {};
    }
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>