package com.delay.hospital.service;

import com.delay.hospital.entity.Dept;
import com.delay.hospital.entity.Hospital;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-23 11:42
 */
public interface HospitalService extends JpaRepository<Hospital, Integer> {
    List<Hospital> findAllByNameLike(String s);

    Hospital findByName(String name);
}
