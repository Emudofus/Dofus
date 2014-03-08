package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ColoredSprite extends DynamicSprite
   {
      
      public function ColoredSprite() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ColoredSprite));
      
      private static const NEUTRAL_COLOR_TRANSFORM:ColorTransform = new ColorTransform();
      
      override public function init(param1:IAnimationSpriteHandler) : void {
         var _loc3_:ColorTransform = null;
         var _loc2_:uint = parseInt(getQualifiedClassName(this).split("_")[1]);
         _loc3_ = param1.getColorTransform(_loc2_);
         if(_loc3_)
         {
            this.colorize(_loc3_);
         }
         param1.registerColoredSprite(this,_loc2_);
      }
      
      public function colorize(param1:ColorTransform) : void {
         if(param1)
         {
            transform.colorTransform = param1;
         }
         else
         {
            transform.colorTransform = NEUTRAL_COLOR_TRANSFORM;
         }
      }
   }
}
