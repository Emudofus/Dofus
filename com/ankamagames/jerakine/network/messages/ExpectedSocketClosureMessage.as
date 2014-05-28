package com.ankamagames.jerakine.network.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.ILogableMessage;
   
   public class ExpectedSocketClosureMessage extends Object implements Message, ILogableMessage
   {
      
      public function ExpectedSocketClosureMessage(reason:uint = 0) {
         super();
         this.reason = reason;
      }
      
      public var reason:uint;
   }
}
