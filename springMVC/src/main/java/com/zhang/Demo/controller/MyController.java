package com.zhang.Demo.controller;

//import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONObject;
import com.zhang.Demo.entity.DataTableParameter;
import com.zhang.Demo.entity.User;
import com.zhang.Demo.service.MyService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
@RequestMapping("/demo")
public class MyController {

    private MyService myService;

    @Autowired
    public void setMyService(MyService myService) {
        this.myService = myService;
    }

    @RequestMapping(value="/addOne",method= RequestMethod.GET)
    @ResponseBody
    public User inSave(@ModelAttribute User user)
    {
        myService.save(user);
        return user;
    }

    @RequestMapping(value="/findAll",method= RequestMethod.GET)
    @ResponseBody
    public JSONObject findAll()
    {
        List<User> userList = myService.findAll();
        JSONObject json = new JSONObject();
        json.put("data",userList);

        return json;
    }

    @RequestMapping("/findById")
    @ResponseBody
    public JSONObject findById(int id)
    {
        User user = myService.findById(id);
        JSONObject json = new JSONObject();
        json.put("data",user);

        return json;
    }


    @RequestMapping(value="/findByName",method= RequestMethod.GET)
    @ResponseBody
    public JSONObject findByName(String name)
    {
        List<User> userList = myService.findByName(name);
        JSONObject json = new JSONObject();
        json.put("data",userList);

        return json;
    }

    @RequestMapping(value="/findOne",method= RequestMethod.GET)
    @ResponseBody
    public JSONObject findOne(int id)
    {
        User user = myService.findOne(id);
        JSONObject json = new JSONObject();
        json.put("data",user);

        return json;
    }

//    delete

    @RequestMapping(value="/deleteById",method= RequestMethod.GET)
    @ResponseBody
    public void deleteById(int id)
    {
        myService.delete(id);
        return ;
    }


    //modify
    @RequestMapping(value="/modifyOne",method= RequestMethod.GET)
    @ResponseBody
    //WebRequest request, ModelMap model,@RequestBody User user
    public JSONObject modifyOne(@ModelAttribute User user){

        User user1=myService.saveAndFlush(user);
        JSONObject json = new JSONObject();
        json.put("data",user1);

        return json;
    }



    @RequestMapping(value="/tableDemoAjax",method= RequestMethod.GET)
    @ResponseBody
    public String tableDemoAjax(@RequestParam String aoData) {

        System.out.println(aoData);

        DataTableParameter dataTableParam = myService.getDataTableParameterByJsonParam(aoData);

        List<User> userList = myService.findAll();

        int iDisplayEnd=dataTableParam.getiDisplayStart()+dataTableParam.getiDisplayLength();
        if(userList.size()<iDisplayEnd)
            iDisplayEnd=userList.size();

        com.alibaba.fastjson.JSONObject getObj = new com.alibaba.fastjson.JSONObject();
        getObj.put("sEcho", dataTableParam.getsEcho());// 不知道这个值有什么用,有知道的请告知一下
        getObj.put("iTotalRecords", userList.size());//实际的行数
        getObj.put("iTotalDisplayRecords", userList.size());//显示的行数,这个要和上面写的一样

        getObj.put("aaData", userList.subList(dataTableParam.getiDisplayStart(),iDisplayEnd));//要以JSON格式返回
//        System.out.println(getObj);
        return getObj.toString();
    }


}
