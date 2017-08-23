package sunday.common.kit;

import java.util.HashSet;

/**
 * Created by 花间一壶酒 on 2017/6/4.
 */
public final class RandomKit {

    private RandomKit() {
    }

    /**
     * 随机指定范围内N个不重复的数
     * 利用HashSet的特征，只能存放不同的值
     *
     * @param min 指定范围最小值
     * @param max 指定范围最大值
     * @param n   随机数个数
     * @param set 随机数结果集
     */
    public static void randomSet(int min, int max, int n, HashSet<Integer> set) {
        //判断传入值的合法性
        if (n > (max - min + 1) || max < min) {
            return;
        }
        //循环将随机数填入 set 直到达到数量 n
        while (set.size()<n){
            int num = (int) (Math.random() * (max - min + 1)) + min;
            set.add(num);// 将不同的数存入HashSet中
        }
    }
}
