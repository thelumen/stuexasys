package yang.domain.common;

import java.util.Objects;

/**
 * 专业表
 *
 * @author yang
 * @date 2017/5/25
 * At 12:06
 */
public final class Specialty {
    private int id;
    private Integer specialtyId;
    private String name;
    private Integer total;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Specialty specialty = (Specialty) o;
        return Objects.equals(specialtyId, specialty.specialtyId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(specialtyId);
    }

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
