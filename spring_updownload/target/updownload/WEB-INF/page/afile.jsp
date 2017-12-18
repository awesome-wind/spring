<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>上传图片</title>
    <%--<base href="<%=basePath%>">--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

    <form action="onefile" method="post" enctype="multipart/form-data" >
        <input type="file" name="file" />
        <input type="submit" value="上 传" />
    </form>
    <%--<h5>上传结果：</h5>--%>
    <%--<%--%>
        <%--String url = (String) request.getAttribute("fileURL");--%>
        <%--System.out.println("url:" + url);--%>
    <%--%>--%>
    <%--${ fileURL }--%>
    <%--<img alt="暂无图片" src="${ fileURL }" />--%>

</body>
</html>