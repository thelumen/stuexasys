<%--
  Created by IntelliJ IDEA.
  User: 96216
  Date: 2017/9/3
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">查看选择题</li>
    </ol>
    <div id="single_select_clause">
        <label>添加 <strong style="color: #985f0d">授课课程</strong>：<select
                name="courseId"
                id="question_single_course"
                style="width: 200px">
            <option selected></option>
        </select></label>
        <label>添加 <strong style="color: #985f0d">课程章节</strong>：<select
                name="section"
                id="question_single_section"
                style="width: 200px">

        </select></label>
        <button id="query_single" class="btn btn-primary"
                type="button">
            查询
        </button>

    </div>
    <table id="singleTable">
    </table>
</div>

<script>
    $(function () {
        $('#question_single_section').select2();
        //初始化下拉框数据。
        $.ajax({
            //            这个url请求获取该教师所教授所有课程
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                $('#question_single_course').select2({
                    data: data
                });
            }
        });
        //        级联：选择课程后筛选出修这门课的所有章节
        $('#question_single_course').on("select2:select", function (e) {
            var courseId = $('#question_single_course').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/course/section/' + courseId,
                dataType: 'json',
                success: function (data) {
                    var choS = $('#question_single_section');
                    choS.empty();
                    choS.select2({

                        data: data
                    });
                }
            });
        });


        var selectOption = 1;//默认加载预留课程的题目
        
        //格式化表格
        $("#singleTable").bootstrapTable({
            method: "post",
            url: "${pageContext.request.contextPath}/question/single/loadSingle/" + null + "/" + null,
            sidePagination: "server",
            idField: "id",
            showRefresh: "true",
            pagination: "true",
            showColumns: "true",
            showExport: "true",
            columns: [{
                field: 'id',
                title: '题号',
                class:"col-md-1",
                sortable: true
            },{
                field: 'courseId',
                title: '课号',
                class:"col-md-1",
                sortable: true
            }, {
                field: 'section',
                title: '章节',
                class:"col-md-1",
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '章节不能为空';
                        }
                    }
                }
            }, {
                field: 'levels',
                title: '难度级别',
                class:"col-md-1",
                editable: {
                    type: 'select',
                    source: [{value: '1', text: "简单"}, {value: '2', text: "中等"}, {value: '3', text: "困难"}],
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '不能为空';
                        }
                    }
                }
            }, {
                field: 'content',
                title: '题干',
                class:"col-md-2",
                editable: {
                    type: 'text',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '题干不能为空';
                        }
                    }
                }
            }, {
                field: 'que1',
                title: 'A',
                class:"col-md-1",
                editable: {
                    type: 'text',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '选项不能为空';
                        }
                    }
                }
            },{
                field: 'que2',
                title: 'B',
                class:"col-md-1",
                editable: {
                    type: 'text',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '选项不能为空';
                        }
                    }
                }
            },{
                field: 'que3',
                title: 'C',
                class:"col-md-1",
                editable: {
                    type: 'text',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '选项不能为空';
                        }
                    }
                }
            },{
                field: 'que4',
                title: 'D',
                class:"col-md-1",
                editable: {
                    type: 'text',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '选项不能为空';
                        }
                    }
                }
            },{
                field: 'result',
                title: '答案',
                class:"col-md-1",
                editable: {
                    type: 'select',
                    source: [{value: 'A', text: "A"}, {value: 'B', text: "B"}, {value: 'C', text: "C"}, {value: 'D', text: "D"}],
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '不能为空';
                        }
                    }
                }
            }, {
                field: 'edit',
                title: '操作',
                class:"col-md-1",
                formatter: initEditBtn(),
                events: 'editBtnEvent'
            }]
        });

        //查找按钮点击事件
        $("#query_single").click(function () {
            var courseId = $("#question_single_course").val();
            var section = $("#question_single_section").val();
            if (courseId === null) {
                courseId = 0;//未选中时的默认值
            }
            if (section === null || section.length === 0) {
                section = 0;//未选中时的默认值
            }
            $("#singleTable").bootstrapTable("refresh",
                {url: "${pageContext.request.contextPath}/question/single/loadSingle/" + courseId + "/" + section})
        })

    });

    //表格内的按钮初始化
    function initEditBtn() {
        var html = [];
        html.push('<button class="btn btn-primary saveChanged" type="button">更新</button>');
        html.push('&nbsp;&nbsp;');
        html.push('<button class="btn btn-danger delStu" type="button">删除</button>');
        return html.join('');
    }

    //表格内按钮点击事件处理
    window.editBtnEvent = {
        'click .saveChanged': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/question/single/update',
                dataType: "json",
               data: JSON.stringify(row),
               contentType: 'application/json',
                success: function (data) {
                    if (data) {
                        alert("更新成功");
                        $("#singleTable").bootstrapTable("refresh")
                    } else {
                        alert("更新失败");
                    }
                }
            });
        },
        'click .delStu': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/question/single/delete',
                dataType: "json",
                data: JSON.stringify(row),
                contentType: 'application/json',
                success: function (data) {
                    if (data) {
                        alert("成功删除");
                        $("#singleTable").bootstrapTable("refresh")
                    } else {
                        alert("删除失败");
                    }
                }
            });
        }
    }

</script>