package sunday.common.kit;

import org.slf4j.Logger;
import sunday.pojo.manager.FileInfo;
import sunday.pojo.student.GradeInfo;
import sunday.pojo.student.TestPaper;

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

    private static final Logger LOGGER = LogKit.getLogger();
    /**
     * 必须给定一个主目录
     * 如果不存在的话，则自动创建
     */
    private static final String HOME = "/home/sunday";
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
     * 获取相对路径
     * 如：数据库/xxx.txt
     *
     * @param directory 目录文件名
     * @param target    文件的绝对路径
     * @return
     */
    public static String getRelativePath(String directory, String target) {
        StringBuilder sb = new StringBuilder(target);
        return sb.substring(sb.indexOf(directory), sb.length());
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
        ServletOutputStream outp = null;
        FileInputStream in = null;
        try {
            outp = response.getOutputStream();
            in = new FileInputStream(filePath);
            byte[] b = new byte[1024];
            int i;
            while ((i = in.read(b)) > 0) {
                outp.write(b, 0, i);
            }
            outp.flush();
        } catch (Exception e) {
            System.out.println("文件下载失败!");
            e.printStackTrace();
        } finally {
            if (in != null) {
                in.close();
            }
            if (outp != null) {
                outp.close();
            }
        }
    }

    /**
     * 获取资源信息
     * 按照最后更新时间降序排序
     *
     * @return .
     */
    public static List<Map<String, Object>> getResourceInfo() {
        List<String> filePackagerNames = FileKit.getFileOrDirectoryNames(getResourceHome(), true);//获取主目录下的文件夹名
        List<Map<String, Object>> target = new ArrayList<>();//最终返回类型
        if (filePackagerNames != null) {
            int i = 0;
            int j = 0;
            for (String fileName : filePackagerNames) {
                File fileNameInfo = new File(getResourceHome() + File.separator + fileName);//拼接绝对路径并创建file类
                File[] children = fileNameInfo.listFiles();
                List<FileInfo> father = new ArrayList<>();
                if (children != null && children.length > 0) {
                    for (File file : children) {
                        FileInfo fileInfo = new FileInfo();
                        fileInfo.setFileName(file.getName());
                        fileInfo.setLastUpdateTime(file.lastModified());
                        fileInfo.setPath(i + "," + j);
                        father.add(fileInfo);
                        j++;
                    }
                    //按最后更新时间对目录下的文件进行排序
                    father.sort((o1, o2) -> {
                        Long d1 = o1.getLastUpdateTime();
                        Long d2 = o2.getLastUpdateTime();
                        if (d1 > d2) {
                            return -1;
                        }
                        if (Objects.equals(d1, d2)) {
                            return 0;
                        }
                        return 1;
                    });//end sort
                }//end for
                Map<String, Object> filePackageInfo = new HashMap<String, Object>() {{
                    put("directoryName", fileName);
                    put("directory", father);
                }};
                target.add(filePackageInfo);
                i++;
            }//end for
            return target;
        }//end if
        return null;
    }

    /**
     * 根据下载索引码返回绝对路径
     *
     * @param folderNum 文件夹号.
     * @param fileNum   文佳号.
     * @return 文件信息.
     */
    public static Map<String, Object> selectWithFileNum(Integer folderNum, Integer fileNum) {
        Map<String, Object> fileInfoWithMap = new HashMap<>();
        List<String> filePackagerNames = FileKit.getFileOrDirectoryNames(getResourceHome(), true);//获取主目录下的文件夹名
        if (filePackagerNames.size() > 0) {
            String fileName = filePackagerNames.get(folderNum);
            //拼接绝对路径并创建file类
            File fileNameInfo = new File(getResourceHome() + File.separator + fileName);
            File[] children = fileNameInfo.listFiles();
            if (null != children && children.length > 0) {
                String path = getRelativePath(fileName, children[fileNum].getPath());
                fileInfoWithMap.put("fileName", children[fileNum].getName());
                fileInfoWithMap.put("realPath", getResourceHome() + File.separator + path);
            }
        }
        return fileInfoWithMap;
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
        String homePath = getBackupHome() + "/" + specialtyName + "/" + courseName + "/" + test;
        FileKit.existAndCreateDirectory(homePath);

        //新建临时文件，如果文件已存在，就删除新建
        String tempFilePath = homePath + "/$" + studentId + ".bin";
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
        String homePath = getBackupHome() + "/" + specialtyName + "/" + gradeInfo.getCourseName() + "/" + test;
        String realExamInfo = homePath + "/" + gradeInfo.getStudentId() + ".bin";
        String tempExamInfo = homePath + "/$" + gradeInfo.getStudentId() + ".bin";
        //考试信息存在便删除
        FileKit.deleteIfExists(realExamInfo);
        //读取临时文件，并设置学生作答信息
        byte[] data = FileKit.readFile(tempExamInfo);
        TestPaper paper = (TestPaper) FileKit.deserialize(data);
        paper.setStudentAnswer(gradeInfo.getResult());
        byte[] newData = FileKit.serialize(paper);
        FileKit.write2File(newData, realExamInfo);
    }

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
