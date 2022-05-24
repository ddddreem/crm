package com.pj.ssm.crm.commons.utils;

import com.pj.ssm.crm.workbench.domain.Activity;
import org.apache.poi.hssf.usermodel.*;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 28 10:38
 **/
public class HSSFUtils {
    public static HSSFWorkbook getMarketActivityExcel(HSSFWorkbook wb,List<Activity> activities){
        // 创建HSSFWorkBook对象，对应一个excel文件
//        HSSFWorkbook wb = new HSSFWorkbook();
        // 使用wb创建HSSFSheet对象，对应wb文件中的一页
        HSSFSheet sheet = wb.createSheet("市场活动列表");
        // 使用sheet创建HSSFRow对象，对应sheet中的一行
        HSSFRow row = sheet.createRow(0); // 行号：从0开始，依次增加
        // 使用row创建HSSFCell对象，对应row中的列
        HSSFCell cell = row.createCell(0); // 列的编号：从0开始，依次增加
        cell.setCellValue("ID");
        cell = row.createCell(1);
        cell.setCellValue("所有者");
        cell = row.createCell(2);
        cell.setCellValue("名称");
        cell = row.createCell(3);
        cell.setCellValue("开始日期");
        cell = row.createCell(4);
        cell.setCellValue("结束日期");
        cell = row.createCell(5);
        cell.setCellValue("成本");
        cell = row.createCell(6);
        cell.setCellValue("描述");
        cell = row.createCell(7);
        cell.setCellValue("创建时间");
        cell = row.createCell(8);
        cell.setCellValue("创建者");
        cell = row.createCell(9);
        cell.setCellValue("修改时间");
        cell = row.createCell(10);
        cell.setCellValue("修改者");

        if(activities.size() > 0 && activities != null){
            // 使用sheet创建10个HSSFRow对象，对应sheet中的10行
            Activity activity = null;
            for (int i = 0; i < activities.size(); i++) {
                activity = activities.get(i);
                // 没遍历出一个activity，生成一行
                row = sheet.createRow(i + 1);
                cell = row.createCell(0); // 列的编号：从0开始，依次增加
                cell.setCellValue(activity.getId());
                cell = row.createCell(1);
                cell.setCellValue(activity.getOwner());
                cell = row.createCell(2);
                cell.setCellValue(activity.getName());
                cell = row.createCell(3);
                cell.setCellValue(activity.getStartDate());
                cell = row.createCell(4);
                cell.setCellValue(activity.getEndDate());
                cell = row.createCell(5);
                cell.setCellValue(activity.getCost());
                cell = row.createCell(6);
                cell.setCellValue(activity.getDescription());
                cell = row.createCell(7);
                cell.setCellValue(activity.getCreateTime());
                cell = row.createCell(8);
                cell.setCellValue(activity.getCreateBy());
                cell = row.createCell(9);
                cell.setCellValue(activity.getEditTime());
                cell = row.createCell(10);
                cell.setCellValue(activity.getEditBy());
            }
        }
        return wb;
    }

    public static String getCellValueToStr(HSSFCell cell){
        String res = "";
        if(cell.getCellType() == HSSFCell.CELL_TYPE_STRING){
            res = cell.getStringCellValue();
        }else if(cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA){
            res = cell.getCellFormula();
        }else if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){
            res = cell.getNumericCellValue() + "";
            res = res.substring(0, res.lastIndexOf('.'));
        }else if(cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN){
            res = cell.getBooleanCellValue() + "";
        }else{
            res = "";
        }
        return res;
    }

    // 返回导入市场数据的excel模板
    public static HSSFWorkbook getModalHSSFWorkbook(HSSFWorkbook wb){
        HSSFSheet sheet = wb.createSheet("导入市场活动模板");
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("所有者");
        cell = row.createCell(1);
        cell.setCellValue("名称");
        cell = row.createCell(2);
        cell.setCellValue("开始日期");
        cell = row.createCell(3);
        cell.setCellValue("结束日期");
        cell = row.createCell(4);
        cell.setCellValue("成本");
        cell = row.createCell(5);
        cell.setCellValue("描述");

        return wb;
    }
}
