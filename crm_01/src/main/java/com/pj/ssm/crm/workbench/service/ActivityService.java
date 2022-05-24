package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 24 14:27
 **/
public interface ActivityService {
    int saveCreateActivity(Activity activity);
    List<Activity> queryAllActivity();
    List<Activity> queryActivitiesSelective(Map<String, Object> map);
    Integer queryCountRecords();
    void addActivitySelective(Activity activity);
    int deleteActivitiesByIds(String[] ids);
    Activity queryActivityByID(String id);
    int updateActivityByID(Activity activity);
    List<Activity> queryAllActivities();
    List<Activity> queryActivitiesByIDs(String[] ids);
    int saveActivitiesByList(List<Activity> activities);
    Activity queryDetailByID(String id);
    List<Activity> queryRelationActivitiesByClueId(String clueId);
    List<Activity> queryActicityForBundByNameClueId(Map<String, Object> map);
    List<Activity> queryRelationActivitiesForBundByIds(String[] ids);
    List<Activity> queryRelationActivitiesByNameClueId(Map<String, Object> map);
    List<Activity> queryActivitiesByActivityName(String activityName);
}
