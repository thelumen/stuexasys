package sunday.pojo.school;

/**
 * 专业表
 * Created by yang on 2017/5/25.
 * At 12:06
 */
public final class Specialty {
    private int id;
    private Integer specialtyId;
    private String name;

    @Override
    public String toString() {
        return "Specialty{" +
                "id=" + id +
                ", specialtyId=" + specialtyId +
                ", name='" + name + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
