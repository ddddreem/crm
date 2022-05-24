package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.ClueRemark;
import com.pj.ssm.crm.workbench.mapper.ClueRemarkMapper;
import com.pj.ssm.crm.workbench.service.ClueRemarkService;
import com.pj.ssm.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 09 10:38
 **/
@Service("clueRemarkService")
public class ClueRemarkServiceImpl implements ClueRemarkService {

    @Autowired
    private ClueRemarkMapper clueRemarkMapper;

    @Override
    public List<ClueRemark> queryClueRemarksByClueId(String clueId) {
        return clueRemarkMapper.selectClueRemarksByClueId(clueId);
    }

    @Override
    public int saveClueRemark(ClueRemark clueRemark) {
        return clueRemarkMapper.insertClueRemark(clueRemark);
    }

    @Override
    public int deleteClueRemarkById(String id) {
        return clueRemarkMapper.deleteClueRemarkById(id);
    }

    @Override
    public int updateClueRemarkById(ClueRemark clueRemark) {
        return clueRemarkMapper.updateClueRemarkById(clueRemark);
    }
}
