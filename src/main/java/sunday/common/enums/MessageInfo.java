package sunday.common.enums;

/**
 * Created by 花间一壶酒 on 2017/9/5.
 */
public enum MessageInfo {

    SuccessOperation("操作成功",0),
    OperationFailed("执行失败",1),
    NeedlessOperation("多余的执行",2)
    ;

    private String messageContent;
    private Integer messageId;
    MessageInfo(String messageContent, Integer messageId){
        this.messageContent = messageContent;
        this.messageId = messageId;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public Integer getMessageId() {
        return messageId;
    }
}
