package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.ILogableMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   
   public class EntityMovementCompleteMessage extends Object implements Message, ILogableMessage
   {
      
      public function EntityMovementCompleteMessage(param1:IEntity=null) {
         super();
         this._entity = param1;
         if(this._entity)
         {
            this.id = param1.id;
         }
      }
      
      private var _entity:IEntity;
      
      public function get entity() : IEntity {
         return this._entity;
      }
      
      public var id:int;
   }
}
