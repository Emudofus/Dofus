package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;


   public class SpellCastInFightManager extends Object
   {
         

      public function SpellCastInFightManager(entityId:int) {
         this._spells=new Dictionary();
         super();
         this.entityId=entityId;
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellCastInFightManager));

      private var _spells:Dictionary;

      private var skipFirstTurn:Boolean = true;

      public var currentTurn:int = 0;

      public var entityId:int;

      public function nextTurn() : void {
         var spell:SpellManager = null;
         this.currentTurn++;
         for each (spell in this._spells)
         {
            spell.newTurn();
         }
      }

      public function resetInitialCooldown() : void {
         var sm:SpellManager = null;
         var s:SpellWrapper = null;
         var spim:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         for each (s in spim.fullSpellList)
         {
            if(s.spellLevelInfos.initialCooldown!=0)
            {
               if(this._spells[s.spellId]==null)
               {
                  this._spells[s.spellId]=new SpellManager(this,s.spellId,s.spellLevel);
               }
               sm=this._spells[s.spellId];
               sm.resetInitialCooldown(this.currentTurn);
            }
         }
      }

      public function castSpell(pSpellId:uint, pSpellLevel:uint, pTargets:Array, pCountForCooldown:Boolean=true) : void {
         if(this._spells[pSpellId]==null)
         {
            this._spells[pSpellId]=new SpellManager(this,pSpellId,pSpellLevel);
         }
         (this._spells[pSpellId] as SpellManager).cast(this.currentTurn,pTargets,pCountForCooldown);
      }

      public function getSpellManagerBySpellId(pSpellId:uint) : SpellManager {
         return this._spells[pSpellId] as SpellManager;
      }
   }

}