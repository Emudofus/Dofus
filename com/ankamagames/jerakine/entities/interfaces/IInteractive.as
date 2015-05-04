package com.ankamagames.jerakine.entities.interfaces
{
   import flash.events.IEventDispatcher;
   import com.ankamagames.jerakine.messages.MessageHandler;
   
   public interface IInteractive extends IEventDispatcher, IEntity
   {
      
      function get handler() : MessageHandler;
      
      function get useHandCursor() : Boolean;
      
      function get enabledInteractions() : uint;
   }
}
