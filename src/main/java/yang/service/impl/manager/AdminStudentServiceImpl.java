package yang.service.impl.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yang.common.enums.MessageInfo;
import yang.dao.manager.AdminStudentMapper;
import yang.domain.common.Specialty;
import yang.domain.student.StudentTaken;
import yang.service.manager.AdminStudentService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 花间一壶酒
 * @date 2017/8/30
 */
@Service("adminStudentService")
public class AdminStudentServiceImpl implements AdminStudentService {

    @Autowired
    protected AdminStudentMapper mapper;

    @Override
    public List<Map<String, Object>> selectSpecialty() {
        List<Specialty> specialtyList = mapper.selectSpecialty(null);
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
        return ((mapper.selectTeacher2Course(params).size() <= 0 ||
                mapper.deleteTeacher2Course(params) > 0) && mapper.deleteSpecialty(params) > 0);
    }

    @Override
    @SuppressWarnings("unchecked")
    public MessageInfo uploadStudentHandle(Map<String, Object> params) {
        List<Specialty> specialtyList = (List<Specialty>) params.get("specialtyInfo");
        List<StudentTaken> studentUploadList = (List<StudentTaken>) params.get("studentUploadList");
        boolean insertSpecialty;
        if (specialtyList.size() == 0 || studentUploadList.size() == 0) {
            return MessageInfo.ServiceFailed;
        }
        List<Specialty> specialtyListInDB = mapper.selectSpecialty(params);
        if (!(specialtyListInDB.size() < specialtyList.size())) { //判断上传表中的专业是否都存在于数据库中
            insertSpecialty = true;
        } else {
            Map<String, Object> compareMap = new HashMap<>();
            List<Specialty> resultSpecialtyList = new ArrayList<>();
            for (Specialty specialty : specialtyListInDB) {
                compareMap.put(specialty.getSpecialtyId().toString(), 1);
            }
            for (Specialty specialty : specialtyList) {
                if (compareMap.get(specialty.getSpecialtyId().toString()) == null) {
                    resultSpecialtyList.add(specialty);
                }
            }
            params.put("specialtyInfo", resultSpecialtyList);
            insertSpecialty = mapper.insertSpecialty(params) > 0;
        }
        if (!insertSpecialty) {
            return MessageInfo.ServiceFailed;
        }
        List<StudentTaken> studentTakenList = mapper.selectStudentInfo(params);
        if (!(studentTakenList.size() < studentUploadList.size())) {//判断上传表中的学生是否都存在于数据库
            return MessageInfo.NeedlessOperation;
        }
        Map<String, Object> compareMap = new HashMap<>();
        List<StudentTaken> resultStudentList = new ArrayList<>();
        for (StudentTaken studentTaken : studentTakenList) {
            compareMap.put(studentTaken.getStudentId().toString(), 1);
        }
        for (StudentTaken studentTaken : studentUploadList) {
            if (compareMap.get(studentTaken.getStudentId().toString()) == null) {
                resultStudentList.add(studentTaken);
            }
        }
        params.put("studentUploadList", resultStudentList);
        if (mapper.insertStudent(params) > 0 && mapper.insertStudentRole(params) > 0) {
            return MessageInfo.SuccessOperation;
        } else {
            return MessageInfo.ServiceFailed;
        }
    }

}
