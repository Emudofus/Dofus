package com.ankamagames.tiphon.types
{
    import flash.display.*;
    import flash.utils.*;

    public class EquipmentSprite extends DynamicSprite
    {
        private static var n:uint = 0;

        public function EquipmentSprite()
        {
            return;
        }// end function

        override public function init(param1:IAnimationSpriteHandler) : void
        {
            if (getQualifiedClassName(parent) == getQualifiedClassName(this))
            {
                return;
            }
            var _loc_2:* = param1.getSkinSprite(this);
            if (_loc_2 && _loc_2 != this)
            {
                addChild(_loc_2);
            }
            return;
        }// end function

    }
}
