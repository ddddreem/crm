package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.Contacts;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 13:11
 **/
public interface ContactsService {
    List<Contacts> queryAllContacts(Contacts conditionContact);
    List<Contacts> queryContactsByContactName(String contactName);
}
