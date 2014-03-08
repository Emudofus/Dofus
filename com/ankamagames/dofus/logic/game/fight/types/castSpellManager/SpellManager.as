package com.ankamagames.dofus.logic.game.fight.types.castSpellManager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.logic.game.common.misc.SpellModificator;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   
   public class SpellManager extends Object
   {
      
      public function SpellManager(param1:SpellCastInFightManager, param2:uint, param3:uint) {
         super();
         this._spellCastManager = param1;
         this._spellId = param2;
         this._spellLevel = param3;
         this._targetsThisTurn = new Dictionary();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellManager));
      
      private var _spellId:uint;
      
      private var _spellLevel:uint;
      
      private var _lastCastTurn:int;
      
      private var _lastInitialCooldownReset:int;
      
      private var _castThisTurn:uint;
      
      private var _targetsThisTurn:Dictionary;
      
      private var _spellCastManager:SpellCastInFightManager;
      
      public function get lastCastTurn() : int {
         return this._lastCastTurn;
      }
      
      public function get numberCastThisTurn() : uint {
         return this._castThisTurn;
      }
      
      public function set spellLevel(param1:uint) : void {
         this._spellLevel = param1;
      }
      
      public function get spellLevel() : uint {
         return this._spellLevel;
      }
      
      public function get spell() : Spell {
         return Spell.getSpellById(this._spellId);
      }
      
      public function get spellLevelObject() : SpellLevel {
         return Spell.getSpellById(this._spellId).getSpellLevel(this._spellLevel);
      }
      
      public function cast(param1:int, param2:Array, param3:Boolean=true) : void {
         var _loc4_:* = 0;
         this._lastCastTurn = param1;
         for each (_loc4_ in param2)
         {
            if(this._targetsThisTurn[_loc4_] == null)
            {
               this._targetsThisTurn[_loc4_] = 0;
            }
            this._targetsThisTurn[_loc4_] = this._targetsThisTurn[_loc4_] + 1;
         }
         if(param3)
         {
            this._castThisTurn++;
         }
         this.updateSpellWrapper();
      }
      
      public function resetInitialCooldown(param1:int) : void {
         this._lastInitialCooldownReset = param1;
         this.updateSpellWrapper();
      }
      
      public function getCastOnEntity(param1:int) : uint {
         if(this._targetsThisTurn[param1] == null)
         {
            return 0;
         }
         return this._targetsThisTurn[param1];
      }
      
      public function newTurn() : void {
         this._castThisTurn = 0;
         this._targetsThisTurn = new Dictionary();
         this.updateSpellWrapper();
      }
      
      public function get cooldown() : int {
         var _loc5_:CharacterSpellModification = null;
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         var _loc1_:Spell = Spell.getSpellById(this._spellId);
         var _loc2_:SpellLevel = _loc1_.getSpellLevel(this._spellLevel);
         var _loc3_:SpellModificator = new SpellModificator();
         var _loc4_:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
         for each (_loc5_ in _loc4_.spellModifications)
         {
            if(_loc5_.spellId == this._spellId)
            {
               switch(_loc5_.modificationType)
               {
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                     _loc3_.castInterval = _loc5_.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                     _loc3_.castIntervalSet = _loc5_.value;
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
         if(_loc3_.getTotalBonus(_loc3_.castIntervalSet))
         {
            _loc6_ = -_loc3_.getTotalBonus(_loc3_.castInterval) + _loc3_.getTotalBonus(_loc3_.castIntervalSet);
         }
         else
         {
            _loc6_ = _loc2_.minCastInterval - _loc3_.getTotalBonus(_loc3_.castInterval);
         }
         if(_loc6_ == 63)
         {
            return 63;
         }
         var _loc7_:int = this._lastInitialCooldownReset + _loc2_.initialCooldown - this._spellCastManager.currentTurn;
         if(this._lastCastTurn >= this._lastInitialCooldownReset + _loc2_.initialCooldown || _loc2_.initialCooldown == 0)
         {
            _loc8_ = _loc6_ + this._lastCastTurn - this._spellCastManager.currentTurn;
         }
         else
         {
            _loc8_ = _loc7_;
         }
         if(_loc8_ <= 0)
         {
            _loc8_ = 0;
         }
         return _loc8_;
      }
      
      public function forceCooldown(param1:int) : void {
         var _loc5_:SpellWrapper = null;
         var _loc2_:Spell = Spell.getSpellById(this._spellId);
         var _loc3_:SpellLevel = _loc2_.getSpellLevel(this._spellLevel);
         this._lastCastTurn = param1 + this._spellCastManager.currentTurn - _loc3_.minCastInterval;
         var _loc4_:Array = SpellWrapper.getSpellWrappersById(this._spellId,this._spellCastManager.entityId);
         for each (_loc5_ in _loc4_)
         {
            _loc5_.actualCooldown = param1;
         }
      }
      
      public function forceLastCastTurn(param1:int, param2:Boolean=false) : void {
         this._lastCastTurn = param1;
         this.updateSpellWrapper(param2);
      }
      
      private function updateSpellWrapper(param1:Boolean=false) : void {
         var _loc5_:SpellWrapper = null;
         var _loc2_:Array = SpellWrapper.getSpellWrappersById(this._spellId,this._spellCastManager.entityId);
         var _loc3_:Spell = Spell.getSpellById(this._spellId);
         var _loc4_:SpellLevel = _loc3_.getSpellLevel(this._spellLevel);
         for each (_loc5_ in _loc2_)
         {
            if(_loc5_.actualCooldown != 63)
            {
               _loc5_.actualCooldown = this.cooldown;
            }
         }
      }
   }
}
