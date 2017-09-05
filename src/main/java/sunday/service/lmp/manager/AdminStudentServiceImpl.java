package sunday.service.lmp.manager;

import org.springframework.stereotype.Service;
import sunday.common.enums.MessageInfo;
import sunday.mapper.manager.AdminStudentMapper;
import sunday.mapper.student.StudentMapper;
import sunday.mapper.teacher.Specialty2CourseMapper;
import sunday.pojo.school.Specialty;
import sunday.pojo.student.StudentInfo;
import sunday.pojo.student.StudentTaken;
import sunday.service.manager.AdminStudentService;

import java.lang.reflect.Array;
import java.util.*;

/**
 * Created by 花间一壶酒 on 2017/8/30.
 */

@Service("adminStudentService")
public class AdminStudentServiceImpl implements AdminStudentService {

    @javax.annotation.Resource(name = "adminStudentMapper")
    private AdminStudentMapper adminStudentMapper;
    @javax.annotation.Resource(name = "studentMapper")
    private StudentMapper studentMapper;

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
            List<StudentTaken> studentTakenList = studentMapper.selectStudentInfo(new HashMap<String, Object>() {{
                put("specialtyId", new ArrayList<String>() {{
                    add(params.get("specialtyId").toString());
                }});
            }});//将Map中的普通类型转换为集合类型，用于对应map.xml的处理方法
            if (studentTakenList.size() > 0) {
                List<StudentTaken> resultStudentList = new ArrayList<>();
                Map<String, Object> contrastGroup = new HashMap<>();
                for (StudentTaken aStudentTaken : studentTakenList) {
                    contrastGroup.put(aStudentTaken.getStudentId().toString(), 1);
                }//以数据库中全部学生的 Id 为 key 存入 Map
                for (StudentTaken aStudentTaken : (List<StudentTaken>) params.get("studentUploadList")) {
                    if (contrastGroup.get(aStudentTaken.getStudentId().toString()) == null) {
                        resultStudentList.add(aStudentTaken);
                    }//用新上传的学生的 Id 去 Map 中取值,取不到值的为新添加的，能取到的重复的
                }
                if (resultStudentList.size() == 0) {
                    return MessageInfo.NeedlessOperation;//完全重复的学生表上传
                } else {
                    params.put("studentUploadList", resultStudentList);//将不在数据库中学生提取出来
                }
            }
            if (adminStudentMapper.insertStudent(params) > 0) {
                return MessageInfo.SuccessOperation;
            } else {
                return MessageInfo.OperationFailed;
            }
        } else {
            return MessageInfo.OperationFailed;
        }
    }
}
