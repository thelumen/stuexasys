package sunday.common.kit;

import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * 加密工具
 * Created by yang on 2017/2/9.
 * At 10:51
 */
public final class EncryptKit {

    private EncryptKit() {
    }

    /**
     * MD5
     *
     * @param text
     * @return
     */
    public static String md5(String text) {
        return new Md5Hash(text).toString();
    }

    /**
     * MD5
     *
     * @param text
     * @param salt 盐
     * @return
     */
    public static String md5(String text, String salt) {
        return new Md5Hash(text, salt).toString();
    }

    /**
     * MD5
     *
     * @param text
     * @param salt           盐
     * @param hashIterations 散列次数
     * @return
     */
    public static String md5(String text, String salt, int hashIterations) {
        return new Md5Hash(text, salt, hashIterations).toString();
    }


}
