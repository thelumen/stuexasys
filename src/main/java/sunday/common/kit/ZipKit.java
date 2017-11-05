package sunday.common.kit;

import sunday.pojo.student.AnotherTestTaken;
import sunday.pojo.student.SingleTaken;
import sunday.pojo.student.TestPaper;
import sunday.pojo.student.TfTaken;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.Charset;
import java.util.Objects;
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
     * zip打包学生试卷信息
     *
     * @param zipName   zip文件名
     * @param fileNames 文件名
     * @throws IOException
     */
    public static void zipStudentExamInformation(String zipName, String[] fileNames) throws IOException, ClassNotFoundException {
        FileOutputStream f = new FileOutputStream(zipName);
        ZipOutputStream zos = new ZipOutputStream(f);
        TestPaper paper;
        try (OutputStreamWriter osw = new OutputStreamWriter(zos, Charset.forName("utf8"));
             BufferedWriter bw = new BufferedWriter(osw)) {
            for (String file : fileNames) {
                if (!file.contains(".bin") || file.contains("$")) {
                    continue;
                }
                paper = (TestPaper) FileKit.deserialize(FileKit.readFile(file));
                zos.putNextEntry(new ZipEntry(file.replace(".bin", ".txt")));
                bw.write(toString(paper));
                bw.flush();
                osw.flush();
            }
        }
    }

    /**
     * 学生试卷打印
     *
     * @param paper
     * @return
     */
    public static String toString(TestPaper paper) {
        Objects.requireNonNull(paper);
        StringBuilder sb = new StringBuilder(2 * 1024);
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
                s = t.getRealAnswer() == 1 ? "正确" : "错误";
                sb.append("答案:").append(s).append("\r\n\r\n");
            }
        }
        if (null != paper.getAnotherQuestionTaken()) {
            AnotherTestTaken another = paper.getAnotherQuestionTaken();
            sb.append("附加题：" + "\r\n");
            sb.append("题目：").append(another.getContent()).append("\r\n");
            sb.append("答案:").append(another.getResult()).append("\r\n\r\n");
        }
        if (null != paper.getStudentAnswer()) {
            sb.append("学生作答：" + "\r\n");
            sb.append("答案:").append(paper.getStudentAnswer());
        }
        return sb.toString();
    }
}

