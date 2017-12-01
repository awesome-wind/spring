package com.wz.demoPro.service;

import com.wz.demoPro.entity.User;
import com.wz.demoPro.entity.Work;
import org.springframework.data.jpa.repository.Query;

public interface WorkService {
    void saveAndFlush(Work work);

    void delete(int id);


}
