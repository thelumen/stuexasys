package yang.common.enums;

/**
 * 题目类型
 *
 * Created by 花间一壶酒 on 2017/12/16.
 */
public enum QuestionType {

    Single("选择题",20),
    Single_E("简单的选择题", 4),
    Single_N("普通的选择题", 14),
    Single_D("困难的选择题", 2),
    TF("判断题",5),
    TF_E("简单的判断题", 1),
    TF_N("普通的判断题", 3),
    TF_D("困难的判断题", 1);

    //题目描述
    String msg;
    //题目数量
    int number;

    QuestionType(String s, int i) {
        this.msg = s;
        this.number = i;
    }

    public String getMsg() {
        return msg;
    }

    public int getNumber() {
        return number;
    }
}
