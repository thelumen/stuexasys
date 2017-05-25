package sunday.service;

import sunday.pojo.Specialty;

import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/5/25.
 * At 12:11
 */
public interface SpeCouService {
    /**
     * 新增班级
     *
     * @param specialty
     * @return
     */
    int insertSpecialty(Specialty specialty);

    /**
     * 查询班级
     *
     * @param params
     * @return
     */
    List<Specialty> selectSpecialty(Map<String, Object> params);
}
