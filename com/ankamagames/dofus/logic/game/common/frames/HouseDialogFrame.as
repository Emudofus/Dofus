package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class HouseDialogFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseDialogFrame));

        public function HouseDialogFrame()
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
            var _loc_2:LockableUseCodeAction = null;
            var _loc_3:LockableUseCodeMessage = null;
            switch(true)
            {
                case param1 is LockableUseCodeAction:
                {
                    _loc_2 = param1 as LockableUseCodeAction;
                    _loc_3 = new LockableUseCodeMessage();
                    _loc_3.initLockableUseCodeMessage(_loc_2.code);
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
