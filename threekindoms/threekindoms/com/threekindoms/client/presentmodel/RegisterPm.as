package com.threekindoms.client.presentmodel
{
    import com.adobe.cairngorm.control.CairngormEventDispatcher;
    import com.electrotank.electroserver5.api.EsObject;
    import com.electrotank.electroserver5.api.LoginResponse;
    import com.electrotank.electroserver5.api.MessageType;
    import com.threekindoms.client.cairngormevents.RegisterRemoteEvent;
    import com.threekindoms.client.events.RegisterFailedEvent;
    import com.threekindoms.client.events.ViewToggleEvent;
    import com.threekindoms.client.model.PluginActionType;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.model.ViewType;
    import com.threekindoms.client.services.ElectroServerService;
    import com.threekindoms.client.vo.UserInfo;
    
    import flash.events.IEventDispatcher;

	public class RegisterPm extends BasePresentModel
	{
	    private var service:ElectroServerService;

		public function RegisterPm(eventDispatcher:IEventDispatcher)
		{
			super(eventDispatcher);
            service = ElectroServerService.getInstance();
            service.addEventListener(MessageType.LoginResponse.name, onLoginResponse);
		}

        private function onLoginResponse(e:LoginResponse):void {
            var actionName:String = e.esObject.getString(PluginActionType.ACTION);
            var result:EsObject = new EsObject();
            result.addAll(e.esObject);
            result.setString(PluginConstants.USERNAME, e.userName);
            if (e.successful){
                trace("Register successful, userName: " + result.getString(PluginConstants.USERNAME));
                this.dispatchEvent(new ViewToggleEvent(ViewType.GameFlowView));
            } else {
                this.dispatchEvent(new RegisterFailedEvent("Register failed " + result.getString(PluginConstants.ERRORCAUSE)));
            }
        }

        public function register(userInfo:UserInfo):void {
            CairngormEventDispatcher.getInstance().dispatchEvent(new RegisterRemoteEvent(userInfo));
            this.dispatchEvent(new ViewToggleEvent(ViewType.WaitingView));
        }
		
	}
}