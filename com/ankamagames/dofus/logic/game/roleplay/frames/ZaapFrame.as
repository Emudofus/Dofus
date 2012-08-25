package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.taxi.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.utils.*;

    public class ZaapFrame extends Object implements Frame
    {
        private var _priority:int = 0;
        private var _spawnMapId:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));

        public function ZaapFrame()
        {
            return;
        }// end function

        public function get spawnMapId() : uint
        {
            return this._spawnMapId;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function set priority(param1:int) : void
        {
            this._priority = param1;
            return;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:ZaapListMessage = null;
            var _loc_3:Array = null;
            var _loc_4:TeleportDestinationsListMessage = null;
            var _loc_5:Array = null;
            var _loc_6:Vector.<Hint> = null;
            var _loc_7:Hint = null;
            var _loc_8:TeleportRequestAction = null;
            var _loc_9:int = 0;
            var _loc_10:TeleportRequestMessage = null;
            switch(true)
            {
                case param1 is ZaapListMessage:
                {
                    _loc_2 = param1 as ZaapListMessage;
                    _loc_3 = new Array();
                    _loc_9 = 0;
                    while (_loc_9 < _loc_2.mapIds.length)
                    {
                        
                        _loc_3.push(new TeleportDestinationWrapper(_loc_2.teleporterType, _loc_2.mapIds[_loc_9], _loc_2.subAreaIds[_loc_9], _loc_2.costs[_loc_9], _loc_2.spawnMapId == _loc_2.mapIds[_loc_9]));
                        _loc_9++;
                    }
                    this._spawnMapId = _loc_2.spawnMapId;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList, _loc_3, TeleporterTypeEnum.TELEPORTER_ZAAP);
                    return true;
                }
                case param1 is TeleportDestinationsListMessage:
                {
                    _loc_4 = param1 as TeleportDestinationsListMessage;
                    _loc_5 = new Array();
                    _loc_9 = 0;
                    while (_loc_9 < _loc_4.mapIds.length)
                    {
                        
                        if (_loc_4.teleporterType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
                        {
                            _loc_6 = TeleportDestinationWrapper.getHintsFromMapId(_loc_4.mapIds[_loc_9]);
                            for each (_loc_7 in _loc_6)
                            {
                                
                                _loc_5.push(new TeleportDestinationWrapper(_loc_4.teleporterType, _loc_4.mapIds[_loc_9], _loc_4.subAreaIds[_loc_9], _loc_4.costs[_loc_9], false, _loc_7));
                            }
                        }
                        else
                        {
                            _loc_5.push(new TeleportDestinationWrapper(_loc_4.teleporterType, _loc_4.mapIds[_loc_9], _loc_4.subAreaIds[_loc_9], _loc_4.costs[_loc_9]));
                        }
                        _loc_9++;
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList, _loc_5, _loc_4.teleporterType);
                    return true;
                }
                case param1 is TeleportRequestAction:
                {
                    _loc_8 = param1 as TeleportRequestAction;
                    if (_loc_8.cost <= PlayedCharacterManager.getInstance().characteristics.kamas)
                    {
                        _loc_10 = new TeleportRequestMessage();
                        _loc_10.initTeleportRequestMessage(_loc_8.teleportType, _loc_8.mapId);
                        ConnectionsHandler.getConnection().send(_loc_10);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.not_enough_rich"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is LeaveDialogMessage:
                {
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                    Kernel.getWorker().removeFrame(this);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return true;
        }// end function

    }
}
