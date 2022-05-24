package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.workbench.domain.Funnel;
import com.pj.ssm.crm.workbench.domain.Tran;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 18:02
 **/
public interface TranService {
    List<Tran> queryAllTrans(Tran conditionTran);
    Tran queryTranDetailById(String tranId);
    List<Funnel> queryCountOfTranGroupByStage();
    int saveCreateTran(Tran tran);
}
