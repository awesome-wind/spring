package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

@Controller
public class FileController {

    @RequestMapping("/file")
    public String file() {
        return "afile";
    }

    @RequestMapping("/onefile")
    public String oneFileUpload(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request, ModelMap model) {
        //获得原始文件名
        String fileName = file.getOriginalFilename();
        System.out.println("原始文件名：" + fileName);

        //新定义的文件名
        String newFileName = UUID.randomUUID()+"-"+fileName;
        //获取项目的路径
        String sc = "F:\\IdeaProjects\\spring_updownload\\src\\main\\webapp\\fileUpload\\img\\";
        //设定文件保存的位置
        String path = "/images/";

        File f = new File(path);
        if(!f.exists())
            f.mkdir();
        if(!file.isEmpty()) {
            try {
                FileOutputStream fos = new FileOutputStream(sc+newFileName);
                InputStream in = file.getInputStream();

                int b =0;
                while((b=in.read())!=-1) {
                    fos.write(b);
                }

                fos.close();
                in.close();
            } catch (Exception e){
                e.printStackTrace();
            }
        }

        System.out.println("上传图片到："+sc+newFileName);
        model.addAttribute("fileURL",path+newFileName);

        try{
            Thread thread = Thread.currentThread();
            thread.sleep(120000);
        }catch (InterruptedException e) {
            e.printStackTrace();
        }

        return "afile";
    }

    @RequestMapping("/files")
    public String multiFile() {
        return "multiFiles";
    }

    @RequestMapping("/multiFiles")
    public String multiFiles (@RequestParam("file") CommonsMultipartFile[] files, HttpServletRequest request,ModelMap model) {
        List<String> list = new ArrayList<String>();

        //设定文件保存的位置
        String sc = "F:\\IdeaProjects\\spring_updownload\\src\\main\\webapp\\fileUpload\\img\\";
        //设定文件获取的位置，只能通过静态资源映射获取
        String path = "/images/";

        File f = new File(path);
        if(!f.exists())
            f.mkdir();

        for(int i=0;i<files.length;i++) {
            //获取原始文件名
            String fileName = files[i].getOriginalFilename();
            String newFileName = UUID.randomUUID()+"-"+fileName;

            if(!files[i].isEmpty()) {
                try {
                    FileOutputStream fos = new FileOutputStream(sc+newFileName);
                    InputStream in = files[i].getInputStream();
                    int b = 0;
                    while((b=in.read())!=-1) {
                        fos.write(b);
                    }
                    fos.close();
                    in.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            System.out.println("上传图片到:" + path + newFileName);
            list.add(path + newFileName);
        }
        model.addAttribute("fileList",list);

        try{
            Thread thread = Thread.currentThread();
            thread.sleep(180000);//暂停1.5秒后程序继续执行
        }catch (InterruptedException e) {
            e.printStackTrace();
        }

        return "multiFiles";
    }

    @RequestMapping("/show")
    public String showFiles(ModelMap model) {
        String path = "F:\\IdeaProjects\\spring_updownload\\src\\main\\webapp\\fileUpload\\img\\";
        Map<String, File> fileNameMap = new HashMap<String, File>();

        File[] fileList = new File(path).listFiles();
        for(File file:fileList)
        {
            fileNameMap.put(file.getName(),file);
//            System.out.println(file.getName());
        }
        model.addAttribute("fileNameMap", fileNameMap);
        return "showFiles";
    }

    @RequestMapping("/down")
    public void downFile(HttpServletRequest request,HttpServletResponse response) {
        String fileName = request.getParameter("fileName");
        String filePath = request.getParameter("filePath");
        try {
            //或者用绝对路径但不建议 F:\IdeaProjects\spring_updownload\src\main\webapp\fileUpload\img\
            String path = "/images/";
            File file = new File(filePath);

            if(!file.exists()) {
                request.setAttribute("message","下载资源已被删除");
                System.out.println("download file is deleted!");
                return ;
            }

            // 处理文件名
//            String realname = fileName.substring(fileName.indexOf("_") + 1);
//            System.out.println("实际文件名："+realname);
//            System.out.println("fileName:"+fileName);

            // 设置响应头，控制浏览器下载该文件,不加该段则变为了查看
            response.setHeader("content-disposition", "attachment;filename="
                    + URLEncoder.encode(filePath, "UTF-8"));

            // 读取要下载的文件，保存到文件输入流
            FileInputStream in = new FileInputStream(filePath);
            // 创建输出流
            OutputStream out = response.getOutputStream();
            // 创建缓冲区
            byte buffer[] = new byte[1024];
            int len = 0;
            // 循环将输入流中的内容读取到缓冲区当中
            while ((len = in.read(buffer)) > 0) {
                // 输出缓冲区的内容到浏览器，实现文件下载
                out.write(buffer, 0, len);
            }
            // 关闭文件输入流
            in.close();
            // 关闭输出流
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
