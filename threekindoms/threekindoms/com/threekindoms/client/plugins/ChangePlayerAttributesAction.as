package com.threekindoms.client.plugins
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.threekindoms.client.events.ChangePlayerAttributesEvent;
    import com.threekindoms.client.model.PluginConstants;
    
    import flash.events.IEventDispatcher;

    //TODO: rollback to add playerName
    public class ChangePlayerAttributesAction implements IPluginAction
    {
        public function action(para:EsObject, dispatcher:IEventDispatcher):void {
            var playerName:String = para.getString(PluginConstants.PLAYER_NAME);
            var data:Array = para.getEsObjectArray(PluginConstants.CHANGE_PLAYER_ATTRIBUTE);
            var playerAttributes:Array;
            var playerAttribute:Array;
            for each(var es:EsObject in data) {
                playerAttribute = es.getIntegerArray(PluginConstants.PLAYER_ATTRIBUTES);
                playerAttributes.push(playerAttribute);
            }
            dispatcher.dispatchEvent(new ChangePlayerAttributesEvent(playerAttributes, playerName));
        }
    }
}