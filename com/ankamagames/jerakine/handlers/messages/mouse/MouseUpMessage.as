package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseUpMessage extends MouseMessage
   {
      
      public function MouseUpMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseUpMessage {
         if(!param3)
         {
            param3 = new MouseUpMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseUpMessage;
      }
   }
}
