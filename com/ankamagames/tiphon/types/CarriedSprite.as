package com.ankamagames.tiphon.types
{
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObjectContainer;
   
   public class CarriedSprite extends DynamicSprite
   {
      
      public function CarriedSprite() {
         super();
      }
      
      override public function init(param1:IAnimationSpriteHandler) : void {
         var _loc2_:Array = getQualifiedClassName(this).split("_");
         var _loc3_:DisplayObjectContainer = param1.getSubEntitySlot(parseInt(_loc2_[1]),parseInt(_loc2_[2]));
         if(_loc3_)
         {
            addChild(_loc3_);
         }
      }
   }
}
