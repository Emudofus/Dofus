package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseOverMessage extends MouseMessage
   {
      
      public function MouseOverMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseOverMessage {
         if(!param3)
         {
            param3 = new MouseOverMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseOverMessage;
      }
   }
}
