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
        <table id="teacher_exam_table"/>
    </div>
</div>

<script>
    function operateExamTaken() {

    }

    $(function () {
        $('#teacher_exam_table').bootstrapTable({
            url: '${pageContext.request.contextPath}/teacher/examInfos',
            method: 'post',
            sidePagination: 'server',
            height: 600,
            showRefresh: true,
            toolbar: '#teacher_exam_toolbar',
            columns: [
                [{
                    title: '课程和专业',
                    colspan: 3,
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '测验一',
                    colspan: 3,
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '测验二',
                    colspan: 3,
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '测验三',
                    colspan: 3,
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '附加题',
                    colspan: 2,
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '操作',
                    rowspan: 2,
                    align: 'center',
                    valign: 'middle'
                }],
                [{
                    field: 'courseName',
                    title: '课程名称',
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'specialtyId',
                    title: '专业Id',
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'specialtyName',
                    title: '专业名称',
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'content1',
                    title: '考察章节',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '选择章节',
                        select2:{
                            placeholder: 'Select Country',
                            allowClear: true,
                            minimumInputLength: 3,
                        }
                    }
                }, {
                    field: 'date1',
                    title: '考察时间',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'combodate',
                        title: '考察时间',
                        format: 'YYYY-MM-DD',
                        viewformat: 'YYYY.MM.DD',
                        template: 'YYYY / MMM / D',
                        combodate: {
                            minYear: 2017,
                            maxYear: 2049,
                            minuteStep: 1
                        }
                    }
                }, {
                    field: 'sign1',
                    title: '是否开启',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '是否开启考试',
                        source: [{value: "1", text: "开启"}, {
                            value: "0",
                            text: "关闭"
                        }]
                    }
                }, {
                    field: 'content2',
                    title: '考察章节',
                    editable: true,
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'date2',
                    title: '考察时间',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'combodate',
                        title: '考察时间',
                        format: 'YYYY-MM-DD',
                        viewformat: 'YYYY.MM.DD',
                        template: 'YYYY / MMM / D',
                        combodate: {
                            minYear: 2017,
                            maxYear: 2049,
                            minuteStep: 1
                        }
                    }
                }, {
                    field: 'sign2',
                    title: '是否开启',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '是否开启考试',
                        source: [{value: "1", text: "开启"}, {
                            value: "0",
                            text: "关闭"
                        }]
                    }
                }, {
                    field: 'content3',
                    title: '考察章节',
                    editable: true,
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'date3',
                    title: '考察时间',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'combodate',
                        title: '考察时间',
                        format: 'YYYY-MM-DD',
                        viewformat: 'YYYY.MM.DD',
                        template: 'YYYY / MMM / D',
                        combodate: {
                            minYear: 2017,
                            maxYear: 2049,
                            minuteStep: 1
                        }
                    }
                }, {
                    field: 'sign3',
                    title: '是否开启',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '是否开启考试',
                        source: [{value: "1", text: "开启"}, {
                            value: "0",
                            text: "关闭"
                        }]
                    }
                }, {
                    field: 'date4',
                    title: '考察时间',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'combodate',
                        title: '考察时间',
                        format: 'YYYY-MM-DD',
                        viewformat: 'YYYY.MM.DD',
                        template: 'YYYY / MMM / D',
                        combodate: {
                            minYear: 2017,
                            maxYear: 2049,
                            minuteStep: 1
                        }
                    }
                }, {
                    field: 'sign4',
                    title: '是否开启',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '是否开启考试',
                        source: [{value: "1", text: "开启"}, {
                            value: "0",
                            text: "关闭"
                        }]
                    }
                }]
            ]
        });
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
    });
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>