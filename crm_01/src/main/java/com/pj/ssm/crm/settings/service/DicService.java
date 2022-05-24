package com.pj.ssm.crm.settings.service;

import com.pj.ssm.crm.settings.domain.DicValue;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 05 16:16
 **/
public interface DicService {
    List<DicValue> queryDicValueByTypeCode(String typeCode);
    List<String> queryLegendByTypeCode(String typeCode);
    String queryStageNameByStageId(String stageId);
}