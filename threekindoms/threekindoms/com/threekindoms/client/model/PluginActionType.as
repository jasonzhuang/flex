package com.threekindoms.client.model
{
    import com.threekindoms.client.plugins.StartGameAction;
    import com.threekindoms.client.plugins.ChangePlayerStateAction;
    import flash.utils.Dictionary;

    public class PluginActionType
    {
        private var _actionName:String;

        private static const map:Dictionary = new Dictionary(true);

        {
            map[STARTGAME.actionName] = StartGameAction;
            map[CHANGEPLAYERSTATE.actionName] = ChangePlayerStateAction;
            
        }

        public function get actionName():String
        {
            return this._actionName;
        }

        public function PluginActionType(actionName:String)
        {
            this._actionName = actionName;
        }

        public static function getPlugin(actionName:String):Class
        {
            if (map[actionName] == null)
            {
                throw new Error("the action " + actionName + " is not registered");
            }
            return map[actionName];
        }

        public static const ACTION:String = "ACTION";
        public static const LOGIN:PluginActionType = new PluginActionType("LOGIN");
        public static const REGISTER:PluginActionType = new PluginActionType("REGISTER");
        public static const STARTGAME:PluginActionType = new PluginActionType("STARTGAME");
        public static const CHANGEPLAYERSTATE:PluginActionType = new PluginActionType("CHANGEPLAYERSTATE");
        public static const CARD_CHOSEN:PluginActionType = new PluginActionType("CARD_CHOSEN");
        public static const OPERATION_CHOSEN:PluginActionType = new PluginActionType("OPERATION_CHOSEN");

        public static const ACTION_LIST:PluginActionType = new PluginActionType("ACTION_LIST");
    }
}
