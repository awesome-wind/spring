package com.wz.demoPro.controller;

import com.wz.demoPro.entity.Work;
import com.wz.demoPro.service.WorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/work")
public class WorkController {

    @Autowired
    private WorkService workService;

    @RequestMapping("/addOne")
    public void addOne(Work work) //需要传入一个名为userById的user实体
    {
        System.out.println(123);
        workService.saveAndFlush(work);
        System.out.println(work);
    }
}
