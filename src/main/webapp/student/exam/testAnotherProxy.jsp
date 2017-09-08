<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/6/18
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生测试</title>
    <%@include file="/common/inc/head.jsp" %>
    <script>
        $(document).ready(function () {
            var examInfo =${testPaper.anotherQuestionTaken.courseId};
            examInfo += "_";
            examInfo +=${testPaper.anotherQuestionTaken.id};
            document.getElementById("hideArea").value = examInfo;
            //加载上次提交到数据库的答案
            <c:if test="${ !empty testPaper.anotherQuestionTaken.result}">
            var studentLastAnswer = "${testPaper.anotherQuestionTaken.result}";
            $("#studentResult").val(studentLastAnswer);
            </c:if>

//            alert($("#hideArea").val());

            //计时器实现
            var timeS = 40;//总时间，单位:秒
            var setI = setInterval(countDown, 1000);

            function countDown() {
                timeS = timeS - 1;
                var m = Math.floor(timeS / 60);
                var s = timeS % 60;
                if (s < 10) {
                    s = '0' + s;
                }
                m += ':';
                m += s;
                $("#countDownTxt").text("测试剩余时间:" + m);
                if (timeS === 0) {
                    submitTest();
                }
            }

            //提交按钮
            $("#submitTestPaper").click(function () {
                swal({
                    title: "确定要提交吗？",
                    text: "",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "提交",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true
                }, function () {
                    submitTest();
                });
            });

            //提交到服务器
            function submitTest() {
                clearInterval(setI);
                var QuestionId = $("#hideArea").val().split("_");
                var result = $("#studentResult").val();
                var gradeInfo = {'id': QuestionId[1], 'courseId': QuestionId[0], 'result': result, 'testNum': '4'};
                var jsonData = JSON.stringify(gradeInfo);
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/student/uploadGrade',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: jsonData,
                    success: function (data) {
                        if (data.issuccess) {
                            swal({
                                title: "提交成功",
                                text: "点击确定跳转到个人信息页",
                                type: "success",
                                showCancelButton: false,
                                confirmButtonColor: "#DD6B55",
                                confirmButtonText: "确定",
                                closeOnConfirm: false,
                                showLoaderOnConfirm: true
                            }, function () {
                                window.location.href = ('${pageContext.request.contextPath}/student/personPage');
                            });
                        } else swal("提交失败", "请向老师反映", "error");
                    }
                })
            }
        })
    </script>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/bg-蓝色科技.png)">
<%@include file="/student/nav/nav.jsp" %>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="jumbotron" style="background: #BCD2EE">
                <h4 id="countDownTxt">测试剩余时间:</h4>
                <P>${testPaper.anotherQuestionTaken.content}</P>
                <div class="form-group">
                    <p><textarea class="form-control" rows="5" placeholder="填写相关答案:"
                                 name="anotherResult" id="studentResult"></textarea></p>
                    <button class="btn btn-primary" type="button" id="submitTestPaper">
                        提交答案
                    </button>
                </div>
                <input id="hideArea" type="hidden">
            </div>
        </div>
    </div>
</div>
</body>
</html>
