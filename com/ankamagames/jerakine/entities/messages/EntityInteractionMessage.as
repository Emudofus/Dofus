package com.ankamagames.jerakine.entities.messages
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.messages.*;

    public class EntityInteractionMessage extends Object implements Message
    {
        private var _entity:IInteractive;

        public function EntityInteractionMessage(param1:IInteractive)
        {
            this._entity = param1;
            return;
        }// end function

        public function get entity() : IInteractive
        {
            return this._entity;
        }// end function

    }
}
