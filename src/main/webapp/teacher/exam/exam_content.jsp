<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/31
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">考试信息</li>
    </ol>
    <div class="container-fluid" style="text-align: center">
        <form id="teacher_exam_form">
            <label>请选择 <strong
                    style="color: #985f0d">课程</strong>：<select
                    name="courseId"
                    id="teacher_exam_select_course"
                    style="width: 200px"></select></label><br>
            <label>请选择 <strong
                    style="color: #985f0d">专业</strong>：
                <select id="teacher_exam_select_specialty"
                        name="specialtyId"
                        style="width: 200px"></select></label><br>
            <label><strong
                    style="color: #2b669a">测试一 </strong>考察章节：
                <select id="teacher_exam_chapter1" multiple="multiple"
                        style="width: 100px;">
                    <option value="1">第一章</option>
                    <option value="2">第二章</option>
                    <option value="3">第三章</option>
                    <option value="4">第四章</option>
                    <option value="5">第五章</option>
                    <option value="6">第六章</option>
                    <option value="7">第七章</option>
                    <option value="8">第八章</option>
                </select>
            </label>
            <label>是否开启？<select id="teacher_exam_open1"
                                style="width: 70px">
                <option value="start">开启</option>
                <option value="close" selected>关闭</option>
            </select></label>
            <label><strong
                    style="color: #2b669a">测试二 </strong>考察章节：<input
                    id="teacher_grade_grade2"
                    name="percent2"
                    onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"
            ></label>
            <label>是否开启？<select id="teacher_exam_open2"
                                style="width: 70px">
                <option value="start">开启</option>
                <option value="close" selected>关闭</option>
            </select></label>
            <br>
            <label><strong
                    style="color: #2b669a">测试三 </strong>考察章节：<input
                    id="teacher_grade_grade3"
                    name="percent3"
                    onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"
            ></label>
            <label>是否开启？<select id="teacher_exam_open3"
                                style="width: 70px">
                <option value="start">开启</option>
                <option value="close" selected>关闭</option>
            </select></label>
            <label><strong
                    style="color: #2b669a"></strong>附加题测试：<input
                    id="teacher_grade_grade4"
                    name="percent4"
                    onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"
            ></label>
            <label>是否开启？<select id="teacher_exam_open4"
                                style="width: 70px">
                <option value="start">开启</option>
                <option value="close" selected>关闭</option>
            </select></label>
            <br>
            <button style="margin-left: 30px"
                    class="btn btn-warning"
                    type="button"
                    onclick="outOfGrade()">
                确认分配
            </button>
        </form>
    </div>
</div>

<script>
    $(function () {
//        预加载数据
        $('#teacher_exam_chapter1').select2({
            maximumSelectionLength: 3
        });
        $('#teacher_exam_open1').select2();
        $('#teacher_exam_open2').select2();
        $('#teacher_exam_open3').select2();
        $('#teacher_exam_open4').select2();
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourse',
            dataType: 'json',
            success: function (data) {
                $('#teacher_exam_select_course').select2({
                    data: data
                });
            }
        });
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getSpecialty',
            dataType: 'json',
            success: function (data) {
                $('#teacher_exam_select_specialty').select2({
                    data: data
                });
            }
        });
    });
</script>