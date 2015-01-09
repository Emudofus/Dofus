package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapListMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportDestinationsListMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.world.Hint;
    import com.ankamagames.dofus.logic.game.roleplay.actions.TeleportRequestAction;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportRequestMessage;
    import com.ankamagames.dofus.internalDatacenter.taxi.TeleportDestinationWrapper;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.RoleplayHookList;
    import com.ankamagames.dofus.network.enums.TeleporterTypeEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class ZaapFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));

        private var _priority:int = 0;
        private var _spawnMapId:uint;


        public function get spawnMapId():uint
        {
            return (this._spawnMapId);
        }

        public function get priority():int
        {
            return (this._priority);
        }

        public function set priority(p:int):void
        {
            this._priority = p;
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:ZaapListMessage;
            var _local_3:Array;
            var _local_4:TeleportDestinationsListMessage;
            var _local_5:Array;
            var _local_6:Vector.<Hint>;
            var _local_7:Hint;
            var _local_8:TeleportRequestAction;
            var _local_9:LeaveDialogMessage;
            var i:int;
            var trmsg:TeleportRequestMessage;
            switch (true)
            {
                case (msg is ZaapListMessage):
                    _local_2 = (msg as ZaapListMessage);
                    _local_3 = new Array();
                    i = 0;
                    while (i < _local_2.mapIds.length)
                    {
                        _local_3.push(new TeleportDestinationWrapper(_local_2.teleporterType, _local_2.mapIds[i], _local_2.subAreaIds[i], _local_2.destTeleporterType[i], _local_2.costs[i], (_local_2.spawnMapId == _local_2.mapIds[i])));
                        i++;
                    };
                    this._spawnMapId = _local_2.spawnMapId;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList, _local_3, TeleporterTypeEnum.TELEPORTER_ZAAP);
                    return (true);
                case (msg is TeleportDestinationsListMessage):
                    _local_4 = (msg as TeleportDestinationsListMessage);
                    _local_5 = new Array();
                    i = 0;
                    while (i < _local_4.mapIds.length)
                    {
                        if (_local_4.teleporterType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
                        {
                            _local_6 = TeleportDestinationWrapper.getHintsFromMapId(_local_4.mapIds[i]);
                            for each (_local_7 in _local_6)
                            {
                                _local_5.push(new TeleportDestinationWrapper(_local_4.teleporterType, _local_4.mapIds[i], _local_4.subAreaIds[i], TeleporterTypeEnum.TELEPORTER_SUBWAY, _local_4.costs[i], false, _local_7));
                            };
                        }
                        else
                        {
                            _local_5.push(new TeleportDestinationWrapper(_local_4.teleporterType, _local_4.mapIds[i], _local_4.subAreaIds[i], _local_4.destTeleporterType[i], _local_4.costs[i]));
                        };
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList, _local_5, _local_4.teleporterType);
                    return (true);
                case (msg is TeleportRequestAction):
                    _local_8 = (msg as TeleportRequestAction);
                    if (_local_8.cost <= PlayedCharacterManager.getInstance().characteristics.kamas)
                    {
                        trmsg = new TeleportRequestMessage();
                        trmsg.initTeleportRequestMessage(_local_8.teleportType, _local_8.mapId);
                        ConnectionsHandler.getConnection().send(trmsg);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.not_enough_rich"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is LeaveDialogRequestAction):
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_9 = (msg as LeaveDialogMessage);
                    if (_local_9.dialogType == DialogTypeEnum.DIALOG_TELEPORTER)
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

