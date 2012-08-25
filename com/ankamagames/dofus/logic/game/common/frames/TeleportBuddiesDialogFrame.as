package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.party.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.interactive.meeting.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class TeleportBuddiesDialogFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TeleportBuddiesDialogFrame));

        public function TeleportBuddiesDialogFrame()
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
            var _loc_2:TeleportBuddiesAnswerAction = null;
            var _loc_3:TeleportBuddiesAnswerMessage = null;
            switch(true)
            {
                case param1 is TeleportBuddiesAnswerAction:
                {
                    _loc_2 = param1 as TeleportBuddiesAnswerAction;
                    _loc_3 = new TeleportBuddiesAnswerMessage();
                    _loc_3.initTeleportBuddiesAnswerMessage(_loc_2.accept);
                    ConnectionsHandler.getConnection().send(_loc_3);
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
