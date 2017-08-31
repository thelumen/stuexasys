<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/30
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/main">主页</a>
        </li>
        <li class="active">专业&学科</li>
    </ol>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span6">
                <button class="btn-primary" style="text-align: right"
                        onclick="showAddSpecialty()">新增专业
                </button>
                <br><br>
                <%--选择题--%>
                <div class="table-responsive">
                    <table id="chapter_table"
                           class="table table-bordered table-hover"
                           data-toggle="table">
                        <thead>
                        <tr>
                            <th>专业Id</th>
                            <th>名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${specialties}" var="specialty">
                            <tr>
                                <td>${specialty.specialtyId}</td>
                                <td>${specialty.name}</td>
                                <td>
                                    <button class="btn-primary"
                                            onclick="resetSpecialty('${specialty.specialtyId}')">
                                        修改
                                    </button>
                                    <button class="btn-warning"
                                            onclick="deleteSpecialty('${specialty.specialtyId}')">
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="span6">
                <button class="btn-primary" style="text-align: right"
                        onclick="showAddChapter()">新增章节
                </button>
                <br><br>
                <%--选择题--%>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover"
                           data-toggle="table">
                        <thead>
                        <tr>
                            <th>章节ID</th>
                            <th>章节序列</th>
                            <th>备注</th>
                            <th>名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${chapters}" var="chapter">
                            <tr>
                                <td>${chapter.id}</td>
                                <td>${chapter.name}</td>
                                <td>${chapter.remark}</td>
                                <td>${chapter.content}</td>
                                <td>
                                    <button class="btn-primary"
                                            onclick="getChapter('${chapter.id}')">
                                        修改
                                    </button>
                                    <button class="btn-warning"
                                            onclick="deleteChapter('${chapter.id}')">
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <hr class="divider"/>
</div>
<div id="school_specialty_modal" class="modal fade" tabindex="-1"
     role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">
                    新增专业</h4>
            </div>
            <div class="modal-body">
                <form id="school_specialty_form">
                    <input class="form-control"
                           name="specialtyId"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                           maxlength="6" minlength="6"
                           placeholder="专业Id，如：14届计算机，请填写“140401”">
                    <input name="year" placeholder="填写两位数数字，如14届计算机，请填写“14”"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           minlength="2" maxlength="2" class="form-control"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <input name="specialtyName" type="text"
                           class="form-control"
                           placeholder="专业名称，如：计算机科学与技术">
                    <button type="button" onclick="addSpecialty()">添加</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    //展示新增专业modal
    function showAddSpecialty() {
        $('#school_specialty_modal').modal('show');
    }
    //新增专业
    function addSpecialty() {
        var sId = $('[name="specialtyId"]').val();
        var year = $('[name="year"]').val();
        var name = $('[name="specialtyName"]').val();
        if (sId === "" || year === "" || name === "") {
            alert("请填写完整数据！");
            return false;
        }
        if (sId.length !== 6) {
            alert("专业id长度为6！");
            return false;
        }
        if (year.length !== 2) {
            alert("请正确填写两位数值！");
            return false;
        }
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/school/specialty/add',
            type: 'post',
            dataType: 'json',
            data: {
                specialtyId: sId,
                year: year,
                specialtyName: name
            },
            success: function (data) {
                if (data) {
                    location.reload();
                } else {
                    alert("专业Id重复！");
                }
            },
            error: function () {
                alert("您没有权限！");
            }
        })
    }
    //修改专业
    function resetSpecialty(id) {
        alert(id);
    }
    //删除专业
    function deleteSpecialty(id) {
        swal({
                title: "您确定要删除这条记录？",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            },
            function () {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/school/specialty/delete/' + id,
                    type: 'delete',
                    dataType: 'json',
                    success: function (data) {
                        if (data) {
                            location.reload();
                        }
                    },
                    error: function () {
                        alert("您没有权限！");
                    }
                })
            });
    }
</script>