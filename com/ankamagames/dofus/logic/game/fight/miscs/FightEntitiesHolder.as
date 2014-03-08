package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.dofus.logic.game.common.misc.IEntityLocalizer;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class FightEntitiesHolder extends Object implements IEntityLocalizer
   {
      
      public function FightEntitiesHolder() {
         this._holdedEntities = new Dictionary();
         super();
      }
      
      private static var _self:FightEntitiesHolder;
      
      public static function getInstance() : FightEntitiesHolder {
         if(!_self)
         {
            _self = new FightEntitiesHolder();
            DofusEntities.registerLocalizer(_self);
         }
         return _self;
      }
      
      private var _holdedEntities:Dictionary;
      
      public function getEntity(entityId:int) : IEntity {
         return this._holdedEntities[entityId];
      }
      
      public function holdEntity(entity:IEntity) : void {
         this._holdedEntities[entity.id] = entity;
      }
      
      public function unholdEntity(entityId:int) : void {
         delete this._holdedEntities[[entityId]];
      }
      
      public function reset() : void {
         this._holdedEntities = new Dictionary();
      }
      
      public function getEntities() : Dictionary {
         return this._holdedEntities;
      }
      
      public function unregistered() : void {
         var entity:IEntity = null;
         for each (entity in this._holdedEntities)
         {
            if(entity is IDisplayable)
            {
               (entity as IDisplayable).remove();
            }
            if(entity is TiphonSprite)
            {
               (entity as TiphonSprite).destroy();
            }
         }
         this._holdedEntities = null;
         _self = null;
      }
   }
}
