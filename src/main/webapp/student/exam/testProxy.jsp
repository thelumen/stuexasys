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
            var ans = '${testPaper.singleTakenList[0].courseId},';
            <c:forEach items="${testPaper.singleTakenList}" var="Ans">
            ans += '${Ans.result},';
            </c:forEach>
            <c:forEach items="${testPaper.tfTakenList}" var="Ant">
            ans += '${Ant.result},';
            </c:forEach>
            ans += '${testPaper.testNum},';
            document.getElementById("hideArea").value = ans;

//            alert($("#hideArea").val());

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
                var an = $("#hideArea").val().split(",");
                var i = 1;//迭代器
                var single = 0;//选择题正确数
                var tf = 0;//判断题正确数
                var testRight = 0;//正确数
                $('input:radio:checked').each(function () {
                    var checkValue = $(this).val();
                    if (an[i] === checkValue) {
                        testRight++;
                        if (i <= 20) {
                            single++;
                        } else {
                            tf++;
                        }
                    }
                    i++;
//                    console.log($(this).val());　　// 选中框中的值
                });
                var grade = testRight * 4;
                var gradeInfo = {'courseId': an[0], 'grade': grade, 'testNum': an[26]};
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
                                title: "得分" + grade,
                                text: "选择题:" + single + "/20  " + "判断:" + tf + "/5",
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
<div class="container" style="background: #BCD2EE">
    <div class="row">
        <div class="col-md-12">
            <h4>&nbsp;&nbsp;&nbsp;&nbsp;测试剩余时间:<label id="countDownTxt"></label></h4>
            <form id="testForm">
                <h2>&nbsp;&nbsp;一，选择题（共20题）</h2>
                <hr>
                <c:forEach items="${testPaper.singleTakenList}" var="testPaperSingle" varStatus="statusSingle">
                    <p style="word-break: break-all">
                        &nbsp;&nbsp;&nbsp;&nbsp;${statusSingle.count}.${testPaperSingle.content}</p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.
                            <input type="radio" name="single-${statusSingle.count}" value="1">${testPaperSingle.que1}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.
                            <input type="radio" name="single-${statusSingle.count}" value="2">${testPaperSingle.que2}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.
                            <input type="radio" name="single-${statusSingle.count}" value="3">${testPaperSingle.que3}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.
                            <input type="radio" name="single-${statusSingle.count}" value="4">${testPaperSingle.que4}
                        </label>
                    </p>
                    <hr>
                </c:forEach>
                <h2>&nbsp;&nbsp;二，判断题（共5题）</h2>
                <c:forEach items="${testPaper.tfTakenList}" var="testPaperTf" varStatus="statusTf">
                    <p style="word-break: break-all">&nbsp;&nbsp;&nbsp;&nbsp;${statusTf.count}.${testPaperTf.content}</p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="tf-${statusTf.count}" value="1">正确
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="tf-${statusTf.count}" value="2">错误
                        </label>
                    </p>
                    <hr>
                </c:forEach>
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="button" id="submitTestPaper" class="btn btn-primary">
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
