<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/6/3
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">附加题评分</li>
    </ol>
    <div class="row-fluid">
        <div class="col-md-4">
            <form method="post" action="#">
                <label>请选择 <strong style="color: #985f0d">课程</strong>：
                    <select name="courseId" id="course_select"
                            style="width: 200px">
                        <option selected></option>
                    </select>
                </label>
                <label>请选择 <strong style="color: #985f0d">专业</strong>：
                    <select id="specialty_select" name="specialtyId"
                            style="width: 200px"></select>
                </label><br>
                <button class="btn btn-warning" type="button"
                        onclick="selectStudent()">查询
                </button>
            </form>
            <%--学生信息列--%>
            <div id="student_info">
            </div>
        </div>
        <div class="col-md-8">
            <div id="student_detail"></div>
        </div>
    </div>
</div>
<%--modal--%>

<script>
    var course_select = $('#course_select');
    var specialty_select = $('#specialty_select');

    //上传成绩
    function submitStudentScore() {
        var courseId = $('#info_one').val();
        var studentId = $('#info_second').val();
        var score = $('#info_third').val();
        $.ajax({
            url: '${pageContext.request.contextPath}/grade/' + studentId + "/" + courseId + "/" + score,
            type: 'post',
            dataType: 'json',
            beforeSend: function () {
                if (score == '') {
                    $.alert("请确认已填写学生信息！");
                    return false;
                }
            },
            success: function (result) {
                $.alert(result.msg);
                if (result.code == 0) {
                    if (score > 100) {
                        $('#score').val(100);
                    } else if (score < 0) {
                        $('#score').val(0);
                    } else {
                        $('#score').val(score);
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
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

    //显示并评估
    function assessStudent(content) {
        $.ajax({
            url: '${pageContext.request.contextPath}/grade/another/' + content,
            type: 'post',
            dataType: 'json',
            success: function (data) {
                var studentResult = $('#student_detail');
                studentResult.html('');

                var html = '';
                html = '<a>题号：</a>' + data.id + '<br><br>' + '<a>个人信息：</a><br><br>' + data.courseName + ' / '
                    + data.specialtyName + ' / ' + data.studentName + '<br><br>';
                html += '课程编号：<input id="info_one" name="courseId" readonly value="' + data.courseId + '">';
                html += '学生学号：<input id="info_second" name="studentId" readonly value="' + data.studentId + '"><br><br>';
                html += '<a>题目正文：</a><br><br>';
                html += data.content + '<br><br>';
                html += '<a>标准答案：</a><br><br>';
                html += data.result + '<br><br>';
                html += '<a>学生答案：</a><br><br>';
                html += data.studentAnswer + '<br><br>';
                html += '<a>学生附加题成绩：</a>';
                html += '<input id="score" readonly value="' + data.score + '"><br><br>';
                html += '<a>打分：</a>' + '<input onkeyup="checkScore()" id="info_third" name="score" placeholder="请输入0-100的整数"><br><br>';
                html += '<a style="color: #985f0d">注：学生若有附加题成绩，则不必再评分！如若附加题成绩为0分，则未为其评分！</a><br><br>';
                html += '<button type="button" onclick="submitStudentScore()">上传成绩</button>';

                studentResult.html(html);
            }
        });
    }

    //判断是否是数字
    function checkScore() {
        var score = $('#info_third').val();
        if (isNaN(score)) {
            $('#info_third').val('');
        }
    }

    //查询学生信息
    function selectStudent() {
        var course = course_select.val();
        var specialty = specialty_select.val();
        $.ajax({
            url: '${pageContext.request.contextPath}/grade/' + course + "/" + specialty + "/another",
            dataType: 'json',
            beforeSend: function () {
                if (course == '' || course == '') {
                    $.alert("请选择所教课程及其专业!");
                    return false;
                }
            },
            success: function (result) {
                var studentInfo = $('#student_info');
                studentInfo.html('');
                var html = '';
                for (x in result.data) {
                    html += '<a>题号：</a>' + result.data[x].id + ' <a>个人信息：</a>' + result.data[x].specialtyName
                        + ' / ' + result.data[x].courseName + ' / ' + result.data[x].studentName;
                    html += '   <a href="javascript:void(0);" onclick="assessStudent(\'{0}\')">查看</a>'.replace('{0}',
                        result.data[x].id + '&' + result.data[x].courseId + '&' + result.data[x].studentId);
                    html += '<br><br>';
                }
                studentInfo.html(html);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
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

    //预加载数据
    $(function () {
        specialty_select.select2();
        course_select.select2();
        //课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                course_select.select2({
                    data: data
                });
            }
        });
        //联级：选择课程后筛选出修这门课的专业
        $('#course_select').on("select2:select", function (e) {
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
    })
</script>
<style>
    input {
        border-left: 0px;
        border-top: 0px;
        border-right: 0px;
        border-bottom: 1px
    }
</style>