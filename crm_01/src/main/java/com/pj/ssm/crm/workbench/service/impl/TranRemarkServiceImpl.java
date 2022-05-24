package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.TranRemark;
import com.pj.ssm.crm.workbench.mapper.TranRemarkMapper;
import com.pj.ssm.crm.workbench.service.TranRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 16 8:03
 **/
@Service("tranRemarkService")
public class TranRemarkServiceImpl implements TranRemarkService {

    @Autowired
    private TranRemarkMapper tranRemarkMapper;
    @Override
    public List<TranRemark> queryTranRemarksForDetailByTranId(String tranId) {
        return tranRemarkMapper.selectTranRemarksForDetailByTranId(tranId);
    }
}
