package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.TranHistory;
import com.pj.ssm.crm.workbench.mapper.TranHistoryMapper;
import com.pj.ssm.crm.workbench.service.TranHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 16 8:12
 **/
@Service("tranHistoryService")
public class TranHistoryServiceImpl implements TranHistoryService {

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Override
    public List<TranHistory> queryTranHistoriesForDetailByTranId(String tranId) {
        return tranHistoryMapper.selectTranHistoriesForDetailByTranId(tranId);
    }

    @Override
    public int saveTranHistoryForCreateTran(TranHistory tranHistory) {
        return tranHistoryMapper.insertTranHistoryForCreateTran(tranHistory);
    }
}
