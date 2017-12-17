package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
    @ResponseBody
    public String oneFileUpload(@RequestParam("file") CommonsMultipartFile file, ModelMap model) {
        /**
         * 获取原始文件名，定义一个新的唯一的文件名
         * 获取文件的实际存储位置与其映射存储位置，为了安全，访问文件一般使用映射地址
         */
        String fileName = file.getOriginalFilename();
        String newFileName = UUID.randomUUID()+"-"+fileName;
        String sc = "C:\\Users\\zhang\\GitHub\\spring\\spring_updownload\\src\\main\\webapp\\fileUpload\\img\\";
        String path = "/images/";

        /**
         * 将文件以二进制流的方式先读取，在写到实际存储位置
         */
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

        model.addAttribute("fileURL",path+newFileName);
        return "show";
    }

    @RequestMapping("/files")
    public String multiFile() {
        return "multiFiles";
    }

    @RequestMapping("/multiFiles")
    public String multiFiles (@RequestParam("file") CommonsMultipartFile[] files, HttpServletRequest request,ModelMap model) {

        List<String> list = new ArrayList<String>();
        String sc = "C:\\Users\\zhang\\GitHub\\spring\\spring_updownload\\src\\main\\webapp\\fileUpload\\img\\";
        String path = "/images/";

        File f = new File(path);
        if(!f.exists())
            f.mkdir();

        for(int i=0;i<files.length;i++) {
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
            list.add(path + newFileName);
        }

//        model.addAttribute("fileList",list);
        return "showFiles";
    }

    @RequestMapping("/show")
    public String showFiles(ModelMap model) {
        String path = "C:\\Users\\zhang\\GitHub\\spring\\spring_updownload\\src\\main\\webapp\\fileUpload\\img\\";
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
//        String fileName = request.getParameter("fileName");
        String filePath = request.getParameter("filePath");
        try {
            //或者用绝对路径但不建议 F:\IdeaProjects\spring_updownload\src\main\webapp\fileUpload\img\
//            String path = "/images/";
            File file = new File(filePath);

            if(!file.exists()) {
                request.setAttribute("message","下载资源已被删除");
                System.out.println("download file is deleted!");
                return ;
            }

            // 处理文件名
//            String realname = fileName.substring(fileName.indexOf("-") + 1);
//            System.out.println("实际文件名："+realname);
//            System.out.println("fileName:"+fileName);

            // 设置响应头，控制浏览器下载该文件,不加该段则变为了查看
            response.setHeader("content-disposition", "attachment;filename="
                    + URLEncoder.encode(filePath, "UTF-8"));

            /**
             * 读取要下载的图片或者文件，将其放在缓冲中，再下载
             */
            FileInputStream in = new FileInputStream(filePath);
            OutputStream out = response.getOutputStream();
            byte buffer[] = new byte[1024];
            int len = 0;
            while ((len = in.read(buffer)) > 0) {
                out.write(buffer, 0, len);
            }
            in.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
