package com.threekindoms.client.business
{
	import com.threekindoms.client.vo.UserInfo;
	import com.threekindoms.client.services.ElectroServerService;
	import com.threekindoms.client.model.PluginActionType;
	
	import com.electrotank.electroserver5.api.LoginRequest;
	import com.electrotank.electroserver5.api.EsObject;
	import com.threekindoms.client.vo.UserInfo;
	
	public class RegisterDelegate
	{
		public function register(userInfo:UserInfo):void {
            var lr:LoginRequest = new LoginRequest();
            lr.userName = userInfo.userName;
            lr.password = userInfo.password;
            var para:EsObject = new EsObject();
            para.setString(PluginActionType.ACTION, PluginActionType.REGISTER.actionName);
            para.setString("EMAIL", userInfo.email);
            lr.esObject = para;
            ElectroServerService.getInstance().send(lr);
		}
	}
}