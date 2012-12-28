package com.threekindoms.client.utils
{
    import com.threekindoms.client.model.UserInfo;

    public class UserInfoFactory
    {
        public static function createUserInfo(userName:String, password:String, email:String = null):UserInfo
        {
            var userInfo:UserInfo = new UserInfo;
            userInfo.userName = userName;
            userInfo.password = password;
            userInfo.email = email;
            return userInfo;
        }

    }
}
