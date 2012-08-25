package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.mount.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.mount.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class PaddockFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));

        public function PaddockFrame()
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
            var _loc_2:PaddockSellRequestAction = null;
            var _loc_3:PaddockSellRequestMessage = null;
            switch(true)
            {
                case param1 is PaddockBuyRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new PaddockBuyRequestMessage());
                    return true;
                }
                case param1 is PaddockSellRequestAction:
                {
                    _loc_2 = param1 as PaddockSellRequestAction;
                    _loc_3 = new PaddockSellRequestMessage();
                    _loc_3.initPaddockSellRequestMessage(_loc_2.price);
                    ConnectionsHandler.getConnection().send(_loc_3);
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
