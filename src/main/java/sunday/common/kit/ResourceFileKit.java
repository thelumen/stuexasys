package sunday.common.kit;

import org.slf4j.Logger;

import java.io.File;
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
    //假定在Windows系统
    private static final String HOME = "C:\\搬移文件\\Desktop\\资源文件";

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
            if (!home.mkdir()) {
                LOGGER.info("创建文件失败！");
                return null;
            }
        }
        if (home.isDirectory()) {
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
        } else {
            LOGGER.info("主文件不是一个目录！");
        }
        return null;
    }

    /**
     * 获取资源信息
     * 按照最后更新时间降序排序
     *
     * @return List<Map<String, Object>>.
     */
    public static List<Map<String, Object>> getResourceInfo() {
        List<String> filePackagerNames = getHomeDirectories();//获取主目录下的文件夹名
        List<Map<String, Object>> target = new ArrayList<>();//最终返回类型
        if (filePackagerNames != null) {
            for (String fileName : filePackagerNames) {
                File fileNameInfo = new File(HOME + "/" + fileName);//拼接绝对路径并创建file类
                File[] children = fileNameInfo.listFiles();
                List<Map<String, Object>> father = new ArrayList<>();
                if (children != null && children.length > 0) {
                    for (File file : children) {
                        String path = ResourceFileKit.getRelativePath(fileName, file.getPath()).replaceAll("\\\\", "%2F");
                        Map<String, Object> fileInfo = new HashMap<String, Object>() {{
                            put("name", file.getName());
                            put("path", path);
                            put("lastUpdateTime", DateKit.date2String(file.lastModified()));
                        }};
                        father.add(fileInfo);
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
            }//end for
            return target;
        }//end if
        return null;
    }
}
