<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta id="viewport" name="viewport"
          content="width=device-width,height=device-height,initial-scale=1,user-scalable=no,viewport-fit=cover">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="grey"/>
    <meta name="format-detection" content="telephone=no,address=no,email=no"/>
    <title>医院预约挂号</title>
    <script>
        var deviceWidth = document.documentElement.clientWidth;
        // if (deviceWidth > 640) deviceWidth = 640;
        document.documentElement.style.fontSize = deviceWidth / 7.5 + 'px';
    </script>
    <link rel="stylesheet" href="../css/common.css">
    <style>
        html, body {
            background: #f1f1f1;
        }

        .content {
            display: flex;
            justify-content: left;
            padding: 0 0.7rem;
        }

        .newsClass {
            /*width: 1.5rem;*/
        }

        .newsClass li {
            padding: 0.3rem 0.1rem;
            display: flex;
            /*border-bottom: 1px solid #d4d4d4;*/
            /*border-right: 1px solid #d4d4d4;*/
        }

        .bottom {
            display: flex;
            justify-content: space-between;
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 1rem;
            line-height: 1rem;
        }

        .bottom .tab {
            text-align: center;
            width: 100%;
        }
        .bottom .tab span{
            display: inline-block;
            background: #4b80ff;
            width: 6rem;
            height:0.8rem;
            color:#fff;
            border-radius: 0.5rem;
            line-height: 0.8rem;
        }

        .search-box {
            text-align: center;
            padding: 0.3rem 0;
        }

        .search-box input {
            border: 1px solid #c1c1c1;
            border-radius: 0.3rem;
            height: 0.6rem;
            box-shadow: 0 0 13px rgb(0 0 0 / 25%);
            width: 70%;
            padding: 0 0.2rem;
            box-sizing: border-box;
        }

        .search-box button {
            border-radius: 0.1rem;
            height: 0.5rem;
            background: linear-gradient(135deg, #78d3ff 0%, #a1d7f1 100%);
            color: #fff;
            width: 1rem;
        }

        .back-nav {
            background: #fff;
            padding: 1rem 0 0.5rem 0;
        }

        .hospital-name {
            padding: 0.1rem 0;
        }

        .des {
            padding: 0.1rem 0;
            color: #c5c5c5;
            font-size: 0.21rem;
        }

        .des span:nth-child(2) {
            margin-left: 0.2rem;
        }

        .person-center {
            position: absolute;
            left: 0;
            right: 0;
            margin: auto;
            top: 14px;
            bottom: 0.6rem;
            font-size: 0.24rem;
        }

        .tab img {
            width: 0.4rem;
            position: absolute;
            left: 0;
            right: 0;
            margin: auto;
            top: -15px;
            bottom: 0;
        }
        .newsImg{
            border-radius: 1rem;
            box-shadow: 0 0 20px rgb(0 0 0 / 25%);
        }
        .newsImg img{

            width: 0.94rem;
            border-radius: 1rem;
        }
        .content-right{
            padding-left:0.3rem;
        }
        .top-title{
            display: flex;
            margin-top: 0.9rem;
            background: #fff;
            padding: 0.2rem;
        }
        .top-title .title-img{
            border-radius: 1rem;
            box-shadow: 0 0 20px rgb(0 0 0 / 25%);
            width: 0.94rem;
            height: 0.94rem;
            margin: auto;
        }
        .top-title .title-img img{
            border-radius: 1rem;
            width: 0.94rem;
        }
        .top-title .title-middle{
        }
        .top-title .title-middle .title-title{
            font-size: 0.34rem;
            font-weight: bolder;
            padding: 0.2rem 0;
        }
        .top-title .title-middle .title-des{
            color:#9e9e9e;
            padding: 0.12rem 0;
        }
    </style>
</head>
<body>
<div class="wrap">
    <header class="global-header">
        <div class="center-area">医院预约挂号</div>
    </header>
    <div class="top-title">
        <div class="title-img">
            <img src="/img/hospital.jpg">
        </div>
        <div class="title-middle">
            <div class="title-title">中国人民解放军总医院（301医院）</div>
            <div class="title-des">三级甲等</div>
            <div class="title-des">每日08:30开放</div>
        </div>
    </div>
    <div class="back-nav" style="margin-top: 0.1rem;padding-top: 0.4rem;">
        <div class="content">
            <ul class="newsClass" id="newsContent">

            </ul>
        </div>
    </div>
    <div class="bottom">
        <div class="tab" onclick="location.href='/page/clientPerson'">
            <span class="person-center">个人中心</span>
        </div>
    </div>
</div>
<input type="hidden" value="${hospitalId!''}" id="hospitalId">
</body>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">

    $(function () {
        initHospital();
    })

    function initHospital() {
        var hospitalId = $('#hospitalId').val();
        $.ajax({
            url: '/hospital/findAllDept',
            data: {
                hospitalId: hospitalId
            },
            dataType: 'json',
            success: function (res) {
                if (res.success) {
                    var data = res.data;
                    var html = '';
                    $.each(data, function (index, arr) {
                        html+='<li data-id="' + arr.id + '">\n' +
                            '                    <div class="content-right">\n' +
                            '                        <div class="hospital-name">' + arr.name + '</div>\n' +
                            '                        <div class="des"><span>专家坐诊</span><span>每天08:30放号</span></div>\n' +
                            '                    </div>\n' +
                            '                </li>';
                    })
                    $('.newsClass').html(html);
                } else {
                    alert(res.msg)
                }
            }
        })
    }


    $('#newsContent').on('click', 'li', function () {
        var hospitalId = $('#hospitalId').val();
        var deptId = $(this).data('id');
        location.href = "/page/toDoctor?hospitalId=" + hospitalId + "&deptId=" + deptId;
    })

</script>

</html>