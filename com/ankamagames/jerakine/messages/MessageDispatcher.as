package com.ankamagames.jerakine.messages
{
   public class MessageDispatcher extends Object implements IMessageDispatcher
   {
      
      public function MessageDispatcher() {
         super();
      }
      
      public function dispatchMessage(param1:MessageHandler, param2:Message) : void {
         param1.process(param2);
      }
   }
}
