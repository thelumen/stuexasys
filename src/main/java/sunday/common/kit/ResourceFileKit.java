package sunday.common.kit;

import org.slf4j.Logger;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
    private static final String HOME = "E:/搬移文件/Desktop/资源文件";

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

}
