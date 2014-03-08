package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   
   public class FrustumShape extends Sprite
   {
      
      public function FrustumShape(param1:uint) {
         super();
         this._direction = param1;
      }
      
      private var _direction:uint;
      
      public function get direction() : uint {
         return this._direction;
      }
   }
}
