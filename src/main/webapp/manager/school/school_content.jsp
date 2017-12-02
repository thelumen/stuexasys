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
            <div class="span6">
                <shiro:hasPermission name="shiro:sys:admin">
                    <button class="btn-primary" style="text-align: right"
                            onclick="showAddSpecialty()">新增专业
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
                                            onclick="showModifySpecialty('${specialty.specialtyId}')">
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
            <div class="span6">
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
<%--新增专业--%>
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
    //展示课程添加modal
    function showAddCourse() {
        $('#school_course_modal').modal('show');
    }
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
    //展示修改课程modal
    function showModifyCourse(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/common/course/' + id,
            success: function (data) {
                $('#modify_c_id').val(data.id);
                $('#modify_c_cId').val(data.courseId);
                $('#modify_c_name').val(data.name);
                $('#modify_c_p').val(data.period);
                $('#modify_c_c').val(data.credit);
                $('#modify_c_cn').val(data.chapterNum);
            }
        });
        $('#school_course_modify_modal').modal('show');
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
    //展示新增专业modal
    function showAddSpecialty(id) {
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
            url: '${pageContext.request.contextPath}/admin/common/specialty/add',
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
                location.reload();
            }
        })
    }
    //展示修改专业modal
    function showModifySpecialty(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/common/specialty/' + id,
            success: function (data) {
                $('#modify_s_realId').val(data.id);
                $('#modify_s_id').val(data.specialtyId);
                $('#modify_s_name').val(data.name);
            }
        });
        $('#school_specialty_modify_modal').modal("show");
    }
    //修改专业
    function modifySpecialty(id) {
        var stringData = $('#school_specialty_modify_form').serializeObject();
        var jsonDate = JSON.stringify(stringData);
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/common/specialty/update',
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
                alert("出错！可能原因：1.您没有权限；2.该专业Id被其他事务所关联;3.专业Id重复");
                location.reload();
            }
        })
    }
    //删除专业
    function deleteSpecialty(id) {
        swal({
                title: "您确定要删除这个专业吗？",
                text: "包括此专业下的学生和教师对此专业选课信息都将被删除",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "再见了，同学们",
                cancelButtonText: "我再想想",
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            },
            function () {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/common/specialty/delete/' + id,
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
</script>