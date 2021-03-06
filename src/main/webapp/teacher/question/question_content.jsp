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
    <div class="col-md-5">
        <ul class="nav nav-tabs nav-stacked" data-spy="affix"
            data-offset-top="125">
            <li><a href="javascript:void (0);"
                   onclick="singlePart()">选择题</a></li>
            <li><a href="javascript:void (0);"
                   onclick="tfPart()">判断题</a></li>
            <li><a href="javascript:void (0);"
                   onclick="anoPart()"> 附加题</a></li>
        </ul>
    </div>
    <div class="col-md-7">
        <%--选择题--%>
        <div id="single_div" style="text-align: center">
            <h2 style="text-align: center">选择题</h2>
            <form id="single_form">
                <label>请选择<strong style="color: #985f0d">学科</strong>
                    <select name="courseId" required style="width: 250px"
                            id="single_select_course"
                            title="Please select a course ...">
                        <option selected></option>
                    </select></label><br>
                <label>请选择<strong style="color: #985f0d">章节</strong>
                    <select name="section" required style="width: 250px"
                            id="single_select_chapter"
                            title="Please select a section ...">
                    </select></label><br>
                <label>请选择<strong style="color: #985f0d">难度系数</strong>
                    <select name="levels" required style="width: 100px"
                            id="single_select_level"
                            title="Please select a section ...">
                        <option value="1">简单</option>
                        <option value="2">中等</option>
                        <option value="3">困难</option>
                    </select></label><br>
                <label>请输入题目正文：</label><br>
                <label><textarea id="single_content" name="content" required
                                 style="resize:none;height: 100px;width: 800px"
                                 placeholder="请输入选择题正文..."></textarea></label><br>
                <label>请输入以下选项内容</label><br>
                <label>A： <input name="que1" required
                                 style="width: 600px"></label><br>
                <label>B： <input name="que2" required
                                 style="width: 600px"></label><br>
                <label>C： <input name="que3" required
                                 style="width: 600px"></label><br>
                <label>D： <input name="que4" required
                                 style="width: 600px"></label><br>
                <label>请选择正确答案</label>
                <label><select name="result" required style="width: 100px"
                               id="single_select_result"
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
        <%--判断题--%>
        <div id="tf_div"
             style="display: none;text-align: center">
            <h2 id="section-2" style="text-align: center">判断题</h2>
            <form id="tf_form">
                <label>请选择<strong style="color: #985f0d">学科</strong>
                    <select name="courseId" required style="width: 250px"
                            id="tf_select_course"
                            title="Please select a course ...">
                        <option selected></option>
                    </select></label><br>
                <label>请选择<strong style="color: #985f0d">章节</strong>
                    <select name="section" required style="width: 250px"
                            id="tf_select_chapter"
                            title="Please select a section ...">
                    </select></label><br>
                <label>请选择<strong style="color: #985f0d">难度系数</strong>
                    <select name="levels" required style="width: 100px"
                            id="tf_select_level"
                            title="Please select a section ...">
                        <option value="1">简单</option>
                        <option value="2">中等</option>
                        <option value="3">困难</option>
                    </select></label><br>
                <label>请输入题目正文：</label><br>
                <label><textarea id="tf_content" name="content" required
                                 style="resize:none;height: 100px;width: 800px"
                                 placeholder="请输入判断题正文..."></textarea></label><br>
                <label>请选择正确选择：</label>
                <label><strong style="color: #985f0d">正确：</strong>
                    <input type="radio" name="result" checked
                           value="1"></label>
                <label><strong style="color: #2b542c">错误：</strong>
                    <input type="radio" name="result" value="0"></label><br>
                <label>
                    <button type="button" class="btn btn-primary"
                            onclick="saveTfQuestion()">提交
                    </button>
                </label>
            </form>
        </div>
        <%--附加题--%>
        <div id="another_div"
             style="display: none;text-align: center">
            <h2 style="text-align: center">附加题</h2>
            <form id="another_form">
                <label>请选择<strong style="color: #985f0d">学科</strong>
                    <select name="courseId" required style="width: 250px"
                            id="another_select_course"
                            title="Please select a course ...">
                        <option selected></option>
                    </select></label><br>
                <label>请输入题目正文：</label><br>
                <label><textarea id="ano_content" name="content" required
                                 style="resize:none;height: 100px;width: 800px"
                                 placeholder="请输入附加题正文..."></textarea></label><br>
                <label><textarea id="ano_result" name="result" required
                                 style="resize:none;height: 100px;width: 800px"
                                 placeholder="请输入标准答案..."></textarea></label><br>
                <button type="button" class="btn btn-primary"
                        onclick="saveAnother()">提交
                </button>
            </form>
        </div>
    </div>
