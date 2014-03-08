package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   
   public class EntityMovementStoppedMessage extends Object implements Message
   {
      
      public function EntityMovementStoppedMessage(param1:IEntity) {
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
