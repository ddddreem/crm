package com.pj.ssm.crm.commons.testController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 27 18:06
 **/
@Controller
public class testController {

    // 文件下载
    @RequestMapping("filedownloadtest.do")
    public void fileDownload(HttpServletResponse response) throws Exception{
        // 1.设置响应信息
        response.setContentType("application/octet-stream;charset=UTF-8");
        // 2.获取输出流
        OutputStream os = response.getOutputStream();

        // 浏览器接收到响应信息之后，默认情况下，直接在显示窗口中打开响应信息；即使打不开，也会调用主机上安装的应用程序来打开；
        //      只有实在打不开，才会激活下载窗口
        // 可以设置响应头信息，使浏览器接收到响应信息之后，直接激活文件下载窗口，即使能打开也不自动打开
        response.setHeader("Content-Disposition", "attachment;filename=studentList.xls");

        // 读取excel文件到字节输入流(InputStream)中，输出到输出流中(OutputStream)
        InputStream is = new FileInputStream("E:\\workspace_idea\\serverDir\\studentList.xls");
        // 创建缓冲区，使每次传输的字节数变大，提高效率
        byte[] buffer = new byte[256];
        int len = 0;
        while((len = is.read(buffer)) != -1){
            os.write(buffer, 0, len);
        }

        // 关闭资源，把最后缓冲区的数据刷出，即下载结束
        is.close();
        os.flush();
    }
}
