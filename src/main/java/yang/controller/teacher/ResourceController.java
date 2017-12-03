package yang.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import yang.common.base.ResultBean;
import yang.common.kit.CommonKit;
import yang.common.kit.FileKit;
import yang.common.kit.ResourceKit;
import yang.controller.common.CommonController;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * @author yang
 * @date 2017/8/24
 * At 22:44
 */
@Controller
@RequestMapping("/resource")
public class ResourceController extends CommonController {

    /**
     * 转到资源上传页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    public String resourcePage() {
        return "/teacher/resource/resourceProxy";
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
    public Object getFiles(@PathVariable("directoryName") String directoryName) throws UnsupportedEncodingException {
        List<File> files = FileKit.getFiles(ResourceKit.getResourceHome() + File.separator + directoryName.trim());
        return CommonKit.getTakenInfo(FileKit.wrapFileInfo(files));
    }

    /**
     * 删除资源文件
     *
     * @param path
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/file/delete", method = RequestMethod.GET)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object deleteFile(@RequestParam("path") String path) throws IOException {
        return new ResultBean<>(FileKit.deleteIfExists(path.trim()));
    }

    /**
     * 上传文件
     *
     * @param directoryName
     * @param files
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/{directoryName}/upload", method = RequestMethod.POST)
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public Object uploadFiles(@PathVariable("directoryName") String directoryName,
                              @RequestParam("files") List<MultipartFile> files) throws IOException {
        if (null == files || files.size() == 0) {
            return new ResultBean<>("请添加文件：)");
        }

        String realPath = ResourceKit.getResourceHome() + File.separator + directoryName.trim();
        FileKit.existAndCreateDirectory(realPath);

        for (MultipartFile file : files) {
            file.transferTo(new File(realPath + File.separator + file.getOriginalFilename()));
        }

        return new ResultBean<>(true);
    }

}
