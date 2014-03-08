package com.ankamagames.tiphon.types
{
   import flash.geom.ColorTransform;
   
   public class AdvancedColoredSprite extends ColoredSprite
   {
      
      public function AdvancedColoredSprite() {
         super();
      }
      
      private static const baseColorTransform:ColorTransform = new ColorTransform();
      
      override public function colorize(param1:ColorTransform) : void {
         if(param1)
         {
            baseColorTransform.redMultiplier = param1.redOffset / 128;
            baseColorTransform.greenMultiplier = param1.greenOffset / 128;
            baseColorTransform.blueMultiplier = param1.blueOffset / 128;
            transform.colorTransform = baseColorTransform;
         }
      }
   }
}
