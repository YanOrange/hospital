package com.delay.hospital.service;

import com.delay.hospital.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @Author 闫金柱
 * @create 2021-3-15 10:42
 */
public interface UserService extends JpaRepository<User, Integer> {
    List<User> findAllByStatus(Integer status);

    User findByAccount(String account);

    User findByAccountAndPassWord(String userName, String passWord);
}
