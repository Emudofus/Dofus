package com.ankamagames.jerakine.entities.messages
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.messages.*;

    public class EntityMouseOutMessage extends EntityInteractionMessage implements CancelableMessage
    {
        private var _cancel:Boolean;

        public function EntityMouseOutMessage(param1:IInteractive)
        {
            super(param1);
            return;
        }// end function

        public function set cancel(param1:Boolean) : void
        {
            this._cancel = param1;
            return;
        }// end function

        public function get cancel() : Boolean
        {
            return this._cancel;
        }// end function

    }
}
