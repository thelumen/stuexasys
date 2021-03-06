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
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                });
            }
            window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
            window.history.forward(1);

            var examInfo =${testPaper.anotherQuestionTaken.courseId};
            examInfo += "_";
            examInfo +=${testPaper.anotherQuestionTaken.id};
            examInfo += "_";
            examInfo += '${testPaper.courseName}';
            document.getElementById("hideArea").value = examInfo;
            //加载上次提交到数据库的答案
            <c:if test="${ !empty testPaper.anotherQuestionTaken.result}">
            var studentLastAnswer = "${testPaper.anotherQuestionTaken.result}";
            $("#studentResult").val(studentLastAnswer);
            </c:if>

            //计时器实现
            var timeS = 1800;//测试时间,单位秒
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
                $.confirm({
                    title: "",
                    content: "确定要提交吗?",
                    animation: 'left',
                    backgroundDismiss: true,
                    closeAnimation: 'rotateX',
                    type: 'purple',
                    buttons: {
                        ok: {
                            text: "ok!",
                            theme: 'dark',
                            btnClass: 'btn-primary',
                            keys: ['enter'],
                            action: function () {
                                submitTest();
                            }
                        },
                        cancel: function () {
                        }
                    }
                });
            });

            //提交到服务器
            function submitTest() {
                clearInterval(setI);
                var QuestionId = $("#hideArea").val().split("_");
                var result = $("#studentResult").val();
                var gradeInfo = {
                    'id': QuestionId[1],
                    'courseId': QuestionId[0],
                    'result': result,
                    'testNum': '4',
                    'courseName': QuestionId[2]
                };
                var jsonData = JSON.stringify(gradeInfo);
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/student/uploadGrade',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: jsonData,
                    success: function (data) {
                        if (data.issuccess) {
                            $.confirm({
                                title: "提交成功!",
                                content: "点击确定跳转到个人信息页:)",
                                animation: 'right',
                                closeAnimation: 'rotateX',
                                type: 'purple',
                                buttons: {
                                    ok: {
                                        text: "ok!",
                                        theme: 'dark',
                                        btnClass: 'btn-primary',
                                        keys: ['enter'],
                                        action: function () {
                                            window.location.href = ('${pageContext.request.contextPath}/student/info');
                                        }
                                    }
                                }
                            });
                        } else {
                            $.alert({
                                title: "提交失败！",
                                content: "请向老师反映:(",
                                backgroundDismiss: true
                            });
                        }
                    }
                })
            }
        })
    </script>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/sea.jpg);background-attachment: fixed">
<%@include file="/student/nav/nav.jsp" %>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="jumbotron" style="background: #BCD2EE">
                <c:if test="${empty testPaper}">
                    <script>
                        swal({
                            title: "组题失败",
                            text: "请向教师反映题库内对应题目数不足",
                            type: "error",
                            showCancelButton: false,
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "好的，我这就去",
                            closeOnConfirm: false,
                            showLoaderOnConfirm: true
                        }, function () {
                            window.location.href = ('${pageContext.request.contextPath}/student/exam');
                        });
                    </script>
                </c:if>
                <h4 id="countDownTxt">测试剩余时间:</h4>
                <P>${testPaper.anotherQuestionTaken.content}</P>
                <div class="form-group">
                    <p><textarea class="form-control" rows="5"
                                 placeholder="填写相关答案:"
                                 name="anotherResult"
                                 id="studentResult"></textarea></p>
                    <button class="btn btn-primary" type="button"
                            id="submitTestPaper">
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
