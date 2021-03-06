package com.pj.ssm.crm.workbench.mapper;

import com.pj.ssm.crm.workbench.domain.Contacts;

import java.util.List;

public interface ContactsMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts
     *
     * @mbggenerated Fri May 13 16:11:07 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts
     *
     * @mbggenerated Fri May 13 16:11:07 CST 2022
     */
    int insert(Contacts record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts
     *
     * @mbggenerated Fri May 13 16:11:07 CST 2022
     */
    int insertSelective(Contacts record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts
     *
     * @mbggenerated Fri May 13 16:11:07 CST 2022
     */
    Contacts selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts
     *
     * @mbggenerated Fri May 13 16:11:07 CST 2022
     */
    int updateByPrimaryKeySelective(Contacts record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts
     *
     * @mbggenerated Fri May 13 16:11:07 CST 2022
     */
    int updateByPrimaryKey(Contacts record);

    /**
     * 将转换后的线索数据添加到联系人表中
     */
    int insertContactsByConvert(Contacts contacts);

    /**
     * 根据条件查询联系人
     */
    List<Contacts> selectAllContacts(Contacts conditionContact);

    /**
     * 根据联系人名称模糊查询
     */
    List<Contacts> selectContactsByContactName(String contactName);

    /**
     * 判断创建交易时是否存在联系人信息
     */
    String selectTagByContactName(String contactName);

    /**
     * 创建交易时创建新联系人
     */
    int insertNewContactByCreateNewTran(Contacts newContact);
}