package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.ActivityRemark;
import com.pj.ssm.crm.workbench.mapper.ActivityRemarkMapper;
import com.pj.ssm.crm.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 03 10:22
 **/
@Service("activityRemarkService")
public class ActivityRemarkServiceImpl implements ActivityRemarkService {
    @Autowired
    private ActivityRemarkMapper activityRemarkMapper;

    @Override
    public List<ActivityRemark> queryDetailActivityRemarkByActivityId(String id) {
        return activityRemarkMapper.selectActivityRemarksByActivityId(id);
    }

    @Override
    public int saveCreateActivityRemark(ActivityRemark remark) {
        return activityRemarkMapper.insertSelective(remark);
    }

    @Override
    public int deleteActivityRemarkById(String id) {
        return activityRemarkMapper.deleteActivityRemarkById(id);
    }

    @Override
    public int updateActivityRemarkById(ActivityRemark activityRemark) {
        return activityRemarkMapper.updateActivityRemarkById(activityRemark);
    }

    @Override
    public int deleteActivityRemarksByActivityIds(String[] ids) {
        return activityRemarkMapper.deleteActivityRemarksByActivityIds(ids);
    }

}
