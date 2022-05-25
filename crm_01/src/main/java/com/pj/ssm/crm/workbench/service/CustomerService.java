package com.pj.ssm.crm.workbench.service;

import com.pj.ssm.crm.workbench.domain.Customer;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 11:09
 **/
public interface CustomerService {
    List<Customer> queryAllCustomers(Customer conditionCustomer);
    List<String> queryAllCustomerName(String customerName);
    Customer queryCustomerForEditByCustomerId(String customerId);
    int updateCustomerByModifiedCustomer(Customer modifiedCustomer);
    void deleteCustomersByCustomerIds(String[] ids);
}
