package com.threekindoms.client.presentmodel
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.electrotank.electroserver5.api.MessageType;
    import com.electrotank.electroserver5.api.PluginMessageEvent;
    import com.electrotank.electroserver5.api.PluginRequest;
    import com.threekindoms.client.model.PluginActionType;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.plugins.IPluginAction;
    import com.threekindoms.client.services.ElectroServerService;
    import com.threekindoms.client.utils.PluginActionFactory;
    import com.threekindoms.client.vo.Card;
    import com.threekindoms.client.vo.Player;
    
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    public class PlayGamePm extends BasePresentModel
    {
        private var service:ElectroServerService;
        private var operatingCards:Array;
        private var _players:Array;
        private var _me:Player;
        private var playerByName:Dictionary = new Dictionary(true);

        public function set players(value:Array):void {
            this._players = value;
            storeAllPlayers();
        }

        public function get players():Array {
            return this._players;
        }

        public function getNamedPlayer(playerName:String):Player {
            return this.playerByName[playerName];
        }

        public function get me():Player {
            return this._me;
        }

        public function PlayGamePm(dispatcher:IEventDispatcher) {
            super(dispatcher);
            service = ElectroServerService.getInstance();
            service.addEventListener(MessageType.PluginMessageEvent.name, onPluginMessageEvent);
        }

        private function storeAllPlayers():void {
            var allPlayers:Array = this.players;
            for each (var name:String in allPlayers) {
                var player:Player = addPlayer(name);
                if (player.playerName == service.managerHelper.userManager.me.userName) {
                    _me = player;
                }
            }
        }

        //TODO: load player image
        private function addPlayer(name:String):Player {
            var player:Player = new Player();
            player.playerName = name;
            //TODO:load player image
            players.push(player);
            playerByName[name] = player;
            //TODO:other stuff, like position, attributes
            return player;
        }

        private function onPluginMessageEvent(event:PluginMessageEvent):void {
            var para:EsObject = event.parameters;
            extractData(para);
        }

        private function extractData(para:EsObject):void {
            var actions:Array = para.getStringArray(PluginConstants.ACTION_LIST);
            for each (var action:String in actions) {
                var pluginAction:IPluginAction = PluginActionFactory.getAction(action);
                pluginAction.action(para, this);
            }
        }

        public function cardChosen(card:Card):void {
            var para:EsObject = new EsObject();
            para.setString(PluginActionType.ACTION, PluginActionType.CARD_CHOSEN.actionName);
            var cardObject:EsObject = buildCardEsObject(card);
            para.setEsObject(PluginConstants.CARD_CHOSEN, cardObject);
            sendToPlugin(para);
        }

        public function operationChosen(operation:String):void {
            var para:EsObject = new EsObject();
            para.setString(PluginActionType.ACTION, PluginActionType.OPERATION_CHOSEN.actionName);
            var operationObj:EsObject = new EsObject();
            operationObj.setString(PluginConstants.OPERATION, operation);
            para.setEsObject(PluginConstants.OPERATION_CHOSEN, operationObj);
            sendToPlugin(para);
        }

        private function buildCardEsObject(card:Card):EsObject {
            var cardObject:EsObject = new EsObject();
            cardObject.setInteger(PluginConstants.X, card.x);
            cardObject.setInteger(PluginConstants.Y, card.y);
            return cardObject;
        }

        private function sendToPlugin(esob:EsObject):void {
            var pr:PluginRequest = new PluginRequest();
            pr.parameters = esob;
            pr.roomId = GameFlowPm.currentRoom.id;
            pr.zoneId = GameFlowPm.currentRoom.zoneId;
            pr.pluginName = PluginConstants.START_GAME_HANDLER;
            ElectroServerService.getInstance().send(pr);
        }
    }
}