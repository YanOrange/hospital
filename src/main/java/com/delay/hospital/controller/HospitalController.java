package com.delay.hospital.controller;

import com.delay.hospital.entity.Dept;
import com.delay.hospital.entity.Doctor;
import com.delay.hospital.entity.Hospital;
import com.delay.hospital.service.DeptService;
import com.delay.hospital.service.DoctorService;
import com.delay.hospital.service.HospitalService;
import com.delay.hospital.service.OrderService;
import com.delay.hospital.utils.ExecuteResult;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-23 11:41
 */
@Controller
@RequestMapping("hospital")
public class HospitalController {

    @Autowired
    DeptService deptService;
    @Autowired
    DoctorService doctorService;
    @Autowired
    HospitalService hospitalService;
    @Autowired
    OrderService orderService;

    /**
     * 查看全部医院
     * @return
     */
    @RequestMapping("findAllHospital")
    @ResponseBody
    public ExecuteResult findAllHospital(){
        List<Hospital> all = hospitalService.findAll();
        return ExecuteResult.ok(all);
    }

    /**
     * 查看全部医院通过name
     * @return
     */
    @RequestMapping("findAllHospitalByName")
    @ResponseBody
    public ExecuteResult findAllHospitalByName(String name){
        List<Hospital> all = hospitalService.findAllByNameLike("%"+name+"%");
        return ExecuteResult.ok(all);
    }


    /**
     * 根据医院查看全部科室
     * @return
     */
    @RequestMapping("findAllDept")
    @ResponseBody
    public ExecuteResult findAllDept(Integer hospitalId){
        List<Dept> all = deptService.findByHospitalId(hospitalId);
        return ExecuteResult.ok(all);
    }

    /**
     * 根据deptId查看全部医生
     * @return
     */
    @RequestMapping("findAllDoctor")
    @ResponseBody
    public ExecuteResult findAllDoctor(Integer deptId,Integer hospitalId){
        List<Doctor> all = doctorService.findByHospitalIdAndDeptId(hospitalId,deptId);
        return ExecuteResult.ok(all);
    }

    /**
     * 获取详细信息
     * @return
     */
    @RequestMapping("getInfoByDoctorId")
    @ResponseBody
    public ExecuteResult getInfoByDoctorId(Integer doctorId){
        Doctor doctor = doctorService.findById(doctorId).orElse(null);
        Dept dept = doctor.getDept();
        Hospital hospital = doctor.getHospital();
        JSONObject json = new JSONObject();
        json.put("doctor",doctor);
        json.put("dept",dept);
        json.put("hospital",hospital);
        return ExecuteResult.ok(json);
    }

    /**
     * 更改医院页面
     *
     * @return
     */
    @RequestMapping("toEditHospital")
    public String toEditType(@RequestParam("hospitalId") Integer hospitalId, Model model) {

        Hospital byId = hospitalService.findById(hospitalId).orElse(null);
        model.addAttribute("hospital", byId);

        return "hospital/hospital-edit";
    }

    /**
     * 更改医院
     *
     * @return
     */
    @RequestMapping("editHospitalInfo")
    @ResponseBody
    public ExecuteResult editHospitalInfo(@RequestBody Hospital hospital) {
        Hospital byId = hospitalService.findById(hospital.getId()).orElse(null);
        BeanUtils.copyProperties(hospital, byId, "createTime");
        hospitalService.saveAndFlush(byId);
        return ExecuteResult.ok();
    }

