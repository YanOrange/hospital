<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta id="viewport" name="viewport"
          content="width=device-width,height=device-height,initial-scale=1,user-scalable=no,viewport-fit=cover">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="grey"/>
    <meta name="format-detection" content="telephone=no,address=no,email=no"/>
    <link href="/css/common.css" rel="stylesheet" type="text/css">
    <link href="/css/icon/iconfont.css" rel="stylesheet" type="text/css">
    <script>
        var deviceWidth = document.documentElement.clientWidth;
        if (deviceWidth > 640) deviceWidth = 640;
        document.documentElement.style.fontSize = deviceWidth / 7.5 + 'px';
    </script>
    <script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?f44d5589c9a6b98196ae2127b648aa13";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <style>
        html{
            height: 100%;
            background: #fff;
        }
        .top-img{
            width: 100%;
        }
        .inp-wrap{
            padding:0.3rem;
        }
        .inp-nav{
            border-bottom:1px solid #DDE7E9;
            padding:0.3rem 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .inp-nav input{
            background:none;
            flex: 1;
        }
        .inp-nav input::placeholder{
            font-size:0.3rem;
            color:#999;
        }
        .inp-nav a{
            display: block;
            color:#FE113D;
            font-size:0.3rem;
        }
        .inp-nav a:disabled{
            color:#999;
        }
        .login-btn{
            width:92%;
            height:0.8rem;
            background: linear-gradient(135deg, #78d3ff 0%, #a1d7f1 100%);
            border-radius: 0.4rem;
            color:#fff;
            font-size:0.32rem;
        }
        .btn-nav{
            text-align:center;
            width:100%;
        }

    </style>


</head>
<body>
<div class="top-img">
    <img src="/img/login-bg.jpg" alt="">
</div>
<div class="inp-wrap">
    <div class="inp-nav">
        <input type="text" name="account" id="account" placeholder="请输入账号">
    </div>
    <div class="inp-nav">
        <input type="password" name="passWord" placeholder="请输入密码" id="passWord">
    </div>
</div>
<div class="btn-nav">
    <button type="button" class="login-btn"onclick="login();" >登录</button>
</div>
</body>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">

    $(function () {
    })


    function login() {
        var account = $('#account').val();
        var passWord = $('#passWord').val();
        $.ajax({
            url: '/login/doLogin2',
            dataType: 'json',
            data: {
                userName: account,
                passWord: passWord
            },
            success: function (res) {
                if (res.code == 0) {
                    location.href = '/page/home';
                } else {
                    alert(res.msg);
                }
            }
        })
    }


</script>
</html>