</div>
<script>
    var course = $('#single_select_course');
    var tfcourse = $('#tf_select_course');
    var anocourse = $('#another_select_course');
    var section = $('#single_select_chapter');
    var tfsection = $('#tf_select_chapter');

    //    保存选择题
    function saveSingleQuestion() {
        var textarea = $("#single_content").val();
        var que1 = $("[name='que1']").val();
        var que2 = $("[name='que2']").val();
        var que3 = $("[name='que3']").val();
        var que4 = $("[name='que4']").val();
        var formdata = $('#single_form').serializeObject();
        $.ajax({
            url: '${pageContext.request.contextPath}/question/single/insert',
            data: JSON.stringify(formdata),
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            beforeSend: function () {
                if (course.val() == '' || section.val() == '' || textarea == '' || que1 == '' || que2 == '' || que3 == '') {
                    $.alert({
                        title: "",
                        content: "请完整填写题目内容:)",
                        backgroundDismiss: true
                    });
                    return false;
                }
            },
            success: function (result) {
                $.alert({
                    title: "",
                    content: result.msg,
                    backgroundDismiss: true
                });
                if (result.code == 0) {
                    $("#single_content").val('');
                    $("[name='que1']").val('');
                    $("[name='que2']").val('');
                    $("[name='que3']").val('');
                    $("[name='que4']").val('');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
                    backgroundDismiss: true,
                    content: "系统错误!",
                    buttons: {
                        confirm: {
                            text: '确认',
                            btnClass: 'waves-effect waves-button waves-light'
                        }
                    }
                });
            }
        });
    }

    //    保存判断题
    function saveTfQuestion() {
        var textarea = $('#tf_content').val();
        var data = $('#tf_form').serializeArray();
        $.ajax({
            url: '${pageContext.request.contextPath}/question/tfQuestion/insert',
            data: data,
            dataType: 'json',
            type: 'post',
            beforeSend: function () {
                if (tfcourse.val() == '' || tfsection.val() == '' || textarea == '') {
                    $.alert({
                        title: "",
                        content: "请完整填写题目内容:)",
                        backgroundDismiss: true
                    });
                    return false;
                }
            },
            success: function (result) {
                $.alert({
                    title: "",
                    content: result.msg,
                    backgroundDismiss: true
                });
                if (result.code == 0) {
                    $('#tf_content').val('');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    backgroundDismiss: true,
                    title: false,
                    content: "系统错误!",
                    buttons: {
                        confirm: {
                            text: '确认',
                            btnClass: 'waves-effect waves-button waves-light'
                        }
                    }
                });
            }
        });
    }

    //    保存附加题
    function saveAnother() {
        var textarea_content = $('#ano_content').val();
        var textarea_result = $('#ano_result').val();
        var formdata = $('#another_form').serializeObject();
        var data = JSON.stringify(formdata);
        $.ajax({
            url: '${pageContext.request.contextPath}/question/another/insert',
            data: data,
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            beforeSend: function () {
                if (anocourse.val() == '' || textarea_content == '' || textarea_result == '') {
                    $.alert({
                        title: "",
                        content: "请完整填写题目内容:)",
                        backgroundDismiss: true
                    });
                    return false;
                }
            },
            success: function (result) {
                $.alert({
                    title: "",
                    content: result.msg,
                    backgroundDismiss: true
                });
                if (result.code == 0) {
                    $('#ano_content').val('');
                    $('#ano_result').val('');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    closeAnimation: 'rotateX',
                    title: false,
                    backgroundDismiss: true,
                    content: "系统错误!",
                    buttons: {
                        confirm: {
                            text: '确认',
                            btnClass: 'waves-effect waves-button waves-light'
                        }
                    }
                });
            }
        });
    }

    //        预加载
    $(function () {
        course.select2();
        tfcourse.select2();
        anocourse.select2();
        section.select2();
        tfsection.select2();
        $('#single_select_result').select2();
        $('#single_select_level').select2();
        $('#tf_select_level').select2();
        //课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dataType: 'json',
            success: function (data) {
                course.select2({
                    data: data
                });
                tfcourse.select2({
                    data: data
                });
                anocourse.select2({
                    data: data
                });
            }
        });
        //联级：选择课程后展示该课程题库章节
        course.on("select2:select", function (e) {
            var courseId = course.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/course/section/' + courseId,
                dataType: 'json',
                success: function (data) {
                    section.empty();
                    section.select2({
                        data: data
                    });
                }
            });
        });
        tfcourse.on("select2:select", function (e) {
            var courseId = tfcourse.val();
            $.ajax({
                url: '${pageContext.request.contextPath}/course/section/' + courseId,
                dataType: 'json',
                success: function (data) {
                    tfsection.empty();
                    tfsection.select2({
                        data: data
                    });
                }
            });
        });
    });

    //    控制div显示隐藏
    var single = $('#single_div');
    var tf = $('#tf_div');
    var ano = $('#another_div');

    function singlePart() {
        tf.css('display', 'none');
        ano.css('display', 'none');
        single.css('display', 'block');
    }

    function tfPart() {
        single.css('display', 'none');
        ano.css('display', 'none');
        tf.css('display', 'block');
    }

    function anoPart() {
        single.css('display', 'none');
        tf.css('display', 'none');
        ano.css('display', 'block');
    }
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