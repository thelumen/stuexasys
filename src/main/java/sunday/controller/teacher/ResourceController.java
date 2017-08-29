package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sunday.common.kit.ResourceFileKit;
import sunday.common.kit.TeacherKit;
import sunday.controller.common.CommonController;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/24.
 * At 22:44
 */
@Controller
@RequestMapping("/resource")
public class ResourceController extends CommonController{

    /**
     * 转到资源上传页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String resourcePage() {
        return "/teacher/resource/resourceProxy";
    }

    /**
     * 获取学科目录文件名select
     *
     * @return
     */
    @RequestMapping(value = "/directory", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getDirectories() {
        List<String> directories = ResourceFileKit.getHomeDirectories();
        if (null != directories) {
            List<Map<String, Object>> target = new ArrayList<>();
            TeacherKit.getSelectInfo(directories, target);
            return target;
        }
        return null;
    }

    /**
     * 上传文件
     *
     * @param directoryName HOME文件下某一文件夹名
     * @param files         上传的文件
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/{directoryName}/upload", method = RequestMethod.POST)
    @RequiresAuthentication
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean uploadFiles(@PathVariable("directoryName") String directoryName,
                               @RequestParam("files") List<MultipartFile> files) {
        String directory;
        try {
            directory = new String(directoryName.getBytes("iso8859-1"), "utf-8");
            //HOME主目录下的某一directory
            String realPath = ResourceFileKit.getHome() + File.separator + directory;
            File child = new File(realPath);
            if (!child.exists()) {
                child.mkdir();
            }
            if (null != files && files.size() > 0) {
                for (MultipartFile file : files) {
                    file.transferTo(new File(realPath + File.separator + file.getOriginalFilename()));
                }
                return true;
            }
        } catch (IOException e) {
            //这里做日志写入
            e.printStackTrace();
            return false;
        }

        return false;
    }

    /**
     * 返回某一文件目录类所有普通文件信息
     *
     * @param directoryName
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/{directoryName}/files", method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String, Object>> getFiles(@PathVariable("directoryName") String directoryName) {
        String directory;
        try {
            directory = new String(directoryName.getBytes("iso8859-1"), "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }

        String deepPath = ResourceFileKit.getHome() + File.separator + directory;
        File home = new File(deepPath);
        if (home.exists() && home.isDirectory()) {
            File[] children = home.listFiles();
            if (null != children && children.length > 0) {
                List<Map<String, Object>> father = new ArrayList<>();
                for (File file : children) {
                    if (file.isFile()) {
                        Map<String, Object> child = new HashMap<String, Object>() {{
                            put("name", file.getName());
                            put("path", ResourceFileKit.getRelativePath(directory, file.getPath()));
                        }};
                        father.add(child);
                    }
                }
                return father;
            }
        }
        return null;
    }

}