    /**
     * 删除医院
     *
     * @return
     */
    @RequestMapping("deleteHospital")
    @ResponseBody
    public ExecuteResult deleteHospital(@RequestBody List<Integer> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return ExecuteResult.fail(1, "未选择一列");
        }
        ids.stream().forEach(o -> {
            doctorService.deleteByHospitalId(o);
            deptService.deleteByHospitalId(o);
            hospitalService.deleteById(o);
        });
        return ExecuteResult.ok();
    }

    /**
     * 添加医院
     *
     * @return
     */
    @RequestMapping("addHospital")
    @ResponseBody
    public ExecuteResult addHospital(@RequestBody Hospital hospital) {
        Hospital byName = hospitalService.findByName(hospital.getName());
        if (byName != null) {
            return ExecuteResult.fail(1, "该医院已存在");
        }
        hospital.setCreateTime(new Date());
        hospitalService.saveAndFlush(hospital);
        return ExecuteResult.ok();
    }

    /**
     * 更改诊室页面
     *
     * @return
     */
    @RequestMapping("toEditDept")
    public String toEditDept(@RequestParam("deptId") Integer deptId, Model model) {

        Dept byId = deptService.findById(deptId).orElse(null);
        model.addAttribute("dept", byId);

        return "dept/dept-edit";
    }

    /**
     * 更改诊室
     *
     * @return
     */
    @RequestMapping("editDeptInfo")
    @ResponseBody
    public ExecuteResult editDeptInfo(@RequestBody Dept dept) {
        Dept byId = deptService.findById(dept.getId()).orElse(null);
        Dept byName = deptService.findByNameAndHospitalId(dept.getName(),dept.getHospital().getId());
        if (byName != null) {
            return ExecuteResult.fail(1, "该诊室已存在");
        }
        BeanUtils.copyProperties(dept, byId, "createTime","hospital");
        deptService.saveAndFlush(byId);
        return ExecuteResult.ok();
    }

    /**
     * 删除诊室
     *
     * @return
     */
    @RequestMapping("deleteDept")
    @ResponseBody
    public ExecuteResult deleteDept(@RequestBody List<Integer> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return ExecuteResult.fail(1, "未选择一列");
        }
        ids.stream().forEach(o -> {
            doctorService.deleteByHospitalId(o);
            deptService.deleteById(o);
        });
        return ExecuteResult.ok();
    }

    /**
     * 添加诊室
     *
     * @return
     */
    @RequestMapping("addDept")
    @ResponseBody
    public ExecuteResult addDept(@RequestBody Dept dept) {
        Dept byName = deptService.findByNameAndHospitalId(dept.getName(),dept.getHospital().getId());
        if (byName != null) {
            return ExecuteResult.fail(1, "该诊室已存在");
        }
        dept.setCreateTime(new Date());
        deptService.saveAndFlush(dept);
        return ExecuteResult.ok();
    }

    /**
     * 更改医生页面
     *
     * @return
     */
    @RequestMapping("toEditDoctor")
    public String toEditDoctor(@RequestParam("doctorId") Integer doctorId, Model model) {

        Doctor byId = doctorService.findById(doctorId).orElse(null);
        model.addAttribute("doctor", byId);

        return "doctor/doctor-edit";
    }

    /**
     * 更改医生
     *
     * @return
     */
    @RequestMapping("editDoctorInfo")
    @ResponseBody
    public ExecuteResult editDoctorInfo(@RequestBody Doctor doctor) {
        Doctor byId = doctorService.findById(doctor.getId()).orElse(null);
        Doctor byName = doctorService.findByNameAndHospitalIdAndDeptId(doctor.getName(),doctor.getHospital().getId(),doctor.getDept().getId());
        if (byName != null) {
            return ExecuteResult.fail(1, "该医生已存在");
        }
        BeanUtils.copyProperties(doctor, byId, "createTime","hospital","dept");
        doctorService.saveAndFlush(byId);
        return ExecuteResult.ok();
    }

    /**
     * 删除医生
     *
     * @return
     */
    @RequestMapping("deleteDoctor")
    @ResponseBody
    public ExecuteResult deleteDoctor(@RequestBody List<Integer> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return ExecuteResult.fail(1, "未选择一列");
        }
        ids.stream().forEach(o -> {
            doctorService.deleteById(o);
        });
        return ExecuteResult.ok();
    }

    /**
     * 添加医生
     *
     * @return
     */
    @RequestMapping("addDoctor")
    @ResponseBody
    public ExecuteResult addDoctor(@RequestBody Doctor doctor) {
        Doctor byName = doctorService.findByNameAndHospitalIdAndDeptId(doctor.getName(),doctor.getHospital().getId(),doctor.getDept().getId());
        if (byName != null) {
            return ExecuteResult.fail(1, "该医生已存在");
        }
        doctor.setCreateTime(new Date());
        doctorService.saveAndFlush(doctor);
        return ExecuteResult.ok();
    }



}
