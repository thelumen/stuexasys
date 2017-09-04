<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/8/24
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //初始化
    $(function () {

        initSelect();//初始化下拉框

        var selectOption = 1;//默认加载预留专业的学生

        //表格初始化
        $("#studentTable").bootstrapTable({
            method: "post",
            url: "${pageContext.request.contextPath}/admin/student/initStudentTable/" + selectOption,
            sidePagination: "server",
            idField: "studentId",
            showRefresh: "true",
            pagination: "true",
            showColumns: "true",
            showExport: "true",
            columns: [{
                field: 'studentId',
                title: '学号',
                sortable: true
            }, {
                field: 'name',
                title: '姓名',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '姓名不能为空';
                        }
                    }
                }
            }, {
                field: 'gender',
                title: '性别',
                editable: {
                    type: 'select',
                    source: [{value: '男', text: "男"}, {value: '女', text: "女"}],
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '不能为空';
                        }
                    }
                }
            }, {
                field: 'specialtyId',
                title: '专业',
                editable: {
                    type: 'select',
                    disabled: false,    //是否禁用编辑
                    emptyText: "未录入",   //空值的默认文本
                    source: function () {
                        var result = [];
                        $.each(window._data, function (key, value) {
                            result.push({value: value.id, text: value.text});
                        });
                        return result;
                    },
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '专业不能为空';
                        }
                    }
                }
            }, {
                field: 'cellphone',
                title: '电话',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
                        var cellphone = $.trim(value);
                        if (!myreg.test(cellphone)) {
                            return '请输入有效的手机号码！';
                        }
                    }
                }
            }, {
                field: 'email',
                title: '邮箱',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        var myreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
                        var email = $.trim(value);
                        if (!myreg.test(email)) {
                            return '请输入有效的E_mail！';
                        }
                    }
                }
            }, {
                field: 'password',
                title: '修改密码',
                formatter: function (value, row, index) {
                    return '修改密码';
                },
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '密码不能为空';
                        }
                    }
                }
            }, {
                field: 'edit',
                title: '编辑',
                formatter: initEditBtn(),
                events: 'editBtnEvent'
            }]
        });

        //文件上传
        $("#studentExcelFile").fileinput({
            language: 'zh',
            maxFileSize: 5000,
            uploadUrl: '${pageContext.request.contextPath}/admin/student/upload',
            showUpload: true,
            showRemove: true,
            uploadAsync: true,
            showPreview: true,
            showCancel: false,
            dropZoneEnabled: false,
            enctype: 'multipart/form-data',
            allowedFileExtensions: ['xls']
        }).on("fileuploaded", function (event, data, previewId, index) {
            var result = data.response;
            if (result) {
                $("#modal-container-uploadStudent").modal("hide");
                alert("成功上传");
                location.reload();
            } else {
                alert("上传失败了");
            }
        });

        //查找按钮点击事件
        $("#selectStudent").click(function () {
            var specialty = $("#specialty").val();
            var studentId = $("#studentId").val();
            if (specialty === null) {
                specialty = 0;//未选中时的默认值
            }
            if (studentId === null || studentId.length === 0) {
                studentId = 0;//未选中时的默认值
            }
            if (studentId !== 0) {
                if (studentId.length === 9) {
                    $("#studentTable").bootstrapTable("refresh",
                        {
                            url: "${pageContext.request.contextPath}/admin/student/loadStudent/" + specialty + "/" + studentId,
                            silent: true
                        })
                } else {
                    alert("请输入正确的学号");
                }
            } else {
                $("#studentTable").bootstrapTable("refresh",
                    {
                        url: "${pageContext.request.contextPath}/admin/student/loadStudent/" + specialty + "/" + studentId,
                        silent: true
                    })
            }
        });

        //专业删除按钮的点击事件
        $("#deleteSpecialty").click(function () {
            var specialtyId = $("#specialty").val();
            if (specialtyId === null) {
                alert("请先选择专业");
            } else if (!validate_Specialty()) {
                alert("不可以删除预留专业");
            } else {
                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/admin/student/specialtyDel/" + specialtyId,
                    dataType: "json",
                    success: function (data) {
                        if (data) {
                            alert("删除成功");
                            location.reload()
                        } else {
                            alert("删除失败");
                        }
                    }
                });
            }
        })
    });

    //验证所删除专业中不包括预留专业
    function validate_Specialty() {
        var specialtyId = $("#specialty").val();
        for (var x in specialtyId) {
            alert(specialtyId[x]);
            if (specialtyId[x] === '100000') {
                return false;
            }
        }
        return true;
    }

    //表格内的按钮初始化
    function initEditBtn() {
        var html = [];
        html.push('<button class="btn btn-primary saveChanged" type="button">保存</button>');
        html.push('&nbsp;&nbsp;');
        html.push('<button class="btn btn-danger delStu" type="button">删除</button>');
        return html.join('');
    }

    //初始化下拉框
    function initSelect() {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/student/specialtyGet',
            dataType: 'json',
            success: function (data) {
                $('#specialty').select2({
                    placeholder: "专业",
                    allowClear: true,
                    data: data
                });
                window._data = data;
            }
        });
    }

    //点击事件处理
    window.editBtnEvent = {
        'click .saveChanged': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/admin/student/studentInfoSave',
                dataType: "json",
                data: JSON.stringify(row),
                contentType: 'application/json',
                success: function (data) {
                    if (data) {
                        alert("更新成功");
                        $("#studentTable").bootstrapTable("refresh")
                    } else {
                        alert("更新失败");
                    }
                }
            });
        },
        'click .delStu': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/admin/student/studentInfoDel',
                dataType: "json",
                data: JSON.stringify(row),
                contentType: 'application/json',
                success: function (data) {
                    if (data) {
                        alert("成功删除");
                        $("#studentTable").bootstrapTable("refresh")
                    } else {
                        alert("删除失败");
                    }
                }
            });
        }
    }

