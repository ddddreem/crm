package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UUIDUtils;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.workbench.domain.*;
import com.pj.ssm.crm.workbench.mapper.*;
import com.pj.ssm.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 05 19:55
 **/
@Service("clueService")
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private TranRemarkMapper tranRemarkMapper;

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private ClueRemarkMapper clueRemarkMapper;

    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;

    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;

    @Autowired
    private ContactsActivityRelationMapper contactsActivityRelationMapper;

    @Override
    public int saveCreateClue(Clue clue) {
        return clueMapper.insertSelective(clue);
    }

    @Override
    public List<Clue> queryAllClues(Clue conditionClue) {
        return clueMapper.selectAllClues(conditionClue);
    }

    @Override
    public Clue queryClueById(String id) {
        return clueMapper.selectClueById(id);
    }

    @Override
    public int deleteCluesByIds(String[] id) {
        return clueMapper.deleteCluesByIds(id);
    }

    @Override
    public int updateClueByCondition(Clue record) {
        return clueMapper.updateClueByCondition(record);
    }

    @Override
    public Clue queryClueDetailById(String id) {
        return clueMapper.selectDetailClueById(id);
    }

    @Override
    public int deleteRelationByActivityIdAndClueId(Map<String, Object> map) {
        return clueActivityRelationMapper.deleteRelationByActivityIdAndClueId(map);
    }

    @Override
    public void saveConvert(Map<String, Object> map) {
        User user = (User) map.get(Contants.SESSION_USER);
        // 根据id查询线索信息
        String clueId = (String) map.get("clueId");
        Clue clue = clueMapper.selectClueById(clueId);
        String isCreateTran = (String) map.get("isCreateTran");

        // 把该线索中有关公司的信息转换到客户表中
        Customer c = new Customer();
        c.setAddress(clue.getAddress());
        c.setContactSummary(clue.getContactSummary());
        c.setCreateBy(user.getId());
        c.setCreateTime(DateFormatUtils.DateToString(new Date()));
        c.setDescription(clue.getDescription());
        c.setId(UUIDUtils.getUUID());
        c.setName(clue.getCompany());
        c.setNextContactTime(clue.getNextContactTime());
        c.setOwner(user.getId());
        c.setPhone(clue.getPhone());
        c.setWebsite(clue.getWebsite());
        customerMapper.insertCustomer(c);

        // 将线索中相关个人信息转换到联系人表中
        Contacts co = new Contacts();
        co.setId(UUIDUtils.getUUID());
        co.setAddress(clue.getAddress());
        co.setAppellation(clue.getAppellation());
        co.setContactSummary(clue.getContactSummary());
        co.setCreateBy(user.getId());
        co.setCreateTime(DateFormatUtils.DateToString(new Date()));
        co.setCustomerId(c.getId());
        co.setDescription(clue.getDescription());
        co.setEmail(clue.getEmail());
        co.setFullname(clue.getFullname());
        co.setJob(clue.getJob());
        co.setMphone(clue.getMphone());
        co.setNextContactTime(clue.getNextContactTime());
        co.setOwner(user.getId());
        co.setSource(clue.getSource());
        contactsMapper.insertContactsByConvert(co);

        // 返回线索备注列表
        List<ClueRemark> clueRemarks = clueRemarkMapper.selectClueRemarksByClueId(clueId);
        if(clueRemarks != null && clueRemarks.size() > 0){
            CustomerRemark cur = null;
            ContactsRemark cor = null;
            List<CustomerRemark> curList = new ArrayList<>();
            List<ContactsRemark> corList = new ArrayList<>();
            // 遍历list
            for(ClueRemark clueRemark:clueRemarks){
                // 为客户添加线索备注
                cur = new CustomerRemark();
                cur.setCreateBy(clueRemark.getCreateBy());
                cur.setCreateTime(clueRemark.getCreateTime());
                cur.setCustomerId(c.getId());
                cur.setEditBy(clueRemark.getEditBy());
                cur.setEditTime(clueRemark.getEditTime());
                cur.setEditFlag(clueRemark.getEditFlag());
                cur.setId(UUIDUtils.getUUID());
                cur.setNoteContent(clueRemark.getNoteContent());

                // 为联系人添加线索备注
                cor = new ContactsRemark();
                cor.setContactsId(c.getId());
                cor.setCreateBy(clueRemark.getCreateBy());
                cor.setCreateTime(clueRemark.getCreateTime());
                cor.setEditBy(clueRemark.getEditBy());
                cor.setEditFlag(clueRemark.getEditFlag());
                cor.setEditTime(clueRemark.getEditTime());
                cor.setId(UUIDUtils.getUUID());
                cor.setNoteContent(clueRemark.getNoteContent());
                curList.add(cur);
                corList.add(cor);
            }
            customerRemarkMapper.insertCustomerRemarkByList(curList);
            contactsRemarkMapper.insertContactsRemarkByList(corList);
        }
        // 根据线索id查询所有关联活动
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectClueActivityRelationByClueId(clueId);
        if(clueActivityRelations != null && clueActivityRelations.size() > 0){
            ContactsActivityRelation contactsActivityRelation = null;
            List<ContactsActivityRelation> contactsActivityRelations = new ArrayList<>();
            for(ClueActivityRelation car:clueActivityRelations){
                contactsActivityRelation = new ContactsActivityRelation();
                contactsActivityRelation.setId(UUIDUtils.getUUID());
                contactsActivityRelation.setActivityId(car.getActivityId());
                contactsActivityRelation.setContactsId(co.getId());
                contactsActivityRelations.add(contactsActivityRelation);
            }
            contactsActivityRelationMapper.insertContactsActivityRelationsByList(contactsActivityRelations);
        }

        // 添加交易，判断是否添加交易
        if("true".equals(isCreateTran)){
            Tran tran = new Tran();
            TranHistory tranHistory = new TranHistory();
            TranRemark tranRemark = null;
            tran.setActivityId((String) map.get("activityId"));
            tran.setContactsId(co.getId());
            tran.setCreateBy(user.getId());
            tran.setCreateTime(DateFormatUtils.DateToString(new Date()));
            tran.setCustomerId(c.getId());
            tran.setExpectedDate((String) map.get("expectedDate"));
            tran.setMoney((String) map.get("money"));
            tran.setId(UUIDUtils.getUUID());
            tran.setName((String) map.get("name"));
            tran.setStage((String) map.get("stage"));
            tran.setOwner(user.getId());
            tranMapper.insertConvertTran(tran);

            // 批量保存交易备注
            List<TranRemark> trList = new ArrayList<>();
            if(clueRemarks != null && clueRemarks.size() > 0){
                for(ClueRemark clueRemark:clueRemarks){
                    tranRemark = new TranRemark();
                    tranRemark.setCreateBy(clueRemark.getCreateBy());
                    tranRemark.setCreateTime(clueRemark.getCreateTime());
                    tranRemark.setTranId(tran.getId());
                    tranRemark.setEditBy(clueRemark.getEditBy());
                    tranRemark.setEditTime(clueRemark.getEditTime());
                    tranRemark.setEditFlag(clueRemark.getEditFlag());
                    tranRemark.setId(UUIDUtils.getUUID());
                    tranRemark.setNoteContent(clueRemark.getNoteContent());
                    trList.add(tranRemark);
                }
                tranRemarkMapper.insertConvertTranRemarkByList(trList);
            }

            // 添加交易历史信息
            tranHistory.setId(UUIDUtils.getUUID());
            tranHistory.setCreateBy(user.getId());
            tranHistory.setCreateTime(DateFormatUtils.DateToString(new Date()));
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setStage(tran.getStage());
            tranHistory.setTranId(tran.getId());
            tranHistoryMapper.insertTranHistoryForCreateTran(tranHistory);
        }
        // 删除线索下的所有备注
        clueRemarkMapper.deleteClueRemarkByClueId(clueId);
        // 删除线索所关联的市场活动
        clueActivityRelationMapper.deleteClueActivityRelationByClueId(clueId);
        // 删除该条线索
        clueMapper.deleteByPrimaryKey(clueId);
    }
}