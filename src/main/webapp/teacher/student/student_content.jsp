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
               data-detail-view="true"
               data-detail-formatter="detailFormatter"
               data-minimum-count-columns="2"
               data-show-pagination-switch="true"
               data-pagination="true"
               data-id-field="id"
               data-page-list="[10, 25, 50, 100, ALL]"
               data-show-footer="false"
               data-side-pagination="server"
               data-url="${pageContext.request.contextPath}/teacher/tlcls"
               data-method="post"
               data-query-params="$.fn.bootstrapTable.queryParams"
        >
            <thead>
            <tr>
                <th data-field="teacherId" data-visible="false">学生ID</th>
                <th data-field="teacherName" data-width="400">成绩一</th>
                <th data-field="courseName" data-width="200">成绩二</th>
                <th data-field="specialtyName" data-width="200">成绩三</th>
                <th data-field="starttime" data-width="200">附加题成绩</th>
                <th data-field="endtime" data-width="200">总成绩</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    function outOfGrade() {

    }
</script>