</script>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <label style="display: block">
                <select multiple="multiple" class="form-control " id="specialty"></select>
            </label>
        </div>
        <div class="col-md-3">
            <label style="display: block">
                <input class="form-control" placeholder="学号" id="studentId">
            </label>
        </div>
        <div class="col-md-6">
            <button class="btn btn-primary" type="button" id="selectStudent">查&nbsp;&nbsp;找</button>
            &nbsp;&nbsp;
            <button class="btn btn-danger" type="button" id="deleteSpecialty">删除专业</button>
            &nbsp;&nbsp;
            <button class="btn btn-success" type="button" id="uploadStudent" href="#modal-container-uploadStudent"
                    data-toggle="modal">上传学生
            </button>
        </div>
    </div>

    <div class="row">
        <table id="studentTable">
        </table>
    </div>

    <%--学生信息上传模态框--%>
    <div class="modal fade" id="modal-container-uploadStudent" aria-hidden="true" aria-labelledby="myModalLabel">
        <form enctype="multipart/form-data" id="uploadForm" method="post">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <button class="close" aria-hidden="true" type="button" data-dismiss="modal">×</button>
                        <h4 class="modal-title" id="myModalLabel">
                            上传学生信息
                        </h4>
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <br>
                                <label>&nbsp;&nbsp;请选择需要上传的<strong style="color: #985f0d">学生信息表</strong>：</label>
                                <div class="form-group">
                                    <br>
                                    <label>
                                        <input id="studentExcelFile" multiple type="file" class="file-loading"
                                               name="files">
                                    </label>
                                </div>
                                <br>
                                <a href="${pageContext.request.contextPath}/common/example/上传学生表样表.xls"
                                   class="form-control" style="border:none;">下载上传模板</a>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
                    </div>

                </div>
            </div>
        </form>
    </div>
</div>

