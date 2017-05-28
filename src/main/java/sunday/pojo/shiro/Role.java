package sunday.pojo.shiro;

/**
 * Created by yang on 2017/5/22.
 * At 19:11
 */
public final class Role {
    private short id;
    private String name;
    private String remark;

    public short getId() {
        return id;
    }

    public void setId(short id) {
        this.id = id;
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
