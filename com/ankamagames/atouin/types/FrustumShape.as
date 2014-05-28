package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   
   public class FrustumShape extends Sprite
   {
      
      public function FrustumShape(direction:uint) {
         super();
         this._direction = direction;
      }
      
      private var _direction:uint;
      
      public function get direction() : uint {
         return this._direction;
      }
   }
}
