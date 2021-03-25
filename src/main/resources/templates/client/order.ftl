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
            padding:0 1rem;
        }

        .content div{
            padding:0.1rem 0;
        }
        .content input{
            border:1px solid #D0D0D0;
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

        .search-box{
            text-align: center;
            margin-top: 1rem;
        }
        .search-box input{
            border:1px solid #c1c1c1;
        }
    </style>
</head>
<body>
<div class="wrap">
    <header class="global-header">
        <div class="center-area">医院预约挂号</div>
    </header>
    <div class="content">
        <div>预约医院:<span id="hospitalName"></span></div>
        <div>预约门诊:<span id="deptName"></span></div>
        <div>预约专家:<span id="doctorName"></span></div>
        <div>预约时间:<input type="date" id="date"></div>
        <div>预留手机号:<input type="text" id="phone"></div>
    </div>
    <div class="bottom">
        <div class="tab">
            <span id="sub-btn">提交预约</span>
        </div>
    </div>
</div>
<input type="hidden" value="${doctorId!''}" id="doctorId">
</body>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">

    $(function () {
        initHospital();
    })

    function initHospital() {
        var doctorId = $('#doctorId').val();
        $.ajax({
            url: '/hospital/getInfoByDoctorId',
            data:{
                doctorId:doctorId
            },
            dataType: 'json',
            success: function (res) {
                if (res.success) {
                    var data = res.data;
                    $('#hospitalName').html(data.hospital.name);
                    $('#deptName').html(data.dept.name);
                    $('#doctorName').html(data.doctor.name);
                } else {
                    alert(res.msg)
                }
            }
        })
    }

    $('#sub-btn').on('click',function(){
        var doctorId = $('#doctorId').val();
        var date = $('#date').val();
        var phone = $('#phone').val();
        if(!(doctorId&&date&&phone)){
            alert("请完善参数");
            return false;
        }
        $.ajax({
            url:'/order/createOrder',
            data:{
                doctorId:doctorId,
                date:date,
                phone:phone
            },
            dataType:'json',
            success:function(res){
                if(res.success){
                    if(res.data.status==1){
                        alert("预约成功，请在预约单中查看详情")
                        location.href="/page/clientPerson";
                    }else if(res.data.status==2){
                        alert("预约失败，请在预约单中查看详情")
                        location.href="/page/clientPerson";
                    }
                }else{
                    alert(res.msg)
                }
            }
        })
    })


</script>

</html>