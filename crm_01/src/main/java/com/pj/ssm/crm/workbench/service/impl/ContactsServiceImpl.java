package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.Contacts;
import com.pj.ssm.crm.workbench.mapper.ContactsMapper;
import com.pj.ssm.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 13:12
 **/
@Service("contactsService")
public class ContactsServiceImpl implements ContactsService {

    @Autowired
    private ContactsMapper contactsMapper;

    @Override
    public List<Contacts> queryAllContacts(Contacts conditionContact) {
        return contactsMapper.selectAllContacts(conditionContact);
    }

    @Override
    public List<Contacts> queryContactsByContactName(String contactName) {
        return contactsMapper.selectContactsByContactName(contactName);
    }

}
