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

    <label>请选择文件<strong>目录分类</strong>：
        <select style="width: 200px" id="teacher_resource_home_directory">
            <option selected></option>
        </select>
    </label>

    <table id="teacher_resource_table">
        <tr>
            <td></td>
        </tr>
    </table>
</div>
<script>
    var table = $('#teacher_resource_table');

    $(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/teacher/directory',
            dateType: 'json',
            success: function (data) {
                $('#teacher_resource_home_directory').select2({
                    data: data
                });
            }
        });

        $('#teacher_resource_home_directory').on("select2:select", function (e) {
            var directoryName = $('#teacher_resource_home_directory').val();
//            alert(directoryName);
            $.ajax({
                url: '${pageContext.request.contextPath}/teacher/' + directoryName + '/files',
                dataType: 'json',
                type:'post',
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

    })
</script>