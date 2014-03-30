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
      
      public function SpellCastInFightManager(entityId:int) {
         this._spells = new Dictionary();
         super();
         this.entityId = entityId;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellCastInFightManager));
      
      private var _spells:Dictionary;
      
      private var skipFirstTurn:Boolean = true;
      
      private var _storedSpellCooldowns:Vector.<GameFightSpellCooldown>;
      
      public var currentTurn:int = 0;
      
      public var entityId:int;
      
      public var needCooldownUpdate:Boolean = false;
      
      public function nextTurn() : void {
         var spell:SpellManager = null;
         this.currentTurn++;
         for each (spell in this._spells)
         {
            spell.newTurn();
         }
      }
      
      public function resetInitialCooldown(hasBeenSummoned:Boolean=false) : void {
         var sm:SpellManager = null;
         var s:SpellWrapper = null;
         var spim:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         var spellList:Array = spim.getFullSpellListByOwnerId(this.entityId);
         for each (s in spellList)
         {
            if(s.spellLevelInfos.initialCooldown != 0)
            {
               if(!((hasBeenSummoned) && (s.actualCooldown > s.spellLevelInfos.initialCooldown)))
               {
                  if(this._spells[s.spellId] == null)
                  {
                     this._spells[s.spellId] = new SpellManager(this,s.spellId,s.spellLevel);
                  }
                  sm = this._spells[s.spellId];
                  sm.resetInitialCooldown(this.currentTurn);
               }
            }
         }
      }
      
      public function updateCooldowns(spellCooldowns:Vector.<GameFightSpellCooldown>=null) : void {
         var spellCooldown:GameFightSpellCooldown = null;
         var spellW:SpellWrapper = null;
         var spellLevel:SpellLevel = null;
         var spellCastManager:SpellCastInFightManager = null;
         var interval:* = 0;
         var spellModifs:SpellModificator = null;
         var characteristics:CharacterCharacteristicsInformations = null;
         var spellModification:CharacterSpellModification = null;
         if((this.needCooldownUpdate) && (!spellCooldowns))
         {
            spellCooldowns = this._storedSpellCooldowns;
         }
         var playedFighterManager:CurrentPlayedFighterManager = CurrentPlayedFighterManager.getInstance();
         var numCoolDown:int = spellCooldowns.length;
         var k:int = 0;
         while(k < numCoolDown)
         {
            spellCooldown = spellCooldowns[k];
            spellW = SpellWrapper.getFirstSpellWrapperById(spellCooldown.spellId,this.entityId);
            if(!spellW)
            {
               this.needCooldownUpdate = true;
               this._storedSpellCooldowns = spellCooldowns;
               return;
            }
            if((spellW) && (spellW.spellLevel > 0))
            {
               spellLevel = spellW.spell.getSpellLevel(spellW.spellLevel);
               spellCastManager = playedFighterManager.getSpellCastManagerById(this.entityId);
               spellCastManager.castSpell(spellW.id,spellW.spellLevel,[],false);
               interval = spellLevel.minCastInterval;
               if(spellCooldown.cooldown != 63)
               {
                  spellModifs = new SpellModificator();
                  characteristics = PlayedCharacterManager.getInstance().characteristics;
                  for each (spellModification in characteristics.spellModifications)
                  {
                     if(spellModification.spellId == spellCooldown.spellId)
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
                     interval = interval - spellModifs.getTotalBonus(spellModifs.castInterval);
                  }
               }
               spellCastManager.getSpellManagerBySpellId(spellW.id).forceLastCastTurn(this.currentTurn + spellCooldown.cooldown - interval);
            }
            k++;
         }
         this.needCooldownUpdate = false;
      }
      
      public function castSpell(pSpellId:uint, pSpellLevel:uint, pTargets:Array, pCountForCooldown:Boolean=true) : void {
         if(this._spells[pSpellId] == null)
         {
            this._spells[pSpellId] = new SpellManager(this,pSpellId,pSpellLevel);
         }
         (this._spells[pSpellId] as SpellManager).cast(this.currentTurn,pTargets,pCountForCooldown);
      }
      
      public function getSpellManagerBySpellId(pSpellId:uint) : SpellManager {
         return this._spells[pSpellId] as SpellManager;
      }
   }
}
