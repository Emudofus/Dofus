package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class MapRollOverMessage extends ComponentMessage
   {
      
      public function MapRollOverMessage(target:InteractiveObject, x:int, y:int) {
         super(target);
         this._x = x;
         this._y = y;
      }
      
      private var _x:int;
      
      private var _y:int;
      
      public function get x() : int {
         return this._x;
      }
      
      public function get y() : int {
         return this._y;
      }
   }
}
