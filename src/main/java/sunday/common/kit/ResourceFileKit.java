package sunday.common.kit;

import org.slf4j.Logger;
import sunday.pojo.student.GradeInfo;
import sunday.pojo.student.TestPaper;

import java.io.*;
import java.util.*;

/**
 * 资源文件目录工具类
 * Created by yang on 2017/6/4.
 * At 12:07
 */
public final class ResourceFileKit {
    private static final Logger LOGGER = LogKit.getLogger();
    //必须给定一个主目录
    //如果不存在的话，则自动创建
    private static final String HOME = File.separator + "home" + File.separator + "sunday";

    private ResourceFileKit() {
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
     * 获取HOME文件夹内所有文件夹名
     *
     * @return
     */
    public static List<String> getHomeDirectories() {
        File home = new File(HOME);
        if (!home.exists()) {
            home.mkdir();
        }
        File[] children = home.listFiles();
        if (children != null && children.length > 0) {
            List<String> directories = new ArrayList<>();
            for (File file : children) {
                if (file.isDirectory()) {
                    directories.add(file.getName());
                }
            }
            return directories;
        }
        return null;
    }

    /**
     * 获取资源信息
     * 按照最后更新时间降序排序
     *
     * @return .
     */
    public static List<Map<String, Object>> getResourceInfo() {
        List<String> filePackagerNames = getHomeDirectories();//获取主目录下的文件夹名
        List<Map<String, Object>> target = new ArrayList<>();//最终返回类型
        if (filePackagerNames != null) {
            int i = 0;
            int j = 0;
            for (String fileName : filePackagerNames) {
                File fileNameInfo = new File(HOME + File.separator + fileName);//拼接绝对路径并创建file类
                File[] children = fileNameInfo.listFiles();
                List<Map<String, Object>> father = new ArrayList<>();
                if (children != null && children.length > 0) {
                    for (File file : children) {
                        Map<String, Object> fileInfo = new HashMap<String, Object>() {{
                            put("name", file.getName());
                            put("lastUpdateTime", DateKit.date2String(file.lastModified()));
                        }};
                        fileInfo.put("path", i + "," + j);
                        father.add(fileInfo);
                        j++;
                    }
                    //按最后更新时间对目录下的文件进行排序
                    father.sort((o1, o2) -> {
                        Date d1 = DateKit.string2Date((String) o1.get("lastUpdateTime"));
                        Date d2 = DateKit.string2Date((String) o2.get("lastUpdateTime"));
                        if (d1.getTime() > d2.getTime()) {
                            return -1;
                        }
                        if (d1.getTime() == d2.getTime()) {
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
        List<String> filePackagerNames = getHomeDirectories();//获取主目录下的文件夹名
        if (null != filePackagerNames && filePackagerNames.size() > 0) {
            String fileName = filePackagerNames.get(folderNum);
            File fileNameInfo = new File(HOME + File.separator + fileName);//拼接绝对路径并创建file类
            File[] children = fileNameInfo.listFiles();
            if (null != children && children.length > 0) {
                String path = ResourceFileKit.getRelativePath(fileName, children[fileNum].getPath());
                fileInfoWithMap.put("fileName", children[fileNum].getName());
                fileInfoWithMap.put("realPath", HOME + File.separator + path);
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
        File fileDir = new File(getHome() + File.separator + "backup" + File.separator
                + specialtyName + File.separator + courseName + File.separator + testPaper.getTestNum());
        if (!fileDir.exists()) {
            if (!fileDir.mkdirs()) {
                System.out.println("创建备份目录失败");
                return false;
            }
        }
        File file = new File(getHome() + File.separator + "backup" + File.separator
                + specialtyName + File.separator + courseName + File.separator + testPaper.getTestNum()
                + File.separator + studentId + ".txt");
        try {
            if (file.exists()) {
                if (!file.delete()) {
                    System.out.println("删除备份文件失败");
                }
            }
            if (!file.createNewFile()) {
                System.out.println("创建备份文件失败");
                return false;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        FileWriter fileWriter = null;
        try {
            fileWriter = new FileWriter(file);
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
                fileWriter.write("参考答案：" + testPaper.getAnotherQuestionTaken().getResult() + "\r\n");
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
        File file = new File(getHome() + File.separator + "backup"
                + File.separator + specialtyName + File.separator + gradeInfo.getCourseName() + File.separator + gradeInfo.getTestNum()
                + File.separator + gradeInfo.getStudentId() + ".txt");
        FileWriter fileWriter = null;
        try {
            fileWriter = new FileWriter(file, true);
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
                fileWriter.write(gradeInfo.getResult()+"\r\n");
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
}
