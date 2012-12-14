package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.house.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class HouseFrame extends Object implements Frame
    {
        private var _houseDialogFrame:HouseDialogFrame;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseFrame));

        public function HouseFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            this._houseDialogFrame = new HouseDialogFrame();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            switch(true)
            {
                case param1 is LeaveDialogAction:
                {
                    _loc_4 = param1 as LeaveDialogAction;
                    _loc_5 = new LeaveDialogRequestMessage();
                    _loc_5.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is HouseBuyAction:
                {
                    _loc_6 = param1 as HouseBuyAction;
                    _loc_7 = new HouseBuyRequestMessage();
                    _loc_7.initHouseBuyRequestMessage(_loc_6.proposedPrice);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is HouseSellAction:
                {
                    _loc_8 = param1 as HouseSellAction;
                    _loc_9 = new HouseSellRequestMessage();
                    _loc_9.initHouseSellRequestMessage(_loc_8.amount);
                    ConnectionsHandler.getConnection().send(_loc_9);
                    return true;
                }
                case param1 is HouseSellFromInsideAction:
                {
                    _loc_10 = param1 as HouseSellFromInsideAction;
                    _loc_11 = new HouseSellFromInsideRequestMessage();
                    _loc_11.initHouseSellFromInsideRequestMessage(_loc_10.amount);
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is PurchasableDialogMessage:
                {
                    _loc_12 = param1 as PurchasableDialogMessage;
                    _loc_13 = 0;
                    _loc_14 = "";
                    _loc_15 = _loc_12.purchasableId;
                    _loc_16 = this.getHouseInformations(_loc_12.purchasableId);
                    if (_loc_16)
                    {
                        _loc_13 = _loc_16.houseId;
                        _loc_14 = _loc_16.ownerName;
                    }
                    Kernel.getWorker().addFrame(this._houseDialogFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.PurchasableDialog, _loc_12.buyOrSell, _loc_12.price, _loc_16);
                    return true;
                }
                case param1 is HouseGuildNoneMessage:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.HouseGuildNone);
                    return true;
                }
                case param1 is HouseGuildRightsMessage:
                {
                    _loc_17 = param1 as HouseGuildRightsMessage;
                    _loc_18 = _loc_17.guildInfo.guildEmblem;
                    _loc_19 = EmblemWrapper.create(_loc_18.symbolShape, EmblemWrapper.UP, _loc_18.symbolColor);
                    _loc_20 = EmblemWrapper.create(_loc_18.backgroundShape, EmblemWrapper.BACK, _loc_18.backgroundColor);
                    _loc_21 = {upEmblem:_loc_19, backEmblem:_loc_20};
                    KernelEventsManager.getInstance().processCallback(HookList.HouseGuildRights, _loc_17.houseId, _loc_17.guildInfo.guildName, _loc_21, _loc_17.rights);
                    return true;
                }
                case param1 is HouseSoldMessage:
                {
                    _loc_22 = param1 as HouseSoldMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.HouseSold, _loc_22.houseId, _loc_22.realPrice, _loc_22.buyerName);
                    return true;
                }
                case param1 is HouseBuyResultMessage:
                {
                    _loc_23 = param1 as HouseBuyResultMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.HouseBuyResult, _loc_23.houseId, _loc_23.bought, _loc_23.realPrice, this.getHouseInformations(_loc_23.houseId).ownerName);
                    return true;
                }
                case param1 is HouseGuildRightsViewAction:
                {
                    _loc_24 = param1 as HouseGuildRightsViewAction;
                    _loc_25 = new HouseGuildRightsViewMessage();
                    ConnectionsHandler.getConnection().send(_loc_25);
                    return true;
                }
                case param1 is HouseGuildShareAction:
                {
                    _loc_26 = param1 as HouseGuildShareAction;
                    _loc_27 = new HouseGuildShareRequestMessage();
                    _loc_27.initHouseGuildShareRequestMessage(_loc_26.enabled, _loc_26.rights);
                    ConnectionsHandler.getConnection().send(_loc_27);
                    return true;
                }
                case param1 is HouseKickAction:
                {
                    _loc_28 = param1 as HouseKickAction;
                    _loc_29 = new HouseKickRequestMessage();
                    _loc_29.initHouseKickRequestMessage(_loc_28.id);
                    ConnectionsHandler.getConnection().send(_loc_29);
                    return true;
                }
                case param1 is HouseKickIndoorMerchantAction:
                {
                    _loc_30 = param1 as HouseKickIndoorMerchantAction;
                    _loc_31 = new HouseKickIndoorMerchantRequestMessage();
                    _loc_31.initHouseKickIndoorMerchantRequestMessage(_loc_30.cellId);
                    ConnectionsHandler.getConnection().send(_loc_31);
                    return true;
                }
                case param1 is LockableStateUpdateHouseDoorMessage:
                {
                    _loc_32 = param1 as LockableStateUpdateHouseDoorMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.LockableStateUpdateHouseDoor, _loc_32.houseId, _loc_32.locked);
                    return true;
                }
                case param1 is LockableShowCodeDialogMessage:
                {
                    _loc_33 = param1 as LockableShowCodeDialogMessage;
                    Kernel.getWorker().addFrame(this._houseDialogFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableShowCode, _loc_33.changeOrUse, _loc_33.codeSize);
                    return true;
                }
                case param1 is LockableChangeCodeAction:
                {
                    _loc_34 = param1 as LockableChangeCodeAction;
                    _loc_35 = new LockableChangeCodeMessage();
                    _loc_35.initLockableChangeCodeMessage(_loc_34.code);
                    ConnectionsHandler.getConnection().send(_loc_35);
                    return true;
                }
                case param1 is HouseLockFromInsideAction:
                {
                    _loc_36 = param1 as HouseLockFromInsideAction;
                    _loc_37 = new HouseLockFromInsideRequestMessage();
                    _loc_37.initHouseLockFromInsideRequestMessage(_loc_36.code);
                    ConnectionsHandler.getConnection().send(_loc_37);
                    return true;
                }
                case param1 is LockableCodeResultMessage:
                {
                    _loc_38 = param1 as LockableCodeResultMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.LockableCodeResult, _loc_38.result);
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
            return true;
        }// end function

        private function getHouseInformations(param1:uint) : HouseWrapper
        {
            var _loc_3:* = null;
            var _loc_2:* = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).housesInformations;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.houseId == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

    }
}
