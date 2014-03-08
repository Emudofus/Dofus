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
   import __AS3__.vec.Vector;
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
         var _loc1_:ScriptEntity = this._entities[PlayedCharacterManager.getInstance().id];
         if(_loc1_)
         {
            _loc1_.teleport(this._playerPosition.x,this._playerPosition.y).start();
         }
         delete this._entities[[PlayedCharacterManager.getInstance().id]];
      }
      
      public function getEntity(param1:int) : ScriptEntity {
         var _loc2_:AnimatedCharacter = null;
         if(!this._entities[param1] && param1 == PlayedCharacterManager.getInstance().id)
         {
            _loc2_ = DofusEntities.getEntity(param1) as AnimatedCharacter;
            this._entities[param1] = new ScriptEntity(param1,_loc2_.look.toString());
         }
         return this._entities[param1];
      }
      
      public function getWorldEntity(param1:int) : ScriptEntity {
         var _loc2_:SpriteWrapper = null;
         var _loc3_:WorldEntitySprite = null;
         if(!this._entities[param1])
         {
            _loc2_ = Atouin.getInstance().getIdentifiedElement(param1) as SpriteWrapper;
            _loc3_ = _loc2_.getChildAt(0) as WorldEntitySprite;
            this._entities[param1] = new ScriptEntity(param1,_loc3_.look.toString(),_loc3_);
         }
         return this._entities[param1];
      }
      
      public function getEntityFromCell(param1:uint) : ScriptEntity {
         var _loc6_:SpriteWrapper = null;
         var _loc7_:WorldEntitySprite = null;
         var _loc2_:AnimatedCharacter = Atouin.getInstance().getEntityOnCell(param1) as AnimatedCharacter;
         if(_loc2_)
         {
            if(!this._entities[_loc2_.id])
            {
               this._entities[_loc2_.id] = new ScriptEntity(_loc2_.id,_loc2_.look.toString(),_loc2_);
            }
            return this._entities[_loc2_.id];
         }
         var _loc3_:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var _loc4_:Vector.<InteractiveElement> = _loc3_.entitiesFrame.interactiveElements;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = Atouin.getInstance().getIdentifiedElement(_loc4_[_loc5_].elementId) as SpriteWrapper;
            _loc7_ = _loc6_.getChildAt(0) as WorldEntitySprite;
            if(_loc7_.cellId == param1)
            {
               this._entities[_loc7_.identifier] = new ScriptEntity(_loc7_.identifier,_loc7_.look.toString(),_loc7_);
               return this._entities[_loc7_.identifier];
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getPlayer() : ScriptEntity {
         return this.getEntity(PlayedCharacterManager.getInstance().id);
      }
      
      public function createMonster(param1:int, param2:Boolean=true, param3:int=0, param4:int=0, param5:int=1) : ScriptEntity {
         var _loc6_:ScriptEntity = this.createEntity(Monster.getMonsterById(param1).look);
         if(param2)
         {
            _loc6_.x = param3;
            _loc6_.y = param4;
            _loc6_.direction = param5;
            _loc6_.display().start();
         }
         return _loc6_;
      }
      
      public function createNpc(param1:int, param2:Boolean=true, param3:int=0, param4:int=0, param5:int=1) : ScriptEntity {
         var _loc6_:ScriptEntity = this.createEntity(Npc.getNpcById(param1).look);
         if(param2)
         {
            _loc6_.x = param3;
            _loc6_.y = param4;
            _loc6_.direction = param5;
            _loc6_.display().start();
         }
         return _loc6_;
      }
      
      public function createCustom(param1:String, param2:Boolean=true, param3:int=0, param4:int=0, param5:int=1) : ScriptEntity {
         var _loc6_:ScriptEntity = this.createEntity(param1);
         if(param2)
         {
            _loc6_.x = param3;
            _loc6_.y = param4;
            _loc6_.direction = param5;
            _loc6_.display().start();
         }
         return _loc6_;
      }
      
      public function removeEntity(param1:int) : void {
         delete this._entities[[param1]];
      }
      
      public function removeEntities() : void {
         var _loc1_:ScriptEntity = null;
         for each (_loc1_ in this._entities)
         {
            if(_loc1_.id != PlayedCharacterManager.getInstance().id)
            {
               _loc1_.destroy();
               _loc1_.remove().start();
            }
         }
      }
      
      private function createEntity(param1:String) : ScriptEntity {
         var _loc2_:int = EntitiesManager.getInstance().getFreeEntityId();
         this._entities[_loc2_] = new ScriptEntity(_loc2_,param1);
         return this._entities[_loc2_];
      }
   }
}
