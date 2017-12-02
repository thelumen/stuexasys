package yang.common.base;

import java.io.Serializable;

/**
 *
 * @author yang
 * @date 2017/9/5
 * At 17:11
 */
public class ResultBean<T> implements Serializable {

    private static final int SUCCESS = 0;
    private static final int FAILED = 1;
    private static final int NO_PERMISSION = 2;

    private int code = SUCCESS;
    private T data;
    private String msg = "success";

    /**
     * 无权限返回
     */
    public ResultBean() {
        super();
        this.code = NO_PERMISSION;
        this.msg = "您没有权限！";
    }

    /**
     * 成功返回
     *
     * @param data
     */
    public ResultBean(T data) {
        super();
        this.data = data;
    }

    /**
     * 异常返回
     *
     * @param e
     */
    public ResultBean(Throwable e) {
        super();
        this.msg = e.toString();
        this.code = FAILED;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
