package com.ankamagames.tiphon.types
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class EquipmentSprite extends DynamicSprite
   {
      
      public function EquipmentSprite() {
         super();
      }
      
      public static var enableLiveReference:Boolean = false;
      
      public static var liveReference:Dictionary = new Dictionary(false);
      
      private static const _handlerRef:Dictionary = new Dictionary(true);
      
      public function updateTransform() : void {
         if(_handlerRef[this])
         {
            this.makeChild(_handlerRef[this]);
         }
      }
      
      override public function init(param1:IAnimationSpriteHandler) : void {
         if(getQualifiedClassName(parent) == getQualifiedClassName(this))
         {
            return;
         }
         var _loc2_:DisplayObject = this.makeChild(param1);
         if((_loc2_) && (enableLiveReference))
         {
            if(!liveReference[getQualifiedClassName(_loc2_)])
            {
               liveReference[getQualifiedClassName(_loc2_)] = new Dictionary(true);
            }
            liveReference[getQualifiedClassName(_loc2_)][this] = 1;
            _handlerRef[this] = param1;
         }
      }
      
      private function makeChild(param1:IAnimationSpriteHandler) : DisplayObject {
         var _loc3_:uint = 0;
         var _loc2_:Sprite = param1.getSkinSprite(this);
         if((_loc2_) && !(_loc2_ == this))
         {
            _loc3_ = 0;
            while((numChildren) && !(_loc3_ == numChildren))
            {
               _loc3_ = numChildren;
               removeChildAt(0);
            }
            return addChild(_loc2_);
         }
         return null;
      }
   }
}
