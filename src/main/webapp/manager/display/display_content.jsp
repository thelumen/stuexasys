<%--
  Created by IntelliJ IDEA.
  User: wade
  Date: 2017/8/22
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<body style="background: url(${pageContext.request.contextPath}/common/image/1293375.jpg);background-attachment: fixed">
<header>
    <span style="font-family: 华文楷体;font-size: 30px;color: #1b6d85">功能简介</span>
</header>
<div class="col-md-6">
    <h4>教师管理</h4>
    <ul>
        <li>
            添加教师&编辑
        </li>
        <li>
            添加教师时，教工号和密码为必填字段，其他值不添加将会采用默认值。
        </li>
        <li>
            编辑教师时，教工号不可修改，密码以加密后的状态显示
        </li>
        <li>
            删除按钮，将会移除这名教师在数据库中的所有信息，包括这名教师所教的课程、所发布的考试信息。
        </li>
        <li>
            导出全部教师信息, 可选择的导出类型
        </li>
    </ul>
    <h4>学生管理</h4>
    <ul>
        <li>
            进入此页面时，默认加载预留专业学生，预留专业是为降级未处理、特殊原因（参军、休学等）等学生特别设置的专业。
        </li>
        <li>
            查找：当选择专业未输入学号时，查找显示为选中的专业的全部学生。<br>
            当选择专业且输入了一个学号时，查找显示为选中专业中此学号的学生。<br>
            当只输入了一个学号未选择专业时，查找为从全部学生中查找此学号的学生信息。<br>
            如果什么都不选择，则加载预留专业学生
        </li>
        <li>
            修改学生信息后需要点击保存，修改密码时，请先将提示文本“修改密码”删除，再添加新密码。
        </li>
        <li>
            删除学生将会从学生表中删除此学生，但会保留此学生的考试信息。
        </li>
        <li>
            可以导出学生信息
        </li>
        <li>
            一个专业的学生毕业时，先前往学生管理页面处理降级等特殊学生，将这些学生添加到预留专业，然后前往专业&学科页面删除专业。
        </li>
    </ul>
    <h4>专业&学科</h4>
    <ul>
        <li>
            修改专业，只能修改专业名，不能修改专业号
        </li>
        <li>
            删除专业时，不仅此专业被删除，包括此专业下的全部学生和教师对这个专业的选课信息都将被删除。
        </li>
        <li>
            修改课程时，除课程号外，都可以修改。
        </li>
        <li>
            课程删除，只删除此课程信息，相关联的信息会得到保留。
        </li>
    </ul>
</div>
<div class="col-md-6">
    <h4>上传学生</h4>
    <ul>
        <li>
            只接受.Xls后缀的Excel文件
        </li>
        <li>
            可在上传界面下载模板，填写时请勿将第一行表头删除。
        </li>
        <li>
            请仔细检查每个专业的第一条学生信息，保证其正确性。
        </li>
        <li>
            当前四列某一个单元格未填写时，上传会失败，并提示您错误行，当提示服务器出错时，请联系QQ:627252995。
        </li>
        <li>
            系统只会读取前四列，额外添加的列信息不会被读取。
        </li>
        <li>
            服务器中没有的专业，将会自动添加，服务器只会录入表格中的新数据，数据库中已存在的学生和专业将会被自动忽略.<br>
            也就是说当您只想上传一个学生时，可以下载一个模板添加这名学生的信息上传，也可以将这名学生的信息添加到之前上传表中，保存后上传。
        </li>
        <li>
            上传学生时，数据库中不存在的专业将会自动录入，不需要先新增专业，再上传学生。
        </li>
    </ul>
</div>
</body>
