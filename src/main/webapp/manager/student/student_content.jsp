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
            <p>专业:
                <label>

                    <input class="form-control" placeholder="专业" id="special">
                </label>
            </p>
        </div>
        <div class="col-md-3">
            <p>学号:
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
        <table id="studentTable">
        </table>
    </div>
</div>
<script>
    $(function () {
        TableInit();
        DataInit();
    });
    function TableInit() {
        var url="${pageContext.request.contextPath}/admin/initStudentTable";
        $("#studentTable").bootstrapTable({
            method:'post',
            dataType:'json',
            contentType: "application/x-www-form-urlencoded",
            cache: false,
            striped: true,
            url:url,
            search: false,                      //显示搜索框
            showRefresh:true,                   //显示刷新按钮
            showToggle:true,                    //显示切换视图按钮
            showColumns:true,                   //显示详细信息
            pagination:true,                    //显示分页条
            queryParams:queryParams,            //重写向服务器的传参方法
            minimumCountColumns:2,              //当列数小于此值时，将隐藏内容列下拉框。
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 20,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            uniqueId: "id",                     //为每一行指定一个唯一标示符
            responseHandler: responseHandler,
            columns: [
                {
                    field: '',
                    title: 'Sort No.',
                    formatter: function (value, row, index) {
                        return index+1;
                    }
                },
                {
                    field:'studentId',
                    title : '学号'
                },
                {
                    field:'name',
                    title : '姓名'
                },
                {
                    field:'special',
                    title : '专业'
                },
                {
                    field:'gender',
                    title : '性别'
                }
            ]
        })
    }
    function DataInit() {

    }
    function queryParams(params) {

    }
    function responseHandler(params) {

    }
</script>