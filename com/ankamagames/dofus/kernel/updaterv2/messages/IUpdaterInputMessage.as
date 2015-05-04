package com.ankamagames.dofus.kernel.updaterv2.messages
{
   import com.ankamagames.jerakine.messages.QueueableMessage;
   
   public interface IUpdaterInputMessage extends QueueableMessage
   {
      
      function deserialize(param1:Object) : void;
   }
}
