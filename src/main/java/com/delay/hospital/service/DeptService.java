package com.delay.hospital.service;

import com.delay.hospital.entity.Dept;
import com.delay.hospital.entity.Doctor;
import com.delay.hospital.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-23 11:42
 */
public interface DeptService  extends JpaRepository<Dept, Integer> {
    List<Dept> findByHospitalId(Integer hospitalId);

    Dept findByName(String name);

    Dept findByNameAndHospitalId(String name, Integer id);

    void deleteByHospitalId(Integer o);

}
