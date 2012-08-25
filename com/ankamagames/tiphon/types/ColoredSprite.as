package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ColoredSprite extends DynamicSprite
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ColoredSprite));
        private static const NEUTRAL_COLOR_TRANSFORM:ColorTransform = new ColorTransform();

        public function ColoredSprite()
        {
            return;
        }// end function

        override public function init(param1:IAnimationSpriteHandler) : void
        {
            var _loc_3:ColorTransform = null;
            var _loc_2:* = parseInt(getQualifiedClassName(this).split("_")[1]);
            _loc_3 = param1.getColorTransform(_loc_2);
            if (_loc_3)
            {
                this.colorize(_loc_3);
            }
            param1.registerColoredSprite(this, _loc_2);
            return;
        }// end function

        public function colorize(param1:ColorTransform) : void
        {
            if (param1)
            {
                transform.colorTransform = param1;
            }
            else
            {
                transform.colorTransform = NEUTRAL_COLOR_TRANSFORM;
            }
            return;
        }// end function

    }
}
