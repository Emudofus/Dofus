package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.queues.LoginQueueStatusMessage;
    import com.ankamagames.dofus.network.messages.queues.QueueStatusMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.messages.Message;

    public class QueueFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QueueFrame));


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
            var _local_2:LoginQueueStatusMessage;
            var _local_3:QueueStatusMessage;
            switch (true)
            {
                case (msg is LoginQueueStatusMessage):
                    _local_2 = (msg as LoginQueueStatusMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.LoginQueueStatus, _local_2.position, _local_2.total);
                    return (true);
                case (msg is QueueStatusMessage):
                    _local_3 = (msg as QueueStatusMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.QueueStatus, _local_3.position, _local_3.total);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.common.frames

