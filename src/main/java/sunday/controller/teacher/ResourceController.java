package sunday.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sunday.common.kit.ChapterKit;
import sunday.common.kit.CommonKit;
import sunday.common.kit.FileKit;
import sunday.common.kit.ResourceKit;
import sunday.controller.common.CommonController;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

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
     * 获取学科目录文件名select
     *
     * @return
     */
    @RequestMapping(value = "/directory", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getDirectories() {
        List<String> directories = FileKit.getFileOrDirectoryNames(ResourceKit.getResourceHome(), true);
        return null != directories ? ChapterKit.getChapterInSelect(directories.toArray(new String[directories.size()])) : null;
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
    public Map<String, Object> getFiles(@PathVariable("directoryName") String directoryName) {
        String directory = CommonKit.string2Chinese(directoryName);
        String deepPath = ResourceKit.getResourceHome() + "/" + directory;
        List<File> files = FileKit.getFiles(deepPath);

        return CommonKit.getTakenInfo(FileKit.wrapFileInfo(files, 2));
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
    public boolean deleteFile(@RequestParam("path") String path) throws IOException {
        String realPath = ResourceKit.getResourceHome() + "/" + new String(path.getBytes("iso8859-1"), "utf8");
        return FileKit.deleteIfExists(realPath);
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
    @RequiresPermissions(value = "shiro:sys:teacher")
    @ResponseBody
    public boolean uploadFiles(@PathVariable("directoryName") String directoryName,
                               @RequestParam("files") List<MultipartFile> files) {
        String directory;
        try {
            directory = CommonKit.string2Chinese(directoryName);
            //HOME主目录下的某一directory
            String realPath = ResourceKit.getResourceHome() + "/" + directory;
            FileKit.existAndCreateFile(realPath);
            if (null != files && files.size() > 0) {
                for (MultipartFile file : files) {
                    file.transferTo(new File(realPath + "/" + file.getOriginalFilename()));
                }
                return true;
            }
        } catch (IOException e) {
            LOGGER.error(e.toString());
            return false;
        }
        return false;
    }


}
