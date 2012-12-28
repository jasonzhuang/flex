package com.threekindoms.client.presentmodel
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.LoginResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.threekindoms.client.cairngormevents.LoginRemoteEvent;
	import com.threekindoms.client.events.ViewToggleEvent;
	import com.threekindoms.client.model.PluginActionType;
	import com.threekindoms.client.model.PluginConstants;
	import com.threekindoms.client.model.ViewType;
	import com.threekindoms.client.services.ElectroServerService;
	import com.threekindoms.client.events.LoginFailedEvent;
	
	import flash.events.IEventDispatcher;
    
	public class LoginPm extends BasePresentModel
	{
		public function LoginPm(eventDispatcher:IEventDispatcher)
		{
			super(eventDispatcher);
		}
		
		public function login(userName:String, password:String):void {
            CairngormEventDispatcher.getInstance().dispatchEvent(new LoginRemoteEvent(userName, password));
            this.dispatchEvent(new ViewToggleEvent(ViewType.WaitingView));
		}
	}
}