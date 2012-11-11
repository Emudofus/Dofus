package com.ankamagames.tiphon.types
{
    import flash.utils.*;

    public class DisplayInfoSprite extends DynamicSprite
    {

        public function DisplayInfoSprite()
        {
            return;
        }// end function

        override public function init(param1:IAnimationSpriteHandler) : void
        {
            alpha = 0;
            var _loc_2:* = getQualifiedClassName(this).split("_")[1];
            param1.registerInfoSprite(this, _loc_2);
            return;
        }// end function

    }
}
