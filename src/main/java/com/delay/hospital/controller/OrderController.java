package com.delay.hospital.controller;

import com.delay.hospital.entity.Dept;
import com.delay.hospital.entity.Doctor;
import com.delay.hospital.entity.Hospital;
import com.delay.hospital.entity.Order;
import com.delay.hospital.service.DoctorService;
import com.delay.hospital.service.OrderService;
import com.delay.hospital.utils.ExecuteResult;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-23 11:39
 */
@Controller
@RequestMapping("order")
public class OrderController extends BaseController {

    private static final int count = 10;

    @Autowired
    DoctorService doctorService;
    @Autowired
    OrderService orderService;

    /**
     * 通过用户id查找订单
     * @return
     */
    @RequestMapping("findAllOrderByUser")
    @ResponseBody
    public ExecuteResult findAllOrderByUser(){
        List<Order> list = orderService.findByUserId(getUser2().getId());
        return ExecuteResult.ok(list);
    }

    /**
     * 查找全部订单
     * @return
     */
    @RequestMapping("findAll")
    @ResponseBody
    public ExecuteResult findAll(){
        List<Order> list = orderService.findAll();
        return ExecuteResult.ok(list);
    }

    /**
     * 删除订单
     *
     * @return
     */
    @RequestMapping("delete")
    @ResponseBody
    public ExecuteResult delete(@RequestBody List<Integer> userIds) {
        userIds.stream().forEach(o -> {
            orderService.deleteById(o);
        });
        return ExecuteResult.ok();
    }

    /**
     * 创建预约单
     * @param doctorId
     * @param phone
     * @param date
     * @return
     * @throws ParseException
     */
    @RequestMapping("createOrder")
    @ResponseBody
    public ExecuteResult createOrder(Integer doctorId, String phone, String date) throws ParseException {
        Doctor doctor = doctorService.findById(doctorId).orElse(null);
        Dept dept = doctor.getDept();
        Hospital hospital = doctor.getHospital();
        Order order = new Order();
        order.setOrderNo(getOrderNo());
        order.setDoTime(DateUtils.parseDate(date, "yyyy-MM-dd"));
        sortOrder(order, doctorId, date, orderService);
        order.setDept(dept);
        order.setHospital(hospital);
        order.setDoctor(doctor);
        order.setUser(getUser2());
        order.setCreateTime(new Date());
        order.setPhone(phone);
        orderService.saveAndFlush(order);
        return ExecuteResult.ok(order);
    }

    public static String getOrderNo() {

        String head = DateFormatUtils.format(new Date(), "yyyyMMddhhmmssSS");
        String foot = RandomStringUtils.randomNumeric(4);
        return head + foot;
    }

    /**
     * 智能排期 最多预约10人
     *
     * @return
     */
    public static void sortOrder(Order order, Integer doctorId, String date, OrderService orderService) throws ParseException {
        List<Order> list = orderService.findByDoctorIdAndDoTime(doctorId, DateUtils.parseDate(date, "yyyy-MM-dd"));
        if (CollectionUtils.isNotEmpty(list)) {
            int size = list.size();
            if (size >= count) {
                order.setMsg("预约失败，预约人数已满");
                order.setStatus(2);
                return;
            }
            order.setMsg("请请携带好证件，于" + date + "到达预约医院进行就诊，就诊号为" + (++size));
            order.setStatus(1);
            return;
        }
        order.setMsg("请携带好证件，于" + date + "到达预约医院进行就诊，就诊号为1");
        order.setStatus(1);
    }

}
