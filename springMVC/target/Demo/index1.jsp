<%--
  Created by IntelliJ IDEA.
  User: wangz
  Date: 2017/11/6
  Time: 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Title</title>

    <!-- jQuery -->
    <script type="text/javascript" charset="utf8" src="dataTable/js/jquery.js"></script>


    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="dataTable/css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="dataTable/css/dataTables.bootstrap.css">


    <!-- DataTables -->
    <script type="text/javascript" charset="utf8" src="dataTable/js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf8" src="dataTable/js/dataTables.bootstrap.js"></script>


    <script>

        $(document).ready( function () {
            var table =  $('#myTable').DataTable({
                language: {
                    url:"scripts/zh_CN.txt"
                },
                "info" : true,
                "paging": true,
                "processing":true,       //加载效果
                "searching": true,


                "bServerSide": true, //是否启动服务器端数据导入
//                "aLengthMenu": [
//                    [10, 20, 50],
//                    [10, 20, 50]
//                ], //更改显示记录数选项
//                "iDisplayLength": 10, //默认显示的记录数
//                "sPaginationType": "bootstrap", //详细分页组，可以支持直接跳转到某页
                "aaSorting": [
                    [0, "desc"]
                ], //默认的排序方式，第1列，升序排列
//                "bFilter": false, //是否启动过滤、搜索功能
//                "bDestroy": true,
//                "bLengthChange": true,


                //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
                //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
                columns: [
                    { data: 'id' },
                    { data: 'name' },
                    { data: 'job' },
                    { data: 'phone' }
                ],
                //开启服务器模式
//                serverSide: true,
                "sAjaxSource": "/demo/findAll"
            });

        } );

    </script>



</head>
<body>


<table id="myTable" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>编号</th>
        <th>姓名</th>
        <th>工作</th>
        <th>电话</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>


</body>
</html>
