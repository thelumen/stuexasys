package sunday.service.lmp.manager;

import org.springframework.stereotype.Service;
import sunday.common.enums.MessageInfo;
import sunday.pojo.school.Specialty;
import sunday.pojo.student.StudentTaken;
import sunday.service.common.CommonService;
import sunday.service.manager.AdminStudentService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 花间一壶酒 on 2017/8/30.
 */

@Service("adminStudentService")
public class AdminStudentServiceImpl extends CommonService implements AdminStudentService {

    @Override
    public List<Map<String, Object>> selectSpecialty() {
        List<Specialty> specialtyList = adminStudentMapper.selectSpecialty(null);
        List<Map<String, Object>> mapList = new ArrayList<>();
        if (null != specialtyList) {
            for (Specialty specialty : specialtyList) {
                Map<String, Object> aSpecialtyInfo = new HashMap<String, Object>() {{
                    put("id", specialty.getSpecialtyId());
                    put("text", specialty.getName());
                }};
                mapList.add(aSpecialtyInfo);
            }
            if (mapList.size() > 0) {
                return mapList;
            }
        }
        return null;
    }

    @Override
    public boolean deleteSpecialty(Map<String, Object> params) {
        return ((adminStudentMapper.selectTeacher2Course(params).size() <= 0 || adminStudentMapper.deleteTeacher2Course(params) > 0) && adminStudentMapper.deleteSpecialty(params) > 0);
    }

    @Override
    @SuppressWarnings("unchecked")
    public MessageInfo uploadStudentHandle(Map<String, Object> params) {
        if (adminStudentMapper.selectSpecialty(params).size() > 0 || adminStudentMapper.insertSpecialty(params) > 0) {
            List<StudentTaken> studentTakenList = adminStudentMapper.selectStudentInfo(params);
            if (studentTakenList.size() > 0) {
                Map<String, Object> compareMap = new HashMap<>();
                List<StudentTaken> resultStudentList = new ArrayList<>();
                for (StudentTaken studentTaken : studentTakenList) {
                    compareMap.put(studentTaken.getStudentId().toString(), 1);
                }
                List<StudentTaken> studentUploadList = (List<StudentTaken>) params.get("studentUploadList");
                for (StudentTaken studentTaken : studentUploadList) {
                    if (compareMap.get(studentTaken.getStudentId().toString()) == null) {
                        resultStudentList.add(studentTaken);
                    }
                }
                if (resultStudentList.size() == 0) {
                    return MessageInfo.NeedlessOperation;//完全重复的学生表上传
                } else {
                    params.put("studentUploadList", resultStudentList);//将不在数据库中学生提取出来
                }
            }
            if (adminStudentMapper.insertStudent(params) > 0 && adminStudentMapper.insertStudentRole(params) > 0) {
                return MessageInfo.SuccessOperation;
            } else {
                return MessageInfo.OperationFailed;
            }
        } else {
            return MessageInfo.OperationFailed;
        }
    }
}
