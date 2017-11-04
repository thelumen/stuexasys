package sunday.common.kit;

import sunday.pojo.student.AnotherTestTaken;
import sunday.pojo.student.SingleTaken;
import sunday.pojo.student.TestPaper;
import sunday.pojo.student.TfTaken;

import java.io.*;
import java.nio.charset.Charset;
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
        OutputStreamWriter osw = new OutputStreamWriter(zos, Charset.forName("utf8"));
        //BufferedOutputStream out = new BufferedOutputStream(zos);
        BufferedReader in;
        for (String file : fileNames) {
            in = new BufferedReader(new FileReader(file));
            zos.putNextEntry(new ZipEntry(file));
            int c;
            while ((c = in.read()) > 0) {
                osw.write(c);
            }
            in.close();
            osw.flush();
        }
        osw.close();

    }

    /**
     * 学生试卷打印
     *
     * @param paper
     * @return
     */
    public static String toString(TestPaper paper) {
        StringBuilder sb = new StringBuilder(1024);
        sb.append("测验：").append(paper.getTestNum()).append("\r\n");
        sb.append("课程：").append(paper.getCourseName()).append("\r\n\r\n");
        String level;

        if (null != paper.getSingleTakenList()) {
            sb.append("选择题：" + "\r\n");
            for (SingleTaken s : paper.getSingleTakenList()) {
                level = s.getLevels() == 1 ? "简单" : s.getLevels() == 2 ? "中等" : "困难";
                sb.append("章节：").append(s.getSection()).append(" 难度：").append(level).append("\r\n");
                sb.append("题目：").append(s.getContent()).append("\r\n");
                sb.append("A:").append(s.getQue1()).append("\r\n");
                sb.append("B:").append(s.getQue2()).append("\r\n");
                sb.append("C:").append(s.getQue3()).append("\r\n");
                sb.append("D:").append(s.getQue4()).append("\r\n");
                sb.append("答案:").append(s.getRealAnswer()).append("\r\n\r\n");
            }
        }
        if (null != paper.getTfTakenList()) {
            sb.append("判断题：" + "\r\n");
            String s;
            for (TfTaken t : paper.getTfTakenList()) {
                level = t.getLevels() == 1 ? "简单" : t.getLevels() == 2 ? "中等" : "困难";
                sb.append("章节：").append(t.getSection()).append(" 难度：").append(level).append("\r\n");
                sb.append("题目：").append(t.getContent()).append("\r\n");
                s = t.getResult() == 1 ? "正确" : "错误";
                sb.append("答案:").append(s).append("\r\n\r\n");
            }
        }
        if (null != paper.getAnotherQuestionTaken()) {
            AnotherTestTaken another = paper.getAnotherQuestionTaken();
            sb.append("附加题：" + "\r\n");
            sb.append("题目：").append(another.getContent()).append("\r\n");
            sb.append("答案:").append(another.getResult()).append("\r\n\r\n");
        }
        return sb.toString();
    }
}

