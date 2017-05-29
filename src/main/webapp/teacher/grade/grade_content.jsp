<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/27
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/teacher/grade/grade.css" charset="UTF-8">
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">成绩统计</li>
    </ol>
    <div class="container-fluid" style="text-align: center">
        <form id="teacher_course_form">
            <label>请选择需要分配的 <strong style="color: #985f0d">课程</strong>：<select
                    name="courseId"
                    id="teacher_grade_select_course"
                    style="width: 200px"></select></label>
            <label style="margin-left: 20px">请选择 <strong
                    style="color: #985f0d">教课班级</strong>：</strong>
                <select id="teacher_grade_select_specialty" name="specialtyId"
                        style="width: 200px"></select></label><br>
            <label><strong>测试一</strong>所占比重：<input id="teacher_grade_grade1"
                                                   name="percent1"
                                                   placeholder="请填写0-100的数字"></label>
            <label><strong>测试二</strong>所占比重：<input id="teacher_grade_grade2"
                                                   name="percent2"
                                                   placeholder="请填写0-100的数字"></label>
            <label><strong>测试三</strong>所占比重：<input id="teacher_grade_grade3"
                                                   name="percent3"
                                                   placeholder="请填写0-100的数字"></label>
            <label><strong>测试四</strong>所占比重：<input id="teacher_grade_grade4"
                                                   name="percent4"
                                                   placeholder="请填写0-100的数字"></label><br>
            <button style="margin-left: 30px" class="btn btn-warning"
                    type="button"
                    onclick="outOfGrade()">
                确认分配
            </button>
        </form>
    </div>
    <hr class="divider"/>
    <br><br>
    <div id="teacher_grade_toolbar">
        <label>请选择需要查看的 <strong style="color: #985f0d">专业</strong>：<select
                name="specialtyId"
                id="teacher_grade_choose_specialty"
                style="width: 200px"></select>
            <button id="teacher_grade_select_btn" class="btn btn-primary">
                <i class="glyphicon glyphicon-search"></i> 查询
            </button>
    </div>
    <div class="table-responsive">
        <table id="teacher_grade_table"
               data-toggle="table"
        <%--data-toolbar="#teacher_grade_toolbar"--%>
               data-method="post"
               data-url="${pageContext.request.contextPath}/teacher/student/grade/${action}"
               data-height="1500"
               data-side-pagination="server"
               data-search="true"
               data-show-refresh="true"
               data-id-field="specialtyId"
               data-row-style="rowStyle"
        >
            <thead>
            <tr>
                <th data-field="specialtyId" data-width="300" rowspan="2"
                    data-sortable="true">
                    专业ID
                </th>
                <th data-field="specialtyName" data-width="300" rowspan="2">
                    专业名称
                </th>
                <th data-field="studentId" data-width="200" rowspan="2">学生ID
                </th>
                <th data-field="studentName" data-width="250" rowspan="2">学生姓名
                </th>
                <th data-field="courseName" data-width="400" rowspan="2">课程名称
                </th>
                <th colspan="5">成绩详情</th>
            </tr>
            <tr>
                <th data-field="grade1" data-width="200">成绩一</th>
                <th data-field="grade2" data-width="200">成绩二</th>
                <th data-field="grade3" data-width="200">成绩三</th>
                <th data-field="grade4" data-width="200">附加题成绩</th>
                <th data-field="total" data-width="200">
                    总成绩
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    //    成绩分配
    function outOfGrade() {
//        $("[name='percent1']").val()
    }

    //    function queryParams() {
    //        var params = {};
    //        $('#teacher_grade_toolbar').find('select[name]').each(function () {
    //            params[$(this).attr('specialtyId')] = $(this).val();
    //        });
    //        return params;
    //    }
    //
    //    function responseHandler(res) {
    //        return res.rows;
    //    }

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

    $(function () {

//        $('#teacher_grade_select_btn').click(function () {
//            $('#teacher_grade_table').bootstrapTable('refresh');
//        });

        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourse',
            dataType: 'json',
            success: function (data) {
                $('#teacher_grade_select_course').select2({
                    data: data
                });
            }
        });
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getSpecialty',
            dataType: 'json',
            success: function (data) {
                $('#teacher_grade_select_specialty').select2({
                    data: data
                });
                $('#teacher_grade_choose_specialty').select2({
                    data: data
                });
            }
        });
    });
</script>