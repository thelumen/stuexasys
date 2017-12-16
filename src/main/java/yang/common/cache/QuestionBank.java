package yang.common.cache;

import yang.domain.common.Another;
import yang.domain.common.SingleQuestion;
import yang.domain.common.TfQuestion;

import java.util.List;

/**
 * @author yangxuyue
 * @date 2017/12/16.
 * At 11:20
 */
public class QuestionBank {
    /**
     * 选择题
     */
    private List<SingleQuestion> singleQuestions;
    /**
     * 判断题
     */
    private List<TfQuestion> tfQuestions;
    /**
     * 附加题
     */
    private List<Another> anothers;

    public List<SingleQuestion> getSingleQuestions() {
        return singleQuestions;
    }

    public void setSingleQuestions(List<SingleQuestion> singleQuestions) {
        this.singleQuestions = singleQuestions;
    }

    public List<TfQuestion> getTfQuestions() {
        return tfQuestions;
    }

    public void setTfQuestions(List<TfQuestion> tfQuestions) {
        this.tfQuestions = tfQuestions;
    }

    public List<Another> getAnothers() {
        return anothers;
    }

    public void setAnothers(List<Another> anothers) {
        this.anothers = anothers;
    }
}
