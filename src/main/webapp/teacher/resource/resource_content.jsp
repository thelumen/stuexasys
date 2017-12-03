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
    <div class="container">
        <div id="toolbar">
            <label>请选择文件<strong style="color: #985f0d">目录分类</strong>：
                <select style="width: 200px"
                        id="directory">
                    <option selected></option>
                </select>
            </label>
            <button class="btn btn-primary" type="button" onclick="check()">
                <i class="glyphicon glyphicon-search"></i> 查询
            </button>
            <button class="btn btn-primary" type="button" onclick="showModal()">
                <i class="glyphicon glyphicon-upload"></i> 文件上传
            </button>
        </div>
        <table id="resource_table"
               data-toolbar="#toolbar"
               class="table table-bordered table-hover"
               data-toggle="table"
               data-show-refresh="true"
               data-pagination="true"
               data-side-pagination="server"
               data-method="post"
               data-query-params="$.fn.bootstrapTable.queryParams">
            <thead>
            <tr>
                <th data-field="fileName">文件名</th>
                <th data-field="path">文件路径</th>
                <th data-field="nowDate">创建日期</th>
                <th data-formatter="operate">操作
                </th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>
<div id="modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">文件上传</h4>
            </div>
            <div class="modal-body">
                <label>请选择需要<strong style="color: #985f0d">上传的文件</strong>：
                    <form id="form">
                        <input id="file_input" multiple
                               type="file" class="file" name="files"
                               data-show-upload="false"
                               data-show-caption="true"
                               data-allowed-file-extensions='["jpg","png","gif","txt","xls","xlsx","doc", "docx","ppt"]'
                               placeholder="仅支持:jpg png gif txt xls xlsx doc docx ppt"><br>
                        <button class="btn btn-primary" type="button"
                                onclick="submitFiles()">上传文件
                        </button>
                    </form>
                </label>
            </div>
        </div>
    </div>
</div>
<script>
    var table = $('#resource_table');
    var select = $('#directory');
    var modal = $('#modal');

    //    初始化
    $(function () {
        select.select2();
        $.ajax({
            url: '${pageContext.request.contextPath}/course/single',
            dateType: 'json',
            success: function (data) {
                select.select2({
                    data: data
                });
            }
        });
    });

    //操作
    function operate(value, row) {
        var html = [];
        html.push('<button class="btn btn-danger" type="button" onclick="deleteFile(\'{0}\')">删除</button>'.replace('{0}', row.path));
        return html.join('');
    }

    //展示modal
    function showModal() {
        modal.modal("show");
    }

    //    文件上传
    function submitFiles() {
        var files = $('#file_input').val();
        var directoryName = $('#directory').text();
        $('#form').ajaxSubmit({
            url: '${pageContext.request.contextPath}/resource/' + directoryName + '/upload',
            type: 'post',
            dataType: 'json',
            beforeSend: function () {
                if (files == '' || directoryName == '') {
                    $.alert({
                        title: "",
                        content: "请选择学科分类以及上传的文件 并且选择正确的文件类型 :)",
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
                    modal.modal("hide");
                    $('#file_input').val("");
                    table.bootstrapTable("refresh");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.confirm({
                    animation: 'rotateX',
                    backgroundDismiss: true,
                    closeAnimation: 'rotateX',
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

    //删除资源
    function deleteFile(path) {
        $.confirm({
            title: "Warnning!",
            content: "您确定要删除这个文件吗？",
            animation: 'right',
            closeAnimation: 'rotateX',
            backgroundDismiss: true,
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        $.get("${pageContext.request.contextPath}/resource/file/delete", {
                            path: path
                        }, function (result) {
                            $.alert({
                                title: "",
                                content: result.msg,
                                backgroundDismiss: true
                            });
                            if (result.code == 0) {
                                table.bootstrapTable("refresh");
                            }
                        });
                    }
                },
                cancel: function () {
                }
            }
        });
    }

    //查询
    function check() {
        var value = select.val();
        if (value == undefined || value == "" || value == "null") {
            $.alert({
                title: "",
                content: "请选择一条数据项:)",
                backgroundDismiss: true
            });
            return false;
        }
        table.bootstrapTable('refresh', {url: "${pageContext.request.contextPath}/resource/" + select.text() + "/files"});
    }

</script>