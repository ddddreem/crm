package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.ActivityRemark;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 03 10:21
 **/
public interface ActivityRemarkService {
    List<ActivityRemark> queryDetailActivityRemarkByActivityId(String id);
    int saveCreateActivityRemark(ActivityRemark remark);
    int deleteActivityRemarkById(String id);
    int updateActivityRemarkById(ActivityRemark activityRemark);
    int deleteActivityRemarksByActivityIds(String[] ids);
}
