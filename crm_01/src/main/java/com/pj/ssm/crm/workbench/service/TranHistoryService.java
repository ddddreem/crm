package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.TranHistory;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 16 8:12
 **/
public interface TranHistoryService {
    List<TranHistory> queryTranHistoriesForDetailByTranId(String tranId);
    int saveTranHistoryForCreateTran(TranHistory tranHistory);
}
