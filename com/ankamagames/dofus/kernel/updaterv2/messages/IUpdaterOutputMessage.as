package com.ankamagames.dofus.kernel.updaterv2.messages
{
   import com.ankamagames.jerakine.messages.QueueableMessage;
   
   public interface IUpdaterOutputMessage extends QueueableMessage
   {
      
      function serialize() : String;
   }
}
