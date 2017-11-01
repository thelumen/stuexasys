<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fum" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/5/31
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生测试</title>
    <%@include file="/common/inc/head.jsp" %>
    <script>
        $(function () {
            $("button.btn-success").click(function () {
                var rows = this.value;
                var s = rows.split("_");
                var testNum = 0;
                if (s[2] === "测试一") {
                    testNum = 1;
                } else if (s[2] === "测试二") {
                    testNum = 2;
                } else if (s[2] === "测试三") {
                    testNum = 3;
                } else testNum = 4;
                var examInfo = {"courseId": s[0], "content": s[1], "testNum": testNum,"courseName":s[3]};
                var jsonDate = JSON.stringify(examInfo);
                var myUrl = '${pageContext.request.contextPath}/student/test/ready';
                $.ajax({
                    type: 'post',
                    url: myUrl,
                    dataType: 'json',
                    contentType: 'application/json',
                    data: jsonDate,
                    success: function (data) {
                        if (data.generalTest) {
                            <%--window.open('${pageContext.request.contextPath}/student/test/start/' + data.examInfo);--%>
                            window.location.href = '${pageContext.request.contextPath}/student/test/start/' + data.examInfo;
                        } else window.location.href = '${pageContext.request.contextPath}/student/test/startAnother/' + data.examInfo;
                    }
                });
            })
        })
    </script>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/bg-蓝色科技.png)">
<%@include file="/student/nav/nav.jsp" %>
<br>
<div class="container" style="background: #BCD2EE">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover  table-responsive">
                <thead>
                <tr>
                    <th>课程名称</th>
                    <th>测试编号</th>
                    <th>测试章节</th>
                    <th>测试时间</th>
                    <th>考试信号</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty studentExamInfo}">
                    <c:forEach items="${studentExamInfo}" var="Info" varStatus="status">
                        <tr class="rowId">
                            <td>${Info.courseName}</td>
                            <td>${Info.testNum}</td>
                            <td>${Info.content}</td>
                            <td><fum:formatDate value="${Info.date}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:if test="${Info.test==1}">
                                    <button type="button" class="btn btn-success"
                                            value="${Info.courseId}_${Info.content}_${Info.testNum}_${Info.courseName}">
                                        <label>开始考试</label>
                                    </button>
                                </c:if>
                                <c:if test="${!(Info.test==1)}">
                                    <button type="button" class="btn btn-primary" disabled="disabled">
                                        <label>等待开始</label>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
