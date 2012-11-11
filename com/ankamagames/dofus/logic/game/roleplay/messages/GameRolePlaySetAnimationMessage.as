package com.ankamagames.dofus.logic.game.roleplay.messages
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.jerakine.messages.*;

    public class GameRolePlaySetAnimationMessage extends Object implements Message
    {
        private var _informations:GameContextActorInformations;
        private var _animation:String;
        private var _duration:uint;
        private var _instant:Boolean;
        private var _directions8:Boolean;
        private var _playStaticOnly:Boolean;

        public function GameRolePlaySetAnimationMessage(param1:GameContextActorInformations, param2:String, param3:uint = 0, param4:Boolean = true, param5:Boolean = true, param6:Boolean = false)
        {
            this._informations = param1;
            this._animation = param2;
            this._duration = param3;
            this._instant = param4;
            this._directions8 = param5;
            this._playStaticOnly = param6;
            return;
        }// end function

        public function get informations() : GameContextActorInformations
        {
            return this._informations;
        }// end function

        public function get animation() : String
        {
            return this._animation;
        }// end function

        public function get duration() : uint
        {
            return this._duration;
        }// end function

        public function get instant() : Boolean
        {
            return this._instant;
        }// end function

        public function get directions8() : Boolean
        {
            return this._directions8;
        }// end function

        public function get playStaticOnly() : Boolean
        {
            return this._playStaticOnly;
        }// end function

    }
}
