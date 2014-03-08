package com.ankamagames.tiphon.types
{
   import flash.utils.getQualifiedClassName;
   
   public class DisplayInfoSprite extends DynamicSprite
   {
      
      public function DisplayInfoSprite() {
         super();
      }
      
      override public function init(param1:IAnimationSpriteHandler) : void {
         alpha = 0;
         var _loc2_:String = getQualifiedClassName(this).split("_")[1];
         param1.registerInfoSprite(this,_loc2_);
      }
   }
}
