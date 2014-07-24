package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.IEventDispatcher;
   
   public interface ISSOCommunicator extends IEventDispatcher
   {
      
      function destroy() : void;
      
      function ssoTokenRequest() : void;
   }
}
