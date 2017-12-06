<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/6/11
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试</title>
    <%@include file="/common/inc/head.jsp" %>
    <script>
        $(function () {
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                });
            }
            window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
            window.history.forward(1);

            var ans = '${testPaper.singleTakenList[0].courseId},';
            <c:forEach items="${testPaper.singleTakenList}" var="Ans">
            ans += '${Ans.result},';
            </c:forEach>
            <c:forEach items="${testPaper.tfTakenList}" var="Ant">
            ans += '${Ant.result},';
            </c:forEach>
            ans += '${testPaper.testNum},';
            ans += '${testPaper.courseName},';
            document.getElementById("hideArea").value = ans;

//        alert($("#hideArea").val());

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
                $("#countDownTxt").text(m);
                if (timeS === 0) {
                    clearInterval(setI);//结束计时器
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
                                clearInterval(setI);//结束计时器
                                submitTest();
                            }
                        },
                        cancel: function () {
                        }
                    }
                });
            });
        });

        //提交到服务器
        function submitTest() {
            var an = $("#hideArea").val().split(",");
            var stuResult = "";
            $('input:radio:checked').each(function () {
                var checkValue = $(this).val();
                stuResult += checkValue;
                stuResult += ",";
//                console.log($(this).val());　　// 选中框中的值
            });
            var gradeInfo = {
                'courseId': an[0],
                'answer': an,
                'testNum': an[26],
                'result': stuResult,
                'courseName': an[27]
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
                            title: "得分" + data.grade,
                            content: "选择题:" + data.single + "/20 " + "判断:" + data.tf + "/5",
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
                    } else if (data.overtime) {
                        $.alert({
                            title: "提交失败！",
                            content: "教师已关闭考试:(",
                            backgroundDismiss: true
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
    </script>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/sea.jpg);background-attachment: fixed">
<%@include file="/student/nav/nav.jsp" %>
<br>
<div class="container" style="background: #BCD2EE">
    <div class="row">
        <div class="col-md-12">
            <h4>&nbsp;&nbsp;&nbsp;&nbsp;测试剩余时间:<label id="countDownTxt"></label>
            </h4>
            <form id="testForm">
                <h2>&nbsp;&nbsp;一，选择题（共20题）</h2>
                <hr>
                <c:if test="${empty testPaper}">
                    <script>
                        $.confirm({
                            title: "组题失败:(",
                            content: "请向教师反映题库内对应题目数不足..",
                            animation: 'right',
                            closeAnimation: 'rotateX',
                            type: 'red',
                            buttons: {
                                ok: {
                                    text: "ok!",
                                    theme: 'dark',
                                    btnClass: 'btn-primary',
                                    keys: ['enter'],
                                    action: function () {
                                        location.href = ('${pageContext.request.contextPath}/student/exam');
                                    }
                                }
                            }
                        });
                    </script>
                </c:if>
                <c:forEach items="${testPaper.singleTakenList}"
                           var="testPaperSingle" varStatus="statusSingle">
                    <p style="word-break: break-all">
                        &nbsp;&nbsp;&nbsp;&nbsp;${statusSingle.count}.${testPaperSingle.content}</p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.
                            <input type="radio"
                                   name="single-${statusSingle.count}"
                                   value="A">${testPaperSingle.que1}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.
                            <input type="radio"
                                   name="single-${statusSingle.count}"
                                   value="B">${testPaperSingle.que2}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.
                            <input type="radio"
                                   name="single-${statusSingle.count}"
                                   value="C">${testPaperSingle.que3}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.
                            <input type="radio"
                                   name="single-${statusSingle.count}"
                                   value="D">${testPaperSingle.que4}
                        </label>
                    </p>
                    <p hidden>
                        <label>
                            <input type="radio"
                                   name="single-${statusSingle.count}"
                                   value="未作答" checked>
                        </label>
                    </p>
                    <hr>
                </c:forEach>
                <h2>&nbsp;&nbsp;二，判断题（共5题）</h2>
                <c:forEach items="${testPaper.tfTakenList}" var="testPaperTf"
                           varStatus="statusTf">
                    <p style="word-break: break-all">
                        &nbsp;&nbsp;&nbsp;&nbsp;${statusTf.count}.${testPaperTf.content}</p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="tf-${statusTf.count}"
                                   value="正确">正确
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="tf-${statusTf.count}"
                                   value="错误">错误
                        </label>
                    </p>
                    <p hidden>
                        <label>
                            <input type="radio" name="tf-${statusTf.count}"
                                   value="未作答" checked>
                        </label>
                    </p>
                    <hr>
                </c:forEach>
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="button" id="submitTestPaper"
                            class="btn btn-primary">
                        <label>提交试卷</label>
                    </button>
                </p>
            </form>
            <input id="hideArea" type="hidden">
        </div>
    </div>
</div>
</body>
</html>
