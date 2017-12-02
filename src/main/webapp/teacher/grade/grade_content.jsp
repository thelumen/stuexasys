<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/5/27
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">成绩统计</li>
    </ol>
    <div class="container-fluid" style="text-align: center">
        <form id="teacher_course_form">
            <label>请选择需要分配的 <strong style="color: #985f0d">课程</strong>：
                <select name="courseId" id="course_select" style="width: 200px">
                    <option selected></option>
                </select></label>
            <label style="margin-left: 20px">请选择 <strong style="color: #985f0d">教课专业</strong>：
                <select id="specialty_select" name="specialtyId"
                        style="width: 200px">
                </select>
            </label><br>
            <label><strong style="color: #2b669a">测试一 </strong>所占比重：
                <input name="percent1" placeholder="请填写0-100的数字"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"
                       onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </label>
            <label><strong style="color: #2b669a">测试二 </strong>所占比重：
                <input name="percent2" placeholder="请填写0-100的数字"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"
                       onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </label>
            <label><strong style="color: #2b669a">测试三 </strong>所占比重：
                <input name="percent3" placeholder="请填写0-100的数字"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"
                       onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </label>
            <label><strong style="color: #2b669a">测试四 </strong>所占比重：
                <input name="percent4" placeholder="请填写0-100的数字"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"
                       onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </label><br>
            <button style="margin-left: 30px" class="btn btn-warning"
                    type="button" onclick="outOfGrade()">
                确认分配
            </button>
        </form>
    </div>
    <hr class="divider"/>
    <br><br>
    <div id="teacher_grade_toolbar">
        <label>请选择需要查看的 <strong style="color: #985f0d">课程</strong>：
            <select id="table_course_select" name="courseId"
                    style="width: 200px">
                <option selected></option>
            </select>
        </label>
        <label>请选择需要查看的 <strong style="color: #985f0d">专业</strong>：
            <select name="specialtyId" id="table_specialty_select"
                    style="width: 200px"></select>
        </label>
        <button class="btn btn-primary" type="button" onclick="checkData()">
            <i class="glyphicon glyphicon-search"></i> 查询
        </button>
        <button class="btn btn-primary" type="button" onclick="checkAllData()">
            <i class="glyphicon glyphicon-repeat"></i> 全部数据
        </button>
    </div>
    <div class="table-responsive">
        <table id="teacher_grade_table"
               data-toggle="table"
               data-toolbar="#teacher_grade_toolbar"
               data-method="post"
               data-show-export="true"
               data-url="${pageContext.request.contextPath}/grade/list"
               data-side-pagination="server"
               data-show-refresh="true"
               data-id-field="specialtyId"
               data-pagination="true"
               data-query-params="$.fn.bootstrapTable.queryParams"
               data-row-style="rowStyle"
        >
            <thead>
            <tr>
                <th colspan="4">学生信息</th>
                <th data-field="courseName" data-width="300" rowspan="2">课程名称
                </th>
                <th colspan="5">成绩详情</th>
            </tr>
            <tr>
                <th data-field="specialtyId" data-width="200"
                    data-sortable="true">
                    专业ID
                </th>
                <th data-field="specialtyName" data-width="300">
                    专业名称
                </th>
                <th data-field="studentId" data-width="150">学生ID
                </th>
                <th data-field="studentName" data-width="200">学生姓名
                </th>
                <th data-field="grade1" data-width="150">成绩一</th>
                <th data-field="grade2" data-width="150">成绩二</th>
                <th data-field="grade3" data-width="150">成绩三</th>
                <th data-field="grade4" data-width="150">附加题成绩</th>
                <th data-field="total" data-width="150">
                    总成绩
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<script>
    var course_select = $('#course_select');
    var specialty_select = $('#specialty_select');
    var table = $('#teacher_grade_table');
    var table_course_select = $('#table_course_select');
    var table_specialty_select = $('#table_specialty_select');

    //    成绩分配
    function outOfGrade() {
        var data = $('#teacher_course_form').serializeObject();
        var value1 = Number($("[name='percent1']").val());
        var value2 = Number($("[name='percent2']").val());
        var value3 = Number($("[name='percent3']").val());
        var value4 = Number($("[name='percent4']").val());
        $.ajax({
            url: '${pageContext.request.contextPath}/grade/assign',
            type: 'post',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify(data),
            beforeSend: function () {
                if (value1 + value2 + value3 + value4 != 100) {
                    $.alert("分配数额为100,请重新分配!");
                    return false;
                }
            },
            success: function (result) {
                $.alert(result.msg);
                if (result.code == 0) {
                    table.bootstrapTable("refresh");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
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

    //自定义查询
    function checkData() {
        var specialtyId = table_specialty_select.val();
        var courseId = table_course_select.val();
        if (courseId == '' || specialtyId == '') {
            $.alert("请填写课程和专业：)");
            return false;
        }
        table.bootstrapTable('refresh', {url: "${pageContext.request.contextPath}/grade/" + specialtyId + "/" + courseId});
    }

    //全部数据
    function checkAllData() {
        table.bootstrapTable('refresh', {url: "${pageContext.request.contextPath}/grade/list"});
    }

    //预加载
    $(function () {
        course_select.select2();
        specialty_select.select2();
        table_specialty_select.select2();
        table_course_select.select2();

        //课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                course_select.select2({
                    data: data
                });
                table_course_select.select2({
                    data: data
                });
            }
        });
        //联级：选择课程后筛选出修这门课的专业
        course_select.on("select2:select", function (e) {
            var courseId = course_select.val();
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
        table_course_select.on("select2:select", function (e) {
            var courseId = table_course_select.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/specialty/' + courseId,
                dataType: 'json',
                success: function (data) {
                    table_specialty_select.empty();
                    table_specialty_select.select2({
                        data: data
                    });
                }
            });
        })
    });

    //样式
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
</script>
<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle !important;
    }
</style>