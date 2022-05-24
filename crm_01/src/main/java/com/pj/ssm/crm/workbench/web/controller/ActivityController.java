package com.pj.ssm.crm.workbench.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.*;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.service.UserService;
import com.pj.ssm.crm.workbench.domain.Activity;
import com.pj.ssm.crm.workbench.domain.ActivityRemark;
import com.pj.ssm.crm.workbench.service.ActivityRemarkService;
import com.pj.ssm.crm.workbench.service.ActivityService;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 24 11:40
 **/
@Controller
public class ActivityController {

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ActivityRemarkService activityRemarkService;

    // 在工作区中显示市场活动列表页面
    @RequestMapping("/workbench/activity/index.do")
    public ModelAndView index(){
        ModelAndView mv = new ModelAndView();
        // 获取用户列表，添加到mv中
        mv.addObject("userList", userService.queryAllUsers());
        // 设置跳转的页面
        mv.setViewName("workbench/activity/index");
        return mv;
    }

    // 保存添加的市场活动
    @RequestMapping("/workbench/activity/saveCreateActivity.do")
    public @ResponseBody Msg saveCreateActivity(Activity activity, HttpSession session){
        // 再次封装activity
        activity.setId(UUIDUtils.getUUID());
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        activity.setCreateBy(user.getId());
        activity.setCreateTime(DateFormatUtils.DateToString(new Date()));
        Msg msg = new Msg();
        try{
            int code = activityService.saveCreateActivity(activity);
            if(code > 0){
                Integer count = activityService.queryCountRecords();
                msg.setCode(Contants.RETURNOBJECT_SUCCESS);
                msg.add("count", count);
            }else{
                msg.setCode(Contants.RETURNOBJECT_FAILURE);
                msg.setMsg("系统忙,请稍后重试...");
            }
        }catch (Exception e){
            e.printStackTrace();
            msg.setCode(Contants.RETURNOBJECT_FAILURE);
            msg.setMsg("系统忙,请稍后重试...");
        }
        return msg;
    }

    // 获取所有的活动记录
    @RequestMapping("/workbench/activity/queryAllActivity.do")
    @ResponseBody
    public Msg queryAllActivity(){
        List<Activity> activities = activityService.queryAllActivity();
        if(activities != null){
            return Msg.success().add("activities", activities);
        }
        return Msg.fail();
    }

