package com.threekindoms.client.presentmodel
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.electrotank.electroserver5.api.LoginResponse;
    import com.threekindoms.client.cairngormevents.LoginRemoteEvent;
    import com.threekindoms.client.events.LoginFailedEvent;
    import com.threekindoms.client.events.ViewToggleEvent;
    import com.threekindoms.client.plugins.IPluginAction;
    import com.threekindoms.client.model.PluginActionType;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.model.ViewType;
    import com.threekindoms.client.services.ElectroServerService;
    import com.threekindoms.client.events.LogEvent;
	import flash.events.IEventDispatcher;
	import com.electrotank.electroserver5.api.MessageType;
    import com.threekindoms.client.utils.PluginActionFactory;

	public class WaitingPm extends BasePresentModel
	{
        private var result:EsObject;
	
		public function WaitingPm(dispatcher:IEventDispatcher) {
			super(dispatcher);
            ElectroServerService.getInstance().addEventListener(MessageType.LoginResponse.name,  onLoginResponse);
		}
		
        private function onLoginResponse(e:LoginResponse):void {
//            var actionName:String = e.esObject.getString(PluginActionType.ACTION);
//            var result:EsObject = new EsObject();
//            result.addAll(e.esObject);
//            result.setString(PluginConstants.USERNAME, e.userName);
            if (e.successful) {
                this.dispatchEvent(new ViewToggleEvent(ViewType.GameFlowView));
            } else {
                this.dispatchEvent(new LoginFailedEvent("Login Failed " + result.getString(PluginConstants.ERRORCAUSE)));
            }
              this.dispatchEvent(new ViewToggleEvent(ViewType.GameFlowView));
        }

        public function setLog(message:String):void {
        	this.dispatchEvent(new LogEvent(message));
        }
	}
}