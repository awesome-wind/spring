package com.zhang.Demo.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zhang.Demo.entity.DataTableParameter;
import com.zhang.Demo.entity.User;
import com.zhang.Demo.repository.MyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.testng.collections.Lists;
import org.testng.collections.Maps;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

@Service
@Transactional    //事务标记
public class MyServiceImpl implements MyService{

    private MyRepository myRepository;

    @Autowired
    public void setMyRepository(MyRepository myRepository) {
        this.myRepository = myRepository;
    }

    public User save(User user)
    {
        myRepository.save(user);
        return user;
    }

    public List<User> findAll() {
        List<User> all = myRepository.findAll();
        return all;
    }

    public User findById(int id) {
        User user = myRepository.findById(id);
        return user;
    }

    public List<User> findByName(String name) {
        List<User> names = myRepository.findByName(name);
        return names;
    }

    public User findOne(int id) {
        User user=myRepository.findOne(id);
        return user;
    }

    public void delete(int id) {
        myRepository.delete(id);
    }

    public User saveAndFlush(User user) {
        User user1=myRepository.saveAndFlush(user);
        return user1;
    }

    public DataTableParameter getDataTableParameterByJsonParam(String jsonParam) {
        Map<String,Object> map = convertJsonStringToHashMap(jsonParam);

        int sEcho=(Integer) map.get("sEcho");
        int iDisplayStart=(Integer)map.get("iDisplayStart");
        int iDisplayLength=(Integer)map.get("iDisplayLength");
        int iColumns=(Integer)map.get("iColumns");
        int iSortingCols = (Integer) map.get("iSortingCols");

        List<String> mDataProps= Lists.newArrayList();
        List<Boolean> bSortables=Lists.newArrayList();

        for(int i=0;i<iColumns;i++)
        {
            String dataProp=(String)map.get("mDataProp_"+i);
            Boolean sortable = (Boolean)map.get("bSortable_"+i);
            mDataProps.add(dataProp);
            bSortables.add(sortable);
        }

        List<Integer> iSortCols = Lists.newArrayList();
        List<String> sSortDirs = Lists.newArrayList();
        List<String> iSortColsName = Lists.newArrayList();

        for(int i=0;i<iSortingCols;i++)
        {
            Integer sortCol = (Integer)map.get("iSortCol_"+i);
            String sortColName = mDataProps.get(sortCol);
            String sortDir = (String)map.get("sSortDir_"+i);
            iSortCols.add(sortCol);
            iSortColsName.add(sortColName);
            sSortDirs.add(sortDir);

        }
        return new DataTableParameter(sEcho,iDisplayStart,iDisplayLength,iColumns, mDataProps, bSortables, iSortingCols, iSortCols, sSortDirs,iSortColsName);
    }

    private Map<String,Object> convertJsonStringToHashMap(String jsonParam) {

        JSONArray jsonArray = JSONArray.parseArray(jsonParam);
        Map<String,Object> map= Maps.newHashMap();

        for(int i=0;i<jsonArray.size();i++)
        {
            JSONObject jsonObject=jsonArray.getJSONObject(i);
            map.put(jsonObject.getString("name"),jsonObject.get("value"));
        }

        return map;
    }


}
