package com.pj.ssm.crm.settings.service.impl;

import com.pj.ssm.crm.settings.domain.DicValue;
import com.pj.ssm.crm.settings.mapper.DicValueMapper;
import com.pj.ssm.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 05 16:16
 **/
@Service("dicService")
public class DicServiceImpl implements DicService {

    @Autowired
    private DicValueMapper dicValueMapper;

    @Override
    public List<DicValue> queryDicValueByTypeCode(String typeCode) {
        return dicValueMapper.selectDicValueByTypeCode(typeCode);
    }

    @Override
    public List<String> queryLegendByTypeCode(String typeCode) {
        return dicValueMapper.selectLegendByTypeCode(typeCode);
    }

    @Override
    public String queryStageNameByStageId(String stageId) {
        return dicValueMapper.selectStageNameByStageId(stageId);
    }
}
