package yang.common.enums;

/**
 *
 * @author 花间一壶酒
 * @date 2017/8/30
 */
public enum UpdateType {

    StuSet("学生设置",0),
    StuFind("学生找回",1),
    AdminSet("管理员设置",2)
    ;

    private final String typeInfo;
    private final Integer typeNum;

    UpdateType(String typeInfo,Integer typeNum){
        this.typeInfo=typeInfo;
        this.typeNum = typeNum;
    }

    public String getTypeInfo() {
        return typeInfo;
    }

    public Integer getTypeNum() {
        return typeNum;
    }
}
