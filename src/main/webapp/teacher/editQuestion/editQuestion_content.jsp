<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/9/5
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        $(function () {

            //初始化下拉框
            $.ajax({
                url: '${pageContext.request.contextPath}/question/courseGet',
                dataType: 'json',
                success: function (data) {
                    $('#course').select2({
                        placeholder: "课程名",
                        allowClear: true,
                        data: data
                    });
                }
            });

            //表格初始化
            $("#editQuestionTable").bootstrapTable({
                method: "post",
                url: "${pageContext.request.contextPath}/question/initTable",
                sidePagination: "server",
                idField: "questionId",
                showRefresh: "true",
                pagination: "true",
                showColumns: "true",
                showExport: "true",
                columns: [{
                    field: 'courseName',
                    title: '课程'
                }, {
                    field: 'content',
                    title: '题干',
                    editable: {
                        type: 'textarea',
                        title: '修改题干',
                        validate: function (value) {
                            if ($.trim(value) === '') {
                                return '题干不能为空';
                            }
                        }
                    }
                }, {
                    field: 'result',
                    title: '实例答案',
                    editable: {
                        type: 'textarea',
                        title: '修改答案'
                    }
                }, {
                    field: 'edit',
                    title: '操作',
                    formatter: initEditBtn(),
                    events: 'editBtnEvent'
                }]
            });

            //查找按钮点击事件
            $("#selectQuestion").click(function () {
                var courseId = $("#course").val();
                if (courseId !== null) {
                    $("#editQuestionTable").bootstrapTable("refresh", {
                        url: '${pageContext.request.contextPath}/question/questionLoad/' + courseId,
                        silent: true
                    })
                } else {
                    alert("请选择一个课程");
                }
            })
        });

        //表格内的按钮初始化
        function initEditBtn() {
            var html = [];
            html.push('<button class="btn btn-primary editQuestion" type="button">保存</button>');
            html.push('&nbsp;&nbsp;');
            html.push('<button class="btn btn-danger delQuestion" type="button">删除</button>');
            return html.join('');
        }

        //点击事件处理
        window.editBtnEvent = {
            'click .editQuestion': function (e, value, row, index) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/question/questionSave',
                    dataType: "json",
                    data: JSON.stringify(row),
                    contentType: 'application/json',
                    success: function (data) {
                        if (data) {
                            alert("更新成功");
                            $("#editQuestionTable").bootstrapTable("refresh")
                        } else {
                            alert("更新失败");
                        }
                    }
                });
            },
            'click .delQuestion': function (e, value, row, index) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/question/questionDel',
                    dataType: "json",
                    data: JSON.stringify(row),
                    contentType: 'application/json',
                    success: function (data) {
                        if (data) {
                            alert("成功删除");
                            $("#editQuestionTable").bootstrapTable("refresh")
                        } else {
                            alert("删除失败");
                        }
                    }
                });
            }
        }
    </script>
</head>
<body>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <label style="display: block">
                <select class="form-control " id="course"></select>
            </label>
        </div>
        <div class="col-md-6">
            <button class="btn btn-primary" type="button" id="selectQuestion">查找</button>
        </div>
    </div>
    <div class="row">
        <table id="editQuestionTable">
        </table>
    </div>
</div>
</body>
</html>
