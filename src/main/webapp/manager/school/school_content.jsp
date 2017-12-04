<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
            <div class="col-md-6">
                <shiro:hasPermission name="shiro:sys:admin">
                    <button class="btn-primary" style="text-align: right"
                            onclick="addSpecialty()">新增专业
                    </button>
                </shiro:hasPermission>
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
                                            onclick="
                                                    modifySpecialty('${specialty.id}'+'_'+'${specialty.specialtyId}'+'_'+'${specialty.name}')">
                                        修改
                                    </button>
                                    <shiro:hasPermission name="shiro:sys:admin">
                                        <button class="btn-warning"
                                                onclick="deleteSpecialty('${specialty.specialtyId}')">
                                            删除
                                        </button>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-6">
                <shiro:hasPermission name="shiro:sys:admin">
                    <button class="btn-primary" style="text-align: right"
                            onclick="showAddCourse()">新增课程
                    </button>
                </shiro:hasPermission>
                <br><br>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover"
                           data-toggle="table">
                        <thead>
                        <tr>
                            <th>课程Id</th>
                            <th>课程名称</th>
                            <th>学时</th>
                            <th>学分</th>
                            <th>总章节数</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${courses}" var="course">
                            <tr>
                                <td>${course.courseId}</td>
                                <td>${course.name}</td>
                                <td>${course.period}</td>
                                <td>${course.credit}</td>
                                <td>${course.chapterNum}</td>
                                <td>
                                    <button class="btn-primary"
                                            onclick="showModifyCourse('${course.courseId}')">
                                        修改
                                    </button>
                                    <shiro:hasPermission name="shiro:sys:admin">
                                        <button class="btn-warning"
                                                onclick="deleteCourse('${course.courseId}')">
                                            删除
                                        </button>
                                    </shiro:hasPermission>
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
<%--新增课程--%>
<div id="school_course_modal" class="modal fade" tabindex="-1"
     role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">
                    新增课程</h4>
            </div>
            <div class="modal-body">
                <form id="school_course_form">
                    <input class="form-control"
                           name="courseId"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                           maxlength="8" minlength="8"
                           placeholder="请填写课程Id，8位数值">
                    <input name="name" placeholder="请填写课程名称"
                           class="form-control">
                    <input name="period" placeholder="请填写学时"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           class="form-control" maxlength="2"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <input name="credit" placeholder="请填写学分"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           class="form-control" maxlength="2"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <input name="chapterNum" placeholder="请填写总章节数"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           class="form-control" maxlength="2"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <button type="button" onclick="addCourse()">添加</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%--修改课程--%>
<div id="school_course_modify_modal" class="modal fade" tabindex="-1"
     role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">
                    课程修改</h4>
            </div>
            <div class="modal-body">
                <form id="school_course_modify_form">
                    <input id="modify_c_id" name="id" hidden>
                    <input class="form-control"
                           name="courseId" id="modify_c_cId"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                           maxlength="8" minlength="8" readonly
                           placeholder="请填写课程Id，8位数值">
                    <input name="name" placeholder="请填写课程名称" id="modify_c_name"
                           class="form-control">
                    <input name="period" placeholder="请填写学时" id="modify_c_p"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           class="form-control" maxlength="2"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <input name="credit" placeholder="请填写学分" id="modify_c_c"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           class="form-control" maxlength="2"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <input name="chapterNum" placeholder="请填写总章节数"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           class="form-control" maxlength="2" id="modify_c_cn"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <button type="button" onclick="modifyCourse()">修改</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%--修改专业--%>
