<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/11/1
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/student/main">首页</a>
        </li>
        <li class="active">试卷管理</li>
    </ol>
    <div class="container">
        <div id="toolbar">
            <label><strong style="color: #985f0d">专业</strong>：
                <select id="specialty" style="width: 180px">
                </select>
            </label>
            <label><strong style="color: #985f0d">课程</strong>：
                <select id="course" style="width: 150px">
                </select>
            </label>
            <label><strong style="color: #985f0d">测试</strong>：
                <select id="test" style="width: 100px">
                </select>
            </label>
            <button class="btn btn-primary" type="button" onclick="check()">
                <i class="glyphicon glyphicon-search"></i> 查询
            </button>
            <a id="download_button" class="btn btn-danger" href="#"> <i
                    class="glyphicon glyphicon-download"></i> 下载</a>
            <button class="btn btn-primary" type="button"
                    onclick="deletePart()">
                <i class="glyphicon glyphicon-remove"></i> 清除无用文件
            </button>
            <button class="btn btn-primary" type="button"
                    onclick="deleteAll()">
                <i class="glyphicon glyphicon-remove"></i> 清除全部文件
            </button>
        </div>
        <table id="file_table"
               data-toolbar="#toolbar"
               class="table table-bordered table-hover"
               data-toggle="table"
               data-pagination="true"
               data-side-pagination="server"
               data-method="post"
               data-query-params="$.fn.bootstrapTable.queryParams">
            <thead>
            <tr>
                <th data-field="fileName">文件名</th>
                <th data-field="path">文件路径</th>
                <th data-field="nowDate">创建日期</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>
<script>
    //    select
    var specialty = $('#specialty');
    var course = $('#course');
    var test = $('#test');
    //    table
    var table = $('#file_table');

    //下载按钮点击事件
    //下载zip文件
    function downloadZipFile() {
        if (test.val() == undefined || test.text() == "" || test.text() == "null") {
            $.alert({
                title: "",
                content: "填写完整信息后方可下载文件:)",
                backgroundDismiss: true
            });
            return false;
        }
        $.get("${pageContext.request.contextPath}/admin/file/download",
            {
                specialtyId: specialty.val(),
                courseId: course.val(),
                test: test.val()
            })
    }

    //    查询试卷
    function check() {
        if (test.val() == undefined || test.text() == "" || test.text() == "null") {
            $.alert({
                title: "",
                content: "请选择完整信息进行删除:)",
                backgroundDismiss: true
            });
            return false;
        }
        $.get("${pageContext.request.contextPath}/admin/file/list",
            {
                specialtyId: specialty.val(),
                courseId: course.val(),
                test: test.val()
            }, function (result) {
                table.bootstrapTable('load', result);
            });
        $('#download_button').attr("href",
            "${pageContext.request.contextPath}/admin/file/" + specialty.val() + "/" + course.val() + "/" + test.val() + "/download")
    }

    //删除无用文件
    function deletePart() {
        $.confirm({
            title: "Warnning!",
            content: "您确定要删除临时文件吗？",
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
                        if (test.text() == undefined || test.text() == "" || test.text() == "null") {
                            $.alert({
                                title: "",
                                content: "请选择完整信息进行删除:)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        $.get("${pageContext.request.contextPath}/admin/file/delete",
                            {
                                specialtyId: specialty.val(),
                                courseId: course.val(),
                                test: test.val()
                            }, function (result) {
                                $.alert({
                                    title: "",
                                    content: result.msg,
                                    backgroundDismiss: true
                                });
                            });
                    }
            },
                cancel: function () {
                }
            }
        });
    }

    //删除全部文件
    function deleteAll() {
        $.confirm({
            title: "Warnning!",
            content: "您确定要删除全部文件吗？",
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
                        if (test.text() == undefined || test.text() == "" || test.text() == "null") {
                            $.alert({
                                title: "",
                                content: "请选择完整信息进行删除:)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        $.get("${pageContext.request.contextPath}/admin/file/delete",
                            {
                                specialtyId: specialty.val(),
                                courseId: course.val(),
                                test: test.val(),
                                isAll: true
                            }, function (result) {
                                $.alert({
                                    title: "",
                                    content: result.msg,
                                    backgroundDismiss: true
                                });
                            });
                    }
                },
                cancel: function () {
                }
            }
        });
    }

    //初始化
    $(function () {
        specialty.select2();
        course.select2();
        test.select2();
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/file/specialty',
            dataType: 'json',
            success: function (data) {
                specialty.select2({
                    data: data
                });
            }
        });
        //        联级查询专业课程
        specialty.on("select2:select", function (e) {
            var specialtyId = specialty.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/file/' + specialtyId,
                dataType: 'json',
                success: function (data) {
                    course.empty();
                    test.empty();
                    course.select2({
                        data: data
                    });
                }
            });
        });
        //        联级查询测试
        course.on("select2:select", function (e) {
            var specialtyId = specialty.val();
            var courseId = course.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/file/' + specialtyId + "/" + courseId,
                dataType: 'json',
                success: function (data) {
                    test.empty();
                    test.select2({
                        data: data
                    });
                }
            });
        });
    });

</script>