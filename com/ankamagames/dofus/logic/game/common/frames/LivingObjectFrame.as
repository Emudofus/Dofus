package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class LivingObjectFrame extends Object implements Frame
    {
        private var livingObjectUID:uint = 0;
        private var action:uint = 0;
        private static const ACTION_TOSKIN:uint = 1;
        private static const ACTION_TOFEED:uint = 2;
        private static const ACTION_TODISSOCIATE:uint = 3;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PrismFrame));

        public function LivingObjectFrame()
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            switch(true)
            {
                case param1 is LivingObjectDissociateAction:
                {
                    _loc_2 = param1 as LivingObjectDissociateAction;
                    _loc_3 = new LivingObjectDissociateMessage();
                    _loc_3.initLivingObjectDissociateMessage(_loc_2.livingUID, _loc_2.livingPosition);
                    this.livingObjectUID = _loc_2.livingUID;
                    this.action = ACTION_TODISSOCIATE;
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is LivingObjectFeedAction:
                {
                    _loc_4 = param1 as LivingObjectFeedAction;
                    _loc_5 = new ObjectFeedMessage();
                    _loc_5.initObjectFeedMessage(_loc_4.objectUID, _loc_4.foodUID, _loc_4.foodQuantity);
                    this.livingObjectUID = _loc_4.objectUID;
                    this.action = ACTION_TOFEED;
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is LivingObjectChangeSkinRequestAction:
                {
                    _loc_6 = param1 as LivingObjectChangeSkinRequestAction;
                    _loc_7 = new LivingObjectChangeSkinRequestMessage();
                    _loc_7.initLivingObjectChangeSkinRequestMessage(_loc_6.livingUID, _loc_6.livingPosition, _loc_6.skinId);
                    this.livingObjectUID = _loc_6.livingUID;
                    this.action = ACTION_TOSKIN;
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is ObjectModifiedMessage:
                {
                    _loc_8 = param1 as ObjectModifiedMessage;
                    _loc_9 = ItemWrapper.create(_loc_8.object.position, _loc_8.object.objectUID, _loc_8.object.objectGID, _loc_8.object.quantity, _loc_8.object.effects, false);
                    if (!_loc_9)
                    {
                        return false;
                    }
                    switch(this.action)
                    {
                        case ACTION_TOFEED:
                        {
                            break;
                        }
                        case ACTION_TODISSOCIATE:
                        {
                            break;
                        }
                        case ACTION_TOSKIN:
                        {
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                    if (_loc_9.livingObjectId != 0)
                    {
                    }
                    this.livingObjectUID = 0;
                    return false;
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

    }
}
