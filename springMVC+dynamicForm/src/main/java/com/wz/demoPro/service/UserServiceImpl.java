package com.wz.demoPro.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wz.demoPro.entity.DataTableParameter;
import com.wz.demoPro.entity.User;
import com.wz.demoPro.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.testng.collections.Lists;
import org.testng.collections.Maps;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;


    public User saveAndFlush(User user) {
        User user1 = userRepository.saveAndFlush(user);
        return user1;
    }

    public List<User> findAll() {
        List<User> all = userRepository.findAll();
        return all;
    }

    public User findOne(int id) {
        User user = userRepository.findOne(id);
        return user;
    }

    public void delOne(int id) {
        userRepository.delete(id);
    }

    public DataTableParameter getDataTableParameterByJsonParam(String aoData) {

        Map<String,Object> map = convertJsonStringToHashMap(aoData);

        int sEcho=(Integer) map.get("sEcho");
        int iDisplayStart=(Integer)map.get("iDisplayStart");
        int iDisplayLength=(Integer)map.get("iDisplayLength");
        int iColumns=(Integer)map.get("iColumns");
//        int iSortingCols = (Integer) map.get("iSortingCols");

        List<String> mDataProps= Lists.newArrayList();
//        List<Boolean> bSortables=Lists.newArrayList();

        for(int i=0;i<iColumns;i++)
        {
            String dataProp=(String)map.get("mDataProp_"+i);
//            Boolean sortable = (Boolean)map.get("bSortable_"+i);
            mDataProps.add(dataProp);
//            bSortables.add(sortable);
        }

//        List<Integer> iSortCols = Lists.newArrayList();
//        List<String> sSortDirs = Lists.newArrayList();
//        List<String> iSortColsName = Lists.newArrayList();
//
//        for(int i=0;i<iSortingCols;i++)
//        {
//            Integer sortCol = (Integer)map.get("iSortCol_"+i);
//            String sortColName = mDataProps.get(sortCol);
//            String sortDir = (String)map.get("sSortDir_"+i);
//            iSortCols.add(sortCol);
//            iSortColsName.add(sortColName);
//            sSortDirs.add(sortDir);
//
//        }
            //, bSortables, iSortingCols, iSortCols, sSortDirs,iSortColsName
        return new DataTableParameter(sEcho,iDisplayStart,iDisplayLength,iColumns, mDataProps);
    }

    private Map<String,Object> convertJsonStringToHashMap(String aoData) {
        JSONArray jsonArray = JSONArray.parseArray(aoData);
        Map<String,Object> map= Maps.newHashMap();

        for(int i=0;i<jsonArray.size();i++)
        {
            JSONObject jsonObject=jsonArray.getJSONObject(i);
            map.put(jsonObject.getString("name"),jsonObject.get("value"));
        }

        return map;
    }


}
