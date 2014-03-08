package com.ankamagames.tiphon.types
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class DynamicSprite extends MovieClip
   {
      
      public function DynamicSprite() {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      }
      
      public function init(param1:IAnimationSpriteHandler) : void {
      }
      
      private function onAdded(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         while(!(_loc2_ is TiphonSprite) && (_loc2_.parent))
         {
            _loc2_ = _loc2_.parent;
         }
         if(_loc2_ is TiphonSprite)
         {
            this.init(_loc2_ as TiphonSprite);
         }
      }
      
      public function getRoot() : ScriptedAnimation {
         var _loc1_:DisplayObject = this;
         while(_loc1_)
         {
            if(_loc1_ is ScriptedAnimation)
            {
               return _loc1_ as ScriptedAnimation;
            }
            _loc1_ = _loc1_.parent;
         }
         return null;
      }
   }
}
