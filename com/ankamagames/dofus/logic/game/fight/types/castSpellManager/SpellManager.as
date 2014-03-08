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
      
      public function SpellManager(spellCastManager:SpellCastInFightManager, pSpellId:uint, pSpellLevel:uint) {
         super();
         this._spellCastManager = spellCastManager;
         this._spellId = pSpellId;
         this._spellLevel = pSpellLevel;
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
      
      public function set spellLevel(pSpellLevel:uint) : void {
         this._spellLevel = pSpellLevel;
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
      
      public function cast(pTurn:int, pTarget:Array, pCountForCooldown:Boolean=true) : void {
         var target:* = 0;
         this._lastCastTurn = pTurn;
         for each (target in pTarget)
         {
            if(this._targetsThisTurn[target] == null)
            {
               this._targetsThisTurn[target] = 0;
            }
            this._targetsThisTurn[target] = this._targetsThisTurn[target] + 1;
         }
         if(pCountForCooldown)
         {
            this._castThisTurn++;
         }
         this.updateSpellWrapper();
      }
      
      public function resetInitialCooldown(pTurn:int) : void {
         this._lastInitialCooldownReset = pTurn;
         this.updateSpellWrapper();
      }
      
      public function getCastOnEntity(pEntityId:int) : uint {
         if(this._targetsThisTurn[pEntityId] == null)
         {
            return 0;
         }
         return this._targetsThisTurn[pEntityId];
      }
      
      public function newTurn() : void {
         this._castThisTurn = 0;
         this._targetsThisTurn = new Dictionary();
         this.updateSpellWrapper();
      }
      
      public function get cooldown() : int {
         var spellModification:CharacterSpellModification = null;
         var interval:* = 0;
         var cooldown:* = 0;
         var spell:Spell = Spell.getSpellById(this._spellId);
         var spellLevel:SpellLevel = spell.getSpellLevel(this._spellLevel);
         var spellModifs:SpellModificator = new SpellModificator();
         var characteristics:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
         for each (spellModification in characteristics.spellModifications)
         {
            if(spellModification.spellId == this._spellId)
            {
               switch(spellModification.modificationType)
               {
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                     spellModifs.castInterval = spellModification.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                     spellModifs.castIntervalSet = spellModification.value;
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         if(spellModifs.getTotalBonus(spellModifs.castIntervalSet))
         {
            interval = -spellModifs.getTotalBonus(spellModifs.castInterval) + spellModifs.getTotalBonus(spellModifs.castIntervalSet);
         }
         else
         {
            interval = spellLevel.minCastInterval - spellModifs.getTotalBonus(spellModifs.castInterval);
         }
         if(interval == 63)
         {
            return 63;
         }
         var initialCooldown:int = this._lastInitialCooldownReset + spellLevel.initialCooldown - this._spellCastManager.currentTurn;
         if((this._lastCastTurn >= this._lastInitialCooldownReset + spellLevel.initialCooldown) || (spellLevel.initialCooldown == 0))
         {
            cooldown = interval + this._lastCastTurn - this._spellCastManager.currentTurn;
         }
         else
         {
            cooldown = initialCooldown;
         }
         if(cooldown <= 0)
         {
            cooldown = 0;
         }
         return cooldown;
      }
      
      public function forceCooldown(cooldown:int) : void {
         var spellW:SpellWrapper = null;
         var spell:Spell = Spell.getSpellById(this._spellId);
         var spellL:SpellLevel = spell.getSpellLevel(this._spellLevel);
         this._lastCastTurn = cooldown + this._spellCastManager.currentTurn - spellL.minCastInterval;
         var spellWs:Array = SpellWrapper.getSpellWrappersById(this._spellId,this._spellCastManager.entityId);
         for each (spellW in spellWs)
         {
            spellW.actualCooldown = cooldown;
         }
      }
      
      public function forceLastCastTurn(pLastCastTurn:int, reallyForceNoKidding:Boolean=false) : void {
         this._lastCastTurn = pLastCastTurn;
         this.updateSpellWrapper(reallyForceNoKidding);
      }
      
      private function updateSpellWrapper(forceLastCastTurn:Boolean=false) : void {
         var spellW:SpellWrapper = null;
         var spellWs:Array = SpellWrapper.getSpellWrappersById(this._spellId,this._spellCastManager.entityId);
         var spell:Spell = Spell.getSpellById(this._spellId);
         var spellLevel:SpellLevel = spell.getSpellLevel(this._spellLevel);
         for each (spellW in spellWs)
         {
            if(spellW.actualCooldown != 63)
            {
               spellW.actualCooldown = this.cooldown;
            }
         }
      }
   }
}