    // 根据页面中的条件查询活动记录
    @RequestMapping("/workbench/activity/queryActivitiesSelective.do")
    public @ResponseBody Msg queryActivitiesSelective(String owner, String name, String startTime, String endTime, @RequestParam(value = "pn", defaultValue = "1") String pn, String ps){
        int pageNo = Integer.parseInt(pn);
        int pageSize = Integer.parseInt(ps);
        Map<String, Object> map = new HashMap<>();
        map.put("owner", owner);
        map.put("name", name);
        map.put("startTime", startTime);
        map.put("endTime", endTime);
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pageNo, pageSize);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Activity> list = activityService.queryActivitiesSelective(map);
        // 使用pageInfo包装查询后的结果，只需要pageInfo交给页面就行了
        // 封装了详细的分页信息，包括有我们查询出来的数据
        PageInfo page = new PageInfo(list, 5);
        return Msg.success().add("pageInfo", page);
    }

    // 删除市场活动数据
    // 需要设置事务为不是只读，因为spring和mybatis的整合中设置了给所有方法添加事务并设置为只读
    @RequestMapping("/workbench/activity/removeActivitiesByIds.do")
    public @ResponseBody Msg removeActivitiesByIds(String[] id){
        Msg msg = new Msg();
        try{
            int rows = activityService.deleteActivitiesByIds(id);
            // 删除所属的市场活动里的所有备注信息
            activityRemarkService.deleteActivityRemarksByActivityIds(id);
            if(rows > 0){
                msg.setCode(Contants.RETURNOBJECT_SUCCESS);
                msg.setMsg("共有" + rows + "条记录受影响");
                msg.add("rows", rows);
            }
            else{
                msg.setCode(Contants.RETURNOBJECT_FAILURE);
                msg.setMsg("系统繁忙,请稍后重试...");
            }
        }catch (Exception e){
            e.printStackTrace();
            msg.setCode(Contants.RETURNOBJECT_FAILURE);
            msg.setMsg("系统繁忙,请稍后重试...");
        }
        return msg;
    }

    // 根据id查找市场活动单条数据
    @RequestMapping("/workbench/activity/queryActivityByID.do")
    @ResponseBody
    public Msg queryActivityByID(String id){
        Activity activity = activityService.queryActivityByID(id);
        if(activity != null) return Msg.success().add("activity", activity);
        return Msg.fail();
    }

    // 修改和更新市场活动数据
    @RequestMapping("/workbench/activity/updateActivityByID.do")
    public @ResponseBody Msg updateActivityByID(Activity activity, HttpSession session){
        activity.setEditTime(DateFormatUtils.DateToString(new Date()));
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        activity.setEditBy(user.getId());
        try {
            int i = activityService.updateActivityByID(activity);
            if(i > 0){
                return Msg.success().add("count", i);
            }else{
                return Msg.fail();
            }
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 导出全部活动，以excel文件导出到页面，供用户下载
    @RequestMapping("/workbench/activity/exportAllActivities.do")
    public void exportAllActivities(HttpServletResponse response) throws Exception{
        List<Activity> activities = activityService.queryAllActivities();
        // 创建HSSFWorkBook对象，对应一个excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        wb = HSSFUtils.getMarketActivityExcel(wb, activities);
        // 调用工具函数生成excel文件
//        OutputStream os = new FileOutputStream("E:\\workspace_idea\\serverDir\\activityList.xls");
//        wb.write(os);

        // 使用完毕关闭流
//        wb.close();
//        os.close();

        // 1.设置响应信息
        response.setContentType("application/octet-stream;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=activityList.xls");
        // 把生成的excel文件下载到客户端
        OutputStream out = response.getOutputStream();
//        InputStream is = new FileInputStream("E:\\workspace_idea\\serverDir\\activityList.xls");
//        byte[] buffer = new byte[256];
//        int len = 0;
//        while((len = is.read(buffer)) != -1){
//            out.write(buffer, 0, len);
//        }

        // 直接从内存到内存，访问磁盘效率太低
        wb.write(out);

        wb.close();
        out.flush(); // 把数据刷走，如果不刷走，留在缓冲区的数据可能丢失
    }

    // 根据id数组查询数据库中的市场活动数据，并生成Excel文件传到页面,导出用户选择的市场活动
    @RequestMapping("/workbench/activity/queryActivitiesByIDs.do")
    public void queryActivitiesByIDs(String[] id, HttpServletResponse response) throws IOException {
        List<Activity> activities = activityService.queryActivitiesByIDs(id);
        // 创建HSSFWorkBook对象，对应一个excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        wb = HSSFUtils.getMarketActivityExcel(wb, activities);

        response.setContentType("application/octet-stream;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=selectiveActivityList.xls");

        OutputStream out = response.getOutputStream();

        wb.write(out);

        wb.close();
        out.flush();
    }

    // 用户导入excel文件，将设计好的市场活动添加到数据库中
    @RequestMapping("/workbench/activity/importActivitiesByExcel.do")
    public @ResponseBody Msg importActivitiesByExcel(MultipartFile activityFile, HttpSession session){
        try {
//            // 把excel文件写到磁盘目录下,这样写虽然能完成需求，但是效率太低了，不建议使用
//            String originalFilename = activityFile.getOriginalFilename();
//            File file = new File("E:\\workspace_idea\\clientDir\\", originalFilename);
//            activityFile.transferTo(file);
//            // 解析excel文件，获取文件中的数据，并且封装到activityList
//            InputStream is = new FileInputStream("E:\\workspace_idea\\clientDir\\"+ originalFilename);

            // 直接使用MultipartFile的getInputStream()方法获取输入流，直接从内存中传到内存，效率更高
            InputStream is = activityFile.getInputStream();
            HSSFWorkbook wb = new HSSFWorkbook(is);
            HSSFSheet sheet = wb.getSheetAt(0);
            HSSFRow row = null;
            HSSFCell cell = null;

            Activity activity = null;
            ArrayList<Activity> activities = new ArrayList<>();
            User user = (User) session.getAttribute(Contants.SESSION_USER);
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                row = sheet.getRow(i); // 行的下标，下标从0开始，依次增加
                activity = new Activity();

                // 把一些固定的字段先赋值
                activity.setId(UUIDUtils.getUUID());
                activity.setCreateBy(user.getId());
                activity.setCreateTime(DateFormatUtils.DateToString(new Date()));
                String owner = userService.queryIDByUserName(HSSFUtils.getCellValueToStr(row.getCell(0)));
                activity.setOwner(owner);

                for (int j = 1; j < row.getLastCellNum(); j++) { // row.getLastCellNum();最后一列的下标+1
                    // 根据row获取HSSFCell对象，封装了一列的所用信息
                    cell = row.getCell(j);
                    String str = HSSFUtils.getCellValueToStr(cell);

                    if(j == 1){
                        activity.setName(str);
                    }else if(j == 2){
                        activity.setStartDate(str);
                    }else if(j == 3){
                        activity.setEndDate(str);
                    }else if(j == 4){
                        activity.setCost(str);
                    }else if(j == 5){
                        activity.setDescription(str);
                    }
                }
                activities.add(activity);
            }
            int count = activityService.saveActivitiesByList(activities);
            return Msg.success().add("count", count);
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 获取导入市场活动的模板
    @RequestMapping("/workbench/activity/getActivityModal.do")
    public void getActivityModal(HttpServletResponse response) throws Exception{
        HSSFWorkbook modalHSSFWorkbook = new HSSFWorkbook();
        modalHSSFWorkbook = HSSFUtils.getModalHSSFWorkbook(modalHSSFWorkbook);

        OutputStream out = response.getOutputStream();
        response.setContentType("application/octet-stream;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=activityModal.xls");

        modalHSSFWorkbook.write(out);

        modalHSSFWorkbook.close();
        out.flush();
    }

    // 跳转市场活动明细页面
    @RequestMapping("/workbench/activity/detailActivity.do")
    public ModelAndView detailActivity(String id){
        ModelAndView mv = new ModelAndView();
        Activity activity = activityService.queryDetailByID(id);
        List<ActivityRemark> activityRemarks = activityRemarkService.queryDetailActivityRemarkByActivityId(id);
        mv.addObject("activityDetail", activity);
        mv.addObject("activityRemarks", activityRemarks);
        mv.setViewName("workbench/activity/detail");
        return mv;
    }
}
