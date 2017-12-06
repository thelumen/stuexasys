package yang.domain.manager;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * @author yang
 * @date 2017/10/8
 * At 21:06
 */
public final class FileInfo {
    private String fileName;
    private String path;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date nowDate;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path.replace("\\", "/");
    }

    public void setNowDate(long lastModified) {
        this.nowDate = new Date(lastModified);
    }

    public Date getNowDate() {
        return nowDate;
    }

}
