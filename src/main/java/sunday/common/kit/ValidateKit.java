package sunday.common.kit;

import sunday.pojo.school.Course;
import sunday.pojo.school.Specialty;

import java.util.Objects;

/**
 * Created by yang on 2017/9/9.
 * At 9:53
 */
public final class ValidateKit {
    private ValidateKit() {
    }

    /**
     * 校验课程
     *
     * @param course
     * @return
     */
    public static boolean validateCourse(Course course) {
        if (course.getCourseId() < 10000000 || course.getCourseId() > 99999999) {
            return false;
        }
        if (Objects.equals(course.getName(), "")) {
            return false;
        }
        if (course.getPeriod() < 0 || course.getPeriod() > 99 || course.getCredit() < 0 || course.getCredit() > 99) {
            return false;
        }
        return true;
    }

    /**
     * 校验专业
     *
     * @param specialty
     * @return
     */
    public static boolean validateSpecialty(Specialty specialty) {
        if (specialty.getSpecialtyId() < 100000 || specialty.getSpecialtyId() > 999999) {
            return false;
        }
        if (Objects.equals(specialty.getName(), "")) {
            return false;
        }
        return true;
    }
}
