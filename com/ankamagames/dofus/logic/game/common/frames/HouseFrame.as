package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseBuyAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseBuyRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseSellAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseSellFromInsideAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellFromInsideRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable.PurchasableDialogMessage;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildRightsMessage;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSoldMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseBuyResultMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsViewAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildRightsViewMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseGuildShareAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildShareRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseKickAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseKickIndoorMerchantAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableStateUpdateHouseDoorMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableShowCodeDialogMessage;
    import com.ankamagames.dofus.logic.game.common.actions.LockableChangeCodeAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableChangeCodeMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseLockFromInsideAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseLockFromInsideRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableCodeResultMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildNoneMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import flash.utils.Dictionary;

    public class HouseFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseFrame));

        private var _houseDialogFrame:HouseDialogFrame;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            this._houseDialogFrame = new HouseDialogFrame();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var i:int;
            var housesListSize:int;
            var _local_4:LeaveDialogAction;
            var _local_5:LeaveDialogRequestMessage;
            var _local_6:HouseBuyAction;
            var _local_7:HouseBuyRequestMessage;
            var _local_8:HouseSellAction;
            var _local_9:HouseSellRequestMessage;
            var _local_10:HouseSellFromInsideAction;
            var _local_11:HouseSellFromInsideRequestMessage;
            var _local_12:PurchasableDialogMessage;
            var _local_13:int;
            var _local_14:String;
            var _local_15:uint;
            var _local_16:HouseWrapper;
            var _local_17:HouseGuildRightsMessage;
            var _local_18:GuildEmblem;
            var _local_19:EmblemWrapper;
            var _local_20:EmblemWrapper;
            var _local_21:Object;
            var _local_22:HouseSoldMessage;
            var _local_23:HouseBuyResultMessage;
            var _local_24:HouseGuildRightsViewAction;
            var _local_25:HouseGuildRightsViewMessage;
            var _local_26:HouseGuildShareAction;
            var _local_27:HouseGuildShareRequestMessage;
            var _local_28:HouseKickAction;
            var _local_29:HouseKickRequestMessage;
            var _local_30:HouseKickIndoorMerchantAction;
            var _local_31:HouseKickIndoorMerchantRequestMessage;
            var _local_32:LockableStateUpdateHouseDoorMessage;
            var _local_33:LockableShowCodeDialogMessage;
            var _local_34:LockableChangeCodeAction;
            var _local_35:LockableChangeCodeMessage;
            var _local_36:HouseLockFromInsideAction;
            var _local_37:HouseLockFromInsideRequestMessage;
            var _local_38:LockableCodeResultMessage;
            switch (true)
            {
                case (msg is LeaveDialogAction):
                    _local_4 = (msg as LeaveDialogAction);
                    _local_5 = new LeaveDialogRequestMessage();
                    _local_5.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is HouseBuyAction):
                    _local_6 = (msg as HouseBuyAction);
                    _local_7 = new HouseBuyRequestMessage();
                    _local_7.initHouseBuyRequestMessage(_local_6.proposedPrice);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is HouseSellAction):
                    _local_8 = (msg as HouseSellAction);
                    _local_9 = new HouseSellRequestMessage();
                    _local_9.initHouseSellRequestMessage(_local_8.amount);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is HouseSellFromInsideAction):
                    _local_10 = (msg as HouseSellFromInsideAction);
                    _local_11 = new HouseSellFromInsideRequestMessage();
                    _local_11.initHouseSellFromInsideRequestMessage(_local_10.amount);
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is PurchasableDialogMessage):
                    _local_12 = (msg as PurchasableDialogMessage);
                    _local_13 = 0;
                    _local_14 = "";
                    _local_15 = _local_12.purchasableId;
                    _local_16 = this.getHouseInformations(_local_12.purchasableId);
                    if (_local_16)
                    {
                        _local_13 = _local_16.houseId;
                        _local_14 = _local_16.ownerName;
                    };
                    Kernel.getWorker().addFrame(this._houseDialogFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.PurchasableDialog, _local_12.buyOrSell, _local_12.price, _local_16);
                    return (true);
                case (msg is HouseGuildNoneMessage):
                    KernelEventsManager.getInstance().processCallback(HookList.HouseGuildNone);
                    return (true);
                case (msg is HouseGuildRightsMessage):
                    _local_17 = (msg as HouseGuildRightsMessage);
                    _local_18 = _local_17.guildInfo.guildEmblem;
                    _local_19 = EmblemWrapper.create(_local_18.symbolShape, EmblemWrapper.UP, _local_18.symbolColor);
                    _local_20 = EmblemWrapper.create(_local_18.backgroundShape, EmblemWrapper.BACK, _local_18.backgroundColor);
                    _local_21 = {
                        "upEmblem":_local_19,
                        "backEmblem":_local_20
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseGuildRights, _local_17.houseId, _local_17.guildInfo.guildName, _local_21, _local_17.rights);
                    return (true);
                case (msg is HouseSoldMessage):
                    _local_22 = (msg as HouseSoldMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.HouseSold, _local_22.houseId, _local_22.realPrice, _local_22.buyerName);
                    return (true);
                case (msg is HouseBuyResultMessage):
                    _local_23 = (msg as HouseBuyResultMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.HouseBuyResult, _local_23.houseId, _local_23.bought, _local_23.realPrice, this.getHouseInformations(_local_23.houseId).ownerName);
                    return (true);
                case (msg is HouseGuildRightsViewAction):
                    _local_24 = (msg as HouseGuildRightsViewAction);
                    _local_25 = new HouseGuildRightsViewMessage();
                    ConnectionsHandler.getConnection().send(_local_25);
                    return (true);
                case (msg is HouseGuildShareAction):
                    _local_26 = (msg as HouseGuildShareAction);
                    _local_27 = new HouseGuildShareRequestMessage();
                    _local_27.initHouseGuildShareRequestMessage(_local_26.enabled, _local_26.rights);
                    ConnectionsHandler.getConnection().send(_local_27);
                    return (true);
                case (msg is HouseKickAction):
                    _local_28 = (msg as HouseKickAction);
                    _local_29 = new HouseKickRequestMessage();
                    _local_29.initHouseKickRequestMessage(_local_28.id);
                    ConnectionsHandler.getConnection().send(_local_29);
                    return (true);
                case (msg is HouseKickIndoorMerchantAction):
                    _local_30 = (msg as HouseKickIndoorMerchantAction);
                    _local_31 = new HouseKickIndoorMerchantRequestMessage();
                    _local_31.initHouseKickIndoorMerchantRequestMessage(_local_30.cellId);
                    ConnectionsHandler.getConnection().send(_local_31);
                    return (true);
                case (msg is LockableStateUpdateHouseDoorMessage):
                    _local_32 = (msg as LockableStateUpdateHouseDoorMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableStateUpdateHouseDoor, _local_32.houseId, _local_32.locked);
                    return (true);
                case (msg is LockableShowCodeDialogMessage):
                    _local_33 = (msg as LockableShowCodeDialogMessage);
                    Kernel.getWorker().addFrame(this._houseDialogFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableShowCode, _local_33.changeOrUse, _local_33.codeSize);
                    return (true);
                case (msg is LockableChangeCodeAction):
                    _local_34 = (msg as LockableChangeCodeAction);
                    _local_35 = new LockableChangeCodeMessage();
                    _local_35.initLockableChangeCodeMessage(_local_34.code);
                    ConnectionsHandler.getConnection().send(_local_35);
                    return (true);
                case (msg is HouseLockFromInsideAction):
                    _local_36 = (msg as HouseLockFromInsideAction);
                    _local_37 = new HouseLockFromInsideRequestMessage();
                    _local_37.initHouseLockFromInsideRequestMessage(_local_36.code);
                    ConnectionsHandler.getConnection().send(_local_37);
                    return (true);
                case (msg is LockableCodeResultMessage):
                    _local_38 = (msg as LockableCodeResultMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableCodeResult, _local_38.result);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function getHouseInformations(houseID:uint):HouseWrapper
        {
            var hi:HouseWrapper;
            var houseList:Dictionary = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).housesInformations;
            for each (hi in houseList)
            {
                if (hi.houseId == houseID)
                {
                    return (hi);
                };
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

