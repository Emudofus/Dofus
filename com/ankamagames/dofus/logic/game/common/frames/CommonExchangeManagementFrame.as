package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.*;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class CommonExchangeManagementFrame extends Object implements Frame
    {
        private var _exchangeType:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonExchangeManagementFrame));

        public function CommonExchangeManagementFrame(param1:uint)
        {
            this._exchangeType = param1;
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get craftFrame() : CraftFrame
        {
            return Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:LeaveDialogRequestMessage = null;
            var _loc_3:BidHouseManagementFrame = null;
            var _loc_4:ExchangeAcceptMessage = null;
            var _loc_5:LeaveDialogRequestMessage = null;
            var _loc_6:ExchangeReadyAction = null;
            var _loc_7:ExchangeReadyMessage = null;
            var _loc_8:ExchangeObjectModifiedMessage = null;
            var _loc_9:ItemWrapper = null;
            var _loc_10:ExchangeObjectAddedMessage = null;
            var _loc_11:ItemWrapper = null;
            var _loc_12:ExchangeObjectRemovedMessage = null;
            var _loc_13:ExchangeObjectMoveAction = null;
            var _loc_14:ExchangeObjectMoveMessage = null;
            var _loc_15:ExchangeIsReadyMessage = null;
            var _loc_16:RoleplayEntitiesFrame = null;
            var _loc_17:String = null;
            var _loc_18:ExchangeKamaModifiedMessage = null;
            switch(true)
            {
                case param1 is LeaveShopStockAction:
                {
                    _loc_2 = new LeaveDialogRequestMessage();
                    _loc_2.initLeaveDialogRequestMessage();
                    _loc_3 = Kernel.getWorker().getFrame(BidHouseManagementFrame) as BidHouseManagementFrame;
                    if (_loc_3)
                    {
                        _loc_3.switching = false;
                    }
                    ConnectionsHandler.getConnection().send(_loc_2);
                    return true;
                }
                case param1 is ExchangeAcceptAction:
                {
                    _loc_4 = new ExchangeAcceptMessage();
                    _loc_4.initExchangeAcceptMessage();
                    ConnectionsHandler.getConnection().send(_loc_4);
                    return true;
                }
                case param1 is ExchangeRefuseAction:
                {
                    _loc_5 = new LeaveDialogRequestMessage();
                    _loc_5.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is ExchangeReadyAction:
                {
                    _loc_6 = param1 as ExchangeReadyAction;
                    _loc_7 = new ExchangeReadyMessage();
                    _loc_7.initExchangeReadyMessage(_loc_6.isReady);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is ExchangeObjectModifiedMessage:
                {
                    _loc_8 = param1 as ExchangeObjectModifiedMessage;
                    _loc_9 = ItemWrapper.create(_loc_8.object.position, _loc_8.object.objectUID, _loc_8.object.objectGID, _loc_8.object.quantity, _loc_8.object.effects, false);
                    switch(this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                        {
                            this.craftFrame.modifyCraftComponent(_loc_8.remote, _loc_9);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectModified, _loc_9);
                    return true;
                }
                case param1 is ExchangeObjectAddedMessage:
                {
                    _loc_10 = param1 as ExchangeObjectAddedMessage;
                    _loc_11 = ItemWrapper.create(_loc_10.object.position, _loc_10.object.objectUID, _loc_10.object.objectGID, _loc_10.object.quantity, _loc_10.object.effects, false);
                    switch(this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                        {
                            this.craftFrame.addCraftComponent(_loc_10.remote, _loc_11);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectAdded, _loc_11);
                    return true;
                }
                case param1 is ExchangeObjectRemovedMessage:
                {
                    _loc_12 = param1 as ExchangeObjectRemovedMessage;
                    switch(this._exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                        {
                            this.craftFrame.removeCraftComponent(_loc_12.remote, _loc_12.objectUID);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeObjectRemoved, _loc_12.objectUID);
                    return true;
                }
                case param1 is ExchangeObjectMoveAction:
                {
                    _loc_13 = param1 as ExchangeObjectMoveAction;
                    _loc_14 = new ExchangeObjectMoveMessage();
                    _loc_14.initExchangeObjectMoveMessage(_loc_13.objectUID, _loc_13.quantity);
                    ConnectionsHandler.getConnection().send(_loc_14);
                    return true;
                }
                case param1 is ExchangeIsReadyMessage:
                {
                    _loc_15 = param1 as ExchangeIsReadyMessage;
                    _loc_16 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                    _loc_17 = (_loc_16.getEntityInfos(_loc_15.id) as GameRolePlayNamedActorInformations).name;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeIsReady, _loc_17, _loc_15.ready);
                    return true;
                }
                case param1 is ExchangeKamaModifiedMessage:
                {
                    _loc_18 = param1 as ExchangeKamaModifiedMessage;
                    if (!_loc_18.remote)
                    {
                        InventoryManager.getInstance().inventory.hiddedKamas = _loc_18.quantity;
                    }
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeKamaModified, _loc_18.quantity, _loc_18.remote);
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
            if (Kernel.getWorker().contains(CraftFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CraftFrame));
            }
            return true;
        }// end function

    }
}
