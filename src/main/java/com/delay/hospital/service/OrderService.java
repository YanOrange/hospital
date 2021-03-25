package com.delay.hospital.service;

import com.delay.hospital.entity.Hospital;
import com.delay.hospital.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-23 11:42
 */
public interface OrderService extends JpaRepository<Order, Integer> {
    List<Order> findByDoctorId(Integer doctorId);

    List<Order> findByDoctorIdAndDoTime(Integer doctorId, Date parseDate);

    List<Order> findByUserId(Integer id);
}
