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
            display: flex;
            justify-content: left;
            margin-top: 0.88rem;
            padding: 0 1.5rem;
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
    </style>
</head>
<body>
<div class="wrap">
    <header class="global-header">
        <div class="center-area">医院预约挂号</div>
    </header>
    <div class="content">
        <ul class="newsClass" id="newsContent">

        </ul>
    </div>
    <div class="bottom">
        <div class="tab" onclick="location.href='/page/clientPerson'">
            <span>个人中心</span>
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
                        html += '<li data-id="' + arr.id + '">' + arr.name + '</li>';
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