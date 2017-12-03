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
        <label>添加 <strong style="color: #985f0d">考试课程</strong>：
            <select name="courseId" id="course_select" style="width: 200px">
                <option selected></option>
            </select>
        </label>
        <label>添加 <strong style="color: #985f0d">测验专业</strong>：
            <select name="specialtyId" id="specialty_select"
                    style="width: 200px"></select>
        </label>
        <button class="btn btn-primary" type="button" onclick="addExamInfo()">
            <i class="glyphicon glyphicon-plus"></i> 添加
        </button>
        <button type="button"
                class="btn btn-danger" data-toggle="modal"
                data-target="#teacher_exam_modal">
            开启/关闭考试
        </button>
    </div>
    <div class="table-responsive">
        <table id="exam_table"></table>
    </div>
</div>
<%--modal--%>
<div class="modal fade" id="teacher_exam_modal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">开启/关闭考试通道</h4>
            </div>
            <div class="modal-body">
                <ul>
                    <li>开启考试的记录行为<strong style="color: red">红色</strong></li>
                    <li>未开启考试的记录行为<strong>白色</strong></li>
                </ul>
                <table id="modal_table"
                       data-toggle="table"
                       data-height="350"
                       data-method="post"
                       data-show-refresh="true"
                       data-pagination="true"
                       data-side-pagination="server"
                       data-row-style="modalRowStyle"
                       data-page-list="[10, 25, 50, 100, ALL]"
                       data-query-params="$.fn.bootstrapTable.queryParams"
                       data-url="${pageContext.request.contextPath}/exam/modal/list">
                    <thead>
                    <tr>
                        <th data-field="id">id</th>
                        <th data-field="courseName">课程名称</th>
                        <th data-field="specialtyName">专业名称</th>
                        <th data-field="started" data-visible="false">开启/关闭标志
                        </th>
                        <th data-formatter="operateModalExamInfo">操作
                        </th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var course_select = $('#course_select');
    var specialty_select = $('#specialty_select');
    var modal_table = $('#modal_table');
    var table = $('#exam_table');

    //开启考试
    function examStart(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/exam/' + id + "/start",
            type: 'post',
            dataType: 'json',
            success: function (result) {
                if (result.code == 0) {
                    modal_table.bootstrapTable("refresh");
                } else {
                    $.alert({
                        title: "",
                        content: result.msg,
                        backgroundDismiss: true
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    backgroundDismiss: true,
                    title: false,
                    content: "系统错误!",
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

    //关闭考试
    function examClose(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/exam/' + id + "/close",
            type: 'post',
            dataType: 'json',
            success: function (result) {
                if (result.code == 0) {
                    modal_table.bootstrapTable("refresh");
                } else {
                    $.alert({
                        title: "",
                        content: result.msg,
                        backgroundDismiss: true
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
                    backgroundDismiss: true,
                    content: "系统错误!",
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

    //    更新考试信息
    function updateExamInfo(id) {
        var data = JSON.stringify(table.bootstrapTable("getRowByUniqueId", id));
        $.ajax({
            url: '${pageContext.request.contextPath}/exam/update',
            data: data,
            contentType: 'application/json',
            type: 'post',
            dataType: 'json',
            success: function (result) {
                $.alert({
                    title: "",
                    content: result.msg,
                    backgroundDismiss: true
                });
                if (result.code == 0) {
                    table.bootstrapTable("refresh");
                }
                table.bootstrapTable("resetView");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
                    backgroundDismiss: true,
                    content: "系统错误！",
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

    //    删除考试信息
    function deleteExamInfo(info) {
        $.confirm({
                title: "Warnning!",
                content: "您确定要删除这条考试信息吗？",
                animation: 'right',
                closeAnimation: 'rotateX',
                type: 'red',
                backgroundDismiss: true,
                buttons: {
                    ok: {
                        text: "ok!",
                        theme: 'dark',
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action: function () {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/exam/examInfo/' + info + "/delete",
                                type: 'delete',
                                dataType: 'json',
                                success: function (data) {
                                    $.alert({
                                        title: "",
                                        content: result.msg,
                                        backgroundDismiss: true
                                    });
                                    if (data.code === 0) {
                                        table.bootstrapTable("refresh");
                                        modal_table.bootstrapTable("refresh");
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.confirm({
                                        animation: 'rotateX',
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        backgroundDismiss: true,
                                        content: "系统错误!",
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
            }
        )
    }

    //添加考试信息
    function addExamInfo() {
        var courseId = course_select.val();
        var specialtyId = specialty_select.val();
        $.ajax({
            url: '${pageContext.request.contextPath}/exam/examInfo/' + courseId + "/" + specialtyId + "/insert",
            type: 'post',
            dataType: 'json',
            beforeSend: function () {
                if (courseId == '' || specialtyId == '') {
                    $.alert({
                        title: "",
                        content: "请选择课程和专业!",
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
                    modal_table.bootstrapTable("refresh");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    backgroundDismiss: true,
                    title: false,
                    content: "系统错误!",
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
        specialty_select.select2();
        course_select.select2();
        //课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                $('#course_select').select2({
                    data: data
                });
            }
        });
        //联级：选择课程后筛选出修这门课的专业
        course_select.on("select2:select", function (e) {
            var courseId = $('#course_select').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/specialty/' + courseId,
                dataType: 'json',
                success: function (data) {
                    specialty_select.empty();
                    specialty_select.select2({
                        data: data
                    });
                }
            });
        });

        $('#teacher_exam_modal').on('shown.bs.modal', function () {
            modal_table.bootstrapTable('resetView');
        });

        $('#exam_table').bootstrapTable({
            url: '${pageContext.request.contextPath}/exam/examInfos',
            method: 'post',
            sidePagination: 'server',
            uniqueId: 'id',
            pagination: "true",
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
                    colspan: 1,
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
                            var i = 0;
                            var num = [];
                            num = value.split(",");
                            for (x in num) {
                                if (isNaN(num[x])) {
                                    return '请正确填写考察章节信息!';
                                }
                                i++;
                            }
                            if (i > 4) {
                                return '章节数最多能设置4章!';
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
                        template: 'YYYY / MM / DD',
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
                            var i = 0;
                            var num = [];
                            num = value.split(",");
                            for (x in num) {
                                if (isNaN(num[x])) {
                                    return '请正确填写考察章节信息!';
                                }
                                i++;
                            }
                            if (i > 4) {
                                return '章节数最多能设置4章!';
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
                        template: 'YYYY / MM / DD',
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
                            var i = 0;
                            var num = [];
                            num = value.split(",");
                            for (x in num) {
                                if (isNaN(num[x])) {
                                    return '请正确填写考察章节信息!';
                                }
                                i++;
                            }
                            if (i > 4) {
                                return '章节数最多能设置4章!';
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
                        template: 'YYYY / MM / DD',
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
                        template: 'YYYY / MM / DD',
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
                    field: 'test',
                    title: '考试信号',
                    align: 'center',
                    valign: 'middle',
                    editable: {
                        type: 'select',
                        title: '是否开启考试',
                        source: [
                            {value: "1", text: "开启"},
                            {value: "0", text: "关闭"}
                        ]
                    }
                }]
            ]
        });

    });

    //    modalTable中，考试开启row为红色
    function modalRowStyle(row, index) {
        if (row.started === 1) {
            return {
                classes: 'danger'
            };
        }
        return {};
    }

    //    考试信息对学生可见时，行颜色为红色
    function rowStyle(row, index) {
        if (row.test === 1) {
            return {
                classes: 'danger'
            };
        }
        return {};
    }

    //    modal操作
    function operateModalExamInfo(value, row) {
        var html = [];
        html.push('<button class="btn btn-primary" type="button" onclick="examStart(\'{0}\')">开启</button>'.replace('{0}', row.id));
        html.push('<button class="btn btn-danger" type="button" onclick="examClose(\'{0}\')">关闭</button>'.replace('{0}', row.id));
        return html.join('');
    }

    //    操作
    function operateExamTaken(value, row) {
        var html = [];
        html.push('<button class="btn btn-primary" type="button" onclick="updateExamInfo(\'{0}\')">保存</button>'.replace('{0}', row.id));
        html.push('<button class="btn btn-danger" type="button" onclick="deleteExamInfo(\'{0}\')">删除</button>'.replace('{0}',
            row.teacherId + "&" + row.courseId + "&" + row.specialtyId));
        return html.join('');
    }
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>