package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.queues.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class QueueFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(QueueFrame));

        public function QueueFrame()
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
            var _loc_2:LoginQueueStatusMessage = null;
            var _loc_3:QueueStatusMessage = null;
            switch(true)
            {
                case param1 is LoginQueueStatusMessage:
                {
                    _loc_2 = param1 as LoginQueueStatusMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.LoginQueueStatus, _loc_2.position, _loc_2.total);
                    return true;
                }
                case param1 is QueueStatusMessage:
                {
                    _loc_3 = param1 as QueueStatusMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.QueueStatus, _loc_3.position, _loc_3.total);
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

    }
}
