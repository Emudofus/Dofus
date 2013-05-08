package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;


   public class EntityMovementStoppedMessage extends Object implements Message
   {
         

      public function EntityMovementStoppedMessage(entity:IEntity) {
         super();
         this._entity=entity;
         if(this._entity)
         {
            this.id=entity.id;
         }
      }



      private var _entity:IEntity;

      public function get entity() : IEntity {
         return this._entity;
      }

      public var id:int;
   }

}