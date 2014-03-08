package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   
   public class AdjacentMapOutMessage extends Object implements Message
   {
      
      public function AdjacentMapOutMessage(param1:uint, param2:DisplayObject) {
         super();
         this._nDirection = param1;
         this._spZone = param2;
      }
      
      private var _nDirection:uint;
      
      private var _spZone:DisplayObject;
      
      public function get direction() : uint {
         return this._nDirection;
      }
      
      public function get zone() : DisplayObject {
         return this._spZone;
      }
   }
}
