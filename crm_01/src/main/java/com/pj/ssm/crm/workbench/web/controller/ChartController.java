package com.pj.ssm.crm.workbench.web.controller;

import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.settings.domain.DicValue;
import com.pj.ssm.crm.settings.service.DicService;
import com.pj.ssm.crm.workbench.domain.Funnel;
import com.pj.ssm.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 18 8:27
 **/
@Controller
public class ChartController {

    @Autowired
    private TranService tranService;

    @Autowired
    private DicService dicService;


    // 跳转交易图表页面
    @RequestMapping("/workbench/chart/transaction/tranChart.do")
    public String tranChart(){
        return "workbench/chart/transaction/index";
    }

    @RequestMapping("/workbench/chart/transaction/queryCountOfTranGroupByStage.do")
    public @ResponseBody Msg queryCountOfTranGroupByStage(){
        List<String> stage = dicService.queryLegendByTypeCode("stage");
        List<Funnel> funnels = tranService.queryCountOfTranGroupByStage();
        return Msg.success().add("funnels", funnels).add("stage", stage);
    }
}
