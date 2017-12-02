package yang.domain.manager;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * Created by yang on 2017/10/8.
 * At 21:06
 */
public final class FileInfo {
    private String fileName;
    private String path;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date nowDate;
    private String lastUpdateTime;

    public String getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(String lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

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
        //\\\\被java转换成\\，\\又被正则表达式转换成\。
        //this.path = path.replaceAll("\\\\", "/");
        this.path = path.replace("\\", "/");
    }

    public void setNowDate(long lastModified) {
        this.nowDate = new Date(lastModified);
    }

    public Date getNowDate() {
        return nowDate;
    }

}
