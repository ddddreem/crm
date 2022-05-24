package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.TranRemark;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 16 8:02
 **/
public interface TranRemarkService {
    List<TranRemark> queryTranRemarksForDetailByTranId(String tranId);
}
