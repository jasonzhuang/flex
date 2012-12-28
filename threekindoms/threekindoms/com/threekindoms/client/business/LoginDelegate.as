package com.threekindoms.client.business
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.LoginRequest;
	import com.threekindoms.client.model.PluginActionType;
	import com.threekindoms.client.services.ElectroServerService;
    import com.threekindoms.client.utils.PluginActionFactory;
	
	public class LoginDelegate
	{
		public function login(userName:String, password:String):void {
            var lr:LoginRequest = new LoginRequest();
            lr.userName = userName;
//            lr.password = password;
//            var para:EsObject = new EsObject();
//            para.setString(PluginActionType.ACTION, PluginActionType.LOGIN.actionName);
//            lr.esObject = para;
            
            ElectroServerService.getInstance().send(lr);
		}
	}
}