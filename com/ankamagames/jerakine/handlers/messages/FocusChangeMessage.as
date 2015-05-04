package com.ankamagames.jerakine.handlers.messages
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   
   public class FocusChangeMessage extends HumanInputMessage
   {
      
      public function FocusChangeMessage()
      {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:FocusChangeMessage = null) : FocusChangeMessage
      {
         if(!param2)
         {
            var param2:FocusChangeMessage = new FocusChangeMessage();
         }
         return HumanInputMessage.create(param1,new Event("FocusChange"),param2) as FocusChangeMessage;
      }
   }
}
