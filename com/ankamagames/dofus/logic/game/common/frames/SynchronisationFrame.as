package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class SynchronisationFrame extends Object implements Frame
    {
        private var _synchroStep:uint = 0;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SynchronisationFrame));

        public function SynchronisationFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function pushed() : Boolean
        {
            this._synchroStep = 0;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:SequenceNumberMessage = null;
            switch(true)
            {
                case param1 is SequenceNumberRequestMessage:
                {
                    _loc_2 = new SequenceNumberMessage();
                    (this._synchroStep + 1);
                    _loc_2.initSequenceNumberMessage(this._synchroStep);
                    ConnectionsHandler.getConnection().send(_loc_2);
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
