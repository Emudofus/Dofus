package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.IEventDispatcher;
   
   public interface IGeneralCommunicator extends IEventDispatcher
   {
      
      function destroy() : void;
      
      function closeArenaRequest() : void;
   }
}
