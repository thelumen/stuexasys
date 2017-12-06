package yang.common.kit;

import org.slf4j.Logger;
import yang.domain.manager.FileInfo;
import yang.domain.student.GradeInfo;
import yang.domain.student.TestPaper;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

/**
 * 资源文件目录工具类
 *
 * @author yang
 * @date 2017/6/4
 * At 12:07
 */
public final class ResourceKit {
    private ResourceKit() {
    }

    /**
     * 必须给定一个主目录
     */
    private static final String HOME = "/home/yang";
    /**
     * 资源主目录
     */
    private static final String RESOURCE_HOME = HOME + "/resource";
    /**
     * 试卷备份主目录
     */
    private static final String BACKUP_HOME = HOME + "/backup";

    /**
     * 获取主目录
     *
     * @return
     */
    public static String getHome() {
        return HOME;
    }

    /**
     * 获取备份目录
     *
     * @return
     */
    public static String getBackupHome() {
        return BACKUP_HOME;
    }

    /**
     * 返回资源主目录
     *
     * @return
     */
    public static String getResourceHome() {
        return RESOURCE_HOME;
    }

    /**
     * 文件下载
     *
     * @param response
     * @param path
     * @param fileName
     * @throws UnsupportedEncodingException
     */
    public static void download(HttpServletResponse response, String path, String fileName) throws IOException {
        File filePath = new File(path);
        //utf-8编码
        String realName = URLEncoder.encode(fileName, "UTF-8");

        //初始化并设置参数
        response.reset();
        response.setContentType("application/x-download");
        response.addHeader("Content-Disposition", "attachment; filename=\"" + realName + "\"");
        try (ServletOutputStream outp = response.getOutputStream();
             FileInputStream in = new FileInputStream(filePath);) {
            byte[] b = new byte[1024];
            int i;
            while ((i = in.read(b)) > 0) {
                outp.write(b, 0, i);
            }
            outp.flush();
        }
    }

    /**
     * 获取资源信息
     * 按照最后更新时间降序排序
     *
     * @return .
     */
    public static List<Map<String, Object>> getResourceInfo() {
        List<Map<String, Object>> target = new ArrayList<>();
        List<String> directories = FileKit.getFileOrDirectoryNames(getResourceHome(), true);
        List<File> children;
        List<FileInfo> father;
        Map<String, Object> filePackageInfo;
        //遍历每一个文件夹
        for (String directoryName : directories) {
            children = FileKit.getFiles(getResourceHome() + File.separator + directoryName);
            father = FileKit.wrapFileInfo(children);

            //这里做一个文件路径的修改，防止url的问题造成404错误，导致文件无法下载
            for (FileInfo f : father) {
                String path = f.getPath();
                f.setPath(path.replace('/', '_'));
            }

            //排序
            father.sort(Comparator.comparing(FileInfo::getNowDate));

            filePackageInfo = new HashMap<>();
            filePackageInfo.put("directoryName", directoryName);
            filePackageInfo.put("directory", father);

            target.add(filePackageInfo);
        }
        return target;
    }

    /**
     * 备份学生试卷信息
     *
     * @param testPaper
     * @param courseName
     * @param specialtyName
     * @param studentId
     * @throws IOException
     */
    public static void backUpExamTaken(TestPaper testPaper, String courseName, String specialtyName, int studentId) throws IOException {
        String test = resetTestName(testPaper.getTestNum());
        String homePath = getBackupHome() + File.separator + specialtyName + File.separator + courseName + File.separator + test;
        FileKit.existAndCreateDirectory(homePath);

        //新建临时文件，如果文件已存在，就删除新建
        String tempFilePath = homePath + File.separator + "$" + studentId + ".bin";
        FileKit.deleteIfExists(tempFilePath);

        byte[] data = FileKit.serialize(testPaper);
        FileKit.write2File(data, tempFilePath);
    }

    /**
     * 备份考试结果信息
     *
     * @param gradeInfo     成绩信息
     * @param specialtyName 专业名
     * @return 成功
     */
    public static void backUpExamInfo(GradeInfo gradeInfo, String specialtyName) throws IOException, ClassNotFoundException {
        String test = resetTestName(gradeInfo.getTestNum());
        String homePath = getBackupHome() + File.separator + specialtyName + File.separator + gradeInfo.getCourseName() + File.separator + test;
        String realExamInfo = homePath + File.separator + gradeInfo.getStudentId() + ".bin";
        String tempExamInfo = homePath + File.separator + "$" + gradeInfo.getStudentId() + ".bin";
        //考试信息存在便删除
        FileKit.deleteIfExists(realExamInfo);
        //读取临时文件，并设置学生作答信息
        byte[] data = FileKit.readFile(tempExamInfo);
        TestPaper paper = (TestPaper) FileKit.deserialize(data);
        if (paper != null) {
            paper.setStudentAnswer(gradeInfo.getResult());
        }
        byte[] newData = FileKit.serialize(paper);
        FileKit.write2File(newData, realExamInfo);
    }

    /**
     * 数字转相应测试
     *
     * @param testNum
     * @return
     */
    private static String resetTestName(String testNum) {
        String test;
        switch (Integer.valueOf(testNum)) {
            case 1: {
                test = "测试一";
                break;
            }
            case 2: {
                test = "测试二";
                break;
            }
            case 3: {
                test = "测试三";
                break;
            }
            default: {
                test = "测试四";
            }
        }
        return test;
    }
}
