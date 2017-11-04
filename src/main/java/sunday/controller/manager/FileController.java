package sunday.controller.manager;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sunday.common.kit.CommonKit;
import sunday.common.kit.FileKit;
import sunday.common.kit.ResourceKit;
import sunday.common.kit.ZipKit;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * @author wade
 * @date 2017/11/1.
 * At 14:14
 */
@Controller
@RequestMapping("/admin/file")
public class FileController {

    /**
     * 学生作业主页
     *
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    @RequiresPermissions(value = {"shiro:sys:manager"})
    public String main() {
        return "/manager/file/fileProxy";
    }

    /**
     * 删除无用文件
     *
     * @param specialtyId
     * @param courseId
     * @param test
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @RequiresPermissions(value = {"shiro:sys:manager"})
    @ResponseBody
    public Object deletePartFile(@RequestParam("specialtyId") String specialtyId,
                                 @RequestParam("courseId") String courseId,
                                 @RequestParam("test") String test,
                                 @RequestParam(value = "isAll", required = false, defaultValue = "false") String isAll) {
        String path = ResourceKit.getBackupHome() + "/" + CommonKit.string2Chinese(specialtyId) + "/"
                + CommonKit.string2Chinese(courseId) + "/" + CommonKit.string2Chinese(test);
        FileKit.deleteFile(path, Boolean.valueOf(isAll), "$", ".zip");
        return true;
    }

    /**
     * zip打包并下载
     *
     * @param response
     * @param specialtyId
     * @param courseId
     * @param test
     * @throws IOException
     */
    @RequestMapping(value = "/{specialtyId}/{courseId}/{test}/download", method = RequestMethod.GET)
    @RequiresPermissions(value = {"shiro:sys:manager"})
    @ResponseBody
    public void zipAndDownload(HttpServletResponse response,
                               @PathVariable("specialtyId") String specialtyId,
                               @PathVariable("courseId") String courseId,
                               @PathVariable("test") String test) throws IOException, ClassNotFoundException {
        String dicPath = ResourceKit.getBackupHome() + "/" + CommonKit.string2Chinese(specialtyId) + "/"
                + CommonKit.string2Chinese(courseId) + "/" + CommonKit.string2Chinese(test);
        List<File> files = FileKit.getFiles(dicPath);
        Objects.requireNonNull(files);
        String[] fileNames = new String[files.size()];
        for (int i = 0; i < files.size(); i++) {
            fileNames[i] = files.get(i).getPath();
        }
        //删除原有zip文件
        String zipPath = dicPath + "/" + ZipKit.getZipFilename();
        FileKit.deleteIfExists(zipPath);
        //打包并下载
        ZipKit.zipStudentExamInformation(zipPath, fileNames);
        ResourceKit.download(response, zipPath, ZipKit.getZipFilename());
    }

    /**
     * 获取试卷文件-table
     *
     * @param specialtyId
     * @param courseId
     * @param test
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object getFile(@RequestParam("specialtyId") String specialtyId,
                          @RequestParam("courseId") String courseId,
                          @RequestParam("test") String test) {
        String path = ResourceKit.getBackupHome() + "/" + CommonKit.string2Chinese(specialtyId) + "/"
                + CommonKit.string2Chinese(courseId) + "/" + CommonKit.string2Chinese(test);
        List<File> files = FileKit.getFiles(path);
        return CommonKit.getTakenInfo(FileKit.wrapFileInfo(files, 4));
    }

    /**
     * 获取专业文件夹名
     *
     * @return
     */
    @RequestMapping(value = "/specialty", method = RequestMethod.GET)
    @ResponseBody
    public Object findSpecialty() {
        List<String> dicNames = FileKit.getFileOrDirectoryNames(ResourceKit.getBackupHome(), true);
        return getFileName2Select(dicNames);
    }

    /**
     * 获取指定专业下的课程文件夹名
     *
     * @param specialtyId
     * @return
     */
    @RequestMapping(value = "/{specialtyId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> findCourseBySpecialtyId(@PathVariable("specialtyId") String specialtyId) {
        String targetHome = ResourceKit.getBackupHome() + "/" + CommonKit.string2Chinese(specialtyId);
        List<String> dicNames = FileKit.getFileOrDirectoryNames(targetHome, true);
        return getFileName2Select(dicNames);
    }

    /**
     * 获取指定专业、课程下的文件夹名
     *
     * @param specialtyId
     * @param courseId
     * @return
     */
    @RequestMapping(value = "/{specialtyId}/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> findTestBySpecialtyIdAndCourseId(@PathVariable("specialtyId") String specialtyId,
                                                                      @PathVariable("courseId") String courseId) {
        String targetHome = ResourceKit.getBackupHome() + "/" + CommonKit.string2Chinese(specialtyId) + "/" + CommonKit.string2Chinese(courseId);
        List<String> dicNames = FileKit.getFileOrDirectoryNames(targetHome, true);
        return getFileName2Select(dicNames);
    }

    /**
     * 文件名 2 select
     *
     * @param dicNames
     * @return
     */
    private List<Map<String, Object>> getFileName2Select(List<String> dicNames) {
        Objects.requireNonNull(dicNames);
        List<Map<String, Object>> father = new ArrayList<>();
        //默认数据
        Map<String, Object> child = new HashMap<String, Object>() {{
            put("id", "1");
            put("text", "请选择...");
            put("disabled", true);
            put("selected", true);
        }};
        father.add(child);
        for (String fileName : dicNames) {
            child = new HashMap<String, Object>() {{
                put("id", CommonKit.chinese2CharNumber(fileName));
                put("text", fileName);
            }};
            father.add(child);
        }
        return father;
    }

}
