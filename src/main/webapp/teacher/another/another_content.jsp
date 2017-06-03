<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/6/3
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">附加题评分</li>
    </ol>
    <div class="row-fluid">
        <div class="span4">
            <form id="teacher_another_form" method="post" action="#">
                <label>请选择 <strong style="color: #985f0d">课程</strong>：<select
                        name="courseId" id="teacher_another_select_course"
                        style="width: 200px">
                    <option selected></option>
                </select></label>
                <label>请选择 <strong style="color: #985f0d">专业</strong>：
                    <select id="teacher_another_select_specialty"
                            name="specialtyId"
                            style="width: 200px"></select></label><br>
                <button style="margin-left: 30px" class="btn btn-warning"
                        type="button" onclick="">查询
                </button>
            </form>
        </div>
        <div class="span8">

        </div>
    </div>
</div>
<%--modal--%>

<script>
    $(function () {
        //        预加载数据
        $('#teacher_another_select_specialty').select2();
        //        课程select查询数据
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/getCourse',
            dataType: 'json',
            success: function (data) {
                $('#teacher_another_select_course').select2({
                    data: data
                });
            }
        });
        //        联级：选择课程后筛选出修这门课的专业
        $('#teacher_another_select_course').on("select2:select", function (e) {
            var courseId = $('#teacher_another_select_course').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/getSpecialties/' + courseId,
                dataType: 'json',
                success: function (data) {
                    var choS = $('#teacher_another_select_specialty');
                    choS.empty();
                    choS.select2({
                        data: data
                    });
                }
            });
        });
    })
</script>