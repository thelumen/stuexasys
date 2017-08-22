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
    <jsp:include page="/common/inc/head.jsp"></jsp:include>
    <script>
        $(document).ready(function () {
            var ans = '${testPaper.singleTakenList[0].courseId},';
            <c:forEach items="${testPaper.singleTakenList}" var="Ans">
            ans += '${Ans.result},';
            </c:forEach>
            <c:forEach items="${testPaper.tfTakenList}" var="Ant">
            ans += '${Ant.result},';
            </c:forEach>
            ans+='${testPaper.testNum},';
            document.getElementById("hideArea").value = ans;
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
                var an = $("#hideArea").val().split(",");
                var i = 1;
                var testRight=0;
                $('input:radio:checked').each(function () {
                    var checkValue = $(this).val();
                    if (an[i] === checkValue) {
                        alert("正确");
                        testRight++;
                    }else alert("错误");
                    i++;
//                    console.log($(this).val());　　// 选中框中的值
                });
                var grade=testRight*4;
                var gradeInfo = {'courseId': an[0],'grade':grade,'testNum':an[26]};
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
            <h4 id="countDownTxt"></h4>
            <form id="testForm">
                <h2>一，选择题（共20题）</h2>
                <c:forEach items="${testPaper.singleTakenList}" var="testPaperSingle" varStatus="statusSingle">
                    <p style="word-break: break-all">${statusSingle.count}.${testPaperSingle.name}</p>
                    <p><label>A.<input type="radio" name="single-${statusSingle.count}"
                                       value="1">${testPaperSingle.que1}</label></p>
                    <p><label>B.<input type="radio" name="single-${statusSingle.count}"
                                       value="2">${testPaperSingle.que2}</label></p>
                    <p><label>C.<input type="radio" name="single-${statusSingle.count}"
                                       value="3">${testPaperSingle.que3}</label></p>
                    <p><label>D.<input type="radio" name="single-${statusSingle.count}"
                                       value="4">${testPaperSingle.que4}</label></p>
                    <hr>
                </c:forEach>
                <h2>二，判断题（共5题）</h2>
                <c:forEach items="${testPaper.tfTakenList}" var="testPaperTf" varStatus="statusTf">
                    <p style="word-break: break-all">${statusTf.count}.${testPaperTf.name}</p>
                    <p><label><input type="radio" name="tf-${statusTf.count}" value="1">正确</label></p>
                    <p><label><input type="radio" name="tf-${statusTf.count}" value="2">错误</label></p>
                    <hr>
                </c:forEach>
                <button type="button" id="submitTestPaper" class="btn btn-primary">
                    <label>提交试卷</label>
                </button>
            </form>
            <input id="hideArea" type="hidden">
        </div>
    </div>
</div>
</body>
</html>