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
            var courseId=${testPaper.anotherQuestionTaken.courseId};
            document.getElementById("hideArea").value = courseId;
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
                var an = $("#hideArea").val();
                var result = $("#studentResult").val();
                var gradeInfo = {'courseId': an,'result':result,'testNum':'4'};
                var jsonData = JSON.stringify(gradeInfo);
                $.ajax({
                    type:'post',
                    url:'${pageContext.request.contextPath}/student/uploadGrade',
                    dataType:'json',
                    contentType: 'application/json',
                    data:jsonData,
                    success:function (data) {
                        if (data.issuccess){
                            alert("提交成功");
                        }else alert("提交失败");
                    }
                })
            }
        })
    </script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navber-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">学生考试系统</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/student/main">学生考试系统</a><%--导航栏大标题--%>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"><%--导航栏左侧--%>
            <ul class="nav navbar-nav navbar-right">
                <%--导航栏右侧 通过类选择器动态展示用户状态--%>
                <li class="dropdown">
                    <a class="dropdown-toggle" href="#" data-toggle="dropdown"
                       id="navDropdown">${studentInfo.name}<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li><a href='${pageContext.request.contextPath}/student/personPage'>个人信息</a></li>
                        <li><a href='${pageContext.request.contextPath}/student/exam'>测试</a></li>
                        <li><a href='${pageContext.request.contextPath}/student/resourcesDownload'>资源下载</a></li>
                        <li role='separator' class='divider'></li>
                        <li><a href="javascript:void(0);" onclick="logout();">登出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<hr>
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
                    </button><label id="countDownTxt"></label>
                </div>
                <input id="hideArea" type="hidden">
            </div>
        </div>
    </div>
</div>
</body>
</html>
