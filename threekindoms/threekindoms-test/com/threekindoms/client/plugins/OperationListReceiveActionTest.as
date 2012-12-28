package com.threekindoms.client.plugins
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.electrotank.electroserver5.api.MessageType;
    import com.electrotank.electroserver5.api.PluginMessageEvent;
    import com.threekindoms.client.model.IPluginAction;
    import com.threekindoms.client.model.PluginActionType;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.services.ElectroServerService;
    import com.threekindoms.client.utils.PluginActionFactory;
    
    import flash.events.Event;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;

	public class OperationListReceiveActionTest
	{
        private var server:ElectroServerService;

        [Before]
        public function init():void {
            server = ElectroServerService.getInstance();
        }

        [Test(async)]
        public function testGameInit():void {
            var aysnc:Function = Async.asyncHandler(this, operationReceiveHandler, 10000, null, initTimeOut); 
            server.addEventListener(MessageType.PluginMessageEvent.name, aysnc);
            
            var pluginEvent:PluginMessageEvent = new PluginMessageEvent(MessageType.PluginMessageEvent);
            var esObject:EsObject = new EsObject();
            esObject.setString(PluginActionType.ACTION, PluginActionType.OPERATION_REVEIVE.actionName);
            var operationInfo:EsObject = new EsObject();
            operationInfo.setBoolean(PluginConstants.CANCEL_ENABLE, true);
            esObject.setEsObject(PluginConstants.OPERATION_INFO, operationInfo);
            pluginEvent.parameters = esObject;
            server.dispatchEvent(pluginEvent);
        }

        private function operationReceiveHandler(event:Event, data:Object):void {
            var pluginEvent:PluginMessageEvent = PluginMessageEvent(event);
            var para:EsObject = pluginEvent.parameters;
            var operationInfo:EsObject = para.getEsObject(PluginConstants.OPERATION_INFO);
            var actionName:String = para.getString(PluginActionType.ACTION);
            var pluginAction:IPluginAction = PluginActionFactory.createPluginAction(PluginActionType.getPlugin(actionName));
            Assert.assertTrue(Object(pluginAction).constructor == OperationListReceiveAction);
            Assert.assertTrue(operationInfo.getBoolean(PluginConstants.CANCEL_ENABLE));
        }

        private function initTimeOut(event:Event, data:Object):void {
            Assert.fail("Game init failed");
        }
	}
}