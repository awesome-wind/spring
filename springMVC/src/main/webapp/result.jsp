<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Demo: CSS3 Buttons</title>
    <style type="text/css">
        body {
            background: #ededed;
            width: 900px;
            margin: 30px auto;
            color: #999;
        }
        p {
            margin: 0 0 2em;
        }
        h1 {
            margin: 0;
        }
        a {
            color: #339;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        div {
            padding: 20px 0;
            border-bottom: solid 1px #ccc;
        }

        /* button
        ---------------------------------------------- */
        .button {
            display: inline-block;
            zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
            *display: inline;
            vertical-align: baseline;
            margin: 0 2px;
            outline: none;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            font: 14px/100% Arial, Helvetica, sans-serif;
            padding: .5em 2em .55em;
            text-shadow: 0 1px 1px rgba(0,0,0,.3);
            -webkit-border-radius: .5em;
            -moz-border-radius: .5em;
            border-radius: .5em;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
            box-shadow: 0 1px 2px rgba(0,0,0,.2);
        }
        .button:hover {
            text-decoration: none;
        }
        .button:active {
            position: relative;
            top: 1px;
        }

        .bigrounded {
            -webkit-border-radius: 2em;
            -moz-border-radius: 2em;
            border-radius: 2em;
        }
        .medium {
            font-size: 12px;
            padding: .4em 1.5em .42em;
        }
        .small {
            font-size: 11px;
            padding: .2em 1em .275em;
        }

        /* color styles
        ---------------------------------------------- */

        /* black */
        .black {
            color: #d7d7d7;
            border: solid 1px #333;
            background: #333;
            background: -webkit-gradient(linear, left top, left bottom, from(#666), to(#000));
            background: -moz-linear-gradient(top,  #666,  #000);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#666666', endColorstr='#000000');
        }
        .black:hover {
            background: #000;
            background: -webkit-gradient(linear, left top, left bottom, from(#444), to(#000));
            background: -moz-linear-gradient(top,  #444,  #000);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#444444', endColorstr='#000000');
        }
        .black:active {
            color: #666;
            background: -webkit-gradient(linear, left top, left bottom, from(#000), to(#444));
            background: -moz-linear-gradient(top,  #000,  #444);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#000000', endColorstr='#666666');
        }

        /* gray */
        .gray {
            color: #e9e9e9;
            border: solid 1px #555;
            background: #6e6e6e;
            background: -webkit-gradient(linear, left top, left bottom, from(#888), to(#575757));
            background: -moz-linear-gradient(top,  #888,  #575757);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#888888', endColorstr='#575757');
        }
        .gray:hover {
            background: #616161;
            background: -webkit-gradient(linear, left top, left bottom, from(#757575), to(#4b4b4b));
            background: -moz-linear-gradient(top,  #757575,  #4b4b4b);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#757575', endColorstr='#4b4b4b');
        }
        .gray:active {
            color: #afafaf;
            background: -webkit-gradient(linear, left top, left bottom, from(#575757), to(#888));
            background: -moz-linear-gradient(top,  #575757,  #888);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#575757', endColorstr='#888888');
        }

        /* white */
        .white {
            color: #606060;
            border: solid 1px #b7b7b7;
            background: #fff;
            background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
            background: -moz-linear-gradient(top,  #fff,  #ededed);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
        }
        .white:hover {
            background: #ededed;
            background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#dcdcdc));
            background: -moz-linear-gradient(top,  #fff,  #dcdcdc);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#dcdcdc');
        }
        .white:active {
            color: #999;
            background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#fff));
            background: -moz-linear-gradient(top,  #ededed,  #fff);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#ffffff');
        }

        /* orange */
        .orange {
            color: #fef4e9;
            border: solid 1px #da7c0c;
            background: #f78d1d;
            background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
            background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
        }
        .orange:hover {
            background: #f47c20;
            background: -webkit-gradient(linear, left top, left bottom, from(#f88e11), to(#f06015));
            background: -moz-linear-gradient(top,  #f88e11,  #f06015);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f88e11', endColorstr='#f06015');
        }
        .orange:active {
            color: #fcd3a5;
            background: -webkit-gradient(linear, left top, left bottom, from(#f47a20), to(#faa51a));
            background: -moz-linear-gradient(top,  #f47a20,  #faa51a);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f47a20', endColorstr='#faa51a');
        }

        /* red */
        .red {
            color: #faddde;
            border: solid 1px #980c10;
            background: #d81b21;
            background: -webkit-gradient(linear, left top, left bottom, from(#ed1c24), to(#aa1317));
            background: -moz-linear-gradient(top,  #ed1c24,  #aa1317);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ed1c24', endColorstr='#aa1317');
        }
        .red:hover {
            background: #b61318;
            background: -webkit-gradient(linear, left top, left bottom, from(#c9151b), to(#a11115));
            background: -moz-linear-gradient(top,  #c9151b,  #a11115);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#c9151b', endColorstr='#a11115');
        }
        .red:active {
            color: #de898c;
            background: -webkit-gradient(linear, left top, left bottom, from(#aa1317), to(#ed1c24));
            background: -moz-linear-gradient(top,  #aa1317,  #ed1c24);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#aa1317', endColorstr='#ed1c24');
        }

        /* blue */
        .blue {
            color: #d9eef7;
            border: solid 1px #0076a3;
            background: #0095cd;
            background: -webkit-gradient(linear, left top, left bottom, from(#00adee), to(#0078a5));
            background: -moz-linear-gradient(top,  #00adee,  #0078a5);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#00adee', endColorstr='#0078a5');
        }
        .blue:hover {
            background: #007ead;
            background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e));
            background: -moz-linear-gradient(top,  #0095cc,  #00678e);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#0095cc', endColorstr='#00678e');
        }
        .blue:active {
            color: #80bed6;
            background: -webkit-gradient(linear, left top, left bottom, from(#0078a5), to(#00adee));
            background: -moz-linear-gradient(top,  #0078a5,  #00adee);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#0078a5', endColorstr='#00adee');
        }

        /* rosy */
        .rosy {
            color: #fae7e9;
            border: solid 1px #b73948;
            background: #da5867;
            background: -webkit-gradient(linear, left top, left bottom, from(#f16c7c), to(#bf404f));
            background: -moz-linear-gradient(top,  #f16c7c,  #bf404f);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f16c7c', endColorstr='#bf404f');
        }
        .rosy:hover {
            background: #ba4b58;
            background: -webkit-gradient(linear, left top, left bottom, from(#cf5d6a), to(#a53845));
            background: -moz-linear-gradient(top,  #cf5d6a,  #a53845);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#cf5d6a', endColorstr='#a53845');
        }
        .rosy:active {
            color: #dca4ab;
            background: -webkit-gradient(linear, left top, left bottom, from(#bf404f), to(#f16c7c));
            background: -moz-linear-gradient(top,  #bf404f,  #f16c7c);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#bf404f', endColorstr='#f16c7c');
        }

        /* green */
        .green {
            color: #e8f0de;
            border: solid 1px #538312;
            background: #64991e;
            background: -webkit-gradient(linear, left top, left bottom, from(#7db72f), to(#4e7d0e));
            background: -moz-linear-gradient(top,  #7db72f,  #4e7d0e);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#7db72f', endColorstr='#4e7d0e');
        }
        .green:hover {
            background: #538018;
            background: -webkit-gradient(linear, left top, left bottom, from(#6b9d28), to(#436b0c));
            background: -moz-linear-gradient(top,  #6b9d28,  #436b0c);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#6b9d28', endColorstr='#436b0c');
        }
        .green:active {
            color: #a9c08c;
            background: -webkit-gradient(linear, left top, left bottom, from(#4e7d0e), to(#7db72f));
            background: -moz-linear-gradient(top,  #4e7d0e,  #7db72f);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#4e7d0e', endColorstr='#7db72f');
        }

        /* pink */
        .pink {
            color: #feeef5;
            border: solid 1px #d2729e;
            background: #f895c2;
            background: -webkit-gradient(linear, left top, left bottom, from(#feb1d3), to(#f171ab));
            background: -moz-linear-gradient(top,  #feb1d3,  #f171ab);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#feb1d3', endColorstr='#f171ab');
        }
        .pink:hover {
            background: #d57ea5;
            background: -webkit-gradient(linear, left top, left bottom, from(#f4aacb), to(#e86ca4));
            background: -moz-linear-gradient(top,  #f4aacb,  #e86ca4);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f4aacb', endColorstr='#e86ca4');
        }
        .pink:active {
            color: #f3c3d9;
            background: -webkit-gradient(linear, left top, left bottom, from(#f171ab), to(#feb1d3));
            background: -moz-linear-gradient(top,  #f171ab,  #feb1d3);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f171ab', endColorstr='#feb1d3');
        }

    </style>
</head>

<body>
<h1><a href="http://www.webdesignerwall.com/tutorials/css3-gradient-buttons/">CSS3 Gradient Buttons</a></h1>
<p><em>by</em> <a href="http://www.webdesignerwall.com">Web Designer Wall</a></p>

<div>
    <%--<a href="#" class="button black">Rectangle</a>  or--%>
    <%--<a href="#" class="button black bigrounded">Rounded</a> Can be--%>
    <%--<a href="#" class="button black medium">Medium</a> or--%>
    <%--<a href="#" class="button black small">Small</a>--%>
    <%--<br /><br />--%>
    <input class="button blue" type="button" value="Input Element" />
    <%--<button class="button black">Button Tag</button>--%>
    <%--<span class="button black">Span</span>--%>
    <%--<div class="button black">Div</div>--%>
    <%--<p class="button black">P Tag</p>--%>
    <%--<h3 class="button black">H3</h3>--%>
</div>

<div>
    <a href="#" class="button gray">Gray</a>
    <a href="#" class="button gray bigrounded">Rounded</a>
    <a href="#" class="button gray medium">Medium</a>
    <a href="#" class="button gray small">Small</a>
    <br /><br />
    <input class="button gray" type="button" value="Input Element" />
    <button class="button gray">Button Tag</button>
    <span class="button gray">Span</span>
    <div class="button gray">Div</div>
    <p class="button gray">P Tag</p>
    <h3 class="button gray">H3</h3>
</div>

<div>
    <a href="#" class="button white">White</a>
    <a href="#" class="button white bigrounded">Rounded</a>
    <a href="#" class="button white medium">Medium</a>
    <a href="#" class="button white small">Small</a>
    <br /><br />
    <input class="button white" type="button" value="Input Element" />
    <button class="button white">Button Tag</button>
    <span class="button white">Span</span>
    <div class="button white">Div</div>
    <p class="button white">P Tag</p>
    <h3 class="button white">H3</h3>
</div>

<div>
    <a href="#" class="button orange">Orange</a>
    <a href="#" class="button orange bigrounded">Rounded</a>
    <a href="#" class="button orange medium">Medium</a>
    <a href="#" class="button orange small">Small</a>
    <br /><br />
    <input class="button orange" type="button" value="Input Element" />
    <button class="button orange">Button Tag</button>
    <span class="button orange">Span</span>
    <div class="button orange">Div</div>
    <p class="button orange">P Tag</p>
    <h3 class="button orange">H3</h3>
</div>

<div>
    <a href="#" class="button red">Red</a>
    <a href="#" class="button red bigrounded">Rounded</a>
    <a href="#" class="button red medium">Medium</a>
    <a href="#" class="button red small">Small</a>
    <br /><br />
    <input class="button red" type="button" value="Input Element" />
    <button class="button red">Button Tag</button>
    <span class="button red">Span</span>
    <div class="button red">Div</div>
    <p class="button red">P Tag</p>
    <h3 class="button red">H3</h3>
</div>

<div>
    <a href="#" class="button blue">Blue</a>
    <a href="#" class="button blue bigrounded">Rounded</a>
    <a href="#" class="button blue medium">Medium</a>
    <a href="#" class="button blue small">Small</a>
    <br /><br />
    <input class="button blue" type="button" value="Input Element" />
    <button class="button blue">Button Tag</button>
    <span class="button blue">Span</span>
    <div class="button blue">Div</div>
    <p class="button blue">P Tag</p>
    <h3 class="button blue">H3</h3>
</div>

<div>
    <a href="#" class="button rosy">Rosy</a>
    <a href="#" class="button rosy bigrounded">Rounded</a>
    <a href="#" class="button rosy medium">Medium</a>
    <a href="#" class="button rosy small">Small</a>
    <br /><br />
    <input class="button rosy" type="button" value="Input Element" />
    <button class="button rosy">Button Tag</button>
    <span class="button rosy">Span</span>
    <div class="button rosy">Div</div>
    <p class="button rosy">P Tag</p>
    <h3 class="button rosy">H3</h3>
</div>

<div>
    <a href="#" class="button green">Green</a>
    <a href="#" class="button green bigrounded">Rounded</a>
    <a href="#" class="button green medium">Medium</a>
    <a href="#" class="button green small">Small</a>
    <br /><br />
    <input class="button green" type="button" value="Input Element" />
    <button class="button green">Button Tag</button>
    <span class="button green">Span</span>
    <div class="button green">Div</div>
    <p class="button green">P Tag</p>
    <h3 class="button green">H3</h3>
</div>

<div>
    <a href="#" class="button pink">Pink</a>
    <a href="#" class="button pink bigrounded">Rounded</a>
    <a href="#" class="button pink medium">Medium</a>
    <a href="#" class="button pink small">Small</a>
    <br /><br />
    <input class="button pink" type="button" value="Input Element" />
    <button class="button pink">Button Tag</button>
    <span class="button pink">Span</span>
    <div class="button pink">Div</div>
    <p class="button pink">P Tag</p>
    <h3 class="button pink">H3</h3>
</div>

</body>
</html>