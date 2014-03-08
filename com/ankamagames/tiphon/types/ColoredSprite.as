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
      
      override public function init(handler:IAnimationSpriteHandler) : void {
         var colorT:ColorTransform = null;
         var nColorIndex:uint = parseInt(getQualifiedClassName(this).split("_")[1]);
         colorT = handler.getColorTransform(nColorIndex);
         if(colorT)
         {
            this.colorize(colorT);
         }
         handler.registerColoredSprite(this,nColorIndex);
      }
      
      public function colorize(colorT:ColorTransform) : void {
         if(colorT)
         {
            transform.colorTransform = colorT;
         }
         else
         {
            transform.colorTransform = NEUTRAL_COLOR_TRANSFORM;
         }
      }
   }
}
