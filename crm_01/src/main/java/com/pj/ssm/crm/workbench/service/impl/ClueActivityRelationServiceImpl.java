package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.ClueActivityRelation;
import com.pj.ssm.crm.workbench.mapper.ClueActivityRelationMapper;
import com.pj.ssm.crm.workbench.service.ClueActivityRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 09 17:23
 **/
@Service("clueActivityRelationService")
public class ClueActivityRelationServiceImpl implements ClueActivityRelationService {
    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;

    @Override
    public int saveByActivityClueIdList(List<ClueActivityRelation> clueActivityRelations) {
        return clueActivityRelationMapper.insertByActivityClueIdList(clueActivityRelations);
    }
}
