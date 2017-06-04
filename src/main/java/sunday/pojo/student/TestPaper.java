package sunday.pojo.student;

import java.util.List;

/**
 * Created by 花间一壶酒 on 2017/6/4.
 */
public class TestPaper {
    private List<SingleTaken> singleTakenList;
    private List<TfTaken> tfTakenList;
    private AnotherQuestionTaken anotherQuestionTaken;

    public AnotherQuestionTaken getAnotherQuestionTaken() {
        return anotherQuestionTaken;
    }

    public void setAnotherQuestionTaken(AnotherQuestionTaken anotherQuestionTaken) {
        this.anotherQuestionTaken = anotherQuestionTaken;
    }

    public List<SingleTaken> getSingleTakenList() {
        return singleTakenList;
    }

    public void setSingleTakenList(List<SingleTaken> singleTakenList) {
        this.singleTakenList = singleTakenList;
    }

    public List<TfTaken> getTfTakenList() {
        return tfTakenList;
    }

    public void setTfTakenList(List<TfTaken> tfTakenList) {
        this.tfTakenList = tfTakenList;
    }
}
