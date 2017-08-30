package sunday.common.kit;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yang on 2017/8/22.
 * At 22:38
 */
public final class CommonKit {
    private CommonKit() {
    }

    /**
     * 从map中获取page信息
     *
     * @param params
     * @return
     */
    public static Page getMapInfo2Page(Map<String, Object> params) {
        Page page = new Page();

        if (null != params.get("pageNum")) {
            page.setPageNum(Integer.parseInt(params.get("pageNum").toString()));
        }
        if (null != params.get("pageSize")) {
            page.setPageSize(Integer.parseInt(params.get("pageSize").toString()));
        }
        if (null != params.get("sort")) {
            page.setOrderBy(params.get("sort") + " " + params.get("order"));
        }
        return page;
    }

    /**
     * 获取table所需格式
     *
     * @param target
     * @return
     */
    public static Map<String, Object> getTakenInfo(List<?> target) {
        Map<String, Object> takenInfo = new HashMap<>();

        PageInfo<?> pageInfo = new PageInfo<>(target);
        takenInfo.put("total", pageInfo.getTotal());
        if (null == target) {
            takenInfo.put("rows", new ArrayList<>());
        } else {
            takenInfo.put("rows", pageInfo.getList());
        }

        return takenInfo;
    }
}
