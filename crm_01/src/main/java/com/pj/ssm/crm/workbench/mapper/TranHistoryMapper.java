package com.pj.ssm.crm.workbench.mapper;

import com.pj.ssm.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranHistoryMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Mon May 16 08:06:39 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Mon May 16 08:06:39 CST 2022
     */
    int insert(TranHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Mon May 16 08:06:39 CST 2022
     */
    int insertSelective(TranHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Mon May 16 08:06:39 CST 2022
     */
    TranHistory selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Mon May 16 08:06:39 CST 2022
     */
    int updateByPrimaryKeySelective(TranHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Mon May 16 08:06:39 CST 2022
     */
    int updateByPrimaryKey(TranHistory record);

    /**
     * 根据交易id查询交易历史
     */
    List<TranHistory> selectTranHistoriesForDetailByTranId(String tranId);

    /**
     * 创建交易时添加交易更改历史
     */
    int insertTranHistoryForCreateTran(TranHistory tranHistory);
}