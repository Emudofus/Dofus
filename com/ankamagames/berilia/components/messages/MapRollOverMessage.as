package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class MapRollOverMessage extends ComponentMessage
   {
      
      public function MapRollOverMessage(param1:InteractiveObject, param2:int, param3:int) {
         super(param1);
         this._x = param2;
         this._y = param3;
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
