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
    <div id="teacher_exam_toolbar">
        <label>添加 <strong style="color: #985f0d">考试课程</strong>：<select
                name="courseId"
                id="teacher_exam_choose_course"
                style="width: 200px">
            <option selected></option>
        </select></label>
        <label>添加 <strong style="color: #985f0d">测验专业</strong>：<select
                name="specialtyId"
                id="teacher_exam_choose_specialty"
                style="width: 200px"></select></label>
        <button id="teacher_exam_add_btn" class="btn btn-primary"
                type="button">
            <i class="glyphicon glyphicon-plus"></i> 添加
        </button>
    </div>
    <div class="table-responsive">
        <table id="teacher_exam_table"
               data-toggle="table"
               data-toolbar="#teacher_exam_toolbar"
               data-method="post"
               data-show-export="true"
               data-url="${pageContext.request.contextPath}/teacher/examInfos"
               data-height="1500"
               data-side-pagination="server"
               data-show-refresh="true"
               data-id-field="specialtyId"
               data-row-style="rowStyle"
        >
            <thead>
            <tr>
                <th colspan="3">课程和专业</th>
                <th colspan="11">考察详情</th>
                <th data-formatter="operateExamTaken" rowspan="2">操作
                </th>
            </tr>
            <tr>
                <th data-field="courseName">
                    课程名称
                </th>
                <th data-field="specialtyId">
                    专业ID
                </th>
                <th data-field="specialtyName">
                    专业名称
                </th>
                <th id="content1" data-field="content1" data-editable="true">测验一<br>考察内容
                </th>
                <th id="date1" data-field="date1" data-editable="true">考察时间</th>
                <th id="sign1" data-field="sign1" data-editable="true">是否开启</th>
                <th id="content2" data-field="content2" data-editable="true">测验二<br>考察内容
                </th>
                <th id="date2" data-field="date2" data-editable="true">考察时间</th>
                <th id="sign2" data-field="sign2" data-editable="true">是否开启</th>
                <th id="content3" data-field="content3" data-editable="true">测验三<br>考察内容
                </th>
                <th id="date3" data-field="date3" data-editable="true">考察时间</th>
                <th id="sign3" data-field="sign3" data-editable="true">是否开启</th>
                <th id="date4" data-field="date4" data-editable="true">附加题<br>考察时间
                </th>
                <th id="sign4" data-field="sign4" data-editable="true">是否开启</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<script>
    function operateExamTaken() {

    }

    $(function () {
//        添加考试信息
        $('#teacher_exam_add_btn').click(function () {
            var courseId = $('#teacher_exam_choose_course').val();
            var specialtyId = $('#teacher_exam_choose_specialty').val();
            if (courseId !== '') {
                $.ajax({
                    url: '${pageContext.request.contextPath}/teacher/takeExamInfo/' + courseId + "/" + specialtyId,
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        swal("Success", "添加考试信息成功！", "success");
                        $('#teacher_exam_table').bootstrapTable("refresh");
                    },
                    error: function () {
                        swal("Error", "不可重复添加相同的考试信息！", "error");
                    }
                });
            } else {
                swal("Look", "请选择测验课程和班级！", "error");
            }
        });
//        预加载数据
//        专业select添加样式
        $('#teacher_exam_choose_specialty').select2();

//        课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourse',
            dataType: 'json',
            success: function (data) {
                $('#teacher_exam_choose_course').select2({
                    data: data
                });
            }
        });
//        联级：选择课程后筛选出修这门课的专业
        $('#teacher_exam_choose_course').on("select2:select", function (e) {
            var courseId = $('#teacher_exam_choose_course').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/getSpecialties/' + courseId,
                dataType: 'json',
                success: function (data) {
                    var choS = $('#teacher_exam_choose_specialty');
                    choS.empty();
                    choS.select2({
                        data: data
                    });
                }
            });
        });

//        editable
//        content
        $('#content1').editable();
        $('#content2').editable();
        $('#content3').editable();
//        date
        $('#date1').editable();
        $('#date2').editable();
        $('#date3').editable();
        $('#date4').editable();
//        sign
        $('#sign1').editable();
        $('#sign2').editable();
        $('#sign3').editable();
        $('#sign4').editable();
    });
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>