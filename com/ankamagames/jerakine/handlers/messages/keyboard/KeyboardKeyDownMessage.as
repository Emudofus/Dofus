package com.ankamagames.jerakine.handlers.messages.keyboard
{
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   
   public class KeyboardKeyDownMessage extends KeyboardMessage
   {
      
      public function KeyboardKeyDownMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:KeyboardEvent, param3:KeyboardMessage=null) : KeyboardKeyDownMessage {
         if(!param3)
         {
            param3 = new KeyboardKeyDownMessage();
         }
         return KeyboardMessage.create(param1,param2,param3) as KeyboardKeyDownMessage;
      }
   }
}
