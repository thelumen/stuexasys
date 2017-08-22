<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/6/4
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/teacher/main">首页</a>
        </li>
        <li class="active">资源上传</li>
    </ol>
    <label>请选择文件<strong style="color: #985f0d">目录分类</strong>：
        <select style="width: 200px" id="teacher_resource_home_directory">
            <option selected></option>
        </select>
    </label>
    <label>请选择需要<strong style="color: #985f0d">上传的文件</strong>：
        <form id="teacher_resource_form">
            <input id="teacher_resource_form_inp" multiple
                   type="file" class="file" name="files"
                   data-show-upload="false"
                   data-show-caption="true"
                   data-allowed-file-extensions='["jpg","png","gif","txt","xls","xlsx","doc", "docx","ppt"]'
                   placeholder="仅支持:jpg png gif txt xls xlsx doc docx ppt">
            <button class="btn btn-primary" type="button"
                    onclick="submitFiles()">上传文件
            </button>
        </form>
    </label>
    <table id="teacher_resource_table">
    </table>
</div>
<script>
    var table = $('#teacher_resource_table');
    $(function () {
//        展示学科目录
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/directory',
            dateType: 'json',
            success: function (data) {
                $('#teacher_resource_home_directory').select2({
                    data: data
                });
            }
        });
//        选择后触发新的动作——展示该学科目录下所有普通文件的文件名
        $('#teacher_resource_home_directory').on("select2:select", function (e) {
            var directoryName = $('#teacher_resource_home_directory').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/' + directoryName + '/files',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    table.html('');
                    var html = '';
                    for (x in data) {
                        html += data[x].name;
                        html += '<br>';
                    }
                    table.html(html);
                }
            });
        });
    });
    //    文件上传
    function submitFiles() {
        var files = $('#teacher_resource_form_inp').val();
        var directoryName = $('#teacher_resource_home_directory').val();
        if (files !== '' && directoryName !== '') {
            $('#teacher_resource_form').ajaxSubmit({
                url: '${pageContext.request.contextPath}/teacher/' + directoryName + '/upload',
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    if (data.isSuccess) {
                        swal("year", "上传成功！", "success");
                    }
                },
                error: function () {
                    swal("oh..", "系统智商不在线，不能上传了...", "error");
                }
            });
        } else {
            swal("oh..", "请选择学科分类以及上传的文件 并且选择正确的文件类型 :)", "error");
            return false;
        }
    }
</script>