<div id="school_specialty_modify_modal" class="modal fade" tabindex="-1"
     role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">
                    专业修改</h4>
            </div>
            <div class="modal-body">
                <form id="school_specialty_modify_form">
                    <input id="modify_s_realId" name="id" hidden>
                    <input class="form-control"
                           name="specialtyId" id="modify_s_id"
                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                           maxlength="6" minlength="6" readonly
                           placeholder="专业Id，如：14届计算机，请填写“140401”">
                    <input name="name" type="text"
                           class="form-control" id="modify_s_name"
                           placeholder="专业名称，如：计算机科学与技术">
                    <button type="button" onclick="modifySpecialty()">修改
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    //添加课程
    function addCourse() {
        var courseId = $('[name="courseId"]').val();
        var name = $('[name="name"]').val();
        var period = $('[name="period"]').val();
        var credit = $('[name="credit"]').val();
        var chapterNum = $('[name="chapterNum"]').val();
        if (courseId === "" || name === "" || period === "" || credit === "" || chapterNum === "") {
            alert("请填写完整数据！");
            return false;
        }
        if (courseId.length !== 8) {
            alert("课程Id长度为8！");
            return false;
        }
        if (credit < 0 || credit > 25) {
            alert("学分范围在0-25之间!");
            return false;
        }
        if (chapterNum < 1 || chapterNum > 16) {
            alert("章节数范围在1-16之间!");
            return false;
        }
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/common/course/insert',
            type: 'post',
            dataType: 'json',
            data: $('#school_course_form').serializeArray(),
            success: function (data) {
                if (data) {
                    location.reload();
                } else {
                    alert("课程Id重复！");
                }
            },
            error: function () {
                alert("您没有权限！");
                location.reload();
            }
        })
    }

    //删除课程
    function deleteCourse(id) {
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
                    url: '${pageContext.request.contextPath}/admin/common/course/delete/' + id,
                    type: 'delete',
                    dataType: 'json',
                    success: function (data) {
                        if (data) {
                            location.reload();
                        }
                    },
                    error: function () {
                        alert("您没有权限！");
                        location.reload();
                    }
                })
            });
    }

    //修改课程
    function modifyCourse() {
        var stringData = $('#school_course_modify_form').serializeObject();
        var jsonDate = JSON.stringify(stringData);
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/common/course/update',
            contentType: 'application/json',
            data: jsonDate,
            dataType: 'json',
            type: 'post',
            success: function (data) {
                if (data) {
                    location.reload();
                } else {
                    alert("请填写正确参数！");
                }
            },
            error: function () {
                alert("出错！可能原因：1.您没有权限；2.该课程Id被其他事务所关联;3.课程Id重复;4.属性设置超出范围");
                location.reload();
            }
        })
    }

    //新增专业
    function addSpecialty() {
        $.confirm({
            title: "新增专业",
            content: '<input id="add_specialtyId" class="form-control" onkeyup="this.value=this.value.replace(/\\D/g,\'\')" ' +
            'onafterpaste="this.value=this.value.replace(/\\D/g,\'\')" maxlength="6" minlength="6"' +
            ' placeholder="专业Id，如：14届计算机，请填写“140401”">' +
            '<input id="add_year" placeholder="填写两位数数字，如14届计算机，请填写“14”" ' +
            'onkeyup="this.value=this.value.replace(/\\D/g,\'\')" minlength="2" maxlength="2" ' +
            'class="form-control" onafterpaste="this.value=this.value.replace(/\\D/g,\'\')">' +
            '<input id="add_specialtyName" type="text" class="form-control" placeholder="专业名称，如：计算机科学与技术">',
            animation: 'right',
            closeAnimation: 'rotateX',
            type: 'red',
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        var sId = $('#add_specialtyId').val();
                        var year = $('#add_year').val();
                        var name = $('#add_specialtyName').val();
                        if (sId == "" || year == "" || name == "") {
                            $.alert({
                                title: "",
                                content: "请填写完整数据:)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (sId.length != 6) {
                            $.alert({
                                title: "",
                                content: "专业id长度为6",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (year.length != 2) {
                            $.alert({
                                title: "",
                                content: "请正确填写两位数值:)",
                                backgroundDismiss: true
                            });
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
                            success: function (result) {
                                if (result.code === 0) {
                                    $.confirm({
                                        title: "",
                                        animation: 'left',
                                        closeAnimation: 'rotateX',
                                        content: result.msg + " 数据将在3秒后刷新...",
                                        autoClose: 'confirm|3000',
                                        buttons: {
                                            confirm: {
                                                text: '确认',
                                                btnClass: 'waves-effect waves-button waves-light',
                                                action: function () {
                                                    location.reload();
                                                }
                                            }
                                        }
                                    });
                                } else {
                                    $.alert({
                                        title: "",
                                        content: result.msg,
                                        backgroundDismiss: true
                                    });
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
                        })
                    }
                },
                cancel: function () {
                }
            }
        });
    }

    //修改专业
    function modifySpecialty(info) {
        var array = info.split('_');
        $.confirm({
            title: "修改专业",
            content:
            '<input class="form-control" id="mod_s_id" name="id" value="' + array[0] + '" readonly>' +
            '<input class="form-control" id="mod_s_Id" value="' + array[1] + '" readonly' +
            '  placeholder="专业Id，如：14届计算机，请填写“140401”">' +
            '<input class="form-control" id="mod_s_name" placeholder="专业名称，如：计算机科学与技术" value="' + array[2] + '">',
            animation: 'left',
            backgroundDismiss: true,
            closeAnimation: 'rotateX',
            type: 'purple',
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        var reid = $('#mod_s_id').val();
                        var reId = $('#mod_s_Id').val();
                        if (isNaN(reId) || reId.length != 6) {
                            $.alert({
                                title: "",
                                content: "专业编号为6位数字:)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        var s_name = $('#mod_s_name').val();
                        if (s_name == '') {
                            $.alert({
                                title: "",
                                content: "不要忘记专业名称哦！",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/school/specialty/update',
                            dataType: 'json',
                            type: 'post',
                            data: {
                                id: reid,
                                specialtyId: reId,
                                name: s_name
                            },
                            success: function (result) {
                                if (result.code === 0) {
                                    $.confirm({
                                        title: "",
                                        animation: 'left',
                                        closeAnimation: 'rotateX',
                                        content: result.msg + " 数据将在3秒后刷新...",
                                        autoClose: 'confirm|3000',
                                        buttons: {
                                            confirm: {
                                                text: '确认',
                                                btnClass: 'waves-effect waves-button waves-light',
                                                action: function () {
                                                    location.reload();
                                                }
                                            }
                                        }
                                    });
                                } else {
                                    $.alert({
                                        title: "",
                                        content: result.msg,
                                        backgroundDismiss: true
                                    });
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
                        })
                    }
                },
                cancel: function () {
                }
            }
        });
    }

    //删除专业
    function deleteSpecialty(id) {
        $.confirm({
            title: "Warnning!",
            content: '您确认要删除该专业吗？',
            animation: 'right',
            backgroundDismiss: true,
            closeAnimation: 'rotateX',
            type: 'red',
            buttons: {
                ok: {
                    text: "ok!",
                    theme: 'dark',
                    btnClass: 'btn-primary',
                    keys: ['enter'],
                    action: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/school/specialty/delete/' + id,
                            dataType: 'json',
                            type: 'delete',
                            success: function (result) {
                                if (result.code === 0) {
                                    $.confirm({
                                        title: "",
                                        animation: 'left',
                                        closeAnimation: 'rotateX',
                                        content: result.msg + " 数据将在3秒后刷新...",
                                        autoClose: 'confirm|3000',
                                        buttons: {
                                            confirm: {
                                                text: '确认',
                                                btnClass: 'waves-effect waves-button waves-light',
                                                action: function () {
                                                    location.reload();
                                                }
                                            }
                                        }
                                    });
                                } else {
                                    $.alert({
                                        title: "",
                                        content: result.msg,
                                        backgroundDismiss: true
                                    });
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                $.confirm({
                                    animation: 'rotateX',
                                    backgroundDismiss: true,
                                    closeAnimation: 'rotateX',
                                    title: false,
                                    content: "此专业不可删除!",
                                    buttons: {
                                        confirm: {
                                            text: '确认',
                                            btnClass: 'waves-effect waves-button waves-light'
                                        }
                                    }
                                });
                            }
                        })
                    }
                },
                cancel: function () {
                }
            }
        });
    }
</script>