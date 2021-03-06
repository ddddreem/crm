package com.pj.ssm.crm.workbench.service.impl;

import com.pj.ssm.crm.workbench.domain.Customer;
import com.pj.ssm.crm.workbench.mapper.CustomerMapper;
import com.pj.ssm.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 11:10
 **/
@Service("customerService")
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<Customer> queryAllCustomers(Customer conditionCustomer) {
        return customerMapper.selectAllCustomers(conditionCustomer);
    }

    @Override
    public List<String> queryAllCustomerName(String customerName) {
        return customerMapper.selectAllCustomersName(customerName);
    }

    @Override
    public Customer queryCustomerForEditByCustomerId(String customerId) {
        return customerMapper.selectCustomerForEditByCustomerId(customerId);
    }

    @Override
    public int updateCustomerByModifiedCustomer(Customer modifiedCustomer) {
        return customerMapper.updateCustomerByModifiedCustomer(modifiedCustomer);
    }

    @Override
    public void deleteCustomersByCustomerIds(String[] ids) {
        // 删除联系人与客户关系
        // 删除与客户关联的联系人
        // 删除客户的备注
        // 删除联系人备注
        // 删除所关联的交易
        // 删除交易中的历史
        // 删除交易中的备注
    }

}
