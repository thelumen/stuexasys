<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--[if lt IE 9]>
<script src="https://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js" charset="utf-8"></script>
<script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js" charset="utf-8"></script>
<![endif]-->
<!--jQuery-->
<script src="${pageContext.request.contextPath}/common/jslib/bootstrap-3.3.7/js/jquery.min.js"></script>
<!--Bootstrap-->
<!-- Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/common/jslib/bootstrap-3.3.7/css/bootstrap.min.css">
<!-- 可选的 Bootstrap 主题文件 -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/common/jslib/bootstrap-3.3.7/css/bootstrap-theme.min.css">
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="${pageContext.request.contextPath}/common/jslib/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<!--bootstrap-file-upload-->
<link href="${pageContext.request.contextPath}/common/jslib/bootstrap-fileupload/fileinput.min.css"
      rel="stylesheet"
      charset="utf-8">
<script src="${pageContext.request.contextPath}/common/jslib/bootstrap-fileupload/fileinput.min.js"
        charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/common/jslib/bootstrap-fileupload/zh.js" charset="utf-8"></script>
<%--jquery-form--%>
<script src="${pageContext.request.contextPath}/common/jslib/jquery-form/jquery.form.js" charset="utf-8"></script>
<!-- toastr插件 -->
<link href="${pageContext.request.contextPath}/common/jslib/toastr/toastr.css" rel="stylesheet" charset="utf-8">
<script src="${pageContext.request.contextPath}/common/jslib/toastr/toastr.js" charset="utf-8"></script>
<%--表单序列化--%>
<script src="${pageContext.request.contextPath}/common/jslib/kit/form2Json.js" charset="utf-8"></script>
<%--样式--%>
<link href="${pageContext.request.contextPath}/common/jslib/kit/myStyle.css" rel="stylesheet" charset="utf-8">
<!-- sweetalert插件 -->
<link href="${pageContext.request.contextPath}/common/jslib/sweetAlert/sweetalert.css" rel="stylesheet"
      charset="utf-8">
<script src="${pageContext.request.contextPath}/common/jslib/sweetAlert/sweetalert.min.js"
        charset="utf-8"></script>
<!-- bootstrap-table插件 -->
<link href="${pageContext.request.contextPath}/common/jslib/bootstrap-table/bootstrap-table.min.css"
      rel="stylesheet"
      charset="utf-8">
<script src="${pageContext.request.contextPath}/common/jslib/bootstrap-table/bootstrap-table.min.js"
        charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/common/jslib/bootstrap-table/bootstrap-table-zh-CN.js"
        charset="utf-8"></script>
<script charset="UTF-8">
    $.fn.bootstrapTable.queryParams = function (params) {
        params.pageSize = params.limit;
        params.pageNum = params.offset / params.limit + 1;
        return params;
    }
</script>
<%--select2--%>
<script src="${pageContext.request.contextPath}/common/jslib/select2/select2.min.js" charset="utf-8"></script>
<link href="${pageContext.request.contextPath}/common/jslib/select2/select2.min.css" rel="stylesheet"
      charset="utf-8">
<script src="${pageContext.request.contextPath}/common/jslib/select2/zh-CN.js" charset="utf-8"></script>
<%--bootstrap-data-export--%>
<script src="${pageContext.request.contextPath}/common/jslib/table-export/bootstrap-table-export.js"
        charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/common/jslib/table-export/tableExport.min.js"
        charset="utf-8"></script>
<%--2版bootstrap样式--%>
<link href="${pageContext.request.contextPath}/common/jslib/bootstrap-2.3.2/bootstrap-responsive.min.css"
      rel="stylesheet" charset="utf-8">
<%--editable--%>
<script src="${pageContext.request.contextPath}/common/jslib/editable/bootstrap-table-editable.js"
        charset="utf-8"></script>
<link href="${pageContext.request.contextPath}/common/jslib/editable/bootstrap-editable.css"
      rel="stylesheet" charset="utf-8">
<script src="${pageContext.request.contextPath}/common/jslib/editable/bootstrap-editable.min.js"
        charset="utf-8"></script>
<%--combodate--%>
<script src="${pageContext.request.contextPath}/common/jslib/combodate/combodate.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/common/jslib/combodate/moment.min.js" charset="utf-8"></script>
<link href="${pageContext.request.contextPath}/common/jslib/select2/select2-bootstrap.css" rel="stylesheet"
      charset="utf-8">