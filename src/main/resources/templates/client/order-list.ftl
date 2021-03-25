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
        .content {
            margin-top: 0.88rem;
            padding: 0 1rem;
        }

        .newsClass {
            /*width: 1.5rem;*/
        }

        .newsClass li {
            padding: 0.3rem 0.4rem;
            border: 1px solid #d4d4d4;
            /*border-bottom: 1px solid #d4d4d4;*/
            /*border-right: 1px solid #d4d4d4;*/
        }

        #newsContent li {
            padding: 0.3rem 0.4rem;
        }

        .bottom {
            display: flex;
            justify-content: space-between;
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 1rem;
            line-height: 1rem;
            border: 1px solid #efefef;
        }

        .bottom .tab {
            text-align: center;
            width: 100%;
        }

        .search-box {
            text-align: center;
            margin-top: 1rem;
        }

        .search-box input {
            border: 1px solid #c1c1c1;
        }

        .item {
            padding: 0.2rem 0.3rem;
            box-sizing: border-box;
            border-radius: 0.2rem;
            border: 1px solid #dedede;
            margin-top: 0.2rem;
        }

        .item .item-line .title {
            color: #b1b1b1;
        }

        .content-list {
            padding: 0.2rem 0.3rem;
        }

        .item .item-line {
            display: flex;
            justify-content: space-between;
            padding: 0.1rem 0;
        }
        .item .item-line .val{
            width: 3.5rem;
            line-height: initial;
        }

        .item .item-line .val a {
            background: rgba(230, 109, 78, 1);
            padding: 0.1rem 0.3rem;
            border-radius: 0.2rem;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="wrap">
    <header class="global-header">
        <div class="center-area">我的预约单</div>
    </header>
    <div class="content">
        <ul class="newsClass">

        </ul>
    </div>
</div>
</body>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">

    $(function () {
        initHospital();
    })

    function initHospital() {
        $.ajax({
            url: '/order/findAllOrderByUser',
            dataType: 'json',
            success: function (res) {
                if (res.success) {
                    var data = res.data;
                    var html = '';
                    $.each(data, function (index, l) {
                        html += '<div class="item">\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">订单号</div>\n' +
                            '                <div class="val">' + l.orderNo + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">预约医院</div>\n' +
                            '                <div class="val">' + l.hospital.name + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">预约门诊</div>\n' +
                            '                <div class="val">' + l.dept.name + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">预约医生</div>\n' +
                            '                <div class="val">' + l.doctor.name + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">预约时间</div>\n' +
                            '                <div class="val">' + l.doTime + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">预约信息</div>\n' +
                            '                <div class="val">' + l.msg + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">创建时间</div>\n' +
                            '                <div class="val">' + l.createTime + '</div>\n' +
                            '            </div>\n' +
                            '            <div class="item-line">\n' +
                            '                <div class="title">状态</div>\n';
                        if(l.status == 1){
                            html+='                <div class="val" style="color:green;">预约成功</div>\n';
                        }else if(l.status == 2){
                            html+='                <div class="val" style="color:red;">预约失败</div>\n';
                        }
                            html+='            </div>\n' +
                            '        </div>';
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