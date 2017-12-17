package yang.common.kit;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author yang
 * @date 2017/8/22
 * At 22:38
 */
public final class CommonKit {

    private static final Logger LOGGER = LogKit.getLogger();

    private CommonKit() {
    }

    /**
     * 全中文转换成char数字的伪加密
     *
     * @param target
     * @return
     */
    public static String chinese2CharNumber(String target) {
        char[] srcChars = target.toCharArray();
        StringBuilder store = new StringBuilder();
        for (int i : srcChars) {
            store.append(i).append("&");
        }
        store.deleteCharAt(store.length() - 1);
        return store.toString();
    }

    /**
     * 对应chinese2CharNumber方法的伪解密
     *
     * @param target
     * @return
     */
    public static String string2Chinese(String target) {
        String[] array = target.split("&");
        StringBuilder last = new StringBuilder();
        try {
            for (String s : array) {
                int temp = Integer.parseInt(s);
                last.append((char) temp);
            }
        } catch (NumberFormatException e) {
            LOGGER.error("String转换Number时发生错误，发生在类：{}。输入String值为：{}", ClassKit.getClassName(), target);
        }

        return last.toString();
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
     * 从原始bootstrap-table-map中获取page信息
     *
     * @param params
     * @return
     */
    public static Page getOrginMapInfo2Page(Map<String, Object> params) {
        Page page = new Page();
        int limit = 1;
        int offset = 1;
        if (null != params.get("limit")) {
            limit = Integer.parseInt(params.get("limit").toString());
            page.setPageSize(limit);
        }
        if (null != params.get("offset")) {
            offset = Integer.parseInt(params.get("offset").toString()) / limit + 1;
            page.setPageNum(offset);
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
