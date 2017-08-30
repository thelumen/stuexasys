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
        <div class="span4">
            <form id="teacher_another_form" method="post" action="#">
                <label>请选择 <strong style="color: #985f0d">课程</strong>：<select
                        name="courseId" id="teacher_another_select_course"
                        style="width: 200px">
                    <option selected></option>
                </select></label>
                <label>请选择 <strong style="color: #985f0d">专业</strong>：
                    <select id="teacher_another_select_specialty"
                            name="specialtyId"
                            style="width: 200px"></select></label><br>
                <button style="margin-left: 30px" class="btn btn-warning"
                        type="button" onclick="selectStudent()">查询
                </button>
            </form>
            <%--学生信息列--%>
            <div id="teacher_another_student_info">
            </div>
        </div>
        <div class="span8">
            <div id="teacher_another_student_result"></div>
        </div>
    </div>
</div>
<%--modal--%>

<script>
    var course = $('#teacher_another_select_course');
    var specialty = $('#teacher_another_select_specialty');
    function submitStudentScore() {
        var courseId = $('#info_one').val();
        var studentId = $('#info_second').val();
        var score = $('#info_third').val();
        $.ajax({
            url: '${pageContext.request.contextPath}/grade/' + studentId + "/" + courseId + "/" + score,
            type: 'post',
            dataType: 'json',
            success: function (data) {
                if (data === true) {
                    alert("成绩录入成功!");
                } else {
                    alert("更新成绩出错！");
                }
            },
            error: function () {
                alert("系统出错！");
            }
        });
//        alert(courseId + "&" + studentId + "&" + score);
    }
    //显示并评估
    function assessStudent(content) {
        $.ajax({
            url: '${pageContext.request.contextPath}/grade/another/' + content,
            type: 'post',
            dataType: 'json',
            success: function (data) {
                var studentResult = $('#teacher_another_student_result');
                studentResult.html('');

                var html = '';

                html = '<a>题号：</a>' + data.id + '<br><br>' + '<a>个人信息：</a>' + data.courseName + ' / ' + data.specialtyName + ' / ' + data.studentName + '<br><br>';
                html += '<input id="info_one" name="courseId" value="' + data.courseId + '">';
                html += '<input id="info_second" name="studentId" value="' + data.studentId + '">';
                html += '<a>题目正文：</a><br><br>';
                html += data.content + '<br><br>';
                html += '<a>标准答案：</a><br><br>';
                html += data.result + '<br><br>';
                html += '<a>学生答案：</a><br><br>';
                html += data.studentAnswer + '<br><br>';
                html += '<a>学生附加题成绩：</a>' + data.score + '<br><br>';
                html += '<a>打分：</a>' + '<input onkeyup="checkScore()" id="info_third" name="score" placeholder="请输入0-100的整数"><br><br>';
                html += '<a style="color: #985f0d">注：学生若有附加题成绩，则不必再评分！如若附加题成绩为0分，则未为其评分！</a><br><br>';
                html += '<button type="button" onclick="submitStudentScore()">上传成绩</button>';

                studentResult.html(html);
            }
        });
    }
    function checkScore() {
        var score = $('#info_third').val();
        if (isNaN(score)) {
            $('#info_third').val('');
        }
    }
    //查询附加题考察专业学生信息，左下
    function selectStudent() {
        if (course.val() !== '' && specialty.val() !== '') {
            $.ajax({
                url: '${pageContext.request.contextPath}/grade/' + course.val() + "/" + specialty.val() + "/another",
                dataType: 'json',
                success: function (data) {
                    var studentInfo = $('#teacher_another_student_info');
                    studentInfo.html('');
                    var html = '';
                    for (x in data) {
                        html += '<a>题号：</a>' + data[x].id + ' <a>个人信息：</a>' + data[x].specialtyName + ' / ' + data[x].courseName + ' / ' + data[x].studentName;
                        html += '   <a href="javascript:void(0);" onclick="assessStudent(\'{0}\')">查看</a>'.replace('{0}', data[x].id + '&' + data[x].courseId + '&' + data[x].studentId);
                        html += '<br><br>';
                    }
                    studentInfo.html(html);
                },
                error: function () {
                    alert("无数据");
                }
            });
        } else {
            swal("oh..", "请选择所教课程及其专业！", "error");
        }
    }
    $(function () {
        //        预加载数据
        $('#teacher_another_select_specialty').select2();
        $('#teacher_another_select_course').select2();
        //        课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                $('#teacher_another_select_course').select2({
                    data: data
                });
            }
        });
        //        联级：选择课程后筛选出修这门课的专业
        $('#teacher_another_select_course').on("select2:select", function (e) {
            var courseId = $('#teacher_another_select_course').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/course/specialties/' + courseId,
                dataType: 'json',
                success: function (data) {
                    var choS = $('#teacher_another_select_specialty');
                    choS.empty();
                    choS.select2({
                        data: data
                    });
                }
            });
        });
    })
</script>