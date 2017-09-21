<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/9/21
  Time: 18:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        document.getElementById("hideArea").value = ans;

        alert($("#hideArea").val());

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
            clearInterval(setI);//结束计时器
            var an = $("#hideArea").val().split(",");
            var i = 1;//迭代器
            var single = 0;//选择题正确数
            var tf = 0;//判断题正确数
            var testRight = 0;//正确数
            $('input:radio:checked').each(function () {
                var checkValue = $(this).val();
                if (i <= 20) {
                    var realAnS;
                    if (an[i] % 5 === 0) {
                        realAnS = "A";
                    } else if (an[i] % 5 === 1) {
                        realAnS = "B";
                    } else if (an[i] % 5 === 2) {
                        realAnS = "C";
                    } else if (an[i] % 5 === 3) {
                        realAnS = "D";
                    }
                    if (realAnS === checkValue) {
                        testRight++;
                        single++;
                    }
                } else {
                    var realAnT;
                    if (an[i] % 3 === 1) {
                        realAnT = "1";
                    } else if (an[i] % 3 === 2) {
                        realAnT = "2";
                    }
                    if (realAnT === checkValue) {
                        testRight++;
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