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
            padding: 0.3rem 0.2rem;
        }

        .content .content-title {
            padding: 0.25rem 0;
            display: flex;
            color: #8e8e8e;
            height: 0.4rem;
            line-height: 0.4rem;
        }

        .content .content-value {
            margin-left: 1rem;
            color: #333;
        }

        .content input {
            border: 1px solid #D0D0D0;
            background: none;
            padding: 0 0.4rem;
            height: 0.5rem;
            border-radius: 0.2rem;
            width: 2.5rem;
        }

        .content-title-name {
            width: 1.5rem;
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
            position: relative;
            bottom: 0.4rem;
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
            margin-top: 1rem;
        }

        .search-box input {
            border: 1px solid #c1c1c1;
        }

        .info-title {
            background: #f6f6f6;
            height: 0.8rem;
            line-height: 0.8rem;
            margin-top: 0.9rem;

        }

        .info-title .title-name {
            margin-left: 0.3rem;
            font-weight: bolder;
            color: #525252;

        }
        .des{
            color:#8e8e8e;
            font-size: 0.22rem;
            margin-top: 0.35rem;
        }
        .rule{
            white-space: pre-wrap;
            padding:0.3rem;
            line-height: 18px;
            padding-bottom:1rem;
            color:#656565;
        }

    </style>
</head>
<body>
<div class="wrap">
    <header class="global-header">
        <div class="center-area">医院预约挂号</div>
    </header>
    <div class="info-title">
        <span class="title-name">挂号信息</span>
    </div>
    <div class="content">
        <div class="content-title">
            <div class="content-title-name">预约医院</div>
            <div class="content-value" id="hospitalName"></div>
        </div>
        <div class="content-title">
            <div class="content-title-name">预约门诊</div>
            <div class="content-value" id="deptName"></div>
        </div>
        <div class="content-title">
            <div class="content-title-name">预约专家</div>
            <div class="content-value" id="doctorName"></div>
        </div>
        <div class="content-title">
            <div class="content-title-name">预约时间</div>
            <div class="content-value"><input type="date" id="date"></div>
        </div>
        <div class="content-title">
            <div class="content-title-name">预留手机号</div>
            <div class="content-value"><input placeholder="请输入预留手机号" type="text" id="phone"></div>
        </div>
        <div class="des">具体费用以取号当天医院收取为准，对您造成的不便敬请谅解</div>
    </div>
    <div class="info-title">
        <span class="title-name">医院预约规则</span>
    </div>
    <div class="rule">1：受疫情影响，来自或去过中/高地区的患者就诊须持7日内正规机构核酸检测阴性结果证明，否则将不能正常就诊，请主动配合入口处管理和预检分诊。
2：为减少院内聚集，避免交叉感染风险，每位患者仅允许一位家属陪同。
3. 首次预约患者,预约时必须填写“亲属姓名”用于建档备查，首次填写后无需再填写。
4. 预约成功的医保报销用户请首先确保为本院定点医保用户，首次来院就诊时需到窗口关联医保卡后，再到医院医保自助机取号就诊。预约成功的自费用户请在非医保自助机取号就医。
5. 使用身份证以外其它证件注册预约的患者，只能到窗口取号。
6. 本院【小儿科】只预约小于14周岁(不包含14周岁)的患儿。
7. 预约成功后，请患者于就诊当日携带患者本人的有效证件、银行卡、医保卡、及预约识别码到医院自助挂号机上进行取号（医保报销用户须在医保自助机取号，在非医保自助机取号为自费），如预约登记信息有误，则无法正常取号就诊。
8. 本院【口腔科】下的小儿牙科只对12周岁以下患儿预约。
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
            data: {
                doctorId: doctorId
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

    $('#sub-btn').on('click', function () {
        var doctorId = $('#doctorId').val();
        var date = $('#date').val();
        var phone = $('#phone').val();
        if (!(doctorId && date && phone)) {
            alert("请完善参数");
            return false;
        }
        $.ajax({
            url: '/order/createOrder',
            data: {
                doctorId: doctorId,
                date: date,
                phone: phone
            },
            dataType: 'json',
            success: function (res) {
                if (res.success) {
                    if (res.data.status == 1) {
                        alert("预约成功，请在预约单中查看详情")
                        location.href = "/page/clientPerson";
                    } else if (res.data.status == 2) {
                        alert("预约失败，请在预约单中查看详情")
                        location.href = "/page/clientPerson";
                    }
                } else {
                    alert(res.msg)
                }
            }
        })
    })


</script>

</html>