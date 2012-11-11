package com.ankamagames.tiphon.types
{
    import flash.display.*;
    import flash.utils.*;

    public class CarriedSprite extends DynamicSprite
    {

        public function CarriedSprite()
        {
            return;
        }// end function

        override public function init(param1:IAnimationSpriteHandler) : void
        {
            var _loc_2:* = getQualifiedClassName(this).split("_");
            var _loc_3:* = param1.getSubEntitySlot(parseInt(_loc_2[1]), parseInt(_loc_2[2]));
            if (_loc_3)
            {
                addChild(_loc_3);
            }
            return;
        }// end function

    }
}
