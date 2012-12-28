package com.threekindoms.client.presentmodel
{
    import com.electrotank.electroserver5.api.CreateRoomRequest;
    import com.electrotank.electroserver5.api.EsObject;
    import com.electrotank.electroserver5.api.GenericErrorResponse;
    import com.electrotank.electroserver5.api.JoinRoomEvent;
    import com.electrotank.electroserver5.api.JoinRoomRequest;
    import com.electrotank.electroserver5.api.LeaveRoomEvent;
    import com.electrotank.electroserver5.api.LeaveRoomRequest;
    import com.electrotank.electroserver5.api.MessageType;
    import com.electrotank.electroserver5.api.PluginListEntry;
    import com.electrotank.electroserver5.api.PluginMessageEvent;
    import com.electrotank.electroserver5.api.PluginRequest;
    import com.electrotank.electroserver5.zone.Room;
    import com.threekindoms.client.events.GameStateEvent;
    import com.threekindoms.client.events.LogEvent;
    import com.threekindoms.client.events.StartGameEvent;
    import com.threekindoms.client.events.ViewToggleEvent;
    import com.threekindoms.client.plugins.IPluginAction;
    import com.threekindoms.client.model.PluginActionType;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.model.ViewType;
    import com.threekindoms.client.services.ElectroServerService;
    import com.threekindoms.client.utils.PluginActionFactory;
    import com.threekindoms.client.vo.RoomInfo;

    import flash.events.IEventDispatcher;

    public class GameFlowPm extends BasePresentModel
    {
        private var logMessage:String;

        public static var currentRoom:Room = new Room();
        private var service:ElectroServerService;
        private var pluginAction:IPluginAction;

        public function GameFlowPm(eventDispatcher:IEventDispatcher)
        {
            super(eventDispatcher);
            service = ElectroServerService.getInstance();
            service.addEventListener(MessageType.LeaveRoomEvent.name, onLeaveRoomEvent);
            service.addEventListener(MessageType.JoinRoomEvent.name, onJoinRoomEvent);
            service.addEventListener(MessageType.GenericErrorResponse.name, onGenericErrorResponse);
//            service.addEventListener(MessageType.PluginMessageEvent.name, onPluginMessageEvent);
        }

//        private function onPluginMessageEvent(e:PluginMessageEvent):void
//        {
//            var para:EsObject = e.parameters;
//            var actionName:String = para.getString(PluginActionType.ACTION);
//            pluginAction = PluginActionFactory.getAction(actionName);
//            pluginAction.action(para, this);
//        }

        private function onJoinRoomEvent(e:JoinRoomEvent):void
        {
            this.setChatLog("Joined room roomName: " + e.roomName + ", roomID: " + e.roomId);
            var room:Room = ElectroServerService.getInstance().managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
            currentRoom = room;
        }

        private function onLeaveRoomEvent(e:LeaveRoomEvent):void
        {
            this.setChatLog("Left room");
            this.dispatchEvent(new ViewToggleEvent(ViewType.GameFlowView));
        }

        private function onGenericErrorResponse(e:GenericErrorResponse):void
        {
            setChatLog("Error: " + e.errorType.name);
        }

        public function joinRoom(roomInfo:RoomInfo):void
        {
            if (currentRoom.isJoined)
            {
                logMessage = "You have joined a room, not permitted to join another rooms!";
                this.dispatchEvent(new LogEvent(logMessage));
            }
            else
            {
                var crr:JoinRoomRequest = new JoinRoomRequest();
                crr.zoneName = PluginConstants.ZONE_NAME;
                crr.roomName = roomInfo.rooName;
//                crr.password = roomInfo.password;
                ElectroServerService.getInstance().send(crr);
            }
        }

        public function createRoom(roomInfo:RoomInfo):void
        {
            if (currentRoom.isJoined)
            {
                logMessage = "You have joined a room, not permitted to create another rooms!";
                this.dispatchEvent(new LogEvent(logMessage));
            }
            else
            {
                var crr:CreateRoomRequest = new CreateRoomRequest();
                crr.zoneName = PluginConstants.ZONE_NAME;
                crr.roomName = roomInfo.rooName;
//                crr.password = roomInfo.password;
                crr.capacity = PluginConstants.CAPACITY;

                var pl:PluginListEntry = new PluginListEntry();
                pl.extensionName = PluginConstants.LOGIN_JOIN_ROOM_EXTENSION;
                pl.pluginHandle = PluginConstants.START_GAME_HANDLER;
                pl.pluginName = PluginConstants.START_GAME_HANDLER;
                crr.plugins = [pl];

                ElectroServerService.getInstance().send(crr);
            }
        }

        public function leaveRoom(room:Room):void
        {
            logMessage = "LeaveRoomRequest for roomName: " + currentRoom.name;
            this.dispatchEvent(new LogEvent(logMessage));

            if (currentRoom.isJoined)
            {
                var lrr:LeaveRoomRequest = new LeaveRoomRequest();
                lrr.roomId = currentRoom.id;
                lrr.zoneId = currentRoom.zoneId;
                ElectroServerService.getInstance().send(lrr);
            }
            else
            {
                logMessage = "You aren't joined to that room!";
                this.dispatchEvent(new LogEvent(logMessage));
            }
        }

        public function changeState(room:Room):void
        {
            if (!currentRoom.isJoined)
            {
                logMessage = "You are not in a room!";
                this.dispatchEvent(new LogEvent(logMessage));
            }
            else
            {
                var pr:PluginRequest = new PluginRequest();

                var para:EsObject = new EsObject();

                para.setString(PluginActionType.ACTION, PluginActionType.CHANGEPLAYERSTATE.actionName);

                pr.roomId = currentRoom.id;
                pr.zoneId = currentRoom.zoneId;
                pr.pluginName = PluginConstants.START_GAME_HANDLER;

                pr.parameters = para;
                ElectroServerService.getInstance().send(pr);
            }
        }

        private function setChatLog(log:String):void
        {
            this.dispatchEvent(new LogEvent(log));
        }
    }
}
