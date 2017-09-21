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
    <%@include file="/common/inc/bootstrap-judge.jsp" %>
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
                <c:forEach items="${testPaper.singleTakenList}" var="testPaperSingle" varStatus="statusSingle">
                    <p style="word-break: break-all">
                        &nbsp;&nbsp;&nbsp;&nbsp;${statusSingle.count}.${testPaperSingle.content}</p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.
                            <input type="radio" name="single-${statusSingle.count}" value="A">${testPaperSingle.que1}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.
                            <input type="radio" name="single-${statusSingle.count}" value="B">${testPaperSingle.que2}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.
                            <input type="radio" name="single-${statusSingle.count}" value="C">${testPaperSingle.que3}
                        </label>
                    </p>
                    <p>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.
                            <input type="radio" name="single-${statusSingle.count}" value="D">${testPaperSingle.que4}
                        </label>
                    </p>
                    <p hidden>
                        <label>
                            <input type="radio" value="E" checked>
                        </label>
                    </p>
                    <hr>
                </c:forEach>
                <h2>&nbsp;&nbsp;二，判断题（共5题）</h2>
                <c:forEach items="${testPaper.tfTakenList}" var="testPaperTf" varStatus="statusTf">
                    <p style="word-break: break-all">
                        &nbsp;&nbsp;&nbsp;&nbsp;${statusTf.count}.${testPaperTf.content}</p>
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
                    <p hidden>
                        <label>
                            <input type="radio" value="3" checked>
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
