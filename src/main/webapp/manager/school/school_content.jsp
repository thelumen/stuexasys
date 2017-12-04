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
                <div class="table-responsive">
                    <table class="table table-bordered table-hover"
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
                            onclick="addCourse()">新增课程
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
                                            onclick="modifyCourse('${course.id}'+'_'+'${course.courseId}'
                                                    +'_'+'${course.name}'+'_'+'${course.period}'+'_'+'${course.credit}'
                                                    +'_'+'${course.chapterNum}')">
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
<script>
    //添加课程
    function addCourse() {
        $.confirm({
            title: "新增课程",
            content:
            '<input  id="c_courseId" placeholder="请填写课程Id，8位数值" class="form-control">' +
            '<input id="c_name" placeholder="请填写课程名称" class="form-control">' +
            '<input id="c_period" placeholder="请填写学时，范围：0-100" class="form-control">' +
            '<input id="c_credit" placeholder="请填写学分，范围：0-25" class="form-control">' +
            '<input id="c_chapterNum" placeholder="请填写总章节数，范围：1-16" class="form-control">',
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
                        var courseId = $('#c_courseId').val();
                        var name = $('#c_name').val();
                        var period = $('#c_period').val();
                        var credit = $('#c_credit').val();
                        var chapterNum = $('#c_chapterNum').val();
                        if (courseId == "" || name == "" || period == "" || credit == "" || chapterNum == "") {
                            $.alert({
                                title: "",
                                content: "请填写完整数据:)",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (isNaN(courseId) || courseId.length != 8) {
                            $.alert({
                                title: "",
                                content: "课程Id是长度为8的数字！",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (isNaN(credit) || Number(credit) > 25) {
                            $.alert({
                                title: "",
                                content: "学分是范围在0-25之间的数字",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (isNaN(period) || Number(period) > 100) {
                            $.alert({
                                title: "",
                                content: "学时是范围在0-100之间的数字",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        if (isNaN(chapterNum) || Number(chapterNum) < 1 || Number(chapterNum) > 16) {
                            $.alert({
                                title: "",
                                content: "章节数是范围在1-16之间的数字",
                                backgroundDismiss: true
                            });
                            return false;
                        }
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/school/course/insert',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                courseId: courseId,
                                name: name,
                                period: period,
                                credit: credit,
                                chapterNum: chapterNum
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

    //删除课程
    function deleteCourse(id) {
        $.confirm({
            title: "删除课程",
            content: '您确认要删除该课程吗？',
            animation: 'left',
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
                            url: '${pageContext.request.contextPath}/admin/school/course/delete/' + id,
                            type: 'delete',
                            dataType: 'json',
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
                                    content: "此课程不可删除!",
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

    //修改课程
    function modifyCourse(info) {
        var array = info.split('_');
        $.confirm({
            title: "修改课程",
            content:
            '<input id="mod_c_id"  class="form-control" readonly value="' + array[0] + '">' +
            '<input id="mod_c_courseId" readonly placeholder="请填写课程Id，8位数值" class="form-control" readonly value="' + array[1] + '">' +
            '<input id="mod_c_name" placeholder="请填写课程名称" class="form-control" value="' + array[2] + '">' +
            '<input id="mod_c_period" placeholder="请填写学时，范围：0-100" class="form-control" value="' + array[3] + '">' +
            '<input id="mod_c_credit" placeholder="请填写学分，范围：0-25" class="form-control" value="' + array[4] + '">' +
            '<input id="mod_c_chapterNum" placeholder="请填写总章节数，范围：1-16"  class="form-control" value="' + array[5] + '">',
            animation: 'left',
            backgroundDismiss: true,
            closeAnimation: 'rotateX',
            type: 'purple',
            buttons:
                {
                    ok: {
                        text: "ok!",
                        theme: 'dark',
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action:
                            function () {
                                var id = $('#mod_c_id').val();
                                var courseId = $('#mod_c_courseId').val();
                                var name = $('#mod_c_name').val();
                                var period = $('#mod_c_period').val();
                                var credit = $('#mod_c_credit').val();
                                var num = $('#mod_c_chapterNum').val();
                                if (name == "" || period == "" || credit == "" || num == "") {
                                    $.alert({
                                        title: "",
                                        content: "请填写完整数据:)",
                                        backgroundDismiss: true
                                    });
                                    return false;
                                }
                                if (isNaN(credit) || Number(credit) > 25) {
                                    $.alert({
                                        title: "",
                                        content: "学分是范围在0-25之间的数字",
                                        backgroundDismiss: true
                                    });
                                    return false;
                                }
                                if (isNaN(period) || Number(period) > 100) {
                                    $.alert({
                                        title: "",
                                        content: "学时是范围在0-100之间的数字",
                                        backgroundDismiss: true
                                    });
                                    return false;
                                }
                                if (isNaN(num) || Number(num) < 1 || Number(num) > 16) {
                                    $.alert({
                                        title: "",
                                        content: "章节数是范围在1-16之间的数字",
                                        backgroundDismiss: true
                                    });
                                    return false;
                                }
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/admin/school/course/update',
                                    dataType: 'json',
                                    type: 'post',
                                    data: {
                                        id: id,
                                        courseId: courseId,
                                        name: name,
                                        period: period,
                                        credit: credit,
                                        chapterNum: num
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
        })
        ;
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