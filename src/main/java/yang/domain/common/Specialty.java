package yang.domain.common;

/**
 * 专业表
 * Created by yang on 2017/5/25.
 * At 12:06
 */
public final class Specialty {
    private int id;
    private Integer specialtyId;
    private String name;
    private Integer total;

    @Override
    public String toString() {
        return "Specialty{" +
                "id=" + id +
                ", specialtyId=" + specialtyId +
                ", name='" + name + '\'' +
                ", total=" + total +
                '}';
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public Integer getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Integer specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
