<%--suppress ALL --%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


    <title>人员信息表</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <link rel="stylesheet" type="text/css" href="scripts/sheet.css">
    <link rel="stylesheet" type="text/css" href="scripts/pop-ups.css">
    <script type="text/javascript" src="scripts/jquery-3.2.1.js"></script>

    <script type="text/javascript">
        $(document).ready(function()
        {
            $.ajax(
				{
					type:"GET",
					url:"demo/findAll",
                    data:{},
					datatype:'json',
                    contentType:'application/json;charset=UTF-8',
					success:function(returnData)   //returnData是Servlet返回的数据
					{
                        var jsonObj=returnData.data;

						var html="<table border='1' width='100%' height='100%'><tr> <th>编号</th> <th>姓名</th> <th>工作</th> <th>电话</th> <th width='30%'>选项</th></tr>";

                        for(var i=0;i<jsonObj.length;i++)
                        {
                            html+="<tr align='center'><td>"+jsonObj[i].id+"</td><td>"+jsonObj[i].name+"</td><td>"+jsonObj[i].job+"</td>" +
                                "<td>"+jsonObj[i].phone+"</td><td><input class='button blue' type='button' value='修改' onclick='show("+jsonObj[i].id+")'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                                "<input class='button orange' type='button' value='删除' onclick='deleteById("+jsonObj[i].id+")'></td></tr>";

                        }

                        html+="</table>";

                        $("#mytable table:first").remove();
                        $("#mytable").append(html);


                    }

				});


//            $("#btn").click(function()
//            {
//				$.ajax(
//				{
//					type:"GET",
//					url:"XMLServlet",
//					datatype:"xml",
//					data:{"name":"zhangsan"},
//					success:function(returnData)   //returnData是jsonServlet返回的数据
//					{
//						var id=$(returnData).find("id").text();
//						var name=$(returnData).find("name").text();
//						var age=$(returnData).find("age").text();
//						var address=$(returnData).find("address").text();
//
//						var html="<table border='1' width='60%' align='center'><tr> <th>id</th> <th>name</th> <th>age</th> <th>address</th></tr>"+
//						"<tr align='center'><td>"+id+"</td><td>"+name+"</td><td>"+age+"</td><td>"+address+"</td></tr></table>";
//
//						$("#mybody table:first").remove();
//						$("#mybody").append(html);
//					}
//				});
//
//
//
//                //也可以在进行简化，直接调用jQuery的post方法，接受三个参数，分别为目标地址url，数据和成功后的回调函数
//                $.post(
//                    "XMLServlet", {"name":"zhangsan"}, function(returnData,status)   //status为响应的状态值，成功时为200，一般用不上
//                    {
//                        var id=$(returnData).find("id").text();
//                        var name=$(returnData).find("name").text();
//                        var age=$(returnData).find("age").text();
//                        var address=$(returnData).find("address").text();
//
//                        var html="<table border='1' width='60%' align='center'><tr> <th>id</th> <th>name</th> <th>age</th> <th>address</th></tr>"+
//                            "<tr align='center'><td>"+id+"</td><td>"+name+"</td><td>"+age+"</td><td>"+address+"</td></tr></table>";
//
//                        $("#mybody table:first").remove();
//                        $("#mybody").append(html);
//                    }
//                );
//
//            });
        });

    </script>

    <%--修改--%>
    <script type="text/javascript">
        function show(id){
           // alert(id);
//            document.getElementById('container').innerHTML="";
           $.ajax({
               type:"GET",
               url:"demo/findById",
               data:{"id":id},
               datatype:"json",
               contentType:'application/json;charset=UTF-8',
               success:function (returnData) {
                    user = returnData.data;                        //此处多加了一个var
//                    alert(user.name);

                    var html ="<h2 align='center'>******人事修改******</h2><br>";
                    html+="<form onsubmit='return modify();'>"
                    html+="编号:<input type='text' id='id' value="+user.id+"><br>";
                    html+="姓名:<input type='text' id='name' value="+user.name+" ><br>";
                    html+="工作:<input type='text' id='job' value="+user.job+" ><br>";
                    html+="电话:<input type='text' id='phone' value="+user.phone+"><br><br>";
                    html+="<input type='submit' value='保存'>"
                    html+="</form>"
                   createModalDialog("success","人事详情", html);
//                   document.getElementById('container').innerHTML="";
//                   $("#container").append(html);


               }
           });
        }
        
        function modify() {
            var id=document.getElementById("id");
            var name=document.getElementById("name");
            var job=document.getElementById("job");
            var phone=document.getElementById("phone");


            $.ajax({
                type:"GET",
                url:"demo/modifyOne",
                data:{"id":id.value,"name":name.value,"job":job.value,"phone":phone.value},
                datatype:"json",
                contentType:'application/json;charset=UTF-8',
                success:function (returnData) {
//                    var obj = returnData.data[0];
//                    alert(obj.name);

                }
            });
        }

    </script>

    <script type="text/javascript">



    </script>



    <%--增加--%>
    <script type="text/javascript">

        function addInfo() {
            var html ="<h2 align='center'>******增加人员信息******</h2><br>";
            html+="<form onsubmit='return add();'>"
            html+="编号:<input type='text' id='id'><br>";
            html+="姓名:<input type='text' id='name'><br>";
            html+="工作:<input type='text' id='job'><br>";
            html+="电话:<input type='text' id='phone'><br><br>";
            html+="<input type='submit' value='保存'>"
            html+="</form>"
            createModalDialog("success","", html);
        }

        function add() {
            var id=document.getElementById("id");
            var name=document.getElementById("name");
            var job=document.getElementById("job");
            var phone=document.getElementById("phone");

            $.ajax({
                type:"GET",
                url:"demo/addOne",
                data:{"id":id.value,"name":name.value,"job":job.value,"phone":phone.value},
                datatype:"json",
                contentType:'application/json;charset=UTF-8',
                success:function (returnData) {
//                   alert("success");

                }
            });
        }

    </script>

    <%--删除功能页面--%>
    <script type="text/javascript">

        function deleteById(id){
            $.ajax({
                type:"GET",
                url:"demo/deleteById",
                data:{"id":id},
                datatype:"json",
                contentType:'application/json;charset=UTF-8',
                success:function (returnData) {
//                    alert("success");
                }
            });
            window.location.reload();
        }


    </script>


    <%--查询页面--%>
    <script type="text/javascript">

        function idSearch() {
            var html ="<h2 align='center'>******ID查询******</h2><br>";
            html+="<form onsubmit='return search_Id();'>"
            html+="编号:<input type='text' id='id_find'><br><br>";

            html+="<input type='submit' value='保存'>"
            html+="</form>"
            createModalDialog("success","查询", html);
        }

        function search_Id() {
            var id=document.getElementById("id_find");
//            alert(this);
            $.ajax({
                type:"GET",
                url:"demo/findOne",
                data:{"id":id.value},
                datatype:"json",
                cache : false,
                async : false,
                contentType:"application/json;charset=UTF-8",
                success:function (returnData) {

//                    alert(returnData.data);
                    var jsonObj=returnData.data;

                    var html="<table border='1' width='100%' height='20%'><tr> <th>编号</th> <th>姓名</th> <th>工作</th> <th>电话</th></tr>";
                    html+="<tr align='center'><td>"+jsonObj.id+"</td><td>"+jsonObj.name+"</td><td>"+jsonObj.job+"</td>" +
                        "<td>"+jsonObj.phone+"</td></tr>";
                    html+="</table>";
//                    alert(html);
                    createModalDialog("success","详情", html);

                }
            });
        }
        
        
        function nameSearch(){
            var html ="<h2 align='center'>******姓名查询******</h2><br>";
            html+="<form onsubmit='return search_Name();'>"
            html+="姓名:<input type='text' id='name_find'><br><br>";

            html+="<input type='submit' value='保存'>"
            html+="</form>"
            createModalDialog("success","查询", html);
        }
        
        function search_Name() {
            var name=document.getElementById("name_find");
//            alert(name);
            $.ajax({
                type:"GET",
                url:"demo/findByName",
                data:{"name":name.value},
                datatype:"json",
                cache : false,
                async : false,
                contentType:"application/json;charset=UTF-8",
                success:function (returnData) {


                        var jsonObj=returnData.data;

                        var html="<table border='1' width='100%' height='20%'><tr> <th>编号</th> <th>姓名</th> <th>工作</th> <th>电话</th></tr>";
                        for(var i=0;i<jsonObj.length;i++)
                            html+="<tr align='center'><td>"+jsonObj[i].id+"</td><td>"+jsonObj[i].name+"</td><td>"+jsonObj[i].job+"</td>" +
                                "<td>"+jsonObj[i].phone+"</td></tr>";
                        html+="</table>";
//                    alert(html);
                        createModalDialog("success","详情", html);


                }
            });
        }


    </script>



    <script type="text/javascript">

        function createModalDialog(type, title, content) {

            // 打开弹窗时禁止页面滑动
            $('html, body').css({
                "overflow": "hidden"
            })
            // type为succes情况下设置body的padding-right属性来防止页面滑动
            $('body').css({"padding-right": "15px"})

            // 检查是否已经存在modal
            if ($('.modal').length > 0) {
                $('.modal').remove()
            }

            $('body').append('<div class="center-outside modal">' +
                '<div class="mark-bg"></div>' +
                '<div class="center-middle">' +
                '<div class="center-inner">' +
                '<div class="modal-content">' +
                '<div class="modal-header">' +
                (title || '网页提示') +
                '<span class="icon-close"></span>' +
                '</div>' +
                '<div class="modal-body" align="center">'
                + content + '</div></div></div></div></div>');

            $('.modal .icon-close, .modal .mark-bg, .modal .confirm').click(function () {
                $('.modal').remove()
                $('html, body').attr("style", "")
            })
        }



    </script>



</head>

<body id="mybody">

    <h2 align="center" >人员信息表</h2>

    <div id="mytable">
        <input class="button1 white" type="button" value="增加" onclick="return addInfo();">&nbsp;&nbsp;&nbsp;
        <input class="button1 white" type="button" value="ID查找" onclick="return idSearch();">&nbsp;&nbsp;&nbsp;
        <input class="button1 white" type="button" value="姓名查找" onclick="return nameSearch();">&nbsp;&nbsp;&nbsp;

    </div>

    <div id="mydiv">

    </div>


</body>
</html>













