package com.pj.ssm.crm.poi;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 27 16:52
 **/
public class CreateExcelTest {
    public static void main(String[] args) throws IOException {
        // 创建HSSFWorkBook对象，对应一个excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 使用wb创建HSSFSheet对象，对应wb文件中的一页
        HSSFSheet sheet = wb.createSheet("学生列表");
        // 使用sheet创建HSSFRow对象，对应sheet中的一行
        HSSFRow row = sheet.createRow(0); // 行号：从0开始，依次增加
        // 使用row创建HSSFCell对象，对应row中的列
        HSSFCell cell = row.createCell(0); // 列的编号：从0开始，依次增加
        cell.setCellValue("学号");
        cell = row.createCell(1);
        cell.setCellValue("姓名");
        cell = row.createCell(2);
        cell.setCellValue("年龄");

        // 创建HSSFCellStyle对象，生成修饰对象
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER); // 设置居中

        // 使用sheet创建10个HSSFRow对象，对应sheet中的10行
        for (int i = 1; i <= 10; i++) {
            row = sheet.createRow(i); // 行号：从0开始，依次增加
            // 使用row创建HSSFCell对象，对应row中的列
            cell = row.createCell(0); // 列的编号：从0开始，依次增加
            cell.setCellValue(100 + i);
            cell = row.createCell(1);
            cell.setCellValue("test" + i);
            cell = row.createCell(2);
            cell.setCellStyle(style);
            cell.setCellValue(20 + i);
        }
        // 调用工具函数生成excel文件
        FileOutputStream os = new FileOutputStream("E:\\workspace_idea\\serverDir\\studentList.xls");
        wb.write(os);

        // 使用完毕关闭流
        wb.close();
        os.close();
    }
}
