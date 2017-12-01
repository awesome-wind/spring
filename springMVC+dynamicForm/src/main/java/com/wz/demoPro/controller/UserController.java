package com.wz.demoPro.controller;

import com.alibaba.fastjson.JSONObject;
import com.wz.demoPro.entity.DataTableParameter;
import com.wz.demoPro.entity.User;
import com.wz.demoPro.entity.Work;
import com.wz.demoPro.service.UserService;
import com.wz.demoPro.service.WorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private WorkService workService;

    @ResponseBody
    @RequestMapping(value = "/findAll",method= RequestMethod.GET)
    public String findAll(@RequestParam String aoData)  //此处的aoData必须与前端传过来的参数aoData保持一致
    {
//
//        System.out.println(123);
//        System.out.println(aoData);
//

        DataTableParameter dataTableParam = userService.getDataTableParameterByJsonParam(aoData);

        List<User> userList = userService.findAll();

        int iDisplayEnd=dataTableParam.getiDisplayStart()+dataTableParam.getiDisplayLength();
        if(userList.size()<iDisplayEnd)
            iDisplayEnd=userList.size();

        JSONObject getObj = new JSONObject();
        getObj.put("sEcho", dataTableParam.getsEcho());// 不知道这个值有什么用,有知道的请告知一下
        getObj.put("iTotalRecords", userList.size());//实际的行数
        getObj.put("iTotalDisplayRecords", userList.size());//显示的行数,这个要和上面写的一样

        getObj.put("aaData", userList.subList(dataTableParam.getiDisplayStart(),iDisplayEnd));//要以JSON格式返回
        return getObj.toString();
    }

    @RequestMapping("/addOne")
    @ResponseBody
    public User addOne(User user)
    {
        User user1 = userService.saveAndFlush(user);
        return user1;
    }

    @RequestMapping("/findOne")
    @ResponseBody
    public JSONObject findOne(int id)
    {

        User user = userService.findOne(id);
        JSONObject json = new JSONObject();
        json.put("data",user);

        return json;
    }

    @RequestMapping("/delOne")
    public void deleteOne(int id)
    {
        System.out.println("delOne");
        userService.delOne(id);
    }

    @RequestMapping("/modifyOne")
    @ResponseBody
    public JSONObject modifyOne(@ModelAttribute User user, @RequestParam(value = "arr[][]") String[][] array)
    {

        System.out.println(array.length);
        System.out.println(array[0].length);
        User user1 = userService.saveAndFlush(user);

        User user2 = userService.findOne(user1.getId());

        for(int i=0;i<user2.getWorksById().size();i++)
            workService.delete(user2.getWorksById().get(i).getId());

        Work work= new Work();
//        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd ");
        if(array.length == 4 && array[0].length==1)
        {
            work.setId(Integer.parseInt(array[0][0]));
            work.setNum(Integer.parseInt(array[0][0]));
            work.setDate(array[1][0]);
            work.setCity(array[2][0]);
            work.setWorkInfo(array[3][0]);
            work.setUserById(user1);

            workService.saveAndFlush(work);

        }
        else if(array.length>0 && array[0].length>0)
        {
            for(int i=0;i<array.length;i++)
            {
                work.setId(Integer.parseInt(array[i][0]));
                work.setNum(Integer.parseInt(array[i][0]));
                work.setDate(array[i][1]);
                work.setCity(array[i][2]);
                work.setWorkInfo(array[i][3]);
                work.setUserById(user1);

                workService.saveAndFlush(work);
            }
        }

        JSONObject json = new JSONObject();
        json.put("data",user1);
        return json;
    }


}
