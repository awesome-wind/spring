<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <script type="text/javascript" src="/static/jquery-3.2.1.js"></script>

    <title>下载文件显示页面</title>


    <script type="text/javascript">
        function showFile(name,downURL) {
            var path = "/images/"+name;
            var html = "<img alt='暂无图片' src="+path+"  width='180px' onclick='downFile(this)'/>";
            var picture = test(name);
            html+=picture+"<a href="+downURL+">下载</a></br>";
            $('#picture').append(html);
        }

        function downFile(obj) {
            window.location.href=obj.src;
        }

        function test(key) {
            var arr = key.split("-");
            var name = arr[5];
            for(var i =6 ;i<arr.length;i++){
                name = name+"-"+arr[i];
            }
            return name;
        }
    </script>

</head>

<body>
<!-- 遍历Map集合 -->
<c:forEach var="me" items="${fileNameMap}">
    <c:url value="/down" var="downURL">
        <c:param name="filePath" value="${me.value}"></c:param>
        <%--<c:param name="fileName" value="${me.key}"></c:param>--%>
    </c:url>

    <%--js中完成对图片标题的剪切,或者在后端的key先剪切后再放入map中--%>
    <%--<script type="text/javascript">document.write(test('${me.key}'));</script>--%>
    <%--<a href="${downURL}">下载</a>--%>
    <%--<input type="button" value="图片" onclick="showFile('${me.key}')"/><br>--%>
    <script type="text/javascript">
        $(function () {
            showFile('${me.key}','${downURL}');
        })

    </script>



</c:forEach>

<div id="picture" >

</div>


</body>
</html>
