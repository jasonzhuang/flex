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
    
	public class GameInitActionTest
	{
		private var server:ElectroServerService;
		[Before]
		public function init():void {
            server = ElectroServerService.getInstance();
		}

		[Test(async)]
		public function testGameInit():void {
			var aysnc:Function = Async.asyncHandler(this, gameInitHandler, 10000, null, initTimeOut); 
            server.addEventListener(MessageType.PluginMessageEvent.name, aysnc);
            
            var pluginEvent:PluginMessageEvent = new PluginMessageEvent(MessageType.PluginMessageEvent);
            var esObject:EsObject = new EsObject();
            esObject.setString(PluginActionType.ACTION, PluginActionType.GAME_INIT.actionName);
            var gameInfo:EsObject = new EsObject();
            gameInfo.setInteger(PluginConstants.INIT_PROVISION, 30);
            esObject.setEsObject(PluginConstants.GAME_INFO, gameInfo);
            pluginEvent.parameters = esObject;
            server.dispatchEvent(pluginEvent);
		}

        private function gameInitHandler(event:Event, data:Object):void {
        	var pluginEvent:PluginMessageEvent = PluginMessageEvent(event);
            var para:EsObject = pluginEvent.parameters;
            var gameInfo:EsObject = para.getEsObject(PluginConstants.GAME_INFO);
            var actionName:String = para.getString(PluginActionType.ACTION);
            var pluginAction:IPluginAction = PluginActionFactory.createPluginAction(PluginActionType.getPlugin(actionName));
            Assert.assertTrue(Object(pluginAction).constructor == GameInitAction);
            Assert.assertEquals(gameInfo.getInteger(PluginConstants.INIT_PROVISION), 30);
        }

        private function initTimeOut(event:Event, data:Object):void {
        	Assert.fail("Game init failed");
        }
	}
}