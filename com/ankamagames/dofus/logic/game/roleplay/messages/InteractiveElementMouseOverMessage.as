package com.ankamagames.dofus.logic.game.roleplay.messages
{
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.messages.*;

    public class InteractiveElementMouseOverMessage extends Object implements Message
    {
        private var _ie:InteractiveElement;
        private var _sprite:Object;

        public function InteractiveElementMouseOverMessage(param1:InteractiveElement, param2)
        {
            this._ie = param1;
            this._sprite = param2;
            return;
        }// end function

        public function get interactiveElement() : InteractiveElement
        {
            return this._ie;
        }// end function

        public function get sprite()
        {
            return this._sprite;
        }// end function

    }
}
