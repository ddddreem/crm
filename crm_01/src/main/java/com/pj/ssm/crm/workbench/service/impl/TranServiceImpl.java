package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UUIDUtils;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.workbench.domain.*;
import com.pj.ssm.crm.workbench.mapper.*;
import com.pj.ssm.crm.workbench.service.TranHistoryService;
import com.pj.ssm.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 18:03
 **/
@Service("tranService")
public class TranServiceImpl implements TranService {

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Override
    public List<Tran> queryAllTrans(Tran conditionTran) {
        return tranMapper.selectAllTrans(conditionTran);
    }

    @Override
    public Tran queryTranDetailById(String tranId) {
        return tranMapper.selectTranDetailById(tranId);
    }

    @Override
    public List<Funnel> queryCountOfTranGroupByStage() {
        return tranMapper.selectCountOfTranGroupByStage();
    }

    @Override
    public int saveCreateTran(Tran tran) {
        String createCustomerName = tran.getCustomerName();
        String createContactId = tran.getContactsId();
        String createContactName = tran.getContactName();

        TranHistory tranHistory = new TranHistory();
        String customerId = customerMapper.selectTagByCustomerName(createCustomerName);
        String contactId = contactsMapper.selectTagByContactName(createContactName);
        tran.setCustomerId(customerId);
        if(customerId == null){
            Customer newCustomer = new Customer();
            // 新建客户
            newCustomer.setId(UUIDUtils.getUUID());
            newCustomer.setName(tran.getCustomerName());
            newCustomer.setCreateBy(tran.getCreateBy());
            newCustomer.setCreateTime(DateFormatUtils.DateToString(new Date()));
            newCustomer.setOwner(tran.getOwner());
            newCustomer.setContactSummary(tran.getContactSummary());
            newCustomer.setNextContactTime(tran.getNextContactTime());
            newCustomer.setDescription("创建交易时新建的客户");
            customerMapper.insertNewCustomerByCreateNewTran(newCustomer);
            tran.setCustomerId(newCustomer.getId());
        }
        tran.setContactsId(contactId);
        if(createContactId == "" && contactId == null){
            Contacts newContact = new Contacts();
            // 新建联系人
            newContact.setId(UUIDUtils.getUUID());
            newContact.setFullname(tran.getContactName());
            newContact.setOwner(tran.getOwner());
            newContact.setCreateBy(tran.getCreateBy());
            newContact.setCreateTime(DateFormatUtils.DateToString(new Date()));
            newContact.setSource(tran.getSource());
            newContact.setCustomerId(tran.getCustomerId());
            newContact.setContactSummary(tran.getContactSummary());
            newContact.setNextContactTime(tran.getNextContactTime());
            newContact.setDescription("创建交易时新建的联系人");
            contactsMapper.insertNewContactByCreateNewTran(newContact);
            tran.setContactsId(newContact.getId());
        }
        // 创建交易的同时创建交易历史
        tranHistory.setId(UUIDUtils.getUUID());
        tranHistory.setCreateBy(tran.getCreateBy());
        tranHistory.setCreateTime(DateFormatUtils.DateToString(new Date()));
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setStage(tran.getStage());
        tranHistory.setTranId(tran.getId());
        tranHistoryMapper.insertTranHistoryForCreateTran(tranHistory);
        return tranMapper.insertCreateTran(tran);
    }
}
