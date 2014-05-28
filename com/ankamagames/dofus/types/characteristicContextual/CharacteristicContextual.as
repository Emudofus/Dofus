package com.ankamagames.dofus.types.characteristicContextual
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.berilia.types.event.BeriliaEvent;
   
   public class CharacteristicContextual extends Sprite
   {
      
      public function CharacteristicContextual() {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      private var _referedEntity:IEntity;
      
      public function get referedEntity() : IEntity {
         return this._referedEntity;
      }
      
      public function set referedEntity(oEntity:IEntity) : void {
         this._referedEntity = oEntity;
      }
      
      public function remove() : void {
         dispatchEvent(new BeriliaEvent(BeriliaEvent.REMOVE_COMPONENT));
      }
   }
}
