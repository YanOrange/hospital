package com.delay.hospital.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author 闫金柱
 * @create 2021-3-23 10:40
 */
@Controller
@RequestMapping("page")
public class PageController extends BaseController{

    /**
     * 客户端首页
     *
     * @return
     */
    @RequestMapping("home")
    public String home() {

        return "client/home";
    }

    /**
     * 登录页面
     *
     * @return
     */
    @RequestMapping("login")
    public String login() {
        return "login";
    }

    /**
     * 欢迎页面
     *
     * @return
     */
    @RequestMapping("welcome")
    public String welcome() {
        return "welcome";
    }

    /**
     * 首页
     *
     * @return
     */
    @RequestMapping("index")
    public String index() {
        return "index";
    }

    /**
     * 客户端个人界面
     *
     * @return
     */
    @RequestMapping("clientPerson")
    public String clientPerson() {

        return "client/person";
    }

    /**
     * 获取全部管理员
     *
     * @return
     */
    @RequestMapping("toAdmin")
    public String toAdmin() {
        return "admin/admin-list";
    }

    /**
     * 获取全部订单
     *
     * @return
     */
    @RequestMapping("toOrderList")
    public String toOrderList() {
        return "order/order-list";
    }

    /**
     * 新增用户
     *
     * @return
     */
    @RequestMapping("add")
    public String add(Integer status, Model model) {
        model.addAttribute("status", status);
        return "author/person-add";
    }

    /**
     * 退出登录
     *
     * @return
     */
    @RequestMapping("exit")
    public String exit() {

        getSession().removeAttribute("user");

        return "login";
    }

    /**
     * 客户端登录页面
     *
     * @return
     */
    @RequestMapping("clientLogin")
    public String clientLogin() {

        return "client/login";
    }

    /**
     * 前往选择门诊页面
     * @return
     */
    @RequestMapping("toDept")
    public String toDept(Integer hospitalId,Model model){
        model.addAttribute("hospitalId",hospitalId);
        return "client/dept";
    }

    /**
     * 前往选择医生页面
     * @return
     */
    @RequestMapping("toDoctor")
    public String toDoctor(Integer deptId,Integer hospitalId,Model model){
        model.addAttribute("hospitalId",hospitalId);
        model.addAttribute("deptId",deptId);
        return "client/doctor";
    }

    /**
     * 前往预约页面
     * @return
     */
    @RequestMapping("toOrder")
    public String toOrder(Integer doctorId,Model model){
        model.addAttribute("doctorId",doctorId);
        return "client/order";
    }

    /**
     * 前往医院列表页面
     * @return
     */
    @RequestMapping("hospitalList")
    public String hospitalList(){
        return "hospital/hospital-list";
    }

    /**
     * 前往诊室列表页面
     * @return
     */
    @RequestMapping("deptList")
    public String deptList(){
        return "dept/dept-list";
    }

    /**
     * 前往诊室列表页面
     * @return
     */
    @RequestMapping("doctorList")
    public String doctorList(){
        return "doctor/doctor-list";
    }

    /**
     * 前往医院添加页面
     * @return
     */
    @RequestMapping("addHospital")
    public String addHospital(){
        return "hospital/hospital-add";
    }

    /**
     * 前往诊室添加页面
     * @return
     */
    @RequestMapping("addDept")
    public String addDept(){
        return "dept/dept-add";
    }

    /**
     * 前往医生添加页面
     * @return
     */
    @RequestMapping("addDoctor")
    public String addDoctor(){
        return "doctor/doctor-add";
    }





}
