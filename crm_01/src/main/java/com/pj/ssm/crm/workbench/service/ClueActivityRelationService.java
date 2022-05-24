package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 09 17:23
 **/
public interface ClueActivityRelationService {
    int saveByActivityClueIdList(List<ClueActivityRelation> clueActivityRelations);
}
