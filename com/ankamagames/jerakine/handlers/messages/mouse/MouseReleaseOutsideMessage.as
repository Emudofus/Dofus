package com.ankamagames.jerakine.handlers.messages.mouse
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseReleaseOutsideMessage extends MouseMessage
   {
      
      public function MouseReleaseOutsideMessage()
      {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage = null) : MouseReleaseOutsideMessage
      {
         if(!param3)
         {
            var param3:MouseMessage = new MouseReleaseOutsideMessage();
         }
         return MouseMessage.create(param1,param2,param3) as MouseReleaseOutsideMessage;
      }
   }
}
