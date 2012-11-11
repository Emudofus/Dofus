package com.ankamagames.dofus.logic.game.roleplay.messages
{
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class InteractiveElementActivationMessage extends Object implements Message
    {
        private var _ie:InteractiveElement;
        private var _position:MapPoint;
        private var _skillInstanceId:uint;

        public function InteractiveElementActivationMessage(param1:InteractiveElement, param2:MapPoint, param3:uint)
        {
            this._ie = param1;
            this._position = param2;
            this._skillInstanceId = param3;
            return;
        }// end function

        public function get interactiveElement() : InteractiveElement
        {
            return this._ie;
        }// end function

        public function get position() : MapPoint
        {
            return this._position;
        }// end function

        public function get skillInstanceId() : uint
        {
            return this._skillInstanceId;
        }// end function

    }
}
