<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/5/31
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>资源下载</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%@include file="/common/inc/head.jsp" %>
</head>
<body style="background: url(${pageContext.request.contextPath}/common/image/sea.jpg;);background-attachment: fixed;">
<%@include file="/student/nav/nav.jsp" %>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <c:if test="${empty resourceInfo}">
                <div class="panel-group" id="panel-964917">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <a class="panel-title" href="#t1"
                               data-toggle="collapse">课程名</a>
                        </div>
                        <div class="panel-collapse in" id="t1">
                            <div class="panel-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <p>资源名</p>
                                        </div>
                                        <div class="col-md-5">
                                            <p>更新时间</p>
                                        </div>
                                        <div class="col-md-4">
                                            <a href="#">下载链接</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${!empty resourceInfo}">
            <div class="panel-group" id="panelParent">
                <c:forEach var="Info" items="${resourceInfo}"
                           varStatus="statue">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#panelParent"
                               href="#${statue.count}">${Info.directoryName}</a>
                        </h4>
                    </div>
                    <c:if test="${statue.first}">
                    <div class="panel-collapse collapse in" id=${statue.count}>
                        </c:if>
                        <c:if test="${!statue.first}">
                        <div class="panel-collapse collapse" id=${statue.count}>
                            </c:if>
                            <c:forEach items="${Info.directory}" var="FileInfo">
                                <div class="panel-body"
                                     style="background: #BCD2EE">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-5">
                                                <p>${FileInfo.fileName}</p>
                                            </div>
                                            <div class="col-md-3">
                                                <p>${FileInfo.nowDate}</p>
                                            </div>
                                            <div class="col-md-4">
                                                <a href="${pageContext.request.contextPath}/student/resource/${FileInfo.path}">下载链接</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>