package com.zhang.Demo.service;

import com.zhang.Demo.entity.DataTableParameter;
import com.zhang.Demo.entity.User;

import java.util.List;

public interface MyService {

    User save(User user);

    List<User> findAll();

    User findById(int id);

    List<User> findByName(String name);

    User findOne(int id);

    void delete(int id);

    User saveAndFlush(User user);

    DataTableParameter getDataTableParameterByJsonParam(String aoData);
}
