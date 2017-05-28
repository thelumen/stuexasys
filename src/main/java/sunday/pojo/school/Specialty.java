package sunday.pojo.school;

/**
 * 专业表
 * Created by yang on 2017/5/25.
 * At 12:06
 */
public final class Specialty {
    private byte id;
    private String specialtyId;
    private String name;

    public byte getId() {
        return id;
    }

    public void setId(byte id) {
        this.id = id;
    }

    public String getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(String specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
