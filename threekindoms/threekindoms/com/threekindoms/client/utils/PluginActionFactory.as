package com.threekindoms.client.utils
{
    import com.threekindoms.client.plugins.IPluginAction;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.plugins.MoveCardAction;
    import com.threekindoms.client.plugins.ChangePlayerAttributesAction;
    import com.threekindoms.client.plugins.OperationAction;
    import com.threekindoms.client.plugins.StartGameAction;
    import com.threekindoms.client.plugins.ChangePlayerStateAction;
    import com.threekindoms.client.model.PluginActionType;

    import flash.errors.IllegalOperationError;
    import flash.utils.Dictionary;

    public class PluginActionFactory {
        private static var registeredAction:Dictionary = new Dictionary(true);

        {
            registeredAction[PluginConstants.MOVE_CARD] = MoveCardAction;
            registeredAction[PluginConstants.CHANGE_PLAYER_ATTRIBUTE] = ChangePlayerAttributesAction;
            registeredAction[PluginConstants.OPERATION_LIST] = OperationAction;
            registeredAction[PluginActionType.CHANGEPLAYERSTATE.actionName] = ChangePlayerStateAction;
            registeredAction[PluginActionType.STARTGAME.actionName] = StartGameAction;
        }

        public static function getAction(name:String):IPluginAction {
            if (!registeredAction[name]) {
                throw new IllegalOperationError("action " + name + " is not register");
            }
            var clazz:Class = registeredAction[name];
            return new clazz() as IPluginAction;
        }
    }
}