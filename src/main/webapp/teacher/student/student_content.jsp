<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/27
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/teacher/student/student.css" charset="UTF-8">
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">学生信息</li>
    </ol>
    <div class="container-fluid" style="text-align: center">
        <form id="teacher_course_form">
            <label>请选择需要分配的 <strong style="color: #985f0d">课程</strong>：<select
                    name="courseId"
                    id="teacher_student_select_course"
                    style="width: 200px"></select></label>
            <label style="margin-left: 20px">请选择 <strong
                    style="color: #985f0d">教课班级</strong>：</strong>
                <select id="teacher_student_select_specialty" name="specialtyId"
                        style="width: 200px"></select></label><br>
            <label><strong>测试一</strong>所占比重：<input id="teacher_student_grade1"
                                                   name="percent1"></label>
            <label><strong>测试二</strong>所占比重：<input id="teacher_student_grade2"
                                                   name="percent2"></label>
            <label><strong>测试三</strong>所占比重：<input id="teacher_student_grade3"
                                                   name="percent3"></label>
            <label><strong>测试四</strong>所占比重：<input id="teacher_student_grade4"
                                                   name="percent4"></label><br>
            <button style="margin-left: 30px" class="btn btn-warning"
                    type="button"
                    onclick="outOfGrade()">
                确认分配
            </button>
        </form>
    </div>
    <hr class="divider"/>
    <br><br>
    <div class="table-responsive">
        <table id="teacher_student_table"
               data-toggle="table"
               data-search="true"
               data-show-refresh="true"
               data-show-columns="true"
               data-minimum-count-columns="2"
               data-show-pagination-switch="true"
               data-pagination="true"
               data-id-field="studentId"
               data-page-list="[15, 25, 50, 100, ALL]"
               data-show-footer="false"
               data-side-pagination="server"
               data-url="${pageContext.request.contextPath}/teacher/student/grade/${action}"
               data-method="post"
               data-query-params="$.fn.bootstrapTable.queryParams"
        >
            <thead>
            <tr>
                <th data-field="studentId" data-sortable="true">学生ID</th>
                <th data-field="studentName">学生姓名</th>
                <th data-field="courseName" data-width="400">课程名称</th>
                <th data-field="grade1" data-width="400">成绩一</th>
                <th data-field="grade2" data-width="200">成绩二</th>
                <th data-field="grade3" data-width="200">成绩三</th>
                <th data-field="grade4" data-width="200">附加题成绩</th>
                <th data-field="result" data-width="200">总成绩</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    $(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourses',
            dataType: 'json',
            success: function (data) {
                $('#teacher_student_select_course').select2({
                    data: data
                });
            }
        });
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getSpecialties',
            dataType: 'json',
            success: function (data) {
                $('#teacher_student_select_specialty').select2({
                    data: data
                });
            }
        });
    });
    function outOfGrade() {

    }
</script>