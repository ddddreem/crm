package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 05 19:55
 **/
public interface ClueService {
    int saveCreateClue(Clue clue);
    List<Clue> queryAllClues(Clue conditionClue);
    Clue queryClueById(String id);
    int deleteCluesByIds(String[] id);
    int updateClueByCondition(Clue record);

    Clue queryClueDetailById(String id);
    int deleteRelationByActivityIdAndClueId(Map<String, Object> map);

    void saveConvert(Map<String, Object> map);
}
