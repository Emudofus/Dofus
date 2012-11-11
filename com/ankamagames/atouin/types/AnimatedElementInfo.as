package com.ankamagames.atouin.types
{
    import com.ankamagames.tiphon.display.*;
    import flash.utils.*;

    final public class AnimatedElementInfo extends Object
    {
        public var tiphonSprite:TiphonSprite;
        public var min:int;
        public var max:int;
        public var nextAnimation:int;

        public function AnimatedElementInfo(param1:TiphonSprite, param2:int, param3:int)
        {
            this.tiphonSprite = param1;
            this.min = param2;
            this.max = param3;
            this.setNextAnimation();
            return;
        }// end function

        public function setNextAnimation() : void
        {
            this.nextAnimation = getTimer() + this.min + int(Math.random() * (this.max - this.min));
            return;
        }// end function

    }
}
