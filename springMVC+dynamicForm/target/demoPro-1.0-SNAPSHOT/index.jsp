<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Title</title>


    <script type="text/javascript" charset="utf8" src="dataTable/js/jquery-3.2.1.js"></script>
    <link rel="stylesheet" type="text/css" href="dataTable/css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="dataTable/css/dataTables.bootstrap.css">
    <script type="text/javascript" charset="utf8" src="dataTable/js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf8" src="dataTable/js/dataTables.bootstrap.js"></script>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <script>

        $(document).ready( function () {

            $.ajaxPrefilter(function( options, original_Options, jqXHR ) {
                options.async = true;
            });

           function table() {
                $('#myTable').DataTable({
                    language: {
                        url: "dataTable/zh_CN.txt"
                    },
                    info: true,
                    paging: true,
                    bServerSide: true, //是否启动服务器端数据导入
                    bSort:false,
                    sAjaxSource: "/user/findAll",         //请求的地址
                    fnServerData: retrieveData,           // 获取数据的处理函数
                    autoWidth: false,  //禁用自动调整列宽
                    stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
                    processing: true,  //隐藏加载提示,自行处理
                    serverSide: true,  //启用服务器端分页
                    searching: false,  //禁用原生搜索
                    orderMulti: false,  //启用多列排序
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
                        {data: 'address'},
                        {data: function (obj) {
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
            }

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
                        alert("初始化信息失败");
                    }
                });
            }

            table();

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

                $("#name").val("");
                $("#job").val("");
                $("#phone").val("");
                $("#address").val("");

            });


            $("#btn_confirm").click( function(){

                var addData={
                    "id":$("#id").val(),
                    "name":$("#name").val(),
                    "job":$("#job").val(),
                    "phone":$("#phone").val(),
                    "address":$("#address").val()
                };

                $.ajax({
                    type:"GET",
                    url:"user/addOne",
                    data:addData,
                    dataType:"json",
                    contentType:'application/json;charset=UTF-8',
                    success:function (returnData) {

                        alert(returnData.id);
//                        window.location.reload();
//                        table();
                    }
                });
            });
        });

    </script>

    <%-- 查询，修改，删除--%>
    <script>

        //查询
        show_detail = function(detail_id)
        {
            $("#myModal_do").modal({
                keyword:true
            });

            $("#model_tab_div").empty();
            $("#id_do").hide();

            $.ajax({
                type:"GET",
                url:"/user/findOne",
                data:{"id":detail_id},
                dataType: 'json',
                contentType:"application/json;charset=UTF-8",
                success:function (returnData) {

                    var dataObj = returnData.data;
                    var works = dataObj.worksById;
//                    alert(works.length);

                    $("#id_do").val(dataObj.id);
                    $("#name_do").val(dataObj.name);
                    $("#job_do").val(dataObj.job);
                    $("#phone_do").val(dataObj.phone);
                    $("#address_do").val(dataObj.address);


                    var htm="<table id='model_tab'  border='0' align='center'>";
                    if(works.length == 0)
                    {
                        htm+="";
                    }
                    else
                    {
                        htm+="<tr><td width='12%'>序号：<input type='text' class='btn btn-default' style='width: 45%' value='"+works[0].num+"' disabled='disabled'></td>\n" +
                            "<td width='18%'>时间：<input type='text' class='btn btn-default' style='width: 60%' value='"+works[0].date+"' disabled='disabled'></td>\n" +
                            "<td width='20%'>地点：<input type='text' class='btn btn-default' style='width: 65%' value='"+works[0].city+"'  disabled='disabled'></td>\n" +
                            "<td width='50%'>事由：<input type='text' class='btn btn-default' style='width: 80%' align='left' value='"+works[0].workInfo+"' disabled='disabled'></td></tr>;"



                        for(var i=1;i<works.length;i++)
                        {
                            htm+="<tr><td width='12%'>序号：<input type='text' class='btn btn-default' style='width: 45%' value='"+works[i].num+"' disabled='disabled'></td>\n" +
                                "<td width='18%'>时间：<input type='text' class='btn btn-default' style='width: 60%' value='"+works[i].date+"' disabled='disabled'></td>\n" +
                                "<td width='20%'>地点：<input type='text' class='btn btn-default' style='width: 65%' value='"+works[i].city+"'  disabled='disabled'></td>\n" +
                                "<td width='50%'>事由：<input type='text' class='btn btn-default' style='width: 80%' align='left' value='"+works[i].workInfo+"' disabled='disabled'></td></tr>"
                        }

                    }

                    htm+="</table>";
//
                    $("#model_tab_div").append(htm);


                }

            });

            $("#address_do").attr("disabled","disabled");
            $("#name_do").attr("disabled","disabled");
            $("#job_do").attr("disabled","disabled");
            $("#phone_do").attr("disabled","disabled");

        }


        //修改
        show_modify = function(modify_id){
            $("#myModal_do").modal({
                keyword:true
            });

            $("#model_tab_div").empty();
            $("#id_do").hide();


            $.ajax({
                type:"GET",
                url:"/user/findOne",
                data:{"id":modify_id},
                dataType: 'json',
                contentType:"application/json;charset=UTF-8",
                success:function (returnData) {
                    var dataObj = returnData.data;
                    var works = dataObj.worksById;

                    $("#id_do").val(dataObj.id);
                    $("#name_do").val(dataObj.name);
                    $("#job_do").val(dataObj.job);
                    $("#phone_do").val(dataObj.phone);
                    $("#address_do").val(dataObj.address);


                    var htm="<table id='model_tab'  border='0' align='center'>";
                    if(works.length == 0)
                    {
                        htm+="<tr><td width='12%'>序号：<input type='text' class='btn btn-default' style='width: 50%' value=''></td>\n" +
                            "<td width='18%'>时间：<input type='text' class='btn btn-default' style='width: 65%' value=''></td>\n" +
                            "<td width='20%'>地点：<input type='text' class='btn btn-default' style='width: 65%' value='' ></td>\n" +
                            "<td width='50%'>事由：<input type='text' class='btn btn-default' style='width: 80%' align='left' value=''></td>"+
                            "<td ><button type=\"button\"   class=\"btn btn-default btn-sm\" id='btn_add_row' onclick='addRow()'>" +
                            "<span class=\"glyphicon glyphicon-plus\"></span>" +
                            "</button></td></tr>";
                    }
                    else
                    {
                        htm+="<tr><td width='12%'>序号：<input type='text' class='btn btn-default' style='width: 50%' value='"+works[0].num+"'></td>\n" +
                            "<td width='18%'>时间：<input type='text' class='btn btn-default' style='width: 65%' value='"+works[0].date+"'></td>\n" +
                            "<td width='20%'>地点：<input type='text' class='btn btn-default' style='width: 65%' value='"+works[0].city+"' ></td>\n" +
                            "<td width='50%'>事由：<input type='text' class='btn btn-default' style='width: 80%' align='left' value='"+works[0].workInfo+"'></td>"+
                            "<td ><button type=\"button\"   class=\"btn btn-default btn-sm\" id='btn_add_row' onclick='addRow()'>" +
                            "<span class=\"glyphicon glyphicon-plus\"></span>" +
                            "</button></td></tr>";


                        for(var i=1;i<works.length;i++)
                        {
                            htm+="<tr><td width='12%'>序号：<input type='text' class='btn btn-default' style='width: 50%' value='"+works[i].num+"'></td>\n" +
                                "<td width='18%'>时间：<input type='text' class='btn btn-default' style='width: 65%' value='"+works[i].date+"'></td>\n" +
                                "<td width='20%'>地点：<input type='text' class='btn btn-default' style='width: 65%' value='"+works[i].city+"' ></td>\n" +
                                "<td width='50%'>事由：<input type='text' class='btn btn-default' style='width: 80%' align='left' value='"+works[i].workInfo+"'></td>"+
                                "<td ><button type=\"button\"   class=\"btn btn-default btn-sm\" id='btn_add_row' onclick='deleteRow(this)'>" +
                                "<span class=\"glyphicon glyphicon-minus\"></span>" +
                                "</button></td></tr>";
                        }

                    }

                    htm+="</table>";
                    $("#model_tab_div").append(htm);
                }
            });

            $("#id_do").attr("disabled","disabled");
            $("#name_do").removeAttr("disabled");
            $("#job_do").removeAttr("disabled");
            $("#phone_do").removeAttr("disabled");
            $("#address_do").removeAttr("disabled");

        }


        $(function () {
            $("#btn_confirm_do").click(function(){
                var id   = $("#id_do").val();
                var name = $("#name_do").val();
                var job  = $("#job_do").val();
                var phone= $("#phone_do").val();
                var address = $("#address_do").val();

                var mytable = document.getElementById("model_tab");

                var arr = [];
                for(var i=0;i<mytable.rows.length; i++)
                    arr[i] = new Array();



                for(var i=0;i<mytable.rows.length; i++){

                    for(var j=0;j<mytable.rows[i].cells.length-1; j++){

                        arr[i][j] = mytable.rows[i].cells[j].getElementsByTagName("input")[0].value;

                    }
                }

                var data={"id":id,"name":name,"job":job,"phone":phone,"address":address,"arr[][]":arr};

                $.ajax({
                    type:"GET",
                    url:"/user/modifyOne",
                    data:data,
                    dataType:'json',
                    contentType:'application/json;charset=UTF-8',
                    success:function (returnData) {

                    },
                    error: function (msg) {
                        alert("modify error");

                    }
                });
            });
        })

        show_delete = function(delete_id)
        {
            $.ajax({
                type:"GET",
                url:"user/delOne",
                data:{"id":delete_id},
                dataType:"json",
                contentType:'application/json;charset=UTF-8',
                success:function (returnData) {
                }
            });
            window.location.reload();
        }
    </script>



    <%--动态表格--%>
    <script type="text/javascript">
        function addRow() {
            //取得对象
            var tab=document.getElementById("model_tab");
            //添加行
            var row = tab.insertRow(tab.rows.length);;
            //添加三列
            var td1=row.insertCell(row.cells.length);
            var td2=row.insertCell(row.cells.length);
            var td3=row.insertCell(row.cells.length);
            var td4=row.insertCell(row.cells.length);
            var td5=row.insertCell(row.cells.length);
            td1.innerHTML = "序号：<input type=\"text\" class=\"btn btn-default\" style=\"width: 50%\" >";
            td2.innerHTML = "时间：<input type=\"text\" class=\"btn btn-default\" style=\"width: 65%\" >";
            td3.innerHTML = "地点：<input type=\"text\" class=\"btn btn-default\" style=\"width: 65%\" >";
            td4.innerHTML = "事由：<input type=\"text\" class=\"btn btn-default\" style=\"width: 80%\" align=\"left\">";
            td5.innerHTML = "<button type=\"button\"   class=\"btn btn-default btn-sm\" onclick='deleteRow(this)'>\n" +
                "                            <span class=\"glyphicon glyphicon-minus\"></span>\n" +
                "                        </button>";
        }

        function deleteRow(obj){
            var row=obj.parentNode.parentNode;
            var tab=row.parentNode;
            if(row.rowIndex > 0 )
                tab.deleteRow(row.rowIndex);
        }

    </script>




    <%--模糊搜索功能实现--%>
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
        <button type="button" class="btn btn-default" data-toggle="modal" id="btn_add">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>

    </div>


    <div  style="margin: 10px 10px 10px 10px">
        <table id="myTable" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%">

            <thead>
            <tr>
                <th>编号</th>
                <th>姓名</th>
                <th>工作</th>
                <th>电话</th>
                <th>地址</th>
                <th>选项</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>


    <!-- 模态框（Modal）增加 -->
    <div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel" align="center">人事信息增加</h4>
                </div>
                <div class="modal-body" align="center">

                    <%--<label>编号：<input type="text" id="id"></label>--%>
                    <label>姓名：<input type="text" class="btn btn-default" id="name"></label><br>
                    <label>职位：<input type="text" class="btn btn-default" id="job"></label><br>
                    <label>电话：<input type="text" class="btn btn-default" id="phone"></label><br>
                    <label>籍贯：<input type="text" class="btn btn-default" id="address"></label><br>

                </div>
                <div class="modal-footer" align="center">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_confirm">确认</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <!-- 模态框（Modal） 查询，修改 -->
    <div class="modal" id="myModal_do" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog"  style="width: 60%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel_do" align="center">详情</h4>
                </div>
                <div class="modal-body" align="center">

                    <label id="id_do">编号：<input type="text" class="btn btn-default" ></label>
                    <label>姓名：<input type="text" class="btn btn-default" id="name_do"></label>
                    <label>职位：<input type="text" class="btn btn-default" id="job_do"></label><br>
                    <label>电话：<input type="text" class="btn btn-default" id="phone_do"></label>
                    <label>籍贯：<input type="text" class="btn btn-default" id="address_do"></label><br><br>

                    <div id="model_tab_div">

                    </div>

                </div>

                <div class="modal-footer" align="center">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_confirm_do">确认</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>


</body>
</html>