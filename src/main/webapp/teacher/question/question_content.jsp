<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/6/5
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">题目录入</li>
    </ol>

    <div class="row-fluid">
        <div class="span4">
            <ul class="nav nav-tabs nav-stacked" data-spy="affix"
                data-offset-top="125">
                <li><a href="#section-1">选择题录入</a></li>
                <li><a href="#section-2">简答题录入</a></li>
            </ul>
        </div>
        <div class="span8">
            <h2 id="section-1" style="text-align: center">选择题</h2>
            <div style="text-align: center">
                <form id="teacher_question_single_form">
                    <label>请选择<strong style="color: #985f0d">学科</strong>
                        <select name="courseId" required style="width: 250px"
                                id="teacher_question_single_select_course"
                                title="Please select a course ...">
                            <option selected></option>
                        </select></label><br>
                    <label>请选择<strong style="color: #985f0d">章节</strong>
                        <select name="section" required style="width: 250px"
                                id="teacher_question_single_select_chapter"
                                title="Please select a section ...">
                        </select></label><br>
                    <label>请选择<strong style="color: #985f0d">难度系数</strong>
                        <select name="levels" required style="width: 100px"
                                id="teacher_question_single_select_level"
                                title="Please select a section ...">
                            <option value="1">简单</option>
                            <option value="2">中等</option>
                            <option value="3">困难</option>
                        </select></label><br>
                    <label>请输入题目正文：</label><br>
                    <label><textarea name="content" required
                                     style="resize:none;height: 100px;width: 800px"
                                     placeholder="请输入选择题正文..."></textarea></label><br>
                    <label>请输入以下选项内容</label><br>
                    <label>A： <input name="que1" required style="width: 600px"></label><br>
                    <label>B： <input name="que2" required style="width: 600px"></label><br>
                    <label>C： <input name="que3" required style="width: 600px"></label><br>
                    <label>D： <input name="que4" required style="width: 600px"></label><br>
                    <label>请选择正确答案</label>
                    <label><select name="result" required style="width: 100px"
                                   id="teacher_question_single_select_result"
                                   title="Please select a section ...">
                        <option>A</option>
                        <option>B</option>
                        <option>C</option>
                        <option>D</option>
                    </select></label><br>
                    <label>
                        <button type="button" class="btn btn-primary"
                                onclick="saveSingleQuestion()">提交
                        </button>
                    </label>
                </form>
            </div>
            <h2 id="section-2" style="text-align: center">判断题</h2>
        </div>
    </div>

</div>
<script>
    var course = $('#teacher_question_single_select_course');
    var section = $('#teacher_question_single_select_chapter');
    //    保存选择题
    function saveSingleQuestion() {
        var textarea = $("[name='content']").val();
        var que1 = $("[name='que1']").val();
        var que2 = $("[name='que2']").val();
        var que3 = $("[name='que3']").val();
        var que4 = $("[name='que4']").val();
        if (course.val() !== '' && section.val() !== '' && textarea !== '' && que1 !== '' && que2 !== '' && que3 !== '' && que4 !== '') {
            var formdata = $('#teacher_question_single_form').serializeObject();
            var data = JSON.stringify(formdata);
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/saveSingleQuestion',
                data: data,
                dataType: 'json',
                type: 'post',
                contentType: 'application/json',
                success: function (data) {
                    if (data.isSuccess) {
                        swal("year..", "录入成功！", "success");
                        $("[name='content']").val('');
                        $("[name='que1']").val('');
                        $("[name='que2']").val('');
                        $("[name='que3']").val('');
                        $("[name='que4']").val('');
                    }
                },
                error: function () {
                    swal("ERROR", "系统出错！", "error");
                }
            });
        } else {
            swal("look..", "请完整填写题目内容！", "error");
        }
    }
    $(function () {
//        预加载
        section.select2();
        $('#teacher_question_single_select_result').select2();
        $('#teacher_question_single_select_level').select2();
        //课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourse',
            dataType: 'json',
            success: function (data) {
                course.select2({
                    data: data
                });
            }
        });
        //联级：选择课程后展示该课程题库章节
        course.on("select2:select", function (e) {
            var courseId = course.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/' + courseId + '/chapter',
                dataType: 'json',
                success: function (data) {
                    section.empty();
                    section.select2({
                        data: data
                    });
                }
            });
        });
    });
</script>
<style>
    ul.nav-tabs {
        width: 140px;
        margin-top: 20px;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
    }

    ul.nav-tabs li {
        margin: 0;
        border-top: 1px solid #ddd;
    }

    ul.nav-tabs li:first-child {
        border-top: none;
    }

    ul.nav-tabs li a {
        margin: 0;
        padding: 8px 16px;
        border-radius: 0;
    }

    ul.nav-tabs li.active a, ul.nav-tabs li.active a:hover {
        color: #fff;
        background: #0088cc;
        border: 1px solid #0088cc;
    }

    ul.nav-tabs li:first-child a {
        border-radius: 4px 4px 0 0;
    }

    ul.nav-tabs li:last-child a {
        border-radius: 0 0 4px 4px;
    }

    ul.nav-tabs.affix {
        top: 50px;
    }
</style>