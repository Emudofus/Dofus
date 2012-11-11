package com.ankamagames.dofus.logic.game.roleplay.messages
{
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.messages.*;

    public class InteractiveElementMouseOutMessage extends Object implements Message
    {
        private var _ie:InteractiveElement;

        public function InteractiveElementMouseOutMessage(param1:InteractiveElement)
        {
            this._ie = param1;
            return;
        }// end function

        public function get interactiveElement() : InteractiveElement
        {
            return this._ie;
        }// end function

    }
}
