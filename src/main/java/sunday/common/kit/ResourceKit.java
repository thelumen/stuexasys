package sunday.common.kit;

import org.slf4j.Logger;
import sunday.pojo.manager.FileInfo;
import sunday.pojo.student.GradeInfo;
import sunday.pojo.student.TestPaper;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

/**
 * 资源文件目录工具类
 * Created by yang on 2017/6/4.
 * At 12:07
 */
public final class ResourceKit {
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

    private ResourceKit() {
    }

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
     * 备份考试试题信息
     *
     * @param testPaper     试题信息
     * @param courseName    课程名
     * @param specialtyName 专业名
     * @return 成功
     */
    public static boolean backUpExamTaken(TestPaper testPaper, String courseName, String specialtyName, int studentId) {
        String homePath = getBackupHome() + File.separator + specialtyName + File.separator
                + courseName + File.separator + testPaper.getTestNum();
        File fileDir = new File(homePath);
        if (!fileDir.exists()) {
            if (!fileDir.mkdirs()) {
                System.out.println("创建备份目录失败");
                return false;
            }
        }
        File file = new File(homePath + File.separator + "$" + studentId + ".txt");
        try {
            if (file.exists()) {
                if (!file.delete()) {
                    System.out.println("删除临时文件失败");
                    return false;
                }
            }
            if (!file.createNewFile()) {
                System.out.println("创建临时文件失败");
                return false;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        BufferedWriter fileWriter = null;
        try {
            fileWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
            if (!"4".equals(testPaper.getTestNum())) {
                for (int i = 0; i < 25; i++) {
                    int count = i + 1;
                    if (i < 20) {
                        fileWriter.write(count + "." + testPaper.getSingleTakenList().get(i).getContent() + "\r\n");
                        fileWriter.write("A:" + testPaper.getSingleTakenList().get(i).getQue1() + "\r\n");
                        fileWriter.write("B:" + testPaper.getSingleTakenList().get(i).getQue2() + "\r\n");
                        fileWriter.write("C:" + testPaper.getSingleTakenList().get(i).getQue3() + "\r\n");
                        fileWriter.write("D:" + testPaper.getSingleTakenList().get(i).getQue4() + "\r\n");
                        fileWriter.write("正确答案为：" + testPaper.getSingleTakenList().get(i).getRealAnswer() + "\r\n");
                        fileWriter.write("\r\n");
                    } else {
                        int num = i - 20;
                        fileWriter.write(count + "." + testPaper.getTfTakenList().get(num).getContent() + "\r\n");
                        if (testPaper.getTfTakenList().get(num).getRealAnswer() == 1) {
                            fileWriter.write("正确\r\n");
                            fileWriter.write("\r\n");
                        } else {
                            fileWriter.write("错误\r\n");
                            fileWriter.write("\r\n");
                        }
                    }
                }
            } else {
                fileWriter.write("题干：" + testPaper.getAnotherQuestionTaken().getContent() + "\r\n");
                fileWriter.write("\r\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fileWriter != null) {
                    fileWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    /**
     * 备份考试结果信息
     *
     * @param gradeInfo     成绩信息
     * @param specialtyName 专业名
     * @return 成功
     */
    public static boolean backUpExamInfo(GradeInfo gradeInfo, String specialtyName) {
        String homePath = getBackupHome() + File.separator + specialtyName + File.separator
                + gradeInfo.getCourseName() + File.separator + gradeInfo.getTestNum();
        File fileBackup = new File(homePath + File.separator + gradeInfo.getStudentId() + ".txt");
        if (fileBackup.exists()) {
            if (!fileBackup.delete()) {
                System.out.println("删除原备份文件失败");
                return false;
            }
        }
        File file = new File(homePath + File.separator + "$" + gradeInfo.getStudentId() + ".txt");
        BufferedWriter fileWriter = null;
        try {
            fileWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, true), "UTF-8"));
            fileWriter.write("学生的作答：\r\n");
            if (!"4".equals(gradeInfo.getTestNum())) {
                String[] result = gradeInfo.getResult().split(",");
                fileWriter.write("选择题：\r\n");
                for (int i = 0; i < 20; i++) {
                    if (!"E".equals(result[i])) {
                        fileWriter.write(result[i] + ",");
                    } else {
                        fileWriter.write("未选择,");
                    }
                    if (i == 4 || i == 9 || i == 14) {
                        fileWriter.write("\r\n");
                    }
                }
                fileWriter.write("\r\n");
                fileWriter.write("判断题：\r\n");
                for (int i = 20; i < 25; i++) {
                    if ("1".equals(result[i])) {
                        fileWriter.write("正确,");
                    } else if ("0".equals(result[i])) {
                        fileWriter.write("错误,");
                    } else {
                        fileWriter.write("未选择,");
                    }
                }
            } else {
                fileWriter.write(gradeInfo.getResult() + "\r\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fileWriter != null) {
                    fileWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (!file.renameTo(new File(homePath + File.separator + gradeInfo.getStudentId() + ".txt"))) {
                System.out.println("重命名备份文件失败");
                return false;
            }
        }
        return true;
    }
}
