package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightClickMessage extends MouseMessage
   {
      
      public function MouseRightClickMessage()
      {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseRightClickMessage
      {
         if(!param3)
         {
            var param3:MouseMessage = new MouseRightClickMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseRightClickMessage;
      }
   }
}
