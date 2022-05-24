package com.pj.ssm.crm.workbench.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UUIDUtils;
import com.pj.ssm.crm.settings.domain.DicValue;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.service.DicService;
import com.pj.ssm.crm.settings.service.UserService;
import com.pj.ssm.crm.workbench.domain.*;
import com.pj.ssm.crm.workbench.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.crypto.MacSpi;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 05 16:27
 **/
@Controller
public class ClueController {
    @Autowired
    private DicService dicService;

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ClueService clueService;

    @Autowired
    private ClueRemarkService clueRemarkService;

    @Autowired
    private ClueActivityRelationService clueActivityRelationService;

    @RequestMapping("/workbench/clue/clueIndex.do")
    public ModelAndView clueIndex(){
        ModelAndView mv = new ModelAndView();
        // 获取称呼列表
        List<DicValue> appellation = dicService.queryDicValueByTypeCode("appellation");
        // 获取线索状态列表
        List<DicValue> clueState = dicService.queryDicValueByTypeCode("clueState");
        // 获取线索来源列表
        List<DicValue> source = dicService.queryDicValueByTypeCode("source");
        // 获取用户列表
        List<User> users = userService.queryAllUsers();
        mv.addObject("appellation", appellation);
        mv.addObject("clueState", clueState);
        mv.addObject("source", source);
        mv.addObject("users", users);
        mv.setViewName("workbench/clue/index");
        return mv;
    }

    // 保存创建的线索
    @RequestMapping("/workbench/clue/saveCreateClue.do")
    public @ResponseBody Msg saveCreateClue(Clue clue, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        clue.setCreateBy(user.getId());
        clue.setCreateTime(DateFormatUtils.DateToString(new Date()));
        clue.setId(UUIDUtils.getUUID());
        try{
            int count = clueService.saveCreateClue(clue);
            if(count > 0) return Msg.success();
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }
    // 查询所有的线索并使用分页插件
    @RequestMapping("/workbench/clue/queryAllClues.do")
    public @ResponseBody Msg queryAllClues(Clue conditionClue, String pn, String ps){
        int pageNo = Integer.parseInt(pn);
        int pageSize = Integer.parseInt(ps);
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pageNo, pageSize);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Clue> clues = clueService.queryAllClues(conditionClue);
        // 使用pageInfo包装查询后的结果，只需要pageInfo交给页面就行了
        // 封装了详细的分页信息，包括有我们查询出来的数据
        PageInfo page = new PageInfo(clues, 5);
        return Msg.success().add("pageInfo", page);
    }

    // 根据id查询线索明细
    @RequestMapping("/workbench/clue/queryClueById.do")
    public @ResponseBody Msg queryClueById(String id){
        Clue qClue = clueService.queryClueById(id);
        if(qClue == null){
            return Msg.fail();
        }
        return Msg.success().add("qClue", qClue);
    }

