package com.zhang.Demo.repository;

import com.zhang.Demo.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MyRepository extends JpaRepository<User,Integer>{
    User findById(int id);
    List<User> findByName(String name);
}
