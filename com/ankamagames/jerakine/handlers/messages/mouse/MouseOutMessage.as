package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   
   public class MouseOutMessage extends MouseMessage
   {
      
      public function MouseOutMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseOutMessage {
         if(!param3)
         {
            param3 = new MouseOutMessage();
         }
         return HumanInputMessage.create(param1,param2,param3) as MouseOutMessage;
      }
   }
}