    // 根据id数组删除线索记录
    @RequestMapping("/workbench/clue/deleteCluesByIds.do")
    public @ResponseBody Msg deleteCluesByIds(String[] id){
        try{
            int count = clueService.deleteCluesByIds(id);
            if(count > 0) return Msg.success().add("count", count);
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 根据id更新线索
    @RequestMapping("/workbench/clue/updateClueByCondition.do")
    public @ResponseBody Msg updateClueByCondition(Clue record, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        record.setEditBy(user.getId());
        record.setEditTime(DateFormatUtils.DateToString(new Date()));
        try{
            int count = clueService.updateClueByCondition(record);
            if(count > 0) return Msg.success().add("count", count);
            return Msg.fail();
        }catch(Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 根据id查看线索明细
    @RequestMapping("/workbench/clue/detailClue.do")
    public ModelAndView detailClue(String id){
        ModelAndView mv = new ModelAndView();
        // 获取线索明细并返回页面
        Clue clueDetail = clueService.queryClueDetailById(id);
        // 获取备注列表
        List<ClueRemark> clueRemarks = clueRemarkService.queryClueRemarksByClueId(id);
        // 获取线索关联的市场活动
        List<Activity> relationActivities = activityService.queryRelationActivitiesByClueId(id);
        mv.addObject("clueDetail", clueDetail);
        mv.addObject("clueRemarks", clueRemarks);
        mv.addObject("relationActivities", relationActivities);
        mv.setViewName("workbench/clue/detail");
        return mv;
    }

    // 根据市场活动的名字和线索id模糊查询并返回市场活动列表
    @RequestMapping("/workbench/clue/queryActivityForDetailByNameClueId.do")
    public @ResponseBody Msg queryActivityForDetailByNameClueId(String activityName, String clueId){
        Map<String, Object> map = new HashMap<>();
        map.put("activityName", activityName);
        map.put("clueId", clueId);
        List<Activity> activities = activityService.queryActicityForBundByNameClueId(map);
        return Msg.success().add("unbundActivities", activities);
    }

    // 根据activityId数组和clueId保存关联关系
    @RequestMapping("/workbench/clue/saveByActivityClueIdList.do")
    public @ResponseBody Msg saveByActivityClueIdList(String[] activityId, String clueId){
        ClueActivityRelation clueActivityRelation = null;
        List<ClueActivityRelation> clueActivityRelations = new ArrayList<>();
        // 增强for循环, 遍历activityId数组, 生成关系实体类对象
        for(String act:activityId){
            clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setId(UUIDUtils.getUUID());
            clueActivityRelation.setActivityId(act);
            clueActivityRelation.setClueId(clueId);

            clueActivityRelations.add(clueActivityRelation);
        }
        try{
            int count = clueActivityRelationService.saveByActivityClueIdList(clueActivityRelations);
            if(count > 0){
                List<Activity> relationActivities = activityService.queryRelationActivitiesForBundByIds(activityId);
                return Msg.success().add("relationActivities", relationActivities);
            }
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 根据activityId和clueId删除关联关系
    @RequestMapping("/workbench/clue/deleteRelationByActivityIdAndClueId.do")
    public @ResponseBody Msg deleteRelationByActivityIdAndClueId(String activityId, String clueId){
        Map<String, Object> map = new HashMap<>();
        map.put("activityId", activityId);
        map.put("clueId", clueId);
        try{
            int count = clueService.deleteRelationByActivityIdAndClueId(map);
            if(count > 0) return Msg.success();
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 跳转转换页面
    @RequestMapping("/workbench/clue/convertIndex.do")
    public ModelAndView convertIndex(String id){
        ModelAndView mv = new ModelAndView();
        mv.addObject("clue", clueService.queryClueDetailById(id));
        mv.addObject("stage", dicService.queryDicValueByTypeCode("stage"));
        mv.setViewName("workbench/clue/convert");
        return mv;
    }

    // 响应搜索输入框的键盘弹起事件
    @RequestMapping("/workbench/clue/queryRelationActivitiesByNameClueId.do")
    public @ResponseBody Msg queryRelationActivitiesByNameClueId(String activityName, String clueId){
        Map<String, Object> map = new HashMap<>();
        map.put("activityName", activityName);
        map.put("clueId", clueId);
        try{
            List<Activity> relationActivities = activityService.queryRelationActivitiesByNameClueId(map);
            if(relationActivities != null && relationActivities.size() != 0) return Msg.success().add("relationActivities", relationActivities);
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 将线索转换为客户、联系人和创建交易
    @RequestMapping("/workbench/clue/convertClue.do")
    public @ResponseBody Msg convertClue(String clueId, String money, String name, String expectedDate, String stage, String activityId, String isCreateTran, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("clueId", clueId);
        map.put("money", money);
        map.put("name", name);
        map.put("expectedDate", expectedDate);
        map.put("stage", stage);
        map.put("activityId", activityId);
        map.put("isCreateTran", isCreateTran);
        map.put(Contants.SESSION_USER, session.getAttribute(Contants.SESSION_USER));
        try{
            clueService.saveConvert(map);
            return Msg.success();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }
}
