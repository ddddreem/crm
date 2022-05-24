package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.ClueRemark;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 09 10:38
 **/
public interface ClueRemarkService {
    List<ClueRemark> queryClueRemarksByClueId(String clueId);
    int saveClueRemark(ClueRemark clueRemark);
    int deleteClueRemarkById(String id);
    int updateClueRemarkById(ClueRemark clueRemark);
}
