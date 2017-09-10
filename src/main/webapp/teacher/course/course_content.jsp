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
        <li class="active">课程管理</li>
    </ol>
    <div class="container-fluid" style="text-align: center">
        <form id="teacher_course_form">
            <label>请选择 <strong style="color: #985f0d">您的课程</strong>：<select
                    name="courseId"
                    id="teacher_course_select_course"
                    style="width: 200px"></select></label>
            <label style="margin-left: 20px">请选择您的 <strong
                    style="color: #985f0d">教课班级</strong>：</strong>
                <select id="teacher_course_select_specialty" name="specialtyId"
                        style="width: 200px"></select></label><br>
            <label>开课时间：<input name="starttime" type="date" required></label>
            <label style="margin-left: 20px">结课时间：<input name="endtime"
                                                         type="date"
                                                         required></label>
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
               data-show-columns="true"
               data-minimum-count-columns="2"
               data-show-pagination-switch="true"
               data-pagination="true"
               data-id-field="teacherId"
               data-page-list="[10, 25, 50, 100, ALL]"
               data-show-footer="true"
               data-side-pagination="server"
               data-url="${pageContext.request.contextPath}/course/list"
               data-method="post"
               data-row-style="rowStyle"
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
    var $course=$('#teacher_course_select_course');
    var $specialty=$('#teacher_course_select_specialty');
    //    样式
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
    //    预加载
    $(function () {
        $course.select2();
        $specialty.select2();
//        全部课程
        $.ajax({
            url: '${pageContext.request.contextPath}/course/all',
            dataType: 'json',
            success: function (data) {
                $('#teacher_course_select_course').select2({
                    data: data
                });
            }
        });
//        全部专业
        $.ajax({
            url: '${pageContext.request.contextPath}/course/specialties',
            dataType: 'json',
            success: function (data) {
                $('#teacher_course_select_specialty').select2({
                    data: data
                });
            }
        });
    });
    //    选课
    function takeTheCourse() {
        var data = $('#teacher_course_form').serializeObject();
        if ($("[name='endtime']").val() !== '' && $("[name='starttime']").val() !== '') {
//            alert(JSON.stringify(data))
            $.ajax({
                url: '${pageContext.request.contextPath}/course/insert',
                type: 'post',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (d) {
                    if (d) {
                        swal("恭喜..", "添加新课程成功！ :)", "success");
                        $('#teacher_course_table').bootstrapTable("refresh");
                    } else {
                        swal("Sorry", "起始日期应小于结课日期！", "error");
                    }
                },
                error: function () {
                    swal("Failed..", "不能重复添加相同的课程和班级...", "error");
                }
            });
        } else {
            swal("注意..", "不要忘记填写开课和结课时间哦 :)", "error");
        }
    }
    //    添加操作按钮
    function operateCourseTaken(value, row) {
        var html = '';
        html += '<button class="btn btn-danger pull-right" onclick="deleteCourseTaken(\'{0}\');">删除</button>'.replace('{0}', row.teacherId + "&" + row.courseId + "&" + row.specialtyId);
        return html;
    }
    //    删除选课信息
    function deleteCourseTaken(content) {
        swal({
                title: "Are you sure?",
                text: "删除成功后将会同时删除相应的考试信息，您确定吗？",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                cancelButtonText: "No, cancel!",
                closeOnConfirm: false,
                closeOnCancel: false
            },
            function (isConfirm) {
                if (isConfirm) {
                    $.ajax({
                        type: 'delete',
                        url: '${pageContext.request.contextPath}/course/delete/' + content,
                        dataType: 'json',
                        success: function (data) {
                            if (data === true) {
                                swal("Deleted!", "此课程成功删除！", "success");
                                $('#teacher_course_table').bootstrapTable("refresh");
                            } else {
                                swal("Sorry", "此课程已结被删除！", "error");
                            }
                        },
                        error: function () {
                            swal("Sorry!", "系统出错了！.", "error");
                        }
                    });
                } else {
                    swal("Cancelled", "This Course Information is safe :)", "error");
                }
            });
    }
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>