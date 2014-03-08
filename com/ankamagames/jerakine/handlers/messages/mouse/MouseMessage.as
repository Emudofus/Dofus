package com.ankamagames.jerakine.handlers.messages.mouse
{
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MouseMessage extends HumanInputMessage
   {
      
      public function MouseMessage() {
         super();
      }
      
      public static function create(param1:InteractiveObject, param2:MouseEvent, param3:MouseMessage=null) : MouseMessage {
         if(!param3)
         {
            param3 = new MouseMessage();
         }
         return HumanInputMessage.create(param1,param2,param3) as MouseMessage;
      }
      
      public function get mouseEvent() : MouseEvent {
         return MouseEvent(_nativeEvent);
      }
   }
}
