package com.wz.demoPro.service;

import com.wz.demoPro.entity.User;
import com.wz.demoPro.entity.Work;
import com.wz.demoPro.repository.WorkRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class WorkServiceImpl implements WorkService{

    @Autowired
    private WorkRepository workRepository;

    public void saveAndFlush(Work work) {
        workRepository.saveAndFlush(work);
    }


    public void delete(int id) {
        workRepository.delete(id);
    }


}
