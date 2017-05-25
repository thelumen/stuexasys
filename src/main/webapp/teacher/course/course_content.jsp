<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/25
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">课程管理</li>
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
                    onclick="takeTheCourse()">
                确认选择
            </button>
        </form>
    </div>
    <hr class="divider"/>
    <br><br>
    <div class="table-responsive">
        <table id="shiro_resource_singleTable"
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
                <th data-field="teacherId" data-visible="false">教师ID</th>
                <th data-field="teacherName" data-width="400">教师</th>
                <th data-field="courseName" data-width="200">课程</th>
                <th data-field="specialtyName" data-width="200">专业</th>
                <th data-field="starttime" data-width="200">开课时间</th>
                <th data-field="endtime" data-width="200">结课时间</th>
                <th data-field="on" data-width="200">教课中？</th>
                <th data-formatter="operateSingle" data-width="150">操作
                </th>
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
                $('#teacher_course_select_course').select2({
                    data: data
                });
            }
        });
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getSpecialties',
            dataType: 'json',
            success: function (data) {
                $('#teacher_course_select_specialty').select2({
                    data: data
                });
            }
        });
    });
    function takeTheCourse() {
        var data = $('#teacher_course_form').serializeObject();
        if ($("[name='endtime']").val() !== '' && $("[name='starttime']").val() !== '') {
//            alert(JSON.stringify(data))
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/takeCourse',
                type: 'post',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function (d) {

                }
            });
        } else {
            swal("注意..", "不要忘记填写开课和结课时间哦 :)", "error");
        }
    }
    //操作按钮
    function operateSingle(value, row) {
        var html = [];
        html.push('<button class="btn btn-warning pull-left" onclick="location.href=\'${pageContext.request.contextPath}/system/updateSingle/{0}\'">编辑</button>'.replace('{0}', row.id));
        html.push('<button class="btn btn-danger pull-right" onclick="delSingle(\'{0}\');">删除</button>'.replace('{0}', row.id));
        return html.join('');
    }
    //删除选择题
    function delSingle(id) {
        swal({
                title: "Are you sure?",
                text: "Your will be able to recover this Question!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                cancelButtonText: "No, cancel!",
                closeOnConfirm: false,
                closeOnCancel: false
            },
            function (isConfirm) {
                if (isConfirm) {
                    $.ajax({
                        type: 'post',
                        url: '${pageContext.request.contextPath}/manage/deleteSingle/' + id,
                        dataType: 'json',
                        success: function (data) {
                            if (data.isSuccess) {
                                swal("Deleted!", "This Question has been deleted.", "success");
                                $('#shiro_resource_singleTable').bootstrapTable("refresh");
                            } else {
                                swal("NO!", "Already be deleted!", "error");
                            }
                        }
                    });
                } else {
                    swal("Cancelled", "This Question is safe :)", "error");
                }
            });
    }
    //查看信息详情
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }
</script>