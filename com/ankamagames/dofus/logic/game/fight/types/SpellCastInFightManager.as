package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.logic.game.common.misc.SpellModificator;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   
   public class SpellCastInFightManager extends Object
   {
      
      public function SpellCastInFightManager(param1:int) {
         this._spells = new Dictionary();
         super();
         this.entityId = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellCastInFightManager));
      
      private var _spells:Dictionary;
      
      private var skipFirstTurn:Boolean = true;
      
      private var _storedSpellCooldowns:Vector.<GameFightSpellCooldown>;
      
      public var currentTurn:int = 0;
      
      public var entityId:int;
      
      public var needCooldownUpdate:Boolean = false;
      
      public function nextTurn() : void {
         var _loc1_:SpellManager = null;
         this.currentTurn++;
         for each (_loc1_ in this._spells)
         {
            _loc1_.newTurn();
         }
      }
      
      public function resetInitialCooldown(param1:Boolean=false) : void {
         var _loc2_:SpellManager = null;
         var _loc5_:SpellWrapper = null;
         var _loc3_:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         var _loc4_:Array = _loc3_.getFullSpellListByOwnerId(this.entityId);
         for each (_loc5_ in _loc4_)
         {
            if(_loc5_.spellLevelInfos.initialCooldown != 0)
            {
               if(!((param1) && _loc5_.actualCooldown > _loc5_.spellLevelInfos.initialCooldown))
               {
                  if(this._spells[_loc5_.spellId] == null)
                  {
                     this._spells[_loc5_.spellId] = new SpellManager(this,_loc5_.spellId,_loc5_.spellLevel);
                  }
                  _loc2_ = this._spells[_loc5_.spellId];
                  _loc2_.resetInitialCooldown(this.currentTurn);
               }
            }
         }
      }
      
      public function updateCooldowns(param1:Vector.<GameFightSpellCooldown>=null) : void {
         var _loc5_:GameFightSpellCooldown = null;
         var _loc6_:SpellWrapper = null;
         var _loc7_:SpellLevel = null;
         var _loc8_:SpellCastInFightManager = null;
         var _loc9_:* = 0;
         var _loc10_:SpellModificator = null;
         var _loc11_:CharacterCharacteristicsInformations = null;
         var _loc12_:CharacterSpellModification = null;
         if((this.needCooldownUpdate) && !param1)
         {
            param1 = this._storedSpellCooldowns;
         }
         var _loc2_:CurrentPlayedFighterManager = CurrentPlayedFighterManager.getInstance();
         var _loc3_:int = param1.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = SpellWrapper.getFirstSpellWrapperById(_loc5_.spellId,this.entityId);
            if(!_loc6_)
            {
               this.needCooldownUpdate = true;
               this._storedSpellCooldowns = param1;
               return;
            }
            if((_loc6_) && _loc6_.spellLevel > 0)
            {
               _loc7_ = _loc6_.spell.getSpellLevel(_loc6_.spellLevel);
               _loc8_ = _loc2_.getSpellCastManagerById(this.entityId);
               _loc8_.castSpell(_loc6_.id,_loc6_.spellLevel,[],false);
               _loc9_ = _loc7_.minCastInterval;
               if(_loc5_.cooldown != 63)
               {
                  _loc10_ = new SpellModificator();
                  _loc11_ = PlayedCharacterManager.getInstance().characteristics;
                  for each (_loc12_ in _loc11_.spellModifications)
                  {
                     if(_loc12_.spellId == _loc5_.spellId)
                     {
                        switch(_loc12_.modificationType)
                        {
                           case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                              _loc10_.castInterval = _loc12_.value;
                              continue;
                           case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                              _loc10_.castIntervalSet = _loc12_.value;
                              continue;
                           default:
                              continue;
                        }
                     }
                     else
                     {
                        continue;
                     }
                  }
                  if(_loc10_.getTotalBonus(_loc10_.castIntervalSet))
                  {
                     _loc9_ = -_loc10_.getTotalBonus(_loc10_.castInterval) + _loc10_.getTotalBonus(_loc10_.castIntervalSet);
                  }
                  else
                  {
                     _loc9_ = _loc9_ - _loc10_.getTotalBonus(_loc10_.castInterval);
                  }
               }
               _loc8_.getSpellManagerBySpellId(_loc6_.id).forceLastCastTurn(this.currentTurn + _loc5_.cooldown - _loc9_);
            }
            _loc4_++;
         }
         this.needCooldownUpdate = false;
      }
      
      public function castSpell(param1:uint, param2:uint, param3:Array, param4:Boolean=true) : void {
         if(this._spells[param1] == null)
         {
            this._spells[param1] = new SpellManager(this,param1,param2);
         }
         (this._spells[param1] as SpellManager).cast(this.currentTurn,param3,param4);
      }
      
      public function getSpellManagerBySpellId(param1:uint) : SpellManager {
         return this._spells[param1] as SpellManager;
      }
   }
}
