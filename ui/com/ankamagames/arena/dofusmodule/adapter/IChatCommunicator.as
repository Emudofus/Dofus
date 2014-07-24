package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.IEventDispatcher;
   
   public interface IChatCommunicator extends IEventDispatcher
   {
      
      function destroy() : void;
      
      function addUserMessage(param1:String, param2:String) : void;
      
      function addInfoMessage(param1:String) : void;
   }
}
