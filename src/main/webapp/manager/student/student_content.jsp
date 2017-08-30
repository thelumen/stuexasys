<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/8/24
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <p>
                <label>
                    <input class="form-control" placeholder="专业" id="special">
                </label>
            </p>
        </div>
        <div class="col-md-3">
            <p>
                <label>
                    <input class="form-control" placeholder="学号" id="studentId">
                </label>
            </p>
        </div>
        <div class="col-md-3">
            <p>信息异常
                <label>
                    <input type="checkbox" id="errorStudent" name="errorStudent" checked="checked">
                </label>
            </p>
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" type="button" id="selectStudent">查找</button>
        </div>
    </div>

    <div class="row">
        <table id="studentTable">
        </table>
    </div>
</div>

<script>
    //初始化
    $(function () {
        var selectOption = 0;
        if ($('input:radio[name="errorStudent"]:checked').val() !== null) {
            selectOption = 1;
        }
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
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '姓名不能为空';
                        }
                    }
                }
            }, {
                field: 'specialtyName',
                title: '专业',
                editable: {
                    type: 'text',
                    validate: function (value) {
                        if ($.trim(value) === '') {
                            return '姓名不能为空';
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
                field: 'passwordChanged',
                title: '修改密码',
                formatter: function (value, row, index) {
                    return '修改密码';
                },
                editable: {
                    type: 'text',
                    validate: function (value) {

                    }
                }
            }, {
                field: 'edit',
                title: '编辑',
                formatter: initEditBtn(),
                events: 'editBtnEvent'
            }]
        })
    });

    //按钮初始化
    function initEditBtn() {
        var html = [];
        html.push('<button class="btn btn-primary saveChanged" type="button">保存</button>');
        html.push('&nbsp;&nbsp;');
        html.push('<button class="btn btn-danger delStu" type="button">删除</button>');
        return html.join('');
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
                    } else {
                        alert("更新失败");
                    }
                }
            });
        },
        'click .delStu': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
        }
    }

</script>