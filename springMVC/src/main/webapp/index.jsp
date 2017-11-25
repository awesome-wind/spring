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
    <%--<script src="bootstrap/bootstrap.js"></script>--%>


    <%--<!-- DataTables CSS -->--%>
    <link rel="stylesheet" type="text/css" href="dataTable/css/jquery.dataTables.css">
    <%--<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">--%>

    <link rel="stylesheet" type="text/css" href="dataTable/css/dataTables.bootstrap.css">
    <%--<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.css">--%>


    <%--<!-- DataTables -->--%>
    <script type="text/javascript" charset="utf8" src="dataTable/js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf8" src="dataTable/js/dataTables.bootstrap.js"></script>
    <%--<script type="text/javascript" charset="UTF-8" src="bootstrap/js/bootstrap.js"></script>--%>
    <%--<script type="text/javascript" charset="UTF-8" src="bootstrap/js/model.js"></script>--%>

    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <%--<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>--%>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <script>

        $(document).ready( function () {
            var table = $('#myTable').DataTable({
                language: {
                    url: "scripts/zh_CN.txt"
                },
                info: true,
                paging: true,
                bServerSide: true, //是否启动服务器端数据导入
                sAjaxSource: "/demo/tableDemoAjax",         //请求的地址
                fnServerData: retrieveData,           // 获取数据的处理函数
                autoWidth: false,  //禁用自动调整列宽
                stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
                processing: true,  //隐藏加载提示,自行处理
                serverSide: true,  //启用服务器端分页
                searching: false,  //禁用原生搜索
//                orderMulti: true,  //启用多列排序
                order: [],  //取消默认排序查询,否则复选框一列会出现小箭头
                renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
                pagingType: "simple_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
                columnDefs: [{
                    "targets": 'nosort',  //列的样式名
                    "orderable": false    //包含上样式名‘nosort’的禁止排序
                }],

                columns: [
                    {data: 'id'},
                    {data: 'name'},
                    {data: 'job'},
                    {data: 'phone'},
                    {data: function (obj) {
//                            op1 = "<a class=\"btn btn-default btn-xs\" style=\"background-color: cornflowerblue;color: white;\" onclick=\"ddl_detail(\'" + obj.id + "\');\">详情</a>";
//                            op2 = "<a class=\"btn btn-default btn-xs\" style=\"background-color: cornflowerblue;color: white;\" onclick=\"ddl_edit(\'" + obj.id + "\');\">编辑</a>";
//                            op3 = "<a class=\"btn btn-default btn-xs red\" style=\"background-color: cornflowerblue;color: white;\" onclick=\"ddl_delete(\'" + obj.id + "\');\">删除</a>";
                        op = "<div id='toolbar' class='btn-group'>";
                        op1 = "<button id='btn_edit' type='button' class='btn btn-default' onclick='show_detail(" + obj.id + ");'><span class='glyphicon glyphicon-list' aria-hidden='true'></span>详情</button>";
                        op2 = "<button id='btn_edit' type='button' class='btn btn-default' onclick='show_modify(" + obj.id + ");'><span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>修改</button>";
                        op3 = "<button id='btn_edit' type='button' class='btn btn-default' onclick='show_delete(" + obj.id + ");'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span>删除</button>";
                        op_ = "</div>";
                        return op + op1  + op2  + op3 +op_;
                        }
                    }
                ]
            });


            function retrieveData(sSource, aoData, fnCallback) {


                $.ajax({
                    url: sSource,                              //这个就是请求地址对应sAjaxSource
                    data: {"aoData": JSON.stringify(aoData)},   //这个是把datatable的一些基本数据传给后台,比如起始位置,每页显示的行数 ,分页,排序,查询等的值
                    type: 'GET',
                    dataType: 'json',
                    async: false,
                    success: function (result) {
                        fnCallback(result);                     //把返回的数据传给这个方法就可以了,datatable会自动绑定数据的
                    },
                    error: function (msg) {
                    }
                });
            }
        });
    </script>


    <%--人员信息增加--%>
    <script type="text/javascript">

        $(function () {
            $("#btn_add").click(function () {

                $("#myModal").modal({
                    keyword:true
                });

                $("#id_label").hide();

                $("#name").attr("value","");
                $("#job").attr("value","");
                $("#phone").attr("value","");


                $("#name").removeAttr("disabled");
                $("#job").removeAttr("disabled");
                $("#phone").removeAttr("disabled");


            });


            $("#btn_confirm").click( function(){

                var addData={
                    "id":$("#id").val(),
                    "name":$("#name").val(),
                    "job":$("#job").val(),
                    "phone":$("#phone").val()

                };


                $.ajax({
                    type:"GET",
                    url:"demo/addOne",
                    data:addData,
                    dataType:"json",
                    contentType:'application/json;charset=UTF-8',
                    success:function (returnData) {

                    }
                });
                window.location.reload();
            });

        });
    </script>

    <%--查询，修改，删除--%>
    <script type="text/javascript">
        //查询
        show_detail = function(detail_id)
        {
            $("#myModal").modal({
                keyword:true
            });

            $("#id_label").show();

            $.ajax({
                type:"GET",
                url:"/demo/findOne",
                data:{"id":detail_id},
                dataType: 'json',
                contentType:"application/json;charset=UTF-8",
                success:function (returnData) {
                    var dataObj = returnData.data;
                    $("#id").attr("value",dataObj.id);
                    $("#name").attr("value",dataObj.name);
                    $("#job").attr("value",dataObj.job);
                    $("#phone").attr("value",dataObj.phone);
                }
            });

            $("#id").attr("disabled","disabled");
            $("#name").attr("disabled","disabled");
            $("#job").attr("disabled","disabled");
            $("#phone").attr("disabled","disabled");

        }

        //修改
        show_modify = function(modify_id)
        {
            $("#myModal").modal({
                keyword:true
            });

            $.ajax({
                type:"GET",
                url:"/demo/findOne",
                data:{"id":modify_id},
                dataType: 'json',
                contentType:"application/json;charset=UTF-8",
                success:function (returnData) {
                    var dataObj = returnData.data;
                    $("#id").attr("value",dataObj.id);
                    $("#name").attr("value",dataObj.name);
                    $("#job").attr("value",dataObj.job);
                    $("#phone").attr("value",dataObj.phone);
                }
            });

            $("#id_label").show();
//            $("#id").attr("value",modify_id);
//            $("#name").attr("value",modify_id);
//            $("#id").attr("value",modify_id);
//            $("#id").attr("value",modify_id);

            $("#id").attr("disabled","disabled");
            $("#name").removeAttr("disabled");
            $("#job").removeAttr("disabled");
            $("#phone").removeAttr("disabled");

            $("#btn_confirm").click(function(){
                var id   = $("#id").val;
                var name = $("#name").val();
                var job  = $("#job").val();
                var phone= $("#phone").val;

                var modifyData={"id":id,"name":name,"job":job,"phone":phone};
//                alert(modifyData.phone);

                $.ajax({
                    type:"GET",
                    url:"/demo/modifyOne",
                    data:modifyData,
                    dataType:'json',
                    contentType:'application/json;charset=UTF-8',
                    success:function (returnData) {

                    }
                });
                window.location.reload();
            });
        }


        //  删除
        show_delete = function(delete_id)
        {
            $.ajax({
                type:"GET",
                url:"demo/deleteById",
                data:{"id":delete_id},
                dataType:"json",
                contentType:'application/json;charset=UTF-8',
                success:function (returnData) {
                }
            });
            window.location.reload();
        }


    </script>

    <%--搜索功能实现--%>


    <script type="text/javascript">
        $(function(){
            $("#btn_search").click(function(){
                var txt=$("#txt").val();
                if($.trim(txt)!=""){

                    $("table tr:not('#theader')").hide().filter(":contains('"+txt+"')").show();
                }else{
                    $("table tr:not('#theader')").css("background","#fff").show();
                }
            });
        })
    </script>






</head>
<body>

<div style="margin: 10px; background: gainsboro" align="right" >

    <input type="text" id="txt" class="btn btn-default" align="right">
    <input type="button" id="btn_search" class="btn btn-default" value="搜索" align="right">
    <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>

</div>

<!-- 模态框（Modal） -->
<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" align="center">人事信息增加</h4>
            </div>
            <div class="modal-body" align="center">

                <label id="id_label">编号：<input type="text" id="id"></label><br>
                <label>姓名：<input type="text" id="name"></label><br>
                <label>职位：<input type="text" id="job"></label><br>
                <label>电话：<input type="text" id="phone"></label><br>

            </div>
            <div class="modal-footer" align="center">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_confirm">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<div  style="margin: 10px 10px 10px 10px">
    <table id="myTable" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%">

        <thead>
        <tr>
            <th>编号</th>
            <th>姓名</th>
            <th>工作</th>
            <th>电话</th>
            <th>选项</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>


</body>
</html>
