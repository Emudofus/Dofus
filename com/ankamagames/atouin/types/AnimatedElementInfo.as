package com.ankamagames.atouin.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.utils.getTimer;
   
   public final class AnimatedElementInfo extends Object
   {
      
      public function AnimatedElementInfo(param1:TiphonSprite, param2:int, param3:int) {
         super();
         this.tiphonSprite = param1;
         this.min = param2;
         this.max = param3;
         this.setNextAnimation();
      }
      
      public var tiphonSprite:TiphonSprite;
      
      public var min:int;
      
      public var max:int;
      
      public var nextAnimation:int;
      
      public function setNextAnimation() : void {
         this.nextAnimation = getTimer() + this.min + int(Math.random() * (this.max - this.min));
      }
   }
}
