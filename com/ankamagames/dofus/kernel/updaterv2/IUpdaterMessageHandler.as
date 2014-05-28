package com.ankamagames.dofus.kernel.updaterv2
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   
   public interface IUpdaterMessageHandler
   {
      
      function handleConnectionOpened() : void;
      
      function handleMessage(param1:IUpdaterInputMessage) : void;
      
      function handleConnectionClosed() : void;
   }
}
