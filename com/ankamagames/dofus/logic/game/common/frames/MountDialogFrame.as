package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.utils.*;

    public class MountDialogFrame extends Object implements Frame
    {
        private var _inStable:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MountDialogFrame));

        public function MountDialogFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return 0;
        }// end function

        public function get inStable() : Boolean
        {
            return this._inStable;
        }// end function

        public function pushed() : Boolean
        {
            this._inStable = true;
            this.sendStartOkMount();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            switch(true)
            {
                case param1 is ExchangeMountStableErrorMessage:
                {
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
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
            this._inStable = false;
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, true);
            return true;
        }// end function

        private function sendStartOkMount() : void
        {
            KernelEventsManager.getInstance().processCallback(MountHookList.ExchangeStartOkMount, mountFrame.stableList, mountFrame.paddockList);
            return;
        }// end function

        public static function get mountFrame() : MountFrame
        {
            return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
        }// end function

    }
}
