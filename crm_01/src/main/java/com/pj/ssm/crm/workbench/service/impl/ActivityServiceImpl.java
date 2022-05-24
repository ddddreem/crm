package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.Activity;
import com.pj.ssm.crm.workbench.mapper.ActivityMapper;
import com.pj.ssm.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 24 14:28
 **/
@Service("activityService")
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;
    @Override
    public int saveCreateActivity(Activity activity) {
        return activityMapper.insertActivity(activity);
    }

    @Override
    public List<Activity> queryAllActivity() {
        return activityMapper.selectAllActivity();
    }

    @Override
    public List<Activity> queryActivitiesSelective(Map<String, Object> map) {
        return activityMapper.selectActivitiesSelective(map);
    }

    @Override
    public Integer queryCountRecords() {
        return activityMapper.selectCountRecords();
    }

    @Override
    public void addActivitySelective(Activity activity) {
        activityMapper.insertSelective(activity);
    }

    @Override
    public int deleteActivitiesByIds(String[] ids) {
        return activityMapper.deleteActivityByIds(ids);
    }

    @Override
    public Activity queryActivityByID(String id) {
        return activityMapper.selectActivityByID(id);
    }

    @Override
    public int updateActivityByID(Activity activity) {
        return activityMapper.updateByPrimaryKeySelective(activity);
    }

    @Override
    public List<Activity> queryAllActivities() {
        return activityMapper.selectAllActivities();
    }

    @Override
    public List<Activity> queryActivitiesByIDs(String[] ids) {
        return activityMapper.selectActivitiesByIDs(ids);
    }

    @Override
    public int saveActivitiesByList(List<Activity> activities) {
        return activityMapper.insertActivitiesByList(activities);
    }

    @Override
    public Activity queryDetailByID(String id) {
        return activityMapper.selectDetailByID(id);
    }

    @Override
    public List<Activity> queryRelationActivitiesByClueId(String clueId) {
        return activityMapper.selectRelationActivitiesByClueId(clueId);
    }

    @Override
    public List<Activity> queryActicityForBundByNameClueId(Map<String, Object> map) {
        return activityMapper.selectActicityForBundByNameClueId(map);
    }

    @Override
    public List<Activity> queryRelationActivitiesForBundByIds(String[] ids) {
        return activityMapper.selectRelationActivitiesForBundByIds(ids);
    }

    @Override
    public List<Activity> queryRelationActivitiesByNameClueId(Map<String, Object> map) {
        return activityMapper.selectRelationActivitiesByNameClueId(map);
    }

    @Override
    public List<Activity> queryActivitiesByActivityName(String activityName) {
        return activityMapper.selectActivitiesByActivityName(activityName);
    }
}
