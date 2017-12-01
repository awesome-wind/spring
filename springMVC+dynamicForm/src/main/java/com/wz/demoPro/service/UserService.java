package com.wz.demoPro.service;

import com.wz.demoPro.entity.DataTableParameter;
import com.wz.demoPro.entity.User;

import java.util.List;

public interface UserService {

    User saveAndFlush(User user);

    List<User> findAll();

    User findOne(int id);

    void delOne(int id);

    DataTableParameter getDataTableParameterByJsonParam(String aoData);
}
