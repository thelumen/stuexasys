package sunday.common.kit;

import java.io.*;
import java.util.zip.Adler32;
import java.util.zip.CheckedOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * @author yangxuyue
 * @date 2017/11/2.
 * At 13:41
 */
public class ZipKit {

    /**
     * zip打包同一文件名
     */
    private static final String ZIP_FILENAME = "考卷汇总.zip";

    /**
     * 返回zip文件名
     *
     * @return
     */
    public static String getZipFilename() {
        return ZIP_FILENAME;
    }

    /**
     * zip打包
     *
     * @param zipName   zip文件名
     * @param fileNames 文件名
     * @throws IOException
     */
    public static void zipFiles(String zipName, String[] fileNames) throws IOException {
        FileOutputStream f = new FileOutputStream(zipName);
        //从文件输出流中获取数据校验和输出流,并设置Adler32
        CheckedOutputStream csum = new CheckedOutputStream(f, new Adler32());
        ZipOutputStream zos = new ZipOutputStream(csum);
        BufferedOutputStream out = new BufferedOutputStream(zos);
        BufferedReader in;
        for (String file : fileNames) {
            in = new BufferedReader(new FileReader(file));
            zos.putNextEntry(new ZipEntry(file));
            int c;
            while ((c = in.read()) > 0) {
                out.write(c);
            }
            in.close();
            out.flush();
        }
        out.close();

    }
}

