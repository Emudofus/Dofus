package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   
   public class EntityInteractionMessage extends Object implements Message
   {
      
      public function EntityInteractionMessage(entity:IInteractive) {
         super();
         this._entity = entity;
      }
      
      private var _entity:IInteractive;
      
      public function get entity() : IInteractive {
         return this._entity;
      }
   }
}
