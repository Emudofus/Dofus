package com.ankamagames.dofus.logic.game.fight.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class TextActionInformationMessage extends Object implements Message
    {
        private var _textKey:uint;
        private var _params:Array;

        public function TextActionInformationMessage(param1:uint, param2:Array = null)
        {
            this._textKey = param1;
            this._params = param2;
            return;
        }// end function

        public function get textKey() : uint
        {
            return this._textKey;
        }// end function

        public function get params() : Array
        {
            return this._params;
        }// end function

    }
}
