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
                    <input type="checkbox" id="errorStudent" checked="checked">
                </label>
            </p>
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" type="button" id="selectStudent">查找</button>
        </div>
    </div>

    <div class="row">
        <table id="studentTable"
               data-toggle="table"
               data-method="post"
               data-url="${pageContext.request.contextPath}/admin/student/initStudentTable"
               data-side-pagination="server"
               data-id-field="studentId"
               data-show-refresh="true"
               data-pagination="true"
               data-show-columns="true"
               data-show-export="true"
        >
            <thead>
            <tr>
                <th data-field="studentId" data-width="300"
                    data-sortable="true">
                    学号
                </th>
                <th data-field="name" data-width="300">
                    姓名
                </th>
                <th data-field="gender" data-width="300">
                    性别
                </th>
                <th data-field="specialty" data-width="300">
                    专业
                </th>
                <th data-field="cellphone" data-width="300">
                    电话
                </th>
                <th data-field="email" data-width="300">
                    邮箱
                </th>
                <th data-formatter="initEditBtn" data-width="300">
                    编辑
                </th>
            </tr>
            </thead>
        </table>

    </div>
</div>
<script>
    //初始化
    $();

    //按钮初始化
    function initEditBtn() {
        var html=[];
        html.push('<button class="btn btn-primary saveChanged" type="button">保存</button>');
        html.push('&nbsp;&nbsp;');
        html.push('<button class="btn btn-danger delStu" type="button">删除</button>');
        return html.join('');
    }

    //点击事件处理
    window.opersteEvent={
        'click .saveChanged':function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
        },
        'click .delStu':function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
        }
    }
</script>