package com.ankamagames.tiphon.types
{
    import flash.geom.*;

    public class AdvancedColoredSprite extends ColoredSprite
    {
        private static const baseColorTransform:ColorTransform = new ColorTransform();

        public function AdvancedColoredSprite()
        {
            return;
        }// end function

        override public function colorize(param1:ColorTransform) : void
        {
            if (param1)
            {
                baseColorTransform.redMultiplier = param1.redOffset / 128;
                baseColorTransform.greenMultiplier = param1.greenOffset / 128;
                baseColorTransform.blueMultiplier = param1.blueOffset / 128;
                transform.colorTransform = baseColorTransform;
            }
            return;
        }// end function

    }
}
