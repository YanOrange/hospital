package com.delay.hospital.service;

import com.delay.hospital.entity.Doctor;
import com.delay.hospital.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-23 11:42
 */
public interface DoctorService extends JpaRepository<Doctor, Integer> {
    List<Doctor> findByDeptId(Integer deptId);

    List<Doctor> findByHospitalIdAndDeptId(Integer hospitalId, Integer deptId);

    void deleteByHospitalId(Integer o);

    Doctor findByNameAndHospitalIdAndDeptId(String name, Integer id, Integer id1);
}
