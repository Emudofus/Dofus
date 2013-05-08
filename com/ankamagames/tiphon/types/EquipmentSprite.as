package com.ankamagames.tiphon.types
{
   import flash.utils.getQualifiedClassName;
   import flash.display.Sprite;


   public class EquipmentSprite extends DynamicSprite
   {
         

      public function EquipmentSprite() {
         super();
      }

      private static var n:uint = 0;

      override public function init(handler:IAnimationSpriteHandler) : void {
         var lastNumChild:uint = 0;
         if(getQualifiedClassName(parent)==getQualifiedClassName(this))
         {
            return;
         }
         var c:Sprite = handler.getSkinSprite(this);
         if((c)&&(!(c==this)))
         {
            lastNumChild=0;
            while((numChildren)&&(!(lastNumChild==numChildren)))
            {
               lastNumChild=numChildren;
               removeChildAt(0);
            }
            addChild(c);
         }
      }
   }

}