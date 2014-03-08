package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseClickMessage extends MouseMessage
   {
      
      public function MouseClickMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseClickMessage {
         if(!param3)
         {
            param3 = new MouseClickMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseClickMessage;
      }
   }
}
