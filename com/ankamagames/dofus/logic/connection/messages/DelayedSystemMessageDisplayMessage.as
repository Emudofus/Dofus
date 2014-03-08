package com.ankamagames.dofus.logic.connection.messages
{
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.jerakine.messages.Message;
   import __AS3__.vec.Vector;
   
   public class DelayedSystemMessageDisplayMessage extends SystemMessageDisplayMessage implements Message
   {
      
      public function DelayedSystemMessageDisplayMessage() {
         super();
      }
      
      public function initDelayedSystemMessageDisplayMessage(param1:Boolean=false, param2:uint=0, param3:Vector.<String>=null) : DelayedSystemMessageDisplayMessage {
         this.hangUp = param1;
         this.msgId = param2;
         this.parameters = param3;
         return this;
      }
   }
}
