package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class MapZoomMessage extends Object implements Message
   {
      
      public function MapZoomMessage(param1:Number, param2:int, param3:int) {
         super();
         this._value = param1;
         this._posX = param2;
         this._posY = param3;
      }
      
      private var _value:Number;
      
      private var _posX:int;
      
      private var _posY:int;
      
      public function get value() : Number {
         return this._value;
      }
      
      public function get posX() : int {
         return this._posX;
      }
      
      public function get posY() : int {
         return this._posY;
      }
   }
}
