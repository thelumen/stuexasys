<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/25
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/teacher/cources">选课管理</a>
        </li>
        <li class="active">编辑信息</li>
    </ol>
    <form id="teacher_course_form">
        <input value="${courseTaken.teacherId}">
        <label>请选择 <strong style="color: #985f0d">您的课程</strong>：<select
                name="courseId"
                id="teacher_editCourseTaken_select_course"
                style="width: 200px">
        </select></label>
        <label style="margin-left: 20px">请选择您的 <strong
                style="color: #985f0d">教课班级</strong>：</strong>
            <select id="teacher_editCourseTaken_select_specialty"
                    name="specialtyId"
                    style="width: 200px"></select></label><br>
        <label>开课时间：<input name="starttime" type="date"
                           value="${courseTaken.starttime}" required></label>
        <label style="margin-left: 20px">结课时间：<input name="endtime"
                                                     value="${courseTaken.endtime}"
                                                     type="date"
                                                     required></label>
        <button style="margin-left: 30px" class="btn btn-warning"
                type="button"
                onclick="editTheCourse()">
            确认选择
        </button>
    </form>
</div>
<script>
    $(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourses',
            dataType: 'json',
            success: function (data) {
                $('#teacher_editCourseTaken_select_course').select2({
                    data: data
                });
            }
        });
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getSpecialties',
            dataType: 'json',
            success: function (data) {
                $('#teacher_editCourseTaken_select_specialty').select2({
                    data: data
                });
            }
        });
    });
    function editTheCourse() {
        var data = $('#teacher_course_form').serializeObject();
        if ($("[name='endtime']").val() !== '' && $("[name='starttime']").val() !== '') {
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/editCourse',
                type: 'post',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                error: function () {
                    swal("Failed..", "不能重复添加相同的课程和班级...", "error");
                }
            });
        } else {
            swal("注意..", "不要忘记填写开课和结课时间哦 :)", "error");
        }
    }
</script>