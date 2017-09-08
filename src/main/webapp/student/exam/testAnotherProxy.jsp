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
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
    <script>
        $(document).ready(function () {
            var examInfo =${testPaper.anotherQuestionTaken.courseId};
            examInfo += "_";
            examInfo +=${testPaper.anotherQuestionTaken.id};
            document.getElementById("hideArea").value = examInfo;
            <c:if test="${ !empty testPaper.anotherQuestionTaken.result}">
            var studentLastAnswer ="${testPaper.anotherQuestionTaken.result}";
            $("#studentResult").val(studentLastAnswer);
            </c:if>
            alert($("#hideArea").val());
            //计时器实现
            var timeS = 40;
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
                $("#countDownTxt").text(m);
                if (timeS === 0) {
                    submitTest();
                }
            }

            //提交按钮
            $("#submitTestPaper").click(function () {
                alert("确定要提交吗？");
                submitTest();
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
                            alert("提交成功");
                        } else alert("提交失败");
                        window.location.href = '${pageContext.request.contextPath}/student/exam';
                    }
                })
            }
        })
    </script>
</head>
<body>
<%@include file="/student/nav/nav.jsp"%>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="jumbotron">
                <P>${testPaper.anotherQuestionTaken.content}</P>
                <div class="form-group">
                    <p><textarea class="form-control" rows="5" placeholder="填写相关答案:"
                                 name="anotherResult" id="studentResult"></textarea></p>
                    <button class="btn btn-primary" type="button" id="submitTestPaper">
                        提交答案
                    </button>
                    <label id="countDownTxt"></label>
                </div>
                <input id="hideArea" type="hidden">
            </div>
        </div>
    </div>
</div>
</body>
</html>
