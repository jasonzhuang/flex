package com.threekindoms.client.plugins
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.threekindoms.client.events.GameStateEvent;
    import com.threekindoms.client.model.PluginConstants;
    
    import flash.events.IEventDispatcher;
    
    public class ChangePlayerStateAction implements IPluginAction
    {
        public function action(para:EsObject, dispatcher:IEventDispatcher):void {
            var esObject:EsObject = para;
            var message:String;
            var userName:String = esObject.getString(PluginConstants.USERNAME);
            if (esObject.getBoolean(PluginConstants.GETREADY)) {
                message = userName + " get ready! \n";
            } else {
                message = userName + " exit ready! \n";
            }
            dispatcher.dispatchEvent(new GameStateEvent(message));
       }
    }
}