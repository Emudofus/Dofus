package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.jerakine.lua.LuaPackage;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.scripts.ScriptEntity;
   import com.ankamagames.atouin.types.SpriteWrapper;
   import com.ankamagames.atouin.types.WorldEntitySprite;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.atouin.managers.EntitiesManager;
   
   public class EntityApi extends Object implements LuaPackage
   {
      
      public function EntityApi() {
         this._entities = new Dictionary();
         super();
      }
      
      private var _entities:Dictionary;
      
      private var _playerPosition:MapPoint;
      
      public function init() : void {
         this._playerPosition = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter).position;
      }
      
      public function reset() : void {
         this.removeEntities();
         var player:ScriptEntity = this._entities[PlayedCharacterManager.getInstance().id];
         if(player)
         {
            player.teleport(this._playerPosition.x,this._playerPosition.y).start();
         }
         delete this._entities[PlayedCharacterManager.getInstance().id];
      }
      
      public function getEntity(pEntityId:int) : ScriptEntity {
         var player:AnimatedCharacter = null;
         if((!this._entities[pEntityId]) && (pEntityId == PlayedCharacterManager.getInstance().id))
         {
            player = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
            this._entities[pEntityId] = new ScriptEntity(pEntityId,player.look.toString());
         }
         return this._entities[pEntityId];
      }
      
      public function getWorldEntity(pEntityId:int) : ScriptEntity {
         var worldObject:SpriteWrapper = null;
         var entity:WorldEntitySprite = null;
         if(!this._entities[pEntityId])
         {
            worldObject = Atouin.getInstance().getIdentifiedElement(pEntityId) as SpriteWrapper;
            entity = worldObject.getChildAt(0) as WorldEntitySprite;
            this._entities[pEntityId] = new ScriptEntity(pEntityId,entity.look.toString(),entity);
         }
         return this._entities[pEntityId];
      }
      
      public function getEntityFromCell(pCellID:uint) : ScriptEntity {
         var worldObject:SpriteWrapper = null;
         var entity1:WorldEntitySprite = null;
         var entity:AnimatedCharacter = Atouin.getInstance().getEntityOnCell(pCellID) as AnimatedCharacter;
         if(entity)
         {
            if(!this._entities[entity.id])
            {
               this._entities[entity.id] = new ScriptEntity(entity.id,entity.look.toString(),entity);
            }
            return this._entities[entity.id];
         }
         var rpContextFrame:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var ies:Vector.<InteractiveElement> = rpContextFrame.entitiesFrame.interactiveElements;
         var i:int = 0;
         while(i < ies.length)
         {
            worldObject = Atouin.getInstance().getIdentifiedElement(ies[i].elementId) as SpriteWrapper;
            entity1 = worldObject.getChildAt(0) as WorldEntitySprite;
            if(entity1.cellId == pCellID)
            {
               this._entities[entity1.identifier] = new ScriptEntity(entity1.identifier,entity1.look.toString(),entity1);
               return this._entities[entity1.identifier];
            }
            i++;
         }
         return null;
      }
      
      public function getPlayer() : ScriptEntity {
         return this.getEntity(PlayedCharacterManager.getInstance().id);
      }
      
      public function createMonster(pMonsterId:int, pAddEntity:Boolean = true, pStartX:int = 0, pStartY:int = 0, pStartDirection:int = 1) : ScriptEntity {
         var entity:ScriptEntity = this.createEntity(Monster.getMonsterById(pMonsterId).look);
         if(pAddEntity)
         {
            entity.x = pStartX;
            entity.y = pStartY;
            entity.direction = pStartDirection;
            entity.display().start();
         }
         return entity;
      }
      
      public function createNpc(pNpcId:int, pAddEntity:Boolean = true, pStartX:int = 0, pStartY:int = 0, pStartDirection:int = 1) : ScriptEntity {
         var entity:ScriptEntity = this.createEntity(Npc.getNpcById(pNpcId).look);
         if(pAddEntity)
         {
            entity.x = pStartX;
            entity.y = pStartY;
            entity.direction = pStartDirection;
            entity.display().start();
         }
         return entity;
      }
      
      public function createCustom(pLook:String, pAddEntity:Boolean = true, pStartX:int = 0, pStartY:int = 0, pStartDirection:int = 1) : ScriptEntity {
         var entity:ScriptEntity = this.createEntity(pLook);
         if(pAddEntity)
         {
            entity.x = pStartX;
            entity.y = pStartY;
            entity.direction = pStartDirection;
            entity.display().start();
         }
         return entity;
      }
      
      public function removeEntity(pEntityId:int) : void {
         delete this._entities[pEntityId];
      }
      
      public function removeEntities() : void {
         var entity:ScriptEntity = null;
         for each(entity in this._entities)
         {
            if(entity.id != PlayedCharacterManager.getInstance().id)
            {
               entity.destroy();
               entity.remove().start();
            }
         }
      }
      
      private function createEntity(pLook:String) : ScriptEntity {
         var entityId:int = EntitiesManager.getInstance().getFreeEntityId();
         this._entities[entityId] = new ScriptEntity(entityId,pLook);
         return this._entities[entityId];
      }
   }
}
