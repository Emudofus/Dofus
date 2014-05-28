package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
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
      
      protected static const _log:Logger;
      
      private var _spells:Dictionary;
      
      private var skipFirstTurn:Boolean = true;
      
      private var _storedSpellCooldowns:Vector.<GameFightSpellCooldown>;
      
      public var currentTurn:int = 0;
      
      public var entityId:int;
      
      public var needCooldownUpdate:Boolean = false;
      
      public function nextTurn() : void {
         var spell:SpellManager = null;
         this.currentTurn++;
         for each(spell in this._spells)
         {
            spell.newTurn();
         }
      }
      
      public function resetInitialCooldown(hasBeenSummoned:Boolean = false) : void {
         var sm:SpellManager = null;
         var s:SpellWrapper = null;
         var spim:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         var spellList:Array = spim.getFullSpellListByOwnerId(this.entityId);
         for each(s in spellList)
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
      
      public function updateCooldowns(spellCooldowns:Vector.<GameFightSpellCooldown> = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function castSpell(pSpellId:uint, pSpellLevel:uint, pTargets:Array, pCountForCooldown:Boolean = true) : void {
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
