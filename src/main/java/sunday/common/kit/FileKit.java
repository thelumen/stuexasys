package sunday.common.kit;

import org.nustaq.serialization.FSTObjectInput;
import org.nustaq.serialization.FSTObjectOutput;
import org.slf4j.Logger;
import sunday.pojo.manager.FileInfo;

import java.io.*;
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
     * 删除文件
     *
     * @param path
     * @param isAll
     * @param flags
     */
    public static void deleteFile(String path, boolean isAll, String... flags) {
        List<File> files = getFiles(path);
        if (null != files) {
            for (File f : files) {
                if (isAll) {
                    f.delete();
                } else {
                    for (String flag : flags) {
                        if (f.getName().contains(flag)) {
                            f.delete();
                        }
                    }
                }
            }
        }
    }

    /**
     * 写数据
     *
     * @param bytes
     * @param path
     * @throws IOException
     */
    public static void write2File(byte[] bytes, String path) throws IOException {
        try (DataOutputStream bos = new DataOutputStream(new FileOutputStream(path))) {
            bos.write(bytes);
        }
    }

    /**
     * 读数据
     *
     * @param path
     * @return
     * @throws IOException
     */
    public static byte[] readFile(String path) throws IOException {
        try (DataInputStream dis = new DataInputStream(new FileInputStream(path));
             ByteArrayOutputStream baps = new ByteArrayOutputStream()) {
            byte[] bytes = new byte[128];
            int i = 0;
            while ((i = dis.read(bytes)) > 0) {
                baps.write(bytes, 0, i);
            }
            return baps.toByteArray();
        }
    }

    /**
     * 序列化对象
     *
     * @param obj
     * @return
     */
    public static byte[] serialize(Object obj) {
        try (ByteArrayOutputStream bytesOut = new ByteArrayOutputStream();
             FSTObjectOutput fstOut = new FSTObjectOutput(bytesOut);) {
            fstOut.writeObject(obj);
            fstOut.flush();
            return bytesOut.toByteArray();
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }
        return null;
    }

    /**
     * 反序列化对象
     *
     * @param bytes
     * @return
     */
    public static Object deserialize(byte[] bytes) {
        Objects.requireNonNull(bytes);
        try (FSTObjectInput fstInput = new FSTObjectInput(new ByteArrayInputStream(bytes));) {
            return fstInput.readObject();
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }
        return null;
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
    public static List<FileInfo> wrapFileInfo(List<File> resources, int pathLevels) {
        Objects.requireNonNull(resources);
        List<FileInfo> target = new ArrayList<>();
        FileInfo file;
        for (File f : resources) {
            file = new FileInfo();

            file.setFileName(f.getName());
            file.setPath(splitAndGetLastNodes(f.getPath(), "\\\\", pathLevels));
            file.setNowDate(f.lastModified());

            target.add(file);
        }
        return target;
    }

    /**
     * 分解字符串，得到指定的后几个节点
     *
     * @param src   源字符串
     * @param flag  分解标志
     * @param level 节点层数
     * @return
     */
    private static String splitAndGetLastNodes(String src, String flag, int level) {
        Objects.requireNonNull(src);
        String[] nodes = src.split(flag);
        int length = nodes.length;
        if (length < level) {
            throw new NullPointerException("没有足够的节点数");
        } else if (length == level) {
            return src;
        } else {
            StringBuilder sb = new StringBuilder();
            for (int i = length - level; i < length; i++) {
                sb.append(nodes[i]).append("/");
            }
            return sb.substring(0, sb.length() - 1);
        }

    }

    /**
     * 文件是否存在，不存在就创建
     *
     * @param filePath
     */
    public static void existAndCreateFile(String filePath) {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            try {
                Files.createFile(path);
            } catch (IOException e) {
                LOGGER.error("创建文件失败！文件路径：{}。具体原因：{}", filePath, e.toString());
            }
        }
    }

    /**
     * 文件夹是否存在，不存在就生成
     *
     * @param dicPath 文件夹路径
     */
    public static void existAndCreateDirectory(String dicPath) {
        Path path = Paths.get(dicPath);
        if (!Files.exists(path)) {
            try {
                Files.createDirectories(path);
            } catch (IOException e) {
                LOGGER.error("创建文件夹失败！路径：{}，具体原因：{}", dicPath, e.toString());
            }
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

    /**
     * 判断文件是否存在
     *
     * @param path
     * @return
     */
    public static boolean exists(String path) {
        Path p = Paths.get(path);
        return Files.exists(p);
    }

    /**
     * 删除文件
     *
     * @param path
     * @return
     * @throws IOException
     */
    public static boolean deleteIfExists(String path) throws IOException {
        Path p = Paths.get(path);
        return Files.deleteIfExists(p);
    }

}
