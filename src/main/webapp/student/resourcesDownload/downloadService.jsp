<%--
  Created by IntelliJ IDEA.
  User: 花间一壶酒
  Date: 2017/8/13
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="application/x-msdownload" pageEncoding="UTF-8" %>
<%
    //关于文件下载时采用文件流输出的方式处理：
//    String bath = request.getSession().getServletContext().getRealPath("");
    String localPath = "C:/搬移文件/Desktop/资源文件/";
    response.setContentType("application/x-download");
    String fileDownloadName = localPath + request.getParameter("fileDownloadName"); // 下载的文件的物理路径＋文件名
//    String fileDisplayName = String.valueOf(System.currentTimeMillis()) + fileDownloadName.substring(fileDownloadName.lastIndexOf("."), fileDownloadName.length()); // 给用户提供的下载文件名
    String fileDisplayName = request.getParameter("fileDisplayName");
    fileDisplayName = URLEncoder.encode(fileDisplayName, "UTF-8");
    response.setHeader("Content-disposition", "attachment; filename=" + new String(fileDisplayName.getBytes("UTF-8"), "iso8859-1"));
//    response.addHeader("Content-Disposition", "attachment;filename=" + fileDisplayName);
    OutputStream outp = null;
    FileInputStream in = null;
    try {
        outp = response.getOutputStream();
        in = new FileInputStream(fileDownloadName);
        byte[] b = new byte[1024];
        int i;
        while ((i = in.read(b)) > 0) {
            outp.write(b, 0, i);
        }
        outp.flush();
    } catch (Exception e) {
        System.out.println("文件下载失败!");
        e.printStackTrace();
    } finally {
        if (in != null) {
            in.close();
            in = null;
        }
        if (outp != null) {
            outp.close();
            outp = null;
            out.clear();
            out = pageContext.pushBody();
        }
    }
%>