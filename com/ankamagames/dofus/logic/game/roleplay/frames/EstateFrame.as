package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.estate.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class EstateFrame extends Object implements Frame
    {
        private var _estateList:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EstateFrame));

        public function EstateFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:HouseToSellListMessage = null;
            var _loc_3:PaddockToSellListMessage = null;
            var _loc_4:HouseToSellFilterAction = null;
            var _loc_5:HouseToSellFilterMessage = null;
            var _loc_6:PaddockToSellFilterAction = null;
            var _loc_7:PaddockToSellFilterMessage = null;
            var _loc_8:HouseToSellListRequestAction = null;
            var _loc_9:HouseToSellListRequestMessage = null;
            var _loc_10:PaddockToSellListRequestAction = null;
            var _loc_11:PaddockToSellListRequestMessage = null;
            var _loc_12:LeaveDialogRequestMessage = null;
            var _loc_13:HouseInformationsForSell = null;
            var _loc_14:Estate = null;
            var _loc_15:PaddockInformationsForSell = null;
            var _loc_16:Estate = null;
            switch(true)
            {
                case param1 is HouseToSellListMessage:
                {
                    _loc_2 = param1 as HouseToSellListMessage;
                    this._estateList = new Array();
                    for each (_loc_13 in _loc_2.houseList)
                    {
                        
                        _loc_14 = new Estate(_loc_13);
                        this._estateList.push(_loc_14);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList, this._estateList, _loc_2.pageIndex, _loc_2.totalPage, 0);
                    return true;
                }
                case param1 is PaddockToSellListMessage:
                {
                    _loc_3 = param1 as PaddockToSellListMessage;
                    this._estateList = new Array();
                    for each (_loc_15 in _loc_3.paddockList)
                    {
                        
                        _loc_16 = new Estate(_loc_15);
                        this._estateList.push(_loc_16);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList, this._estateList, _loc_3.pageIndex, _loc_3.totalPage, 1);
                    return true;
                }
                case param1 is HouseToSellFilterAction:
                {
                    _loc_4 = param1 as HouseToSellFilterAction;
                    _loc_5 = new HouseToSellFilterMessage();
                    _loc_5.initHouseToSellFilterMessage(_loc_4.areaId, _loc_4.atLeastNbRoom, _loc_4.atLeastNbChest, _loc_4.skillRequested, _loc_4.maxPrice);
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is PaddockToSellFilterAction:
                {
                    _loc_6 = param1 as PaddockToSellFilterAction;
                    _loc_7 = new PaddockToSellFilterMessage();
                    _loc_7.initPaddockToSellFilterMessage(_loc_6.areaId, _loc_6.atLeastNbMount, _loc_6.atLeastNbMachine, _loc_6.maxPrice);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is HouseToSellListRequestAction:
                {
                    _loc_8 = param1 as HouseToSellListRequestAction;
                    _loc_9 = new HouseToSellListRequestMessage();
                    _loc_9.initHouseToSellListRequestMessage(_loc_8.pageIndex);
                    ConnectionsHandler.getConnection().send(_loc_9);
                    return true;
                }
                case param1 is PaddockToSellListRequestAction:
                {
                    _loc_10 = param1 as PaddockToSellListRequestAction;
                    _loc_11 = new PaddockToSellListRequestMessage();
                    _loc_11.initPaddockToSellListRequestMessage(_loc_10.pageIndex);
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    _loc_12 = new LeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_12);
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
