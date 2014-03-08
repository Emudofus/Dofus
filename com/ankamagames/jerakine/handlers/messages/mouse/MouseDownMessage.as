package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseDownMessage extends MouseMessage
   {
      
      public function MouseDownMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseDownMessage {
         if(!param3)
         {
            param3 = new MouseDownMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseDownMessage;
      }
   }
}
