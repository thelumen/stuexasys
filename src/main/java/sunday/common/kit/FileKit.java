package sunday.common.kit;

import org.slf4j.Logger;
import sunday.pojo.manager.FileInfo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

/**
 * @author yangxuyue
 * @date 2017/11/1.
 * At 14:54
 */
public final class FileKit {
    private static final Logger LOGGER = LogKit.getLogger();

    private FileKit() {
    }

    /**
     * 获取指定文件夹下的文件File
     *
     * @param directoryPath
     * @return
     */
    public static List<File> getFiles(String directoryPath) {
        File dir = new File(directoryPath);
        if (!dir.exists() || !dir.isDirectory()) {
            return null;
        }
        File[] files = dir.listFiles(File::isFile);
        List<File> homework = null;
        if (null != files) {
            homework = new ArrayList<>();
            homework.addAll(Arrays.asList(files));
        }
        return homework;
    }

    /**
     * 包装文件FileInfo
     *
     * @param resources
     * @return
     */
    public static List<FileInfo> wrapFileInfo(List<File> resources) {
        Objects.requireNonNull(resources);
        List<FileInfo> target = new ArrayList<>();
        FileInfo file;
        for (File f : resources) {
            file = new FileInfo();

            file.setFileName(f.getName());
            file.setPath(f.getPath());
            file.setNowDate(f.lastModified());

            target.add(file);
        }
        return target;
    }

    /**
     * 文件夹是否存在，不存在就生成
     *
     * @param homePath 文件夹路径
     */
    public static void existAndCreate(String homePath) {
        Path path = Paths.get(homePath);
        try {
            Files.createDirectories(path);
        } catch (IOException e) {
            LOGGER.error("创建文件夹失败！路径：{}", homePath);
        }
    }

    /**
     * 获取文件（夹）名称，只在当前文件夹下
     *
     * @param directoryPath 指定文件夹
     * @param isDirectory   是否获取文件夹名称
     * @return
     */
    public static List<String> getFileOrDirectoryNames(String directoryPath, boolean isDirectory) {
        List<String> targetNames = new ArrayList<>();
        File dir = new File(directoryPath);
        if (dir.exists() && dir.isDirectory()) {
            File[] files;
            if (isDirectory) {
                files = dir.listFiles(File::isDirectory);
            } else {
                files = dir.listFiles(File::isFile);
            }
            if (null != files) {
                for (File f : files) {
                    targetNames.add(f.getName());
                }
            }
        }
        return targetNames;
    }
}
