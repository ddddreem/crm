package com.pj.ssm.crm.workbench.mapper;

import com.pj.ssm.crm.workbench.domain.CustomerContactsRelation;

public interface CustomerContactsRelationMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_customer_contacts_relation
     *
     * @mbggenerated Wed May 25 11:57:33 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_customer_contacts_relation
     *
     * @mbggenerated Wed May 25 11:57:33 CST 2022
     */
    int insert(CustomerContactsRelation record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_customer_contacts_relation
     *
     * @mbggenerated Wed May 25 11:57:33 CST 2022
     */
    int insertSelective(CustomerContactsRelation record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_customer_contacts_relation
     *
     * @mbggenerated Wed May 25 11:57:33 CST 2022
     */
    CustomerContactsRelation selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_customer_contacts_relation
     *
     * @mbggenerated Wed May 25 11:57:33 CST 2022
     */
    int updateByPrimaryKeySelective(CustomerContactsRelation record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_customer_contacts_relation
     *
     * @mbggenerated Wed May 25 11:57:33 CST 2022
     */
    int updateByPrimaryKey(CustomerContactsRelation record);
}