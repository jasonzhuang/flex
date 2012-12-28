package com.threekindoms.client.plugins
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.threekindoms.client.events.StartGameEvent;
    import com.threekindoms.client.model.PluginConstants;

    import flash.events.IEventDispatcher;

    //TODO:server should change, server add startGame action
    public class StartGameAction implements IPluginAction
    {
        private static const messgae:String = "Both Ready, Start Game!";

        public function action(para:EsObject, dispatcher:IEventDispatcher):void
        {
            var players:Array = para.getStringArray(PluginConstants.PLAYERS);
            dispatcher.dispatchEvent(new StartGameEvent(messgae, players));
        }
    }
}
