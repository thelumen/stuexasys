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
        <button type="button"
                class="btn btn-danger" data-toggle="modal"
                data-target="#modalTable">
            开启/关闭考试
        </button>
    </div>
    <div class="table-responsive">
        <table id="teacher_exam_table"></table>
    </div>
</div>

<script>
    //    考试信息对学生可见时，行颜色为红色
    function rowStyle(row, index) {
        if (row.started === 1) {
            return {
                classes: 'danger'
            };
        }
        return {};
    }
    //    更新考试信息
    function updateExamInfo(id) {
        var table = $('#teacher_exam_table');
        var data = JSON.stringify($('#teacher_exam_table').bootstrapTable("getRowByUniqueId", id));
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/updateExamInfo',
            data: data,
            contentType: 'application/json',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                if (data.isSuccess) {
                    swal("year..", "考试信息已更新!", "success");
                    table.bootstrapTable("refresh");
                } else {
                    swal("Look", "signX信号有且必有一个开启！请重新设置", "error");
                }
                table.bootstrapTable("resetView");
            },
            error: function () {
                swal("Error", "系统出现问题，请联系管理员!", "error");
            }
        });
    }
    //    删除考试信息
    function deleteExamInfo(id) {
        swal({
                title: "Are you sure?",
                text: "Something will be delete ?",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes,it will be!",
                cancelButtonText: "No, cancel!",
                closeOnConfirm: false,
                closeOnCancel: false
            },
            function (isConfirm) {
                if (isConfirm) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/teacher/examInfo/delete/' + id,
                        type: 'delete',
                        dataType: 'json',
                        success: function (data) {
                            if (data.isSuccess) {
                                swal("year..", "删除成功!", "success");
                                $('#teacher_exam_table').bootstrapTable("refresh");
                            }
                        },
                        error: function () {
                            swal("Error", "系统出现错误，请联系管理员!", "error");
                        }
                    });
                }
            }
        )
    }
    //    操作
    function operateExamTaken(value, row) {
        var html = [];
        html.push('<button class="btn btn-primary" type="button" onclick="updateExamInfo(\'{0}\')">保存</button>'.replace('{0}', row.id));
        html.push('<button style="margin-left: 20px" class="btn btn-danger" type="button" onclick="deleteExamInfo(\'{0}\')">删除</button>'.replace('{0}', row.id));
        return html.join('');
    }
    $(function () {
        $('#teacher_exam_table').bootstrapTable({
            url: '${pageContext.request.contextPath}/teacher/examInfos',
            method: 'post',
            sidePagination: 'server',
            height: 600,
            uniqueId: 'id',
            showRefresh: true,
            rowStyle: rowStyle,
            toolbar: '#teacher_exam_toolbar',
            columns: [
                [{
                    title: '课程和专业',
                    colspan: 4,
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
                    title: '学生可见?',
                    colspan: 1,
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '操作',
                    rowspan: 2,
                    align: 'center',
                    valign: 'middle',
                    formatter: operateExamTaken
                }],
                [{
                    field: 'id',
                    title: 'id',
                    align: 'center',
                    valign: 'middle'
                }, {
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
                        type: 'text',
                        title: '填写章节(示例: 1,2,5 )',
                        validate: function (value) {
                            var num = [];
                            num = value.split(",");
                            for (x in num) {
                                if (isNaN(num[x])) {
                                    return '请正确填写考察章节信息!';
                                }
                            }
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
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'text',
                        title: '填写章节(示例: 1,2,5 )',
                        validate: function (value) {
                            var num = [];
                            num = value.split(",");
                            for (x in num) {
                                if (isNaN(num[x])) {
                                    return '请正确填写考察章节信息!';
                                }
                            }
                        }
                    }
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
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'text',
                        title: '填写章节(示例: 1,2,5 )',
                        validate: function (value) {
                            var num = [];
                            num = value.split(",");
                            for (x in num) {
                                if (isNaN(num[x])) {
                                    return '请正确填写考察章节信息!';
                                }
                            }
                        }
                    }
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
                }, {
                    field: 'started',
                    title: '考试信号',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '是否开启考试',
                        source: [{value: "1", text: "开启"}, {
                            value: "0", text: "关闭"
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
                        if (data.isSuccess) {
                            swal("Success", "添加考试信息成功！", "success");
                            $('#teacher_exam_table').bootstrapTable("refresh");
                        } else {
                            swal("注意！", "不可添加重复数据！", "error");
                        }
                    },
                    error: function () {
                        swal("Error", "出现系统错误，请稍后再试！", "error");
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