import org.junit.Test;
import sunday.common.kit.ResourceFileKit;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.System.out;

/**
 * Created by yang on 2017/5/22.
 * At 14:44
 */
public class FileTest {
    private static final String HOME = "E:/搬移文件/Desktop/资源文件";

    @Test
    public void t4() {
        String name = "E:\\搬移文件\\Desktop\\资源文件\\数据结构\\数据结构 - 副本 (6).txt";
        File file = new File(HOME + "/" + "数据结构");
//        out.print(file.exists());
        StringBuilder sb = new StringBuilder();
        sb.append(name);
        out.print(sb.substring(sb.indexOf("数据结构"),sb.length()));
    }

    //搜索文件
    @Test
    public void t3() {
        String realPath = ResourceFileKit.getHome() + "/" + "C语言";
        File home = new File(realPath);
        if (home.exists()) {
            if (home.isDirectory()) {
                File[] children = home.listFiles();
                if (null != children) {
                    List<Map<String, Object>> father = new ArrayList<>();
                    for (File file : children) {
                        Map<String, Object> child = new HashMap<String, Object>() {{
                            put("name", file.getName());
                            put("path", file.getPath());
                        }};
                        father.add(child);
                    }
                }
            }
        }
    }

    //kit测试
    @Test
    public void t2() {
        List<String> a = ResourceFileKit.getHomeDirectories();
        if (a != null) {
            for (String s : a) {
                out.print(s + " ");
            }
        }
    }

    //文件测试
    @Test
    public void t1() throws IOException {
        File home = new File(HOME);
        if (home.isDirectory()) {
            File[] children = home.listFiles();
            for (File file : children) {
                if (file.isDirectory()) {
                    out.print(file.getName() + " path:" + file.getPath() + " absolutePath" + file.getAbsolutePath());
                    out.println();
                }
            }
        }
    }
}
