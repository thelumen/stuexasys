package sunday.common.enums;

/**
 * Created by 花间一壶酒 on 2017/9/2.
 */
public enum DeleteType {

    DeleteWithStudentId(1,"按照学号删除"),
    DeleteWithSpecialtyId(2,"按照专业删除")
    ;

    private final Integer typeId;
    private final String typeName;

    DeleteType(Integer typeId, String typeName) {
        this.typeId = typeId;
        this.typeName = typeName;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public String getTypeName() {
        return typeName;
    }
}
