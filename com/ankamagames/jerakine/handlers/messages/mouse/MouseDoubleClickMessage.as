package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseDoubleClickMessage extends MouseMessage
   {
      
      public function MouseDoubleClickMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseDoubleClickMessage {
         if(!param3)
         {
            param3 = new MouseDoubleClickMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseDoubleClickMessage;
      }
   }
}
