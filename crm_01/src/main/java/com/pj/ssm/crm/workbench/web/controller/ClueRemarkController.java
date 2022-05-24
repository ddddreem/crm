package com.pj.ssm.crm.workbench.web.controller;

import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UUIDUtils;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.workbench.domain.ClueRemark;
import com.pj.ssm.crm.workbench.service.ClueRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.concurrent.ExecutionException;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 09 11:40
 **/
@Controller
public class ClueRemarkController {

    @Autowired
    private ClueRemarkService clueRemarkService;

    // 保存线索备注
    @RequestMapping("/workbench/clue/saveClueRemark.do")
    public @ResponseBody Msg saveClueRemark(ClueRemark clueRemark, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        clueRemark.setId(UUIDUtils.getUUID());
        clueRemark.setCreateBy(user.getId());
        clueRemark.setCreateTime(DateFormatUtils.DateToString(new Date()));
        clueRemark.setEditFlag("0");
        try{
            int count = clueRemarkService.saveClueRemark(clueRemark);
            if(count > 0) return Msg.success().add("createdClueRemark", clueRemark);
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 删除线索备注
    @RequestMapping("/workbench/clue/deleteClueRemarkById.do")
    public @ResponseBody Msg deleteClueRemarkById(String id){
        try{
            int count = clueRemarkService.deleteClueRemarkById(id);
            if(count > 0) return Msg.success().add("count", count);
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    // 修改线索备注
    @RequestMapping("/workbench/clue/updateClueRemarkById.do")
    public @ResponseBody Msg updateClueRemarkById(ClueRemark clueRemark, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        clueRemark.setEditFlag("1");
        clueRemark.setEditBy(user.getId());
        clueRemark.setEditTime(DateFormatUtils.DateToString(new Date()));
        try{
            int count = clueRemarkService.updateClueRemarkById(clueRemark);
            if(count > 0) return Msg.success().add("updateClueRemark", clueRemark);
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }
}
