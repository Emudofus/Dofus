package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class VideoBufferChangeMessage extends ComponentMessage
   {
      
      public function VideoBufferChangeMessage(param1:InteractiveObject, param2:uint) {
         super(param1);
         this._state = param2;
      }
      
      private var _state:uint;
      
      public function get state() : uint {
         return this._state;
      }
   }
}
