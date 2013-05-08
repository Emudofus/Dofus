package com.ankamagames.tiphon.types
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import com.ankamagames.tiphon.display.TiphonSprite;


   public class DynamicSprite extends MovieClip
   {
         

      public function DynamicSprite() {
         super();
         MEMORY_LOG[this]=1;
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      }

      public static var MEMORY_LOG:Dictionary = new Dictionary(true);

      protected function getRoot() : ScriptedAnimation {
         return this._getRoot();
      }

      public function init(handler:IAnimationSpriteHandler) : void {
         
      }

      private function onAdded(e:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         var currentDo:DisplayObject = e.target as DisplayObject;
         while((!(currentDo is TiphonSprite))&&(currentDo.parent))
         {
            currentDo=currentDo.parent;
         }
         if(currentDo is TiphonSprite)
         {
            this.init(currentDo as TiphonSprite);
         }
      }

      private function _getRoot() : ScriptedAnimation {
         var current:DisplayObject = this;
         while(current)
         {
            if(current is ScriptedAnimation)
            {
               return current as ScriptedAnimation;
            }
            current=current.parent;
         }
         return null;
      }
   }

}