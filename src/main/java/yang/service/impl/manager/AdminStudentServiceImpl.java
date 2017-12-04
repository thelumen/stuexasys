package yang.service.impl.manager;

import org.springframework.stereotype.Service;
import yang.common.enums.MessageInfo;
import yang.domain.common.Specialty;
import yang.domain.student.StudentTaken;
import yang.service.common.CommonService;
import yang.service.manager.AdminStudentService;

import java.util.*;

/**
 *
 * @author 花间一壶酒
 * @date 2017/8/30
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
        return ((adminStudentMapper.selectTeacher2Course(params).size() <= 0 ||
                adminStudentMapper.deleteTeacher2Course(params) > 0) && adminStudentMapper.deleteSpecialty(params) > 0);
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
        List<Specialty> specialtyListInDB = adminStudentMapper.selectSpecialty(params);
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
            insertSpecialty = adminStudentMapper.insertSpecialty(params) > 0;
        }
        if (!insertSpecialty) {
            return MessageInfo.ServiceFailed;
        }
        List<StudentTaken> studentTakenList = adminStudentMapper.selectStudentInfo(params);
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
        if (adminStudentMapper.insertStudent(params) > 0 && adminStudentMapper.insertStudentRole(params) > 0) {
            return MessageInfo.SuccessOperation;
        } else {
            return MessageInfo.ServiceFailed;
        }
    }

    /**
     * 转换数据结构
     * <Specialty>
     *
     * @param swapList .
     * @return .
     */
    private Map<String, Object> swapList2MapSpecialty(List<Specialty> swapList) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("specialtyId", swapList.get(0).getSpecialtyId());
        resultMap.put("name", swapList.get(0).getName());
        return resultMap;
    }

    /**
     * 转换数据结构
     * <StudentTaken>
     *
     * @param swapList .
     * @return .
     */
    private Map<String, Object> swapList2MapStudentTaken(List<StudentTaken> swapList) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("studentId", swapList.get(0).getStudentId());
        resultMap.put("name", swapList.get(0).getName());
        resultMap.put("gender", swapList.get(0).getGender());
        resultMap.put("password", swapList.get(0).getPassword());
        resultMap.put("specialtyId", swapList.get(0).getSpecialtyId());
        return resultMap;
    }

    /**
     * 比较两个 List,将后一个中与前一个不重复的对象取出,并放到结果集中
     * <StudentTaken>
     *
     * @param studentTakenList  .
     * @param studentUploadList .
     * @return resultStudentList .
     */
    private List<StudentTaken> compareDiffInList(List<StudentTaken> studentTakenList, List<StudentTaken> studentUploadList) {
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
        return resultStudentList;
    }
}
