package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseRightClickOutsideMessage extends MouseMessage
   {
      
      public function MouseRightClickOutsideMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseRightClickOutsideMessage {
         if(!param3)
         {
            param3 = new MouseRightClickOutsideMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseRightClickOutsideMessage;
      }
   }
}
