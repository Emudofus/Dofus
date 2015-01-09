package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellListMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellListMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellFilterAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellFilterMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellFilterAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellFilterMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellListRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellListRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellListRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellListRequestMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
    import com.ankamagames.dofus.logic.game.roleplay.types.Estate;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.RoleplayHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class EstateFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EstateFrame));

        private var _estateList:Array;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:HouseToSellListMessage;
            var _local_3:PaddockToSellListMessage;
            var _local_4:HouseToSellFilterAction;
            var _local_5:HouseToSellFilterMessage;
            var _local_6:PaddockToSellFilterAction;
            var _local_7:PaddockToSellFilterMessage;
            var _local_8:HouseToSellListRequestAction;
            var _local_9:HouseToSellListRequestMessage;
            var _local_10:PaddockToSellListRequestAction;
            var _local_11:PaddockToSellListRequestMessage;
            var _local_12:LeaveDialogRequestMessage;
            var house:HouseInformationsForSell;
            var estHouse:Estate;
            var paddock:PaddockInformationsForSell;
            var estPaddock:Estate;
            switch (true)
            {
                case (msg is HouseToSellListMessage):
                    _local_2 = (msg as HouseToSellListMessage);
                    this._estateList = new Array();
                    for each (house in _local_2.houseList)
                    {
                        estHouse = new Estate(house);
                        this._estateList.push(estHouse);
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList, this._estateList, _local_2.pageIndex, _local_2.totalPage, 0);
                    return (true);
                case (msg is PaddockToSellListMessage):
                    _local_3 = (msg as PaddockToSellListMessage);
                    this._estateList = new Array();
                    for each (paddock in _local_3.paddockList)
                    {
                        estPaddock = new Estate(paddock);
                        this._estateList.push(estPaddock);
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList, this._estateList, _local_3.pageIndex, _local_3.totalPage, 1);
                    return (true);
                case (msg is HouseToSellFilterAction):
                    _local_4 = (msg as HouseToSellFilterAction);
                    _local_5 = new HouseToSellFilterMessage();
                    _local_5.initHouseToSellFilterMessage(_local_4.areaId, _local_4.atLeastNbRoom, _local_4.atLeastNbChest, _local_4.skillRequested, _local_4.maxPrice);
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is PaddockToSellFilterAction):
                    _local_6 = (msg as PaddockToSellFilterAction);
                    _local_7 = new PaddockToSellFilterMessage();
                    _local_7.initPaddockToSellFilterMessage(_local_6.areaId, _local_6.atLeastNbMount, _local_6.atLeastNbMachine, _local_6.maxPrice);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is HouseToSellListRequestAction):
                    _local_8 = (msg as HouseToSellListRequestAction);
                    _local_9 = new HouseToSellListRequestMessage();
                    _local_9.initHouseToSellListRequestMessage(_local_8.pageIndex);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is PaddockToSellListRequestAction):
                    _local_10 = (msg as PaddockToSellListRequestAction);
                    _local_11 = new PaddockToSellListRequestMessage();
                    _local_11.initPaddockToSellListRequestMessage(_local_10.pageIndex);
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is LeaveDialogRequestAction):
                    _local_12 = new LeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_12);
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

