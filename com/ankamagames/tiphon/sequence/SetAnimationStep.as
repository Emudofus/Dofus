package com.ankamagames.tiphon.sequence
{
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;

    public class SetAnimationStep extends AbstractSequencable
    {
        private var _animation:String;
        private var _target:TiphonSprite;

        public function SetAnimationStep(param1:TiphonSprite, param2:String)
        {
            this._target = param1;
            this._animation = param2;
            return;
        }// end function

        public function get animation() : String
        {
            return this._animation;
        }// end function

        public function get target() : TiphonSprite
        {
            return this._target;
        }// end function

        override public function start() : void
        {
            this._target.setAnimation(this._animation);
            executeCallbacks();
            return;
        }// end function

        override public function toString() : String
        {
            return "set animation " + this._animation + " on " + this._target.name;
        }// end function

    }
}
