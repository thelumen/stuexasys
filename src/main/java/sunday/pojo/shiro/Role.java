package sunday.pojo.shiro;

/**
 * Created by yang on 2017/5/22.
 * At 19:11
 */
public final class Role {
    private int id;
    private String name;
    private String remark